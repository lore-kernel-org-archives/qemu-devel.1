Received: from eggs.gnu.org ([2001:4830:134:3::10]:53405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dWACh-0001rK-82
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dWACe-00042h-37
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:40:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dWACd-00042b-PY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:40:56 -0400
Date: Sat, 15 Jul 2017 02:40:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170715023159-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
	<20170714230852-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
	<20170715012551-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJP2DSo-khn+do0YG_ALDXrqBi6wEPH=m+W59rPfRTuiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJP2DSo-khn+do0YG_ALDXrqBi6wEPH=m+W59rPfRTuiA@mail.gmail.com>
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

On Sat, Jul 15, 2017 at 01:30:56AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Sat, Jul 15, 2017 at 1:09 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >
> > On Sat, Jul 15, 2017 at 12:12:06AM +0200, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >
> > > On Fri, Jul 14, 2017 at 10:17 PM, Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> > > > On Fri, Jul 14, 2017 at 10:04:31PM +0200, Laszlo Ersek wrote:
> > > >> > It worries me that the format of this seems completely undefin=
ed
> > > >> > except in the patchset cover letter.
> > > >> > I don't think we should merge this before it is.
> > > >>
> > > >> I'm not sure what you mean, this patch adds "docs/specs/vmcorein=
fo.txt".
> > > >> That file is the first level contract between the guest firmware
> > > >> (generally, via the linker/loader), the guest kernel driver
> > > >> (specifically), and QEMU (also specifically).
> > > >>
> > > >> The second level contract is the guest kernel's vmcoreinfo ELF n=
ote
> > > >> (which is pointed-to by the first level contract). The layout of=
 that is
> > > >> specified elsewhere indeed (I don't think it belongs here).
> > > >>
> > > >> We've taken care not to trust anything coming from the guest ker=
nel.
> > > >>
> > > >> Can you clarify please?
> > > >>
> > > >> Thanks
> > > >> Laszlo
> > > >
> > > > All there is is this:
> > > >
> > > > +Version 0 content:
> > > > +
> > > > + uint64 paddr:
> > > > +  Physical address of the Linux vmcoreinfo ELF note.
> > > > + uint32 size:
> > > > +  Size of the vmcoreinfo ELF note.
> > > >
> > > > It isn't defined here what is the Linux vmcoreinfo ELF note.
> > > > You want a bit more info so people trying to use it know where to=
 start
> > > > and what they can get out of it.
> > >
> > > QEMU is not responsible for the content of the ELF note. All there =
is afaik is:
> > >
> > > https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-v=
mcoreinfo
> > >
> > > The rest you need to dig in the kernel code and git history I think=
.
> >
> > We need to do a good enough job to at least make it possible for peop=
le
> > to make use of it without reading your python code.
> >
> > Documentation/kdump/kdump.txt has a bit more information.
> >
> >         All of the necessary information about the system kernel's co=
re image is
> >         encoded in the ELF format, and stored in a reserved area of m=
emory
> >         before a crash. The physical address of the start of the ELF =
header is
> >         passed to the dump-capture kernel through the elfcorehdr=3D b=
oot
> >         parameter. Optionally the size of the ELF header can also be =
passed
> >         when using the elfcorehdr=3D[size[KMG]@]offset[KMG] syntax.
> >
> >
> >         With the dump-capture kernel, you can access the memory image=
 through
> >         /proc/vmcore. This exports the dump as an ELF-format file tha=
t you can
> >         write out using file copy commands such as cp or scp. Further=
, you can
> >         use analysis tools such as the GNU Debugger (GDB) and the Cra=
sh tool to
> >         debug the dump file. This method ensures that the dump pages =
are correctly
> >         ordered.
> >
> > I know where to find it but most people likely won't be able to.
> >
>=20
> What do you learn from that regarding vmcoreinfo? That is it being
> used by kdump? and that you can use gdb/crash, that we already use to
> analyse our dumps.

Some things I learn:

That its written by a dump-capture kernel (so you need to set one up
if you want it to work!).

That it's an ELF-format file, that one can use analysis tools such as
the GNU Debugger (GDB) and the Crash tool to debug the dump file.

There's more info scattered in other places.

Why do you get to document it? Because you are the one exposing it
across the hypervisor/vm boundary where it will need to be
understood by people/tools not running within guest.

So "just read the script in qemu source" is not how an interface
should be documented.

> >
> > BTW why does it pass ELF header size? Any idea?
>=20
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dd3bf37955d46718ee1a7f1fc69f953d2328ba7c2

Right but I mean, ELF header has two options: 32 and 64 bit, that's all.

--=20
MST
