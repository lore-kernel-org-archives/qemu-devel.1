Received: from eggs.gnu.org ([2001:4830:134:3::10]:48619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS26T-0003z5-P0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS26R-00075U-UL
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:50:17 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gS26R-00074G-On
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:50:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id x202so22917042oif.13
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20181127145043.18545-1-f4bug@amsat.org>
	<c23486c2-e55e-4b88-7a70-76a77f6de1eb@weilnetz.de>
In-Reply-To: <c23486c2-e55e-4b88-7a70-76a77f6de1eb@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Nov 2018 15:50:02 +0000
Message-ID: <CAFEAcA9JWR41fi=3+E452+K1G2toCnygV8aFpa1O_7K87B6zfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] configure: Disable the nanoMIPS
 disassembler on big endian hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 28 Nov 2018 at 14:59, Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 27.11.2018 um 15:50 schrieb Philippe Mathieu-Daud=C3=A9:
> > Stefan noticed the nanoMIPS disassembler uses incorrect format strings
> > on big endian hosts.
> >
> > On big endian hosts, the output will appear as:
> >
> > $ qemu-system-mipsel -M malta -cpu I7200 -semihosting \
> >   -bios nanoboot.bin -d in_asm
> > 0xbfc0000: Asm output not supported on this arch
> >
> > Reported-by: Stefan Weil <sw@weilnetz.de>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  configure | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 0a3c6a72c3..83a7c4746e 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7382,7 +7382,11 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
> >    mips*)
> >      disas_config "MIPS"
> >      if test -n "${cxx}"; then
> > -      disas_config "NANOMIPS"
> > +      # The nanomips disassembler currently does not work correctly
> > +      # on big endian host.
> > +      if test "$bigendian" =3D "no" ; then
> > +        disas_config "NANOMIPS"
> > +      fi
> >      fi
> >    ;;
> >    moxie*)
>
>
> Thank you. This looks like a patch which might be acceptable for 3.1.
>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>

It seems a bit like overkill to me. We could just mark it
as a known issue for 3.1. After all it seems unlikely that
many people will be running TCG MIPS on a big-endian host,
and if they are then "debug disassembly with some immediate
values incorrect" might be more useful than "none at all".

thanks
-- PMM
