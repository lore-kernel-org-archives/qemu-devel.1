Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC917CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E65520679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8cQw0Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E65520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzuk-0000zt-Oy
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNznc-0000ra-3Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNzna-0004kK-UK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:38:39 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNzna-0004kB-Nk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:38:38 -0400
Received: by mail-qk1-x744.google.com with SMTP id 15so1754643qkh.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=te8kw2FaRtUg2DoexVhzrVv+oglatRsNzfFGhHUGaOs=;
 b=S8cQw0Hz5LbraJHMxuCOq1lUK2x66mni1O3FouN91ZKPbtQdsm6OmatQr7N5RqtohT
 2kc2s3HCyOp+BhdOCgVEfZdhX1EVIG0HlMdcmRxF+I7ynCi2psLC5P1CNMiAqz/fozz/
 JIRJmfgMHALzITuVHrOTqjUZ2O9F96uJfvKA0KFTju01vKvwSnYq0ySZA/XqjR9DVaoN
 BnaPmwsot3mMW1jPFsw47+jghZH0lD4vhwoZk4hRO5lwh6peDzcGf6C2+3s9mUQmDpDf
 S8f1MHcfCBpLLoSGF8Ax1l2SVWhs+QqolqSZzOOv+1z1aiGj9P71QOlERbMWpCq2XZKP
 5SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=te8kw2FaRtUg2DoexVhzrVv+oglatRsNzfFGhHUGaOs=;
 b=ujkYB4niKDcJ/WpC+/y/sM4Jsq4JTCWOKZgnzqs6fHC2iFsakzvmFF9XgZI8/irF+4
 XJ0UHEaHhWsMP3CgOzsahDQSHqPruwf4L8PzzeFtr+Lgkb4lE/rtU6EOqiT6ID5Uzpwj
 gOTm+0M9AXLb/+luWbZmoxbQVAdvbVhUXLDFvMFkiGgFL+rNLnSqKo+mXV8RSek3EkxM
 xlZcA05BNZW0M+eMK7qRTzEdGGtNnvOkN0qw+00VRZSdwiiutlenErw6lZHFYlzRyrZT
 bvh5uYWthXzt8EVKQGHEOCN0TalK9cOeX04kSHuRI/ykE0MJu4FwX2se6ksYhfmS+lus
 lVEw==
X-Gm-Message-State: APjAAAWwQXeWoqGAj2odyiLwVoKEwWLJwP+GltMAKTr2/7SzOhKxi5q4
 ICe1+ORuJj3pKrweO9K8n0htEw==
X-Google-Smtp-Source: APXvYqykUuqU71hPOCNPPEsRfg2oLcaLrCaEhEjzhffpEPSejXEOLJusu4S5tZaLbOpAH1ggxgTN4A==
X-Received: by 2002:a37:6f06:: with SMTP id k6mr2805776qkc.141.1572010717735; 
 Fri, 25 Oct 2019 06:38:37 -0700 (PDT)
Received: from [172.20.87.163] (198-4-20-64.static.cosmoweb.net. [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id z141sm1119650qka.126.2019.10.25.06.38.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:38:37 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] linux-user/sparc64: Fix target_signal_frame
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-9-richard.henderson@linaro.org>
 <fe46bd7d-d036-3a43-d1b4-d05a25555eb4@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3b51c99f-e7da-31e2-aa65-d497a0aa8633@linaro.org>
Date: Fri, 25 Oct 2019 09:38:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fe46bd7d-d036-3a43-d1b4-d05a25555eb4@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 8:47 AM, Laurent Vivier wrote:
> Le 25/10/2019 à 13:39, Richard Henderson a écrit :
>> Instructions are always 4 bytes; use uint32_t not abi_ulong.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/sparc/signal.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
>> index efb0df7e2b..ecfdf937e4 100644
>> --- a/linux-user/sparc/signal.c
>> +++ b/linux-user/sparc/signal.c
>> @@ -87,7 +87,7 @@ struct target_signal_frame {
>>      struct sparc_stackf ss;
>>      __siginfo_t         info;
>>      abi_ulong           fpu_save;
>> -    abi_ulong           insns[2] __attribute__ ((aligned (8)));
>> +    uint32_t            insns[2] __attribute__ ((aligned (8)));
>>      abi_ulong           extramask[TARGET_NSIG_WORDS - 1];
>>      abi_ulong           extra_size; /* Should be 0 */
>>      qemu_siginfo_fpu_t fpu_state;
>> @@ -98,7 +98,7 @@ struct target_rt_signal_frame {
>>      abi_ulong           regs[20];
>>      sigset_t            mask;
>>      abi_ulong           fpu_save;
>> -    unsigned int        insns[2];
>> +    uint32_t            insns[2];
>>      stack_t             stack;
>>      unsigned int        extra_size; /* Should be 0 */
>>      qemu_siginfo_fpu_t  fpu_state;
>>
> 
> This definition is used by sparc and sparc64 (sparc64/signal.c includes
> sparc/signal.c), so the definition was valid before your changes for
> sparc and not good for sparc64. Moreover rt_signal_frame for sparc64
> doesn't look like this one (and signal_frame doesn't exist).

You're right that target_rt_signal_frame isn't correct for sparc64.  But we
also don't implement setup_rt_frame yet, so it's also currently unused.

What's here is just good enough to make setup_frame work, and that is correct
for both sparc and sparc64.


r~

