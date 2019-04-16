Received: from eggs.gnu.org ([209.51.188.92]:33673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGVVX-0002eN-Sq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGVVW-0003b5-K4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:47 -0400
Received: from mail-eopbgr800109.outbound.protection.outlook.com
	([40.107.80.109]:42400
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGVVW-0003Yq-6X
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 16 Apr 2019 21:20:42 +0000
Message-ID: <BN6PR2201MB1251458C6A26DEE093C282EEC6240@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-5-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=i3H+aMaOCqMBkK4r9E4Ezqtyqw=VbwNmJZ6Wnc3in5PA@mail.gmail.com>,
	<bcc405c5-2e96-19a9-123e-bc607c243209@rt-rk.com>
In-Reply-To: <bcc405c5-2e96-19a9-123e-bc607c243209@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 4/4] target/mips: Optimize
 ILVR.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >>
> >> +void helper_msa_ilvr_b(CPUMIPSState *env, uint32_t wd,
> >> +                       uint32_t ws, uint32_t wt)
> >> +{
> >> +    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> >> +    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
> >> +    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
> >> +
> > Why do we use here env->active_fpu.fpr[wd].wr, while for other instruct=
ions in
> > this patch, we access msa_wr_d<b|h|w|d[] directly?
> With a pointer to wr_t we have an array of bytes, halfwords, words or
> doublewords
> and can read from them and change them like an ordinary array. In other
> cases
> we use a variable that is TCGv_i64 and would have to use tcg_gen
> functions to
> modify the value of the register. Before my changes in ilvr instruction
> helpers
> env->active_fpu.fpr[wd].wr was used, so I just copy-pasted that.
>

Your answer touches just surface, and doesn't fully answer my question.
I would like you to show deeper understanding of the code you are working
with. You can't just copy/paste without thinking.

Why do majority of MSA helpers use env->active_fpu.fpr[<index>].wr, while
your code mostly reference the MSA register directly? Is this the same
thing? If yes, why all MSA code doesn't use registers directly, which
would certainly be simpler than referencing active_fpu? What is the role
of "active_fpu"? Can it be changed? Can you analyze the underlying
reasons for referencing "active_fpu", and can you claim that it is safe
to circumvent it and reference the MSA registers directly?

Thanks,
Aleksandar
