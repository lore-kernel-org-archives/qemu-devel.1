Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A117C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6F6218F0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2CmXxxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6F6218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqiJp-0000R3-L0
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hqiJg-0008Ty-BS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hqiJe-00010l-8l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:18:12 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hqiJc-0000yU-4g
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:18:08 -0400
Received: by mail-pg1-x544.google.com with SMTP id u17so23434376pgi.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SAnZsFd6rEFLGj9UFCMIlonlHY8Yx8sFHv65n+Fm788=;
 b=O2CmXxxUnQJE7ImsM4KavAuB9QUFiVkWCYfJQgDrhAmV26eYowjaLtASYk4bNfZzzJ
 JflqLNMa3GalWChvNd5x1Lrj2e7ZQaZSCw0pm6lZTXbZ67e9gaDWriDHlXwEHCnettgW
 FLsWzwWtxD8XiVUdJu4joVz2DJdTQE5AJtyEi1ACDUS2O4ljly9Qgk8LJI/63kd2fB4L
 fWqpUrlbAYrU004kAo+/nnMKyzkgZ6X3S9M7LTLsUtZzygDMi1YLdC2xXtVPDjDkN75U
 kZ63mEbU9WVh3QoPsZcR1ZcYbwRfJlSUakQvHtOv0udfYjHLLxoGJDRIiLxgrXbaEmdn
 cSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SAnZsFd6rEFLGj9UFCMIlonlHY8Yx8sFHv65n+Fm788=;
 b=Uwt5zoEOdfyp+HvB+pmqOXtsvojJvecuRr0epPMXNr7cIxdNQ8ga3gpDo50tcKImD2
 844YCP5U0OfZHnBQk8urMyeXXFnWkoJVNvtB/ZIwhoBO+fXMOue2UQFc86no/ysNE5iS
 CvFTw8XVQ05IPzoIk/wmbyy0D5YSA+eT5ips/ipMhfjg9Vs6K4eq8/Z6WjtC5LvpcFhL
 G6twIf1BPChU45jZ0B5XH0lNkbGv17C+UJS6qEKpaY6kBNJUfY4M12nmmesQ4eg2Jr8U
 LcjIKjgnzwl/6mbT9QL+ig46mBvX+x1MA+gaQmMTfW5LAr1a5IRLYecTNzjsX3p7oA31
 NxoQ==
X-Gm-Message-State: APjAAAWdrATY8sLAm5fuN7ks/czbO30ko6W6ZU9JCLTp2pC2JAc6ZnnD
 EKCAVVBaSh5ytIV0pRvISiYdZQ==
X-Google-Smtp-Source: APXvYqx+VTw6j++VzSSPvbN3F7O3nxg/qi+xjDL7G7570kt+G/hW57mAN+x91cZkaWYkD6tSiEHmWQ==
X-Received: by 2002:a17:90a:dac3:: with SMTP id
 g3mr93706684pjx.45.1564078686631; 
 Thu, 25 Jul 2019 11:18:06 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id w197sm64584997pfd.41.2019.07.25.11.18.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 11:18:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-16-richard.henderson@linaro.org>
 <87wog6yumo.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <75530f99-658c-ed76-d272-48c9b2841337@linaro.org>
Date: Thu, 25 Jul 2019 11:18:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87wog6yumo.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH for-4.2 15/24] target/arm: Reorganize
 ARMMMUIdx
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 8:57 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Prepare for, but do not yet implement, the EL2&0 regime and the
>> Secure EL2 regime.  Rename all of the a-profile symbols to make
>> the distictions clearer.
> 
> Perhaps a summary of the renames would be useful here? My head is
> spinning a little given the number that we have and not being familiar
> with the naming convention.
> 
>   ARMMMUIdx[_StageN]_[M][S]Enn[_nn]
> 
>   _StageN - stage N only, otherwise assumed 1+2 lookup?

How about "full", since most of the indicies only have a single stage lookup.

>   M - M profile (interleaved with A profile)
>   S - Secure
>   Enn - visible exception level, so E02 is shared EL0 and EL2?
>   _nn - not sure?
> 
> The cpu.h comment is very detailed but doesn't actually give me enough
> information to decode an ARMMMUIdx when I come across it in the code.

I have wondered if it was worth going back and splitting this patch so that we
do exactly one rename at at time.  It would mean 9 of these patches...


r~

