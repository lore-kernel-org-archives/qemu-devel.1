Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC46C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DD92332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhFLQlmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DD92332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Zj2-0005qT-RV
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 19:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Zgm-0004RN-8w
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Zgl-0005Xw-BS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:06:48 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0Zgl-0005WT-3q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:06:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id o70so2469399pfg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y2T2kn1vD1yn5+XEUABlHukM46bx9IqfX89YQk12gn4=;
 b=HhFLQlmqFIv4FRK4Vl0CwJBERA9xe8jFmZQ5nsDAwyleP+6F/MN1ZeJHwUm0Z1uPXa
 s88E7NPJuY0Q5ou45M4UbGuhNLchrb59oxkMi+YUo7tqv48gSEjN9Q46D6/PgW6Swr9p
 wK+v9AgyEehF4hRnv5ihnD6XAAf1pInwYIfolbJX4+dXDwI2oEzrDU6uo6kaU4Nhcdxi
 Uz8/4nrDpI+MtT1b5zKlGnGsrQNrFSxkI14bcSKIL5g1SrpEQ3xB+yzH+hMiNitILUCA
 Ax4+6OVPSdOsPcQsNr+C14ZW9XK5PsCbDXo1QAeC0Vpl0K1NxiSfI3ZBc5EUpQlf9dEt
 huQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y2T2kn1vD1yn5+XEUABlHukM46bx9IqfX89YQk12gn4=;
 b=Kt0gRSavdwc4W1L5Qpd3a6BmQ4ApFWGouiz8OD5+LQtPEJuxnHFIQt6o5DftcTWv5n
 AuiWUL6kcNxCIZSsiBnc/9dwbI/vgBZoXT0FwGXBtzAM13sBwaMwTg10yApSPmUY9L8+
 PpJjIxgmQMdxdky+nib7QcGr9jWErf5B/bWS+A/C1Z6C7cSinr/tRVDvAxBZiDPHKBsF
 Lie26hDknevCEuBnQ8k0j1F72fVgEs8OEXzc7N9qipe/Q+GCjYKS7N1f2yN8fu5yVMR1
 RbQp0ssIIg6AucyNsvkmB4JoAFJ0jERUs6s/jGBg/xZx9xHyEK45Bkzkij6maG8H3MrS
 ev9Q==
X-Gm-Message-State: APjAAAW4zi/ltuWPQZdE8OOE3czYy01Se4xbLorRz656goBYa+sAqBk2
 Hy2e28slT0vnWTZMNICB16VhUvjha6E=
X-Google-Smtp-Source: APXvYqyIU3NfamkbRuMbVVJmW1uzRwGHDLmayeSCSINN/88chxXWeK+jfR1fJJ7HpsGlqSaHAXf0+A==
X-Received: by 2002:a17:90a:ac11:: with SMTP id
 o17mr2425639pjq.104.1566428805904; 
 Wed, 21 Aug 2019 16:06:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y188sm27716024pfb.115.2019.08.21.16.06.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 16:06:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
 <20190821122315.18015-5-kbastian@mail.uni-paderborn.de>
 <fa01ce65-2bf5-1877-bb57-f1baa821ddaa@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0b6d1746-57ba-4372-5d24-72d37621b0fd@linaro.org>
Date: Wed, 21 Aug 2019 16:06:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fa01ce65-2bf5-1877-bb57-f1baa821ddaa@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/tricore: Implement a qemu
 excptions helper
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 4:05 PM, Richard Henderson wrote:
> On 8/21/19 5:23 AM, Bastian Koppelmann wrote:
>> @@ -3928,7 +3937,7 @@ static void decode_sr_system(DisasContext *ctx)
>>          ctx->base.is_jmp = DISAS_NORETURN;
>>          break;
>>      case OPC2_16_SR_DEBUG:
>> -        /* raise EXCP_DEBUG */
>> +        generate_qemu_excp(ctx, EXCP_DEBUG);
>>          break;
>>      case OPC2_16_SR_FRET:
>>          gen_fret(ctx);
>> @@ -8354,7 +8363,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
>>  
>>      switch (op2) {
>>      case OPC2_32_SYS_DEBUG:
>> -        /* raise EXCP_DEBUG */
>> +        generate_qemu_excp(ctx, EXCP_DEBUG);
>>          break;
>>      case OPC2_32_SYS_DISABLE:
>>          tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~MASK_ICR_IE_1_3);
> 
> This is not correct -- EXCP_DEBUG is an internal qemu exception.
> 
> The manual I have only describes the ISA and does not describe what a "Debug
> Event" would be.  I note that you're missing the DBGSR.DE check.  I also note
> that whatever a "Debug Event" is, RFM appears to be the return from it.  So one
> can deduce some things about what it should be.

Anyway, remove these hunks and the rest of the patch is ok.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

