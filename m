Received: from eggs.gnu.org ([2001:4830:134:3::10]:32995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLru-0006gQ-Ev
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLrr-0008TB-FV
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:38:26 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com
	([104.47.37.97]:45124
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fiLrq-0008QE-Tx
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:38:23 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 25 Jul 2018 15:38:18 +0000
Message-ID: <BN7PR08MB4868D3AFC6174A70521418A4C6540@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-14-git-send-email-stefan.markovic@rt-rk.com>,
	<9e3660db-6022-5a6a-1c4f-691ed065c4d6@linaro.org>
In-Reply-To: <9e3660db-6022-5a6a-1c4f-691ed065c4d6@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 13/40] target/mips: Add emulation of
 misc nanoMIPS instructions (pool32a0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi, Richard.

> > +    case NM_SOV:
> > +    {
> > +        TCGv t0 =3D tcg_temp_local_new();
> > +        TCGv t1 =3D tcg_temp_new();
> > +        TCGv t2 =3D tcg_temp_new();
> > +        TCGLabel *l1 =3D gen_new_label();
> > +
> > +        gen_load_gpr(t1, rs);
> > +        gen_load_gpr(t2, rt);
> > +        tcg_gen_add_tl(t0, t1, t2);
> > +        tcg_gen_ext32s_tl(t0, t0);
> > +        tcg_gen_xor_tl(t1, t1, t2);
> > +        tcg_gen_xor_tl(t2, t0, t2);
> > +        tcg_gen_andc_tl(t1, t2, t1);
> > +
> > +        tcg_gen_movi_tl(t0, 0);
> > +        tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
>=20
> tcg_gen_setcondi_tl.
>=20

Would here the correct simplification be:

Replace code segment

tcg_gen_movi_tl(t0, 0);
tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
tcg_gen_movi_tl(t0, 1);
gen_set_label(l1);

with

tcg_gen_setcondi_tl(TCG_COND_GE, t0, t1, 0);
(plus deleting the declaration of l1 of course)

Regards,
Aleksandar M.=
