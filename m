Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF6C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4122068E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4122068E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSo2Z-0001y6-K6
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSo1F-0001Qr-Vu
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:09:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:21970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSo19-0006ff-GQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:09:07 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AC6DC7475FE;
 Wed, 14 Oct 2020 23:08:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 81E147475FA; Wed, 14 Oct 2020 23:08:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7E496746383;
 Wed, 14 Oct 2020 23:08:59 +0200 (CEST)
Date: Wed, 14 Oct 2020 23:08:59 +0200 (CEST)
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
In-Reply-To: <CA+E+eSCUdR5tUT5x90iQ-h3cTiS4u=6MnfrGsP0Pj=F75FsnKA@mail.gmail.com>
Message-ID: <1398d4f-211f-2757-e6d7-aa3c7f1b8bcb@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
 <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
 <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
 <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
 <CA+E+eSCUdR5tUT5x90iQ-h3cTiS4u=6MnfrGsP0Pj=F75FsnKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 16:54:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Wed, 14 Oct 2020, Joelle van Dyne wrote:
> Much of the code that uses the macro is like the following (from
> aarch64/tcg-include.inc.c)
>
>        *TCG_CODE_PTR_RW(s, code_ptr) =
>            deposit32(*TCG_CODE_PTR_RW(s, code_ptr), 0, 26, offset);
>
> Before the change, it was just *code_ptr. I'm saying the alternative
> was to have to write "tcg_insn_unit *rw_code_ptr = (tcg_insn_unit
> *)TCG_CODE_PTR_RW(s, code_ptr)" everywhere or else inline cast it.
> Whereas making it return tcg_insn_unit * means only three instances of
> casting to uint8_t *. Using void * means casting at every instance.

It's not C++ so void * does not need to be cast when assigned to some 
other pointer.

> Not opposed to using an inline function over a macro but "inline" is
> not ANSI C. Not sure what this project thinks about that considering
> the style checker prohibits C99 style comments. Personally I don't
> care much.

QEMU has some compiler dependencies, I think only some recent versions of 
gcc and clang are supported and static inline is used elsewhere in the 
code. Richard is an expert on TCG so you can take his advice.

Regards,
BALATON Zoltan

>
> -j
>
> On Wed, Oct 14, 2020 at 1:35 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/14/20 9:03 AM, Joelle van Dyne wrote:
>>>>> static int encode_search(TranslationBlock *tb, uint8_t *block)
>>>>> {
>>>>> -    uint8_t *highwater = tcg_ctx->code_gen_highwater;
>>>>> -    uint8_t *p = block;
>>>>> +    uint8_t *highwater;
>>>>> +    uint8_t *p;
>>>>>     int i, j, n;
>>>>>
>>>>> +    highwater = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx,
>>>>> +                                           tcg_ctx->code_gen_highwater);
>>>>> +    p = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx, block);
>>>>
>>>> Why do you need explicit casts here? Can this be avoided by using
>>>> appropriate type or within the macro (I haven't checked this at all just
>>>> dislike casts as they can hide problems otherwise caught by the compiler).
>>> There's the choice between tcg_insn_unit * and uint8_t *. Since it's
>>> used much more widely in tcg-target.inc.c, it seemed like
>>> tcg_insn_unit * was a better choice.
>>
>> False choice.  This is why tcg_ctx->code_gen_highwater is void*.
>>
>>>>> +#if defined(CONFIG_IOS_JIT)
>>>>> +# define TCG_CODE_PTR_RW(s, code_ptr) \
>>>>> +    (tcg_insn_unit *)((uintptr_t)(code_ptr) + (s)->code_rw_mirror_diff)
>>
>> Better as
>>
>> static inline void *tcg_code_ptr_rw(TCGContext *s, void *rx)
>> {
>> #ifdef CONFIG_IOS_JIT
>>     return rx + s->code_rw_mirror_diff;
>> #else
>>     return rx;
>> #endif
>> }
>>
>>
>> r~
>
>

