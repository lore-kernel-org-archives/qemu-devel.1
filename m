Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC5C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2D7206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Foi+rVNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2D7206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtd8-0005MC-Gr
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34273)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhtaD-0003mw-E6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhtaC-0001uC-9U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:30:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhtaC-0001td-29
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:30:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id u18so5048876wru.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a4LkJI07q5BJNwCUZhyJvIdMycNOxLgXUC8P7wGwvqg=;
 b=Foi+rVNGbiK0t/TosvWP/6hc0bZB3KCXLafPyKO0V2hNojQgAVcjf8FzeUX9+CFGfF
 fbR2BxhXOgX06/laZXogMQzv5rZHpEsUXPFyssFXuT0DW4XL55XPXyFJgc+YtyBD8gkg
 8K4pALtfSfN6ksUnhUDPn9SluCm3ipNX+sASKEbD1rOpmyRU0gwUKMDqdNK9KmrV7R0C
 Wgdf8xp3B1ry/haAK4nbu985xxHyCyJqW6vs7LedbxFfs+UO96PS56T8qf8lnvqOljj9
 7NehNwwrMSJ2dAR9QzOK/MbiW5p6ji6AdBQU5Sei++LKWWgtjczA0/U3oFvHBCmyspQ6
 h9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a4LkJI07q5BJNwCUZhyJvIdMycNOxLgXUC8P7wGwvqg=;
 b=nDJwGHxYx4FFJTiTj261LTs6SDZRM9wu80Cpooktf2oz2TBJxrA9zvLu+MsQQLjogC
 5v4NAT2ZzpqCKqCY88ocVePAAYWSNj+UufWVisXBW8OAMQ/6BSNqO9TMVSiEQi9K+PSq
 ZA8OLnsqZ1Z5xJCQjbmBlN58Ng263O6e6JxWciHxBIxyNK7j4alkBmwJ+h78qiUQlRwF
 FM6WohpqdnmqATBcaQsgtDX7ULsC4GICdOYUG7HY5QOhB02jk/ZtOOec05wyI0z1YKmD
 Z5CDSrpn28MZAlXapnsAGzUPjgDGl4mUrfVsxhaE+RbOveI5B+fBUrBjff1UcpbtBXvc
 +Z0g==
X-Gm-Message-State: APjAAAU23fAJROGyDgTVpqB3Ki6pixfjiuZqd6RnIJDEwQ8gEc2Ks0fG
 S9TiMFHoaffPTB3NWi9s3YgyZQ==
X-Google-Smtp-Source: APXvYqwXpgVsJ1qfyV4uvMCBdsalgqcnaJwopgbSruSZkkDCIc8+zhdjDGXegac57JKpPsQgbkeFnQ==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr15008465wru.242.1561977046918; 
 Mon, 01 Jul 2019 03:30:46 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id j10sm3650766wrw.87.2019.07.01.03.30.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 03:30:46 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <5746cc58-c132-ef29-6ff4-da07c6086dac@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3fe632b7-e83c-9b26-9338-1d7a9c881e0d@linaro.org>
Date: Mon, 1 Jul 2019 12:30:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5746cc58-c132-ef29-6ff4-da07c6086dac@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v6 00/16] tcg/ppc: Add vector opcodes
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
Cc: amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/19 7:58 PM, Mark Cave-Ayland wrote:
> I don't have space for a full set of images on the G4, however I've tried boot tests
> on installer CDs for MacOS 9, OS X 10.2, Linux and HelenOS and it looks good here.
> 
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [PPC32]

Thanks!


r!


