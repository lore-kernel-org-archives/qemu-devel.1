Received: from eggs.gnu.org ([2001:4830:134:3::10]:47582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXVCm-0000SL-1Z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXVCk-0004t3-Jr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:18:36 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:33411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dXVCk-0004sa-6J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:18:34 -0400
Received: by mail-lf0-x22f.google.com with SMTP id z78so18588387lff.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 09:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714222705-mutt-send-email-mst@kernel.org>
	<71fd872e-ca59-169d-07fb-5e304713fa84@redhat.com>
	<20170715011517-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJZ2p_i-SCi-s5=-xcmg4wORv6B_7kjCyRGb5r8oDBWCQ@mail.gmail.com>
	<20170715021021-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLciE6piWiAo=5r-J6jPQnvj-LWxxbTHsY5d=o-VW7Bsg@mail.gmail.com>
	<CABdb73513u5O0Z5ZBWcKq-UPPAXSTWhibUBEXqrksAiNOXYJfg@mail.gmail.com>
In-Reply-To: <CABdb73513u5O0Z5ZBWcKq-UPPAXSTWhibUBEXqrksAiNOXYJfg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 16:18:22 +0000
Message-ID: <CAJ+F1C+HE1NXFmuhY0sJsZUUQ4F8Ua6wpnnuGA4UrWUzZVOPKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/8] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dave Anderson <anderson@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Tue, Jul 18, 2017 at 6:05 PM Ladi Prosek <lprosek@redhat.com> wrote:

>
> > I would like to hear from Ladi how he intended to use the device in
> > the future, and if he would also prefer ACPI methods and what those
> > methods should be.
>
> We should be able to drive pretty much anything from Windows. I wrote
> a dummy driver for your earlier prototype just to be sure that ACPI
> methods are fine, as I had not done or seen that before.
>
> There are constraints which may be unique to Windows, though. If the
> dump-support data is kept in guest-allocated memory, the guest must be
> able to revoke it (set / call the method with NULL PA?) because
> Windows drivers must free everything on unload. Unlike Linux, I don't
>

Well, the currently proposed vmcoreinfo device has a 4k memory region to
put anything you want, Windows shouldn't be allowed to touch it directly
(e820 regions iirc)

think we can get a piece of memory at startup and keep it for as long
> as the OS running. It would be flagged as a memory leak. But that
> should be easy to have. Can't really think of anything else.
>

The question is what kind of data you want to give to the host to help with
debug. Is this something that can be as simple as addr/size, or you would
rather have a 4k page to put various things there.


>
> >>>
> >>> >> > instead of exporting a physical addess and storing address
> there.  This
> >>> >> > way you can add more methods as you add functionality.
> >>> >>
> >>> >> I'm not saying this is a bad idea (especially because I don't full=
y
> >>> >> understand your point), but I will say that I'm quite sad that you
> are
> >>> >> sending Marc-Andr=C3=A9 back to the drawing board after he posted =
v4 --
> also
> >>> >> invalidating my review efforts. :/
> >>> >>
> >>> >> Laszlo
> >>> >
> >>> > You are right, I should have looked at this sooner. Early RFC
> >>> > suggested writing into fw cfg directly. I couldn't find any
> >>> > discussion around this - why was this abandoned?
> >>>
> >>> Violation (or rather abuse) of layers iirc
> >>
> >> Hmm.  I tried to find discussion about that and failed.  It is availab=
le
> >> through QEMU0002 in ACPI - would it be OK if guests went through that?
> >
> > I wouldn't mind, although merging functionality in a single device
> > isn't what I would think of first. I guess Ladi would be happier with
> > a single device. I suppose it shouldn't break drivers if we had
> > memory, io, methods etc to the device?
>
> Yeah, it would be nice if this was part of pvpanic. Even something
> really simple like:
>
>  /* The bit of supported pv event */
>  #define PVPANIC_F_PANICKED      0
> +#define PVPANIC_F_DUMP_INFO_SET      1
>

QEMU0002 is fw_cfg


>
> -     memory_region_init_io(&s->io, OBJECT(s), &pvpanic_ops, s, "pvpanic"=
,
> 1);
> +    memory_region_init_io(&s->io, OBJECT(s), &pvpanic_ops, s,
> "pvpanic", 32); // or whatever
>
> The guest writes to two or three registers: PA, size, type?, then sets
> the PVPANIC_F_DUMP_INFO_SET bit.
>
> Although not sure if extending the I/O region is OK. And of course I
> only need this on x86 :p
>
>
I would rather have a solution that works on various archs. It's a shame
pvpanic was designed with x86 only in mind imho.

--=20
Marc-Andr=C3=A9 Lureau
