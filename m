Received: from eggs.gnu.org ([2001:4830:134:3::10]:52669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuxaw-0008Nr-LE
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuxat-0006kt-H3
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cuxat-0006ih-BA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:44:11 -0400
Message-ID: <1491209040.17505.18.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 03 Apr 2017 10:44:00 +0200
In-Reply-To: <4ccee8ca-8045-784e-5074-3007d8667238@ilande.co.uk>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<4ccee8ca-8045-784e-5074-3007d8667238@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

  Hi,

> I've spent a bit of time over the weekend attempting to convert the
> SPARC CG3/TCX framebuffers over to use your new code and pushed the
> result to my github branch here:
> https://github.com/mcayland/qemu/commits/vga-fixes-sparc.

work/vga-fixes branch updated & rebased to latest master, with your
patches added.

> Using your current git branch, I get an assert() using VGA under
> qemu-system-ppc on startup unless I change the first assert to
> "assert(start >=3D snap->start)".
>=20
> I'm also not convinced by the second assert "assert(start + length <
> snap->end)" either. In the example CG3/TCX conversions I ended up having
> to subtract 1 from the size of the region passed to
> memory_region_snapshot_get_dirty() in order to avoid it firing when
> accessing the last scanline which seems wrong. I didn't explicitly add a
> patch to change this to "<=3D" in my git patchset just in case it broke
> further assumptions in the bitmap code relating to the end address.

Both asserts should use inclusive compare.  Added a patch fixing the
other assert too.

> 2) Redraw issues with CG3/TCX after conversion
>=20
> Despite the conversion from your patches looking reasonably
> straightforward, I still see problems with areas of the screen not
> updating after conversion. I can easily reproduce these locally as follow=
s:
>=20
> ./qemu-system-sparc -vga cg3 -prom-env 'auto-boot?=3Dfalse'
> ./qemu-system-sparc -vga tcx -g 1024x768x8 -prom-env 'auto-boot?=3Dfalse'
> ./qemu-system-sparc -vga tcx -g 1024x768x24 -prom-env 'auto-boot?=3Dfalse=
'

Hmm, I have a blank screen only (yellow with cg3, black with tcx).
No openfirmware prompt showing up ...

> Finally on a slightly unrelated note, the TCX driver still has old code
> for 8 and 16 bpp surfaces in QEMU. Am I right in understanding that all
> surfaces in QEMU are now 32-bit and the 8/16 bpp code can be removed?

Yes, that is correct.  tcx uses qemu_resize_console() so surfaces will
always be 32bpp.

cheers,
  Gerd
