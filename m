Received: from eggs.gnu.org ([2001:4830:134:3::10]:55932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Stefan.Markovic@rt-rk.com>) id 1gH7Pm-0000rQ-B1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Stefan.Markovic@rt-rk.com>) id 1gH7Pj-0003fa-1I
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:17:06 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:37643 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Stefan.Markovic@rt-rk.com>)
	id 1gH7Pi-0002qS-J3
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:17:02 -0400
in-reply-to: <CAFEAcA8-nJ1pKtNautOJ-+Zh0Onw3HoK26ABZozSj3_VR7C=Jg@mail.gmail.com>
from: "Stefan Markovic" <Stefan.Markovic@rt-rk.com>
message-id: <ec5-5bd70800-1f-6e41d300@100209352>
date: Mon, 29 Oct 2018 14:15:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/ID89PT91dGYtOD9xPyBbUEFU?=
 =?utf-8?q?CH_5/6=5D_Determine_the_desired_FPU_mode?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>


exit() error codes are taken and left over from related kernel code. Wi=
ll be set to 1 in next series version. Also, appropriate error messages=
 printing will be added.

Regards,
Stefan

-------- Original Message --------
Subject: Re: [Qemu-devel] [PATCH 5/6] Determine the desired FPU mode
Date: Friday, October 26, 2018 20:12 CEST
From: Peter Maydell <peter.maydell@linaro.org>
To: Stefan Markovic <stefan.markovic@rt-rk.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovi=
c@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Aleksandar Markovic =
<amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Lauren=
t Vivier <laurent@vivier.eu>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.co=
m> <1540563667-23300-6-git-send-email-stefan.markovic@rt-rk.com>


=C2=A0On 26 October 2018 at 15:21, Stefan Markovic <stefan.markovic@rt-=
rk.com> wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Floating-point mode is calculated from MIPS.abiflags FP ABI value
> (based on kernel implementation). Illegal combinations are rejected.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
> linux-user/mips/cpu=5Floop.c | 75 +++++++++++++++++++++++++++++++++++=
+++++++++++
> 1 file changed, 75 insertions(+)

> + if ((info->fp=5Fabi > MAX=5FFP=5FABI && info->fp=5Fabi !=3D MIPS=5F=
ABI=5FFP=5FUNKNOWN)
> + || (info->interp=5Ffp=5Fabi > MAX=5FFP=5FABI &&
> + info->interp=5Ffp=5Fabi !=3D MIPS=5FABI=5FFP=5FUNKNOWN)) {
> + fprintf(stderr, "qemu: Program and interpreter have "
> + "unexpected FPU modes\n");
> + exit(137);

Why are we exit()ing with a funny exit status code here?

If this is a "can't happen" case, then we should assert(). If
it is a "can happen if fed an odd binary" case, then we should just
exit(1) as we do already in this function for an unsupported NaN mode.

> + }
> +
> + prog=5Freq =3D (info->fp=5Fabi =3D=3D MIPS=5FABI=5FFP=5FUNKNOWN) ? =
none=5Freq
> + : fpu=5Freqs[info->fp=5Fabi];
> + interp=5Freq =3D (info->interp=5Ffp=5Fabi =3D=3D MIPS=5FABI=5FFP=5F=
UNKNOWN) ? none=5Freq
> + : fpu=5Freqs[info->interp=5Ffp=5Fabi];
> +
> + prog=5Freq.single &=3D interp=5Freq.single;
> + prog=5Freq.soft &=3D interp=5Freq.soft;
> + prog=5Freq.fr1 &=3D interp=5Freq.fr1;
> + prog=5Freq.frdefault &=3D interp=5Freq.frdefault;
> + prog=5Freq.fre &=3D interp=5Freq.fre;
> +
> + bool cpu=5Fhas=5Fmips=5Fr2=5Fr6 =3D env->insn=5Fflags & ISA=5FMIPS3=
2R2 ||
> + env->insn=5Fflags & ISA=5FMIPS64R2 ||
> + env->insn=5Fflags & ISA=5FMIPS32R6 ||
> + env->insn=5Fflags & ISA=5FMIPS64R6;
> +
> + if (prog=5Freq.fre && !prog=5Freq.frdefault && !prog=5Freq.fr1) {
> + env->CP0=5FConfig5 |=3D (1 << CP0C5=5FFRE);
> + if (env->active=5Ffpu.fcr0 & (1 << FCR0=5FFREP)) {
> + env->hflags |=3D MIPS=5FHFLAG=5FFRE;
> + }
> + } else if ((prog=5Freq.fr1 && prog=5Freq.frdefault) ||
> + (prog=5Freq.single && !prog=5Freq.frdefault)) {
> + if ((env->active=5Ffpu.fcr0 & (1 << FCR0=5FF64)
> + && cpu=5Fhas=5Fmips=5Fr2=5Fr6) || prog=5Freq.fr1) {
> + env->CP0=5FStatus |=3D (1 << CP0St=5FFR);
> + env->hflags |=3D MIPS=5FHFLAG=5FF64;
> + }
> + } else if (!prog=5Freq.fre && !prog=5Freq.frdefault &&
> + !prog=5Freq.fr1 && !prog=5Freq.single && !prog=5Freq.soft) {
> + exit(137);
> + }

Ditto here (and we haven't printed any error message here...)

thanks
-- PMM
=C2=A0
