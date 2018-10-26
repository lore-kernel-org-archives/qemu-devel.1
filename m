Received: from eggs.gnu.org ([2001:4830:134:3::10]:55590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG7VA-0004aX-77
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG7V2-0007Oi-2Z
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:10:29 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com
	([40.107.72.115]:42952
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG7Uw-0007L4-6y
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:10:19 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 19:10:10 +0000
Message-ID: <BN6PR2201MB12514799F1567A35C31C83F7C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
	<1540563667-23300-6-git-send-email-stefan.markovic@rt-rk.com>,
	<CAFEAcA8-nJ1pKtNautOJ-+Zh0Onw3HoK26ABZozSj3_VR7C=Jg@mail.gmail.com>
In-Reply-To: <CAFEAcA8-nJ1pKtNautOJ-+Zh0Onw3HoK26ABZozSj3_VR7C=Jg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 5/6] Determine the desired FPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [Qemu-devel] [PATCH 5/6] Determine the desired FPU mode
>=20
> On 26 October 2018 at 15:21, Stefan Markovic <stefan.markovic@rt-rk.com> =
wrote:
> > From: Stefan Markovic <smarkovic@wavecomp.com>
> >
> > Floating-point mode is calculated from MIPS.abiflags FP ABI value
> > (based on kernel implementation). Illegal combinations are rejected.
> >
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  linux-user/mips/cpu_loop.c | 75 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 75 insertions(+)
>=20
> > +     if ((info->fp_abi > MAX_FP_ABI && info->fp_abi !=3D MIPS_ABI_FP_U=
NKNOWN)
> > +        || (info->interp_fp_abi > MAX_FP_ABI &&
> > +            info->interp_fp_abi !=3D MIPS_ABI_FP_UNKNOWN)) {
> > +        fprintf(stderr, "qemu: Program and interpreter have "
> > +                        "unexpected FPU modes\n");
> > +        exit(137);
>=20
> Why are we exit()ing with a funny exit status code here?
>=20
> If this is a "can't happen" case, then we should assert(). If
> it is a "can happen if fed an odd binary" case, then we should just
> exit(1) as we do already in this function for an unsupported NaN mode.
>=20

Thanks for the review.

This is a "can happen if fed an odd binary" case. Or, in other words, and m=
ore precisely, an executable compiled with one FP option attempts to load a=
 library compiled with another, incompatible, FP option.

Kernel counterpart lines are:

https://elixir.bootlin.com/linux/v4.19/source/arch/mips/kernel/elf.c#L211
https://elixir.bootlin.com/linux/v4.19/source/arch/mips/kernel/elf.c#L263

I think the error code is important for MIPS loader to work as designed in =
such cases. Stefan should be best positioned to explain and analyze the cas=
es, since he worked on verifying and fixing involved scenarios, not only fr=
om QEMU perspective. However, he will be back most likely only on Monday.

Thanks again,
Aleksandar

> > +    }
> > +
> > +    prog_req =3D (info->fp_abi =3D=3D MIPS_ABI_FP_UNKNOWN) ? none_req
> > +                                            : fpu_reqs[info->fp_abi];
> > +    interp_req =3D (info->interp_fp_abi =3D=3D MIPS_ABI_FP_UNKNOWN) ? =
none_req
> > +                                            : fpu_reqs[info->interp_fp=
_abi];
> > +
> > +    prog_req.single &=3D interp_req.single;
> > +    prog_req.soft &=3D interp_req.soft;
> > +    prog_req.fr1 &=3D interp_req.fr1;
> > +    prog_req.frdefault &=3D interp_req.frdefault;
> > +    prog_req.fre &=3D interp_req.fre;
> > +
> > +    bool cpu_has_mips_r2_r6 =3D env->insn_flags & ISA_MIPS32R2 ||
> > +                              env->insn_flags & ISA_MIPS64R2 ||
> > +                              env->insn_flags & ISA_MIPS32R6 ||
> > +                              env->insn_flags & ISA_MIPS64R6;
> > +
> > +    if (prog_req.fre && !prog_req.frdefault && !prog_req.fr1) {
> > +        env->CP0_Config5 |=3D (1 << CP0C5_FRE);
> > +        if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
> > +            env->hflags |=3D MIPS_HFLAG_FRE;
> > +        }
> > +    } else if ((prog_req.fr1 && prog_req.frdefault) ||
> > +         (prog_req.single && !prog_req.frdefault)) {
> > +        if ((env->active_fpu.fcr0 & (1 << FCR0_F64)
> > +            && cpu_has_mips_r2_r6) || prog_req.fr1) {
> > +            env->CP0_Status |=3D (1 << CP0St_FR);
> > +            env->hflags |=3D MIPS_HFLAG_F64;
> > +        }
> > +    } else  if (!prog_req.fre && !prog_req.frdefault &&
> > +          !prog_req.fr1 && !prog_req.single && !prog_req.soft) {
> > +        exit(137);
> > +    }
>=20
> Ditto here (and we haven't printed any error message here...)
>=20
> thanks
> -- PMM
> =
