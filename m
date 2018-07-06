Received: from eggs.gnu.org ([2001:4830:134:3::10]:56633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSX1-0004Lq-Bw
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSWx-0004kG-5j
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:20:23 -0400
Received: from mail-co1nam03on0133.outbound.protection.outlook.com
	([104.47.40.133]:35120
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fbSWw-0004hy-Pd
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:20:19 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 6 Jul 2018 15:20:13 +0000
Message-ID: <BN7PR08MB4868957D4C3531332A504D5AC6470@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530877732-26557-7-git-send-email-aleksandar.markovic@rt-rk.com>,
	<04dc592b-90e5-46be-7ce9-1447642234a0@linaro.org>
In-Reply-To: <04dc592b-90e5-46be-7ce9-1447642234a0@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 6/8] target/mips: Amend CP0 WatchHi
 register implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> > +++ b/target/mips/op_helper.c
> > @@ -893,7 +893,12 @@ target_ulong helper_mfc0_watchlo(CPUMIPSState *env=
, > uint32_t sel)
> >
> >  target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
> >  {
> > -    return env->CP0_WatchHi[sel];
> > +    return (int32_t) env->CP0_WatchHi[sel];
> > +}
> > +
> > +target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
> > +{
> > +    return env->CP0_WatchHi[sel] >> 32;
> >  }
>
> Did you in fact want the high-part sign-extended as well?
> It might be more obvious to write
>
>     return sextract64(env->CP0_WatchHi[sel], 32, 32);
>
> in that case.
>
> > +void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32=
_t sel)
> > +{
> > +    env->CP0_WatchHi[sel] =3D ((uint64_t) (arg1) << 32) |
> > +                            (env->CP0_WatchHi[sel] & 0x00000000fffffff=
fULL);
>
> Cleaner as
>
>     env->CP0_WatchHi[sel] =3D deposit64(env->CP0_WatchHi[sel], 32, 32, ar=
g1);
>
>
> For future cleanup, there is nothing in this (or several other) that requ=
ires
> writing helper code.  This could just as easily be expanded inline with o=
ne
> single load or store operation.
>
>
> r~>

If this all is the case, I am going to remove this patch from this series. =
There is no hurry. This patch just needs to be thought over a little bit mo=
re. It will be sent in some future series.

Regards,
Aleksandar
