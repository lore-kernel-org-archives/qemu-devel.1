Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E470C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C55320679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSyszDMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C55320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hge-0005Z7-9m
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2hfI-0004mF-NL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2hfG-0008AP-EN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:02:04 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2hfF-0007rT-WC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:02:02 -0400
Received: by mail-pl1-x643.google.com with SMTP id h3so72743pls.7
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2D2vwu1Voj+prAsL2zBwI1qGaiqZyAjfx1urdwYK3Xg=;
 b=OSyszDMzjWhzpvgCXTGSkuaDFrkzWKQvKbyvRpf5AG1VJTTpK8DAv8mWfnkvGi17lE
 4p4/gOFN93LW4GtAzaKjf6DV95ryPmE82rTJtxFEa5oBbtOZ9gC4rWzwP5KWrd3eVOR9
 LcAWgdn8gRvwRzPVfe3HCoLDYKCCDkxqfImiGYvlv0t4xyj6ByHg6IBFMAjlwSXxokuq
 x3bjH5ZmAFsDW7LG8hhbAmREU2sQ7qbjd1S82hVXbAgNrO2zNB6mri+dY6Pq0ACdoYsI
 Qxw5CFwa2z2bddJ8Aar4dcaeomUi7QfpypdbZYgTCf4cfsNcgg2WKFXo+svsHpd05/xr
 EbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2D2vwu1Voj+prAsL2zBwI1qGaiqZyAjfx1urdwYK3Xg=;
 b=MkFgn28fA+I/a8s7vsIZvy+L17/G8620N/sVEXS9hQhQs8Jiijy4POOhP8kdH4r9RX
 9DkJcx6ChW1maq9rGOiatR6qyDymV1y2nDps5JgDnmRijrqCHJ9h4jiSvvbiO/mqH+/o
 wpxB7VBMaV6hiNBIEh9mXNCfIyNOA7ak0e/VexpvWsLqQPFml0Aj8At0dBbwpoU6Y798
 zbp3BjMifU6ilPnMZ4NvWhYv04OPU7VUgsADRv564MoNEICDNDEWYU63v9yNEbBD0DNC
 YXOj5Wezu3BPPkP4HRRT133mzaBmYJau7DSwaDisjMjyRJjx55qlVXJoo4twYhHRFMmV
 gvPg==
X-Gm-Message-State: APjAAAXS61Fazx0mcHDnBupacpeLC2kE9NjQJsKX+3U+yWIXqSGhFQZL
 7bjx+CXA8m75RqeWZ34UGdfbfA==
X-Google-Smtp-Source: APXvYqzfh6qOcoWF6lqOhs4QlmlHLvVvVBt6QKwwwq3l7iE75b1RHTS8M75Lh+tNZEa3aRYIw2W0/g==
X-Received: by 2002:a17:902:4581:: with SMTP id
 n1mr642128pld.310.1566936098123; 
 Tue, 27 Aug 2019 13:01:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 1sm147311pfx.56.2019.08.27.13.01.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 13:01:37 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-19-richard.henderson@linaro.org>
 <CAFEAcA9qN47t8zXJ7X3TmhkigSEjf+esxVNwQ0m9X=qa2KF_bg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9fe4184f-7483-4207-2536-16ee798f3747@linaro.org>
Date: Tue, 27 Aug 2019 13:01:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qN47t8zXJ7X3TmhkigSEjf+esxVNwQ0m9X=qa2KF_bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 18/68] target/arm: Convert the rest of
 A32 Miscelaneous instructions
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 3:32 AM, Peter Maydell wrote:
>> +static bool trans_HVC(DisasContext *s, arg_HVC *a)
>> +{
>> +    if (!ENABLE_ARCH_7 || IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
>> +        return false;
>> +    }
>> +    gen_hvc(s, a->imm);
>> +    return true;
>> +}
> 
> I was wondering about for these trans_ functions the
> difference between returning 'false' and calling
> unallocated_encoding() and then returning 'true'.
> If I understand the decodetree right this will only
> make a difference when the pattern is inside a {} group.

Correct.

> So for instance here we have
> 
> {
>   [...]
>   {
>     HVC          1111 0111 1110 ....  1000 .... .... ....     \
>                  &i imm=%imm16_16_0
>     CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
>                  &cps
>     UDF          1111 0111 1111 ----  1010 ---- ---- ----
>   }
>   B_cond_thumb   1111 0. cond:4 ...... 10.0 ............      &ci imm=%imm21
> }
> 
> which means that if the HVC returns 'false' we'll end up
> trying the insn as a B_cond_thumb.

Correct.

> In this case the
> trans function for the B_cond_thumb pattern will correctly
> return false itself for a->cond >= 0xe, so it makes no
> difference. But maybe it would be more robust for a pattern
> like HVC to be self-contained so it doesn't fall through
> for cases that really do belong to it but happen to be
> required to UNDEF (like IS_USER() == true) ?

I agree this should be the rule.

E.g. for this IS_USER case, we have successfully decoded HVC and so should not
return false.  The fact that HVC should raise SIGILL if IS_USER should not be
confused with decoding HVC.

Other constraints, such as rd != 15 or imod != 0, should continue to return
false so that a (potential) grouped insn can match.

> OTOH I suppose you could say that when you're writing patterns
> like the B_cond_thumb one you know you've underdecoded and must
> catch all the theoretical overlaps by writing checks in the trans
> function, so as long as you do that correctly you're fine.

Yes.


r~

