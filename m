Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9186BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26BB22250
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26BB22250
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnoU-0005ro-Qt
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSnne-0005FR-3k
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:55:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSnnZ-0004im-Vj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:55:05 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DF403747611;
 Wed, 14 Oct 2020 22:54:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C066A747610; Wed, 14 Oct 2020 22:54:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BEACF74760D;
 Wed, 14 Oct 2020 22:54:50 +0200 (CEST)
Date: Wed, 14 Oct 2020 22:54:50 +0200 (CEST)
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
In-Reply-To: <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
Message-ID: <7372bc50-a0d4-4c4-fb6-c18f3ab327df@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
 <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
 <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
 <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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
 Joelle van Dyne <j@getutm.app>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Wed, 14 Oct 2020, Richard Henderson wrote:
> On 10/14/20 9:03 AM, Joelle van Dyne wrote:
>>>> static int encode_search(TranslationBlock *tb, uint8_t *block)
>>>> {
>>>> -    uint8_t *highwater = tcg_ctx->code_gen_highwater;
>>>> -    uint8_t *p = block;
>>>> +    uint8_t *highwater;
>>>> +    uint8_t *p;
>>>>     int i, j, n;
>>>>
>>>> +    highwater = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx,
>>>> +                                           tcg_ctx->code_gen_highwater);
>>>> +    p = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx, block);
>>>
>>> Why do you need explicit casts here? Can this be avoided by using
>>> appropriate type or within the macro (I haven't checked this at all just
>>> dislike casts as they can hide problems otherwise caught by the compiler).
>> There's the choice between tcg_insn_unit * and uint8_t *. Since it's
>> used much more widely in tcg-target.inc.c, it seemed like
>> tcg_insn_unit * was a better choice.
>
> False choice.  This is why tcg_ctx->code_gen_highwater is void*.
>
>>>> +#if defined(CONFIG_IOS_JIT)
>>>> +# define TCG_CODE_PTR_RW(s, code_ptr) \
>>>> +    (tcg_insn_unit *)((uintptr_t)(code_ptr) + (s)->code_rw_mirror_diff)
>
> Better as
>
> static inline void *tcg_code_ptr_rw(TCGContext *s, void *rx)
> {
> #ifdef CONFIG_IOS_JIT
>    return rx + s->code_rw_mirror_diff;

This looks better but can you add to void *? I think some compilers may 
complain about that so may need to cast here to uint8_t * then back to 
void * but that's at least within this func or maybe declare rx as uint_t 
* and return void *? Or is rx promoted to the type of 
s->code_rw_mirror_diff and that avoids the warning? If the gcc and clang 
versions we care about don't mind then it's simpler without a cast as you 
suggest.

Regards,
BALATON Zoltan

> #else
>    return rx;
> #endif
> }
>
>
> r~
>
>

