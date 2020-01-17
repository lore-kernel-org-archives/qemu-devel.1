Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FBC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9A3206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ks0H8ZJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9A3206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isV7O-0001hB-9V
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1isUzk-0002zf-26
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1isUzg-0001PK-56
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:01:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:43955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1isUzf-0001No-Le
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1579280464;
 bh=+l5lgwPe60qA2plQZtMcd7m2JWOR8cq/BIuX7fUGvNE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ks0H8ZJ1a6HSEInQwfeMd9bT4G27aMlFlpGhlg9ZCDPEy8yIKmDxAvJTtLfqL8bTV
 cCr2zh8+gSf4mhbB8bZkVbCnVx5WQMsos6eTP8SYaZx7X1X4CGO7NvHIeuNwKkiLXO
 /NyWRmAFfyJQVnfonjJ0JYY3J/wSlT+Bi+Fher54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.20.71.116] ([193.16.224.4]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1iuy6048bL-0038p3; Fri, 17
 Jan 2020 18:01:04 +0100
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <7b14c840-0d3f-0c67-06be-81b058c727fb@gmx.de>
 <08c4bdcb-b07d-eb30-a38d-f27ed6400952@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <2c0285e8-5919-e768-c191-f22b9c296208@gmx.de>
Date: Fri, 17 Jan 2020 18:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <08c4bdcb-b07d-eb30-a38d-f27ed6400952@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F6S+FNTrSzkO+te32Nu1jVrGQrlh61y1oqHqIFsrxgPGAggH/pV
 mXUZaF1OVQv1Oz3yfUqFf3O2wKbmhhs2+SUb7YVRIptcbdU1EJRBFlwJkgt8E18VqUVOD1H
 81+AUZLKeSNZVrJBuzNdafgjeaOzNRjKkwzfeqRShE04kD+ZpOohGAMkXRAfClpVtDUKfo3
 VmJsBKZ4pKZtBDya2Yp8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2XcR5WxR7UQ=:MKTp4kiCo9UkB6FfNptuX4
 6AFkg7PePYVSq9Q4XO7kBZZbhDh6j9/XUAt1g91ukG/EJLC6taA27zdDGRULa8MueyoT8OCFL
 4c46pnLXSjUH8GRc20U3GJ9Uve8sEm0yqklMLN0a1+pcxCLvXVkmmvbm4QFc48KH4xbbOrign
 +lCoVaLBc8VEzrxxNJjTtQ1BVPWrQwxFku7bAvUakhvTcb+mFsVma7+8s4Ac4w54+ea5Zxu4T
 2M3kgvMsA71H+QhamcvFEsF4DtBtdipLW5y2TZgx5UE3MibkkilmASdAjw3fS13r6/x8wJZ/D
 iXQTGb8uE7csbr5+zH+YZna5cvMFEYVljWUFjC+YAdSQWz+To5sB90SU+u3ycYnFwotNLfl/1
 ccwKwmEfB2l5YesFCs7mq5nrT+yqYFr7xRo2kdyIUXhjXVTsnOZsLFGYNJG3Gg4SFodwQvdoN
 OMaNnuSt3e6CgxiYXkB5SVBB/HZ5la2o/xa1G0Q2nS+ZQJbfxPar3OcH+Ng3B7iVUr52QgKw+
 rwb1+W6qmLGPtAEeHd68fbaOgX5f9Pgsi7P4Czj0yoTS1thFRXhFW1fFKEMX1MnVod3g1uNU7
 5JPERKapqvY+2gh4lh01g8Myj8gZMcr9Ehp3F+uhdHl9pCF0XuscytWTXlv+CcR2kgdQjnWqI
 D4jFC/ZRQ3oewY5IQH7km3gY95mlhk2SQM3Gk9iijS4cr4QPQ82LFvdvpQ/mcQJyNI8NYc1BG
 54NPGPZLJlxyjgj4j5hwoeAN2SXHiB44FPnjTXqZz+GPeBhnTYwEuQWfB19Ixog127DHofm/P
 5n7ET3y+wVsyJQ2mnphPsYZxp5U6dOjuxXNUC8EbNwfgmCTH8TYj0h9qT4v2IiqfMgkGoyGW4
 AUAnWaK+yvLvGMq2+49OOfNEYGk55If1QeZgi5NJv4CvAfkt2lvFz8evQjElFPsBO2z1GU1n0
 B9Kmxr5wVYXwIDwwjkUhVIJ/RLjSOT7jI8LlryqQZBFdcXDxZEB6caWbeNx4o7ILi56b53ntH
 wuVA9F+Numf1qRJ06d7eJnZupPDrm31gNpQG4osy/8/nNyuuYuCFZGUmvk2CoYbJqZIV0a/ov
 ILKgkWGdsMobF/tb16jjajOwFasGBOJCUhEZYJaCaFLfVGiqXfNTvbFbi55+RaKp89S2RWrYz
 WfrSe25kMoSEv0atbf+7LK7NV4xA5kF+mqFpqRvDCEkTNRb9fElkEpDKjeyfZJrW7kb1aedGG
 Eg/YfBjv15p+FRB+LNnvmFojONSHN6z8ffhjyuQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.20
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: dave.anglin@bell.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.01.20 17:13, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/17/20 4:49 PM, Helge Deller wrote:
>> On 17.01.20 02:53, Richard Henderson wrote:
>>> The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
>>> or the operation is undefined.=C2=A0 However, real hardware only gener=
ates
>>> an unaligned access trap for unaligned mod 4.
>>>
>>> Match real hardware, but diagnose with GUEST_ERROR a violation of the
>>> specification.
>>>
>>> Reported-by: Helge Deller <deller@gmx.de>
>>> Suggested-by: John David Anglin <dave.anglin@bell.net>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> Helge, can you please test this against your failing kernel?
>>> You will of course want to add -D logfile -d guest_errors to
>>> you qemu command-line.
>>
>> Yes, works as expected.
>> Thanks!
>>
>> Please add:
>> Tested-by: Helge Deller <deller@gmx.de>
>>
>>
>> [deller]$ tail -f logfile
>> Undefined ldc to address unaligned mod 16: 00000504fa6c7848
>> Undefined ldc to address unaligned mod 16: 00000504fa6c7a48
>> Undefined ldc to address unaligned mod 16: 00000506f9434848
>> Undefined ldc to address unaligned mod 16: 00000506f9434a48
>> Undefined ldc to address unaligned mod 16: 00000508fa036848
>> Undefined ldc to address unaligned mod 16: 00000508fa036a48
>> Undefined ldc to address unaligned mod 16: 0000050afa8c4848
>> Undefined ldc to address unaligned mod 16: 0000050afa8c4a48
>> Undefined ldc to address unaligned mod 16: 0000050cf94d1848
>> Undefined ldc to address unaligned mod 16: 0000050cf94d1a48
>> ....
>>
>>
>>
>>>
>>>
>>> r~
>>>
>>> ---
>>> =C2=A0 target/hppa/helper.h=C2=A0=C2=A0=C2=A0 | 2 ++
>>> =C2=A0 target/hppa/op_helper.c | 9 +++++++++
>>> =C2=A0 target/hppa/translate.c | 6 +++++-
>>> =C2=A0 3 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/hppa/helper.h b/target/hppa/helper.h
>>> index 38d834ef6b..2d483aab58 100644
>>> --- a/target/hppa/helper.h
>>> +++ b/target/hppa/helper.h
>>> @@ -17,6 +17,8 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, =
void, env, tl, tr)
>>> =C2=A0 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
>>> =C2=A0 DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, =
tl, tr)
>>>
>>> +DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
>>> +
>>> =C2=A0 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32=
)
>>>
>>> =C2=A0 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
>>> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
>>> index f0516e81f1..345cef2c08 100644
>>> --- a/target/hppa/op_helper.c
>>> +++ b/target/hppa/op_helper.c
>>> @@ -153,6 +153,15 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, t=
arget_ulong addr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_stby_e(env, addr, val, true, GETPC()=
);
>>> =C2=A0 }
>>>
>>> +void HELPER(ldc_check)(target_ulong addr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (unlikely(addr & 0xf)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_GUEST_ER=
ROR,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Undefined ldc t=
o address unaligned mod 16: "
>
> "to unaligned address mod 16"?
>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TARGET_FMT_lx "\=
n", addr);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> =C2=A0 target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint32_t level, uint32_t want)
>>> =C2=A0 {
>>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>>> index 2f8d407a82..669381dc1d 100644
>>> --- a/target/hppa/translate.c
>>> +++ b/target/hppa/translate.c
>>> @@ -2942,7 +2942,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst=
 *a)
>>>
>>> =C2=A0 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 MemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;
>>> +=C2=A0=C2=A0=C2=A0 MemOp mop =3D MO_TE | MO_ALIGN | a->size;
>
>
> Hmmm you changed MO_TEUL -> MO_TE, so from MO_32 to MO_8.
>
> Per your description, shouldn't this be MO_TEUL | MO_ALIGN_4?

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCGv_reg zero, dest, ofs;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCGv_tl addr;
>>>
>>> @@ -2958,8 +2958,12 @@ static bool trans_ldc(DisasContext *ctx, arg_ld=
st *a)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 form_gva(ctx, &addr, &ofs, a->b, a->x, =
a->scale ? a->size : 0,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 a->disp, a->sp, a->m, ctx->mmu_idx =3D=3D MMU_PHYS_IDX);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 gen_helper_ldc_check(addr);

Actually, for 64-bit the address is allowed to be 4-byte aligned, as long =
as the
"co" completer is given, e.g. this would be OK:  "ldcw,co  0(addr),%reg".
Maybe adding something like (if TARGET_32BIT...) now would make sense, so =
we don't get it
wrong when 64bit gets added?

Helge



>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zero =3D tcg_const_reg(0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_atomic_xchg_reg(dest, addr, zer=
o, ctx->mmu_idx, mop);
>>> +=C2=A0=C2=A0=C2=A0 tcg_temp_free(zero);
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (a->m) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save_gpr(ctx, a=
->b, ofs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>
>>
>


