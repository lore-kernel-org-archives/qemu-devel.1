Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUs2G-0005QU-5R
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUs2C-0004Qc-4C
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dUs2B-0004Pp-Ri
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:04:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2EE180F97
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:04:45 +0000 (UTC)
Date: Tue, 11 Jul 2017 06:04:39 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <145552423.49242900.1499767479720.JavaMail.zimbra@redhat.com>
In-Reply-To: <c661a649-e438-e80b-baf4-b44ee6612ca3@redhat.com>
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-7-marcandre.lureau@redhat.com>
	<c661a649-e438-e80b-baf4-b44ee6612ca3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] scripts/dump-guest-memory.py: add
 vmcoreinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, imammedo@redhat.com

Hi

----- Original Message -----
> On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
> > Add vmcoreinfo ELF note if vmcoreinfo device is ready.
> >=20
> > To help the python script, add a little global vmcoreinfo_gdb
> > structure, that is populated with vmcoreinfo_gdb_update().
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/dump-guest-memory.py | 40 ++++++++++++++++++++++++++++++++++++=
++++
> >  hw/acpi/vmcoreinfo.c         |  3 +++
> >  2 files changed, 43 insertions(+)
> >=20
> > diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> > index f7c6635f15..2dd2ed6983 100644
> > --- a/scripts/dump-guest-memory.py
> > +++ b/scripts/dump-guest-memory.py
> > @@ -14,6 +14,7 @@ the COPYING file in the top-level directory.
> >  """
> > =20
> >  import ctypes
> > +import struct
> > =20
> >  UINTPTR_T =3D gdb.lookup_type("uintptr_t")
> > =20
> > @@ -120,6 +121,20 @@ class ELF(object):
> >          self.segments[0].p_filesz +=3D ctypes.sizeof(note)
> >          self.segments[0].p_memsz +=3D ctypes.sizeof(note)
> > =20
> > +
> > +    def add_vmcoreinfo_note(self, vmcoreinfo):
> > +        """Adds a vmcoreinfo note to the ELF dump."""
> > +        chead =3D type(get_arch_note(self.endianness, 0, 0))
> > +        header =3D
> > chead.from_buffer_copy(vmcoreinfo[0:ctypes.sizeof(chead)])
>=20
> Maybe it's obvious to others, but I would have been helped a lot if a
> comment had explained that you are creating a fake note (with 0 desc
> size and 0 name size) to figure out the size of the note header. And
> then you copy that many bytes out of the vmcoreinfo ELF note.
>=20

ok

> > +        note =3D get_arch_note(self.endianness,
> > +                             header.n_namesz - 1, header.n_descsz)
>=20
> Why the -1?

because get_arch_note() adds + 1 (supposedly for the ending \0, see also ad=
d_note())

>=20
> ... I think I'm giving up here for this method. My python is weak and I
> can't follow this too well. Please add some comments.

I simplified a bit the code now, I was also discovering some ctype usage.

> More comments below:
>=20
> > +        ctypes.memmove(ctypes.pointer(note), vmcoreinfo,
> > ctypes.sizeof(note))
> > +        header_size =3D ctypes.sizeof(note) - header.n_descsz
> > +
> > +        self.notes.append(note)
> > +        self.segments[0].p_filesz +=3D ctypes.sizeof(note)
> > +        self.segments[0].p_memsz +=3D ctypes.sizeof(note)
> > +
> >      def add_segment(self, p_type, p_paddr, p_size):
> >          """Adds a segment to the elf."""
> > =20
> > @@ -505,6 +520,30 @@ shape and this command should mostly work."""
> >                  cur +=3D chunk_size
> >                  left -=3D chunk_size
> > =20
> > +    def phys_memory_read(self, addr, size):
> > +        qemu_core =3D gdb.inferiors()[0]
> > +        for block in self.guest_phys_blocks:
> > +            if block["target_start"] <=3D addr < block["target_end"]:
>=20
> Although I don't expect a single read to straddle phys-blocks, I would
> prefer if you checked (addr + size) -- and not just addr -- against
> block["target_end"].

done

>=20
> > +                haddr =3D block["host_addr"] + (addr -
> > block["target_start"])
> > +                return qemu_core.read_memory(haddr, size)
> > +
> > +    def add_vmcoreinfo(self):
> > +        if not gdb.parse_and_eval("vmcoreinfo_gdb_helper"):
> > +            return
> > +
> > +        addr =3D
> > gdb.parse_and_eval("vmcoreinfo_gdb_helper.vmcoreinfo_addr_le")
> > +        addr =3D bytes([addr[i] for i in range(4)])
> > +        addr =3D struct.unpack("<I", addr)[0]
> > +
> > +        mem =3D self.phys_memory_read(addr, 16)
> > +        (version, addr, size) =3D struct.unpack("<IQI", mem)
> > +        if version !=3D 0:
> > +            return
> > +
> > +        vmcoreinfo =3D self.phys_memory_read(addr, size)
> > +        if vmcoreinfo:
> > +            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
> > +
> >      def invoke(self, args, from_tty):
> >          """Handles command invocation from gdb."""
> > =20
> > @@ -518,6 +557,7 @@ shape and this command should mostly work."""
> > =20
> >          self.elf =3D ELF(argv[1])
> >          self.guest_phys_blocks =3D get_guest_phys_blocks()
> > +        self.add_vmcoreinfo()
> > =20
> >          with open(argv[0], "wb") as vmcore:
> >              self.dump_init(vmcore)
> > diff --git a/hw/acpi/vmcoreinfo.c b/hw/acpi/vmcoreinfo.c
> > index 0ea41de8d9..b6bcb47506 100644
> > --- a/hw/acpi/vmcoreinfo.c
> > +++ b/hw/acpi/vmcoreinfo.c
> > @@ -163,6 +163,8 @@ static void vmcoreinfo_handle_reset(void *opaque)
> >      memset(vis->vmcoreinfo_addr_le, 0,
> >      ARRAY_SIZE(vis->vmcoreinfo_addr_le));
> >  }
> > =20
> > +static VMCoreInfoState *vmcoreinfo_gdb_helper;
> > +
> >  static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
> >  {
> >      if (!bios_linker_loader_can_write_pointer()) {
> > @@ -181,6 +183,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Er=
ror
> > **errp)
> >          return;
> >      }
> > =20
> > +    vmcoreinfo_gdb_helper =3D VMCOREINFO(dev);
> >      qemu_register_reset(vmcoreinfo_handle_reset, dev);
> >  }
> > =20
> >=20
>=20
> I guess we don't build QEMU with link-time optimization at the moment.
>=20
> With link-time optimization, I think gcc might reasonably optimize away
> the assignment to "vmcoreinfo_gdb_helper", and "vmcoreinfo_gdb_helper"
> itself. This is why I suggested "volatile":
>=20
> static VMCoreInfoState * volatile vmcoreinfo_gdb_helper;
>=20
> Do you think volatile is only superfluous, or do you actively dislike it
> for some reason?

Yeah, I am not convinced volatile is the best way, but nor is static.

Let's export it?
