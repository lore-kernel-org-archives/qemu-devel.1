Received: from eggs.gnu.org ([2001:4830:134:3::10]:47896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fiP8R-0000Zy-Nf
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fiP8O-0001Qr-Mx
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:07:43 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fiP8O-0001PC-EL
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:07:40 -0400
Received: by mail-pl0-x244.google.com with SMTP id z7-v6so3676360plo.9
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 12:07:40 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-14-git-send-email-stefan.markovic@rt-rk.com>
	<9e3660db-6022-5a6a-1c4f-691ed065c4d6@linaro.org>
	<BN7PR08MB4868D3AFC6174A70521418A4C6540@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <31897197-d799-719f-9604-2dde39d7fdf2@linaro.org>
Date: Wed, 25 Jul 2018 12:07:31 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868D3AFC6174A70521418A4C6540@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 07/25/2018 08:38 AM, Aleksandar Markovic wrote:
> Hi, Richard.
> 
>>> +    case NM_SOV:
>>> +    {
>>> +        TCGv t0 = tcg_temp_local_new();
>>> +        TCGv t1 = tcg_temp_new();
>>> +        TCGv t2 = tcg_temp_new();
>>> +        TCGLabel *l1 = gen_new_label();
>>> +
>>> +        gen_load_gpr(t1, rs);
>>> +        gen_load_gpr(t2, rt);
>>> +        tcg_gen_add_tl(t0, t1, t2);
>>> +        tcg_gen_ext32s_tl(t0, t0);
>>> +        tcg_gen_xor_tl(t1, t1, t2);
>>> +        tcg_gen_xor_tl(t2, t0, t2);
>>> +        tcg_gen_andc_tl(t1, t2, t1);
>>> +
>>> +        tcg_gen_movi_tl(t0, 0);
>>> +        tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
>>
>> tcg_gen_setcondi_tl.
>>
> 
> Would here the correct simplification be:
> 
> Replace code segment
> 
> tcg_gen_movi_tl(t0, 0);
> tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
> tcg_gen_movi_tl(t0, 1);
> gen_set_label(l1);
> 
> with
> 
> tcg_gen_setcondi_tl(TCG_COND_GE, t0, t1, 0);
> (plus deleting the declaration of l1 of course)

Nearly.  You're branching over a move of 1, and so computing the inverse of the
condition.  So the correct replacement is

  tcg_gen_setcondi_tl(TCG_COND_LT, t0, t1, 0);


r~
