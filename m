Received: from eggs.gnu.org ([2001:4830:134:3::10]:48969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW9ih-0008FO-6P
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW9ie-0000sA-0j
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW9id-0000rw-Ns
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:09:55 -0400
Date: Sat, 15 Jul 2017 02:09:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170715012551-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
	<20170714230852-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/8] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sat, Jul 15, 2017 at 12:12:06AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Fri, Jul 14, 2017 at 10:17 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > On Fri, Jul 14, 2017 at 10:04:31PM +0200, Laszlo Ersek wrote:
> >> > It worries me that the format of this seems completely undefined
> >> > except in the patchset cover letter.
> >> > I don't think we should merge this before it is.
> >>
> >> I'm not sure what you mean, this patch adds "docs/specs/vmcoreinfo.t=
xt".
> >> That file is the first level contract between the guest firmware
> >> (generally, via the linker/loader), the guest kernel driver
> >> (specifically), and QEMU (also specifically).
> >>
> >> The second level contract is the guest kernel's vmcoreinfo ELF note
> >> (which is pointed-to by the first level contract). The layout of tha=
t is
> >> specified elsewhere indeed (I don't think it belongs here).
> >>
> >> We've taken care not to trust anything coming from the guest kernel.
> >>
> >> Can you clarify please?
> >>
> >> Thanks
> >> Laszlo
> >
> > All there is is this:
> >
> > +Version 0 content:
> > +
> > + uint64 paddr:
> > +  Physical address of the Linux vmcoreinfo ELF note.
> > + uint32 size:
> > +  Size of the vmcoreinfo ELF note.
> >
> > It isn't defined here what is the Linux vmcoreinfo ELF note.
> > You want a bit more info so people trying to use it know where to sta=
rt
> > and what they can get out of it.
>=20
> QEMU is not responsible for the content of the ELF note. All there is a=
faik is:
>=20
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vmcor=
einfo
>=20
> The rest you need to dig in the kernel code and git history I think.

We need to do a good enough job to at least make it possible for people
to make use of it without reading your python code.

Documentation/kdump/kdump.txt has a bit more information.

	All of the necessary information about the system kernel's core image is
	encoded in the ELF format, and stored in a reserved area of memory
	before a crash. The physical address of the start of the ELF header is
	passed to the dump-capture kernel through the elfcorehdr=3D boot
	parameter. Optionally the size of the ELF header can also be passed
	when using the elfcorehdr=3D[size[KMG]@]offset[KMG] syntax.


	With the dump-capture kernel, you can access the memory image through
	/proc/vmcore. This exports the dump as an ELF-format file that you can
	write out using file copy commands such as cp or scp. Further, you can
	use analysis tools such as the GNU Debugger (GDB) and the Crash tool to
	debug the dump file. This method ensures that the dump pages are correct=
ly
	ordered.

I know where to find it but most people likely won't be able to.

BTW why does it pass ELF header size? Any idea?


> --=20
> Marc-Andr=E9 Lureau
