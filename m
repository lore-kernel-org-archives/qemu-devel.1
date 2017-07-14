Received: from eggs.gnu.org ([2001:4830:134:3::10]:51954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dWA32-0006DP-OY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dWA31-00018O-Is
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:31:00 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:34983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dWA31-00018F-BE
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:30:59 -0400
Received: by mail-lf0-x233.google.com with SMTP id b207so61031208lfg.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 16:30:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170715012551-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
	<20170714230852-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
	<20170715012551-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 15 Jul 2017 01:30:56 +0200
Message-ID: <CAJ+F1CJP2DSo-khn+do0YG_ALDXrqBi6wEPH=m+W59rPfRTuiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Sat, Jul 15, 2017 at 1:09 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Jul 15, 2017 at 12:12:06AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Jul 14, 2017 at 10:17 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > > On Fri, Jul 14, 2017 at 10:04:31PM +0200, Laszlo Ersek wrote:
> > >> > It worries me that the format of this seems completely undefined
> > >> > except in the patchset cover letter.
> > >> > I don't think we should merge this before it is.
> > >>
> > >> I'm not sure what you mean, this patch adds "docs/specs/vmcoreinfo.t=
xt".
> > >> That file is the first level contract between the guest firmware
> > >> (generally, via the linker/loader), the guest kernel driver
> > >> (specifically), and QEMU (also specifically).
> > >>
> > >> The second level contract is the guest kernel's vmcoreinfo ELF note
> > >> (which is pointed-to by the first level contract). The layout of tha=
t is
> > >> specified elsewhere indeed (I don't think it belongs here).
> > >>
> > >> We've taken care not to trust anything coming from the guest kernel.
> > >>
> > >> Can you clarify please?
> > >>
> > >> Thanks
> > >> Laszlo
> > >
> > > All there is is this:
> > >
> > > +Version 0 content:
> > > +
> > > + uint64 paddr:
> > > +  Physical address of the Linux vmcoreinfo ELF note.
> > > + uint32 size:
> > > +  Size of the vmcoreinfo ELF note.
> > >
> > > It isn't defined here what is the Linux vmcoreinfo ELF note.
> > > You want a bit more info so people trying to use it know where to sta=
rt
> > > and what they can get out of it.
> >
> > QEMU is not responsible for the content of the ELF note. All there is a=
faik is:
> >
> > https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vmcor=
einfo
> >
> > The rest you need to dig in the kernel code and git history I think.
>
> We need to do a good enough job to at least make it possible for people
> to make use of it without reading your python code.
>
> Documentation/kdump/kdump.txt has a bit more information.
>
>         All of the necessary information about the system kernel's core i=
mage is
>         encoded in the ELF format, and stored in a reserved area of memor=
y
>         before a crash. The physical address of the start of the ELF head=
er is
>         passed to the dump-capture kernel through the elfcorehdr=3D boot
>         parameter. Optionally the size of the ELF header can also be pass=
ed
>         when using the elfcorehdr=3D[size[KMG]@]offset[KMG] syntax.
>
>
>         With the dump-capture kernel, you can access the memory image thr=
ough
>         /proc/vmcore. This exports the dump as an ELF-format file that yo=
u can
>         write out using file copy commands such as cp or scp. Further, yo=
u can
>         use analysis tools such as the GNU Debugger (GDB) and the Crash t=
ool to
>         debug the dump file. This method ensures that the dump pages are =
correctly
>         ordered.
>
> I know where to find it but most people likely won't be able to.
>

What do you learn from that regarding vmcoreinfo? That is it being
used by kdump? and that you can use gdb/crash, that we already use to
analyse our dumps.

>
> BTW why does it pass ELF header size? Any idea?


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd3bf37955d46718ee1a7f1fc69f953d2328ba7c2
