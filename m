Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59EC46477
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB77720657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB77720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqiv-0002KV-0t
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcqHV-0007Pf-Op
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcqHT-0007WX-2A
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:58:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55831 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hcqHL-0007MJ-3b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:58:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0211D1A224F;
 Mon, 17 Jun 2019 13:58:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.132] (rtrkw870-lin.domain.local [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id C04211A1E6F;
 Mon, 17 Jun 2019 13:58:23 +0200 (CEST)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1559816130-17113-5-git-send-email-stefan.brankovic@rt-rk.com>
 <fac722ec-ea35-80c5-5820-2ff9d1296620@linaro.org>
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <668541d9-cc9a-0fce-81f5-887e4b0b4fa6@rt-rk.com>
Date: Mon, 17 Jun 2019 13:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fac722ec-ea35-80c5-5820-2ff9d1296620@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH 4/8] target/ppc: Optimize emulation of
 vgbbd instruction
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6.6.19. 20:19, Richard Henderson wrote:
> On 6/6/19 5:15 AM, Stefan Brankovic wrote:
>> Optimize altivec instruction vgbbd (Vector Gather Bits by Bytes by Doubleword)
>> All ith bits (i in range 1 to 8) of each byte of doubleword element in
>> source register are concatenated and placed into ith byte of appropriate
>> doubleword element in destination register.
>>
>> Following solution is done for every doubleword element of source register
>> (placed in shifted variable):
>> We gather bits in 2x8 iterations.
>> In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of byte 8 are
>> in their final spots so we just and avr with mask. For every next iteration,
>> we have to shift right both shifted(7 places) and mask(8 places), so we get
>> bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in right places so we and
>> shifted with new value of mask... After first 8 iteration(first for loop) we
>> have all first bits in their final place all second bits but second bit from
>> eight byte in their place,... only 1 eight bit from eight byte is in it's
>> place), so we and result1 with mask1 to save those bits that are at right
>> place and save them in result1. In second loop we do all operations
>> symetrical, so we get other half of bits on their final spots, and save
>> result in result2. Or of result1 and result2 is placed in appropriate
>> doubleword element of vD. We repeat this 2 times.
>>
>> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
>> ---
>>   target/ppc/translate/vmx-impl.inc.c | 99 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 98 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
>> index 87f69dc..010f337 100644
>> --- a/target/ppc/translate/vmx-impl.inc.c
>> +++ b/target/ppc/translate/vmx-impl.inc.c
>> @@ -780,6 +780,103 @@ static void trans_vsr(DisasContext *ctx)
>>       tcg_temp_free_i64(tmp);
>>   }
>>   
>> +/*
>> + * vgbbd VRT,VRB - Vector Gather Bits by Bytes by Doubleword
>> + *
>> + * All ith bits (i in range 1 to 8) of each byte of doubleword element in source
>> + * register are concatenated and placed into ith byte of appropriate doubleword
>> + * element in destination register.
>> + *
>> + * Following solution is done for every doubleword element of source register
>> + * (placed in shifted variable):
>> + * We gather bits in 2x8 iterations.
>> + * In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of byte 8 are
>> + * in their final spots so we just and avr with mask. For every next iteration,
>> + * we have to shift right both shifted(7 places) and mask(8 places), so we get
>> + * bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in right places so we and
>> + * shifted with new value of mask... After first 8 iteration(first for loop) we
>> + * have all first bits in their final place all second bits but second bit from
>> + * eight byte in their place,... only 1 eight bit from eight byte is in it's
>> + * place), so we and result1 with mask1 to save those bits that are at right
>> + * place and save them in result1. In second loop we do all operations
>> + * symetrical, so we get other half of bits on their final spots, and save
>> + * result in result2. Or of result1 and result2 is placed in appropriate
>> + * doubleword element of vD. We repeat this 2 times.
>> + */
>> +static void trans_vgbbd(DisasContext *ctx)
>> +{
>> +    int VT = rD(ctx->opcode);
>> +    int VB = rB(ctx->opcode);
>> +    TCGv_i64 tmp = tcg_temp_new_i64();
>> +    TCGv_i64 avr = tcg_temp_new_i64();
>> +    TCGv_i64 shifted = tcg_temp_new_i64();
>> +    TCGv_i64 result1 = tcg_temp_new_i64();
>> +    TCGv_i64 result2 = tcg_temp_new_i64();
>> +    uint64_t mask = 0x8040201008040201ULL;
>> +    uint64_t mask1 = 0x80c0e0f0f8fcfeffULL;
>> +    uint64_t mask2 = 0x7f3f1f0f07030100ULL;
>> +    int i;
>> +
>> +    get_avr64(avr, VB, true);
>> +    tcg_gen_movi_i64(result1, 0x0ULL);
>> +    tcg_gen_mov_i64(shifted, avr);
>> +    for (i = 0; i < 8; i++) {
>> +        tcg_gen_andi_i64(tmp, shifted, mask);
>> +        tcg_gen_or_i64(result1, result1, tmp);
>> +
>> +        tcg_gen_shri_i64(shifted, shifted, 7);
>> +        mask = mask >> 8;
>> +    }
>> +    tcg_gen_andi_i64(result1, result1, mask1);
> This masking appears to be redundant with the masking within the loop.
>
>> +
>> +    mask = 0x8040201008040201ULL;
>> +    tcg_gen_movi_i64(result2, 0x0ULL);
>> +    for (i = 0; i < 8; i++) {
>> +        tcg_gen_andi_i64(tmp, avr, mask);
>> +        tcg_gen_or_i64(result2, result2, tmp);
>> +
>> +        tcg_gen_shli_i64(avr, avr, 7);
>> +        mask = mask << 8;
>> +    }
>> +    tcg_gen_andi_i64(result2, result2, mask2);
> Similarly.
>
> Also, the first iteration of the second loop is redundant with the first
> iteration of the first loop.
>
> I will also note that these are large constants, not easily constructable.
> Therefore it would be best to avoid needing to construct them twice.  You can
> do this by processing the two doublewords simultaneously.  e.g.
>
> 	TCGv_i64 avr[2], out[2], tmp, tcg_mask;
>
> 	identity_mask = 0x8040201008040201ull;
> 	tcg_gen_movi_i64(tcg_mask, identity_mask);
> 	for (j = 0; j < 2; j++) {
> 	    get_avr(avr[j], VB, j);
> 	    tcg_gen_and_i64(out[j], avr[j], tcg_mask);
> 	}
> 	for (i = 1; i < 8; i++) {
> 	    tcg_gen_movi_i64(tcg_mask, identity_mask >> (i * 8);
> 	    for (j = 0; j < 2; j++) {
> 	        tcg_gen_shri_i64(tmp, avr[j], i * 7);
> 	        tcg_gen_and_i64(tmp, tmp, tcg_mask);
> 	        tcg_gen_or_i64(out[j], out[j], tmp);
> 	    }
> 	}
> 	for (i = 1; i < 8; i++) {
> 	    tcg_gen_movi_i64(tcg_mask, identity_mask << (i * 8));
> 	    for (j = 0; j < 2; j++) {
> 	        tcg_gen_shli_i64(tmp, avr[j], i * 7);
> 	        tcg_gen_and_i64(tmp, tmp, tcg_mask);
> 	        tcg_gen_or_i64(out[j], out[j], tmp);
> 	    }
> 	}
> 	for (j = 0; j < 2; j++) {
> 	    set_avr(VT, out[j], j);
> 	}
>
> This should produce the same results with fewer operations.

I agree with you, this should produce the same result with less 
instructions. I will implement this in v2.

Kind Regards,

Stefan

>
> r~

