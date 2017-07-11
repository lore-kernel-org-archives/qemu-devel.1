Received: from eggs.gnu.org ([2001:4830:134:3::10]:38215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV1gA-0001kg-0H
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV1g6-0007t6-Pg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dV1g6-0007su-FQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:22:38 -0400
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
	<20170711103011.32631-7-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7a147bbd-04d1-be64-6479-990156596704@redhat.com>
Date: Tue, 11 Jul 2017 22:22:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170711103011.32631-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] scripts/dump-guest-memory.py: add
 vmcoreinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, imammedo@redhat.com

On 07/11/17 12:30, Marc-Andr=C3=A9 Lureau wrote:
> Add vmcoreinfo ELF note if vmcoreinfo device is ready.
>=20
> To help the python script, add a little global vmcoreinfo_gdb
> structure, that is populated with vmcoreinfo_gdb_update().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 46 ++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/acpi/vmcoreinfo.c         |  3 +++
>  2 files changed, 49 insertions(+)

... I've gotten a bit confused here, but I think this is what happened:
at 12:04 CEST today you commented on the "volatile thing"; at 12:30 CEST
you posted this v3 series, and I only followed up on your v2 comment at
15:25 CEST. So it's no surprise that whatever we discussed there can't
be seen in this patch.

So... IIUC our discussion there, you're going to post a v4 for this,
with a function-scoped, and internal-linkage, "vmcoreinfo_gdb_helper"
variable, also qualifying it "volatile", and accessing it with the
"function::variable" pattern from the python script. Is that about right?

One more comment below (actually two, but for one location):

> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index f7c6635f15..80730658ae 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -14,6 +14,7 @@ the COPYING file in the top-level directory.
>  """
> =20
>  import ctypes
> +import struct
> =20
>  UINTPTR_T =3D gdb.lookup_type("uintptr_t")
> =20
> @@ -120,6 +121,22 @@ class ELF(object):
>          self.segments[0].p_filesz +=3D ctypes.sizeof(note)
>          self.segments[0].p_memsz +=3D ctypes.sizeof(note)
> =20
> +
> +    def add_vmcoreinfo_note(self, vmcoreinfo):
> +        """Adds a vmcoreinfo note to the ELF dump."""
> +        # compute the header size, and copy that many bytes from the n=
ote
> +        header =3D get_arch_note(self.endianness, 0, 0)
> +        ctypes.memmove(ctypes.pointer(header),
> +                       vmcoreinfo, ctypes.sizeof(header))
> +        # now get the full note
> +        note =3D get_arch_note(self.endianness,
> +                             header.n_namesz - 1, header.n_descsz)
> +        ctypes.memmove(ctypes.pointer(note), vmcoreinfo, ctypes.sizeof=
(note))
> +
> +        self.notes.append(note)
> +        self.segments[0].p_filesz +=3D ctypes.sizeof(note)
> +        self.segments[0].p_memsz +=3D ctypes.sizeof(note)
> +
>      def add_segment(self, p_type, p_paddr, p_size):
>          """Adds a segment to the elf."""
> =20
> @@ -505,6 +522,34 @@ shape and this command should mostly work."""
>                  cur +=3D chunk_size
>                  left -=3D chunk_size
> =20
> +    def phys_memory_read(self, addr, size):
> +        qemu_core =3D gdb.inferiors()[0]
> +        for block in self.guest_phys_blocks:
> +            if block["target_start"] <=3D addr < block["target_end"] \
> +               and addr + size < block["target_end"]:

Thanks for touching this up, but now I have two more new comments :)

First (and sorry about putting my request unclearly in the v2 review), I
think we need the following, and only the following checks here:
- "addr" against block["target_start"],
- "addr + size" against block["target_end"].

Second, if you are comparing limits of the same kind (that is, inclusive
vs. inclusive, and exclusive vs. exclusive), then equality is valid and
should be accepted. Therefore,

  block["target_start"] <=3D addr

is correct (exact match is valid), but

  addr + size < block["target_end"]

is incorrect (too strict), because "addr + size" is an exclusive limit
-- same as block["target_end"] -- so equality should again be accepted:

  addr + size <=3D block["target_end"]

If you clean these up, you can add my

Acked-by: Laszlo Ersek <lersek@redhat.com>

but I would still like a real Pythonista to review this patch. Adding
Janosch.

Janosch -- can you please help review this patch?

Thanks,
Laszlo


> +                haddr =3D block["host_addr"] + (addr - block["target_s=
tart"])
> +                return qemu_core.read_memory(haddr, size)
> +        return None
> +
> +    def add_vmcoreinfo(self):
> +        if not gdb.parse_and_eval("vmcoreinfo_gdb_helper"):
> +            return
> +
> +        addr =3D gdb.parse_and_eval("vmcoreinfo_gdb_helper.vmcoreinfo_=
addr_le")
> +        addr =3D bytes([addr[i] for i in range(4)])
> +        addr =3D struct.unpack("<I", addr)[0]
> +
> +        mem =3D self.phys_memory_read(addr, 16)
> +        if not mem:
> +            return
> +        (version, addr, size) =3D struct.unpack("<IQI", mem)
> +        if version !=3D 0:
> +            return
> +
> +        vmcoreinfo =3D self.phys_memory_read(addr, size)
> +        if vmcoreinfo:
> +            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
> +
>      def invoke(self, args, from_tty):
>          """Handles command invocation from gdb."""
> =20
> @@ -518,6 +563,7 @@ shape and this command should mostly work."""
> =20
>          self.elf =3D ELF(argv[1])
>          self.guest_phys_blocks =3D get_guest_phys_blocks()
> +        self.add_vmcoreinfo()
> =20
>          with open(argv[0], "wb") as vmcore:
>              self.dump_init(vmcore)
> diff --git a/hw/acpi/vmcoreinfo.c b/hw/acpi/vmcoreinfo.c
> index 0ea41de8d9..bfef211aad 100644
> --- a/hw/acpi/vmcoreinfo.c
> +++ b/hw/acpi/vmcoreinfo.c
> @@ -20,6 +20,8 @@
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
> =20
> +VMCoreInfoState *vmcoreinfo_gdb_helper;
> +
>  void vmcoreinfo_build_acpi(VMCoreInfoState *vis, GArray *table_data,
>                             GArray *vmci, BIOSLinker *linker)
>  {
> @@ -181,6 +183,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
> =20
> +    vmcoreinfo_gdb_helper =3D VMCOREINFO(dev);
>      qemu_register_reset(vmcoreinfo_handle_reset, dev);
>  }
> =20
>=20
