Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfDds-0005N9-F6
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfDdr-0004AP-GV
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:38:12 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfDdr-0004AC-A9
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:38:11 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v77so30615518wmv.0
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 14:38:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170207183356.17840-3-laurent@vivier.eu>
References: <20170207183356.17840-1-laurent@vivier.eu>
	<20170207183356.17840-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Feb 2017 22:37:49 +0000
Message-ID: <CAFEAcA8i8r4to8XmQwpd3h_7=tSUsu1qP9UHYcEd0vJSCo950w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] m68k: implement server and client side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2017 at 18:33, Laurent Vivier <laurent@vivier.eu> wrote:
> This also adds the basic test file and the configuration update.
>
> This implementation can only test instructions with values in register an=
d
> no memory access.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Hi; I got round to setting up my machine with an m68k cross
compiler so I can at least compile-test the other target
architectures, and I noticed this code generates compiler
warnings:

> +/* reginfo_dump: print state to a stream, returns nonzero on success */
> +void reginfo_dump(struct reginfo *ri, int is_master)
> +{
> +    int i;
> +    if (is_master) {
> +        fprintf(stderr, "  pc            \e[1;101;37m0x%08x\e[0m\n",
> +                ri->pc);
> +    }
> +    fprintf(stderr, "\tPC: %08x\n", ri->gregs[R_PC]);
> +    fprintf(stderr, "\tPS: %04x\n", ri->gregs[R_PS]);
> +
> +    for (i =3D 0; i < 8; i++) {
> +        fprintf(stderr, "\tD%d: %8x\tA%d: %8x\n", i, ri->gregs[i],
> +                i, ri->gregs[i + 8]);
> +    }
> +
> +
> +    for (i =3D 0; i < 8; i++) {
> +        fprintf(stderr, "\tFP%d: %08x %08x %08x\n", i,
> +                ri->fpregs.f_fpregs[i * 3], ri->fpregs.f_fpregs[i * 3 + =
1],
> +                ri->fpregs.f_fpregs[i * 3 + 2]);

/home/pm215/risu/risu_reginfo_m68k.c:95:37: warning: format =E2=80=98%x=E2=
=80=99
expects argument of type =E2=80=98unsigned int=E2=80=99, but argument 4 has=
 type =E2=80=98int
*=E2=80=99 [-Wformat=3D]
         fprintf(stderr, "\tFP%d: %08x %08x %08x\n", i,
                                     ^

and similarly for the other 3 f_fpregs[] arguments here
and in the fprintf calls in reginfo_dump_mismatch().

Looking at the m68k sys/ucontext.h its definition of
struct fpregset is
#ifdef __mcoldfire__
  int f_fpregs[8][2];
#else
  int f_fpregs[8][3];
#endif

so it's a 2d array, not a 1d array.

Any suggestions for how to fix the code? The whole file
seems to treat f_fpregs as a 1d array...

thanks
-- PMM
