Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE4EC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DA82187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6eIJ125"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DA82187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hii9O-0006SS-L7
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34247)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hii7E-0004e2-GU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hii7D-0003Fk-Ju
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:28:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hii7D-0003FQ-Ap
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:28:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id c27so3564462wrb.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NMSVpAVvmecmbttQ3iXVWbkVTXIlxDa/eRG3CDeCvs0=;
 b=T6eIJ1252fD2W0N6r1d3uLftqkJyWFxDeIFCENZCpbgjOH8XYE4S8FN9W7MIvckDBa
 gL0kOHaCDeV+rpY/rsS/A996bLK6tvZohyolC1CE7GHrmtxYUS3w8CaFG3vg3vbN5Dht
 frSeMSYHl/u7qljafdeWjWyufOdHjIsZ3MSoeXkCTnZcf6j+fFqQ5+HcEG3Vst6OU+vR
 42AXwCfGmYtxHm0F8zF8b7luamj8Ph+J1+CMlK5dorZSnEC02goNKJN4Rwnk5FlEeB5L
 qwJML7N4lCty43Dva+SGA3FmFVM/r27HHWhkKYPVM3+IrxSg9CedvFVpw4xKGFgM7NtJ
 Jx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NMSVpAVvmecmbttQ3iXVWbkVTXIlxDa/eRG3CDeCvs0=;
 b=lzzjq7ys+gQcEi0aYJr424+tsm/RaooZ8EX5/o1XnvSmMXVpbWROfNKKjhKWZ+0Qaw
 l32o8hrkLYc7HEHRxXzaYEiqEtAVn+egZV3rURDNkzfj2k0gPrj7erWZfifaZXiP1TfK
 m6sL1c9Q2BORr8t+oa/D5CfdKtnfq/UXrAqLXj8PYP3A213jDHzyLlidrWNSSCmmMChZ
 QCjPNtESPoY3u1KaDH6ib7FwykrzD0qfE8MGZMxila9h4Gd3Bii2fadrV4QPsy0OJ/0Q
 NREFBveW5STi3o5GLeNuRS9P0Dmzj8JXD4j2XNtWMCNNMpuKM6+ua00C5n4gnSb+NuM5
 AA3w==
X-Gm-Message-State: APjAAAVgbsfyvyijP6o25YnqjGebnnr/vQS3xKcr3bXh1uRGGM3QYbUD
 I1BybzyetsOasIkcE6Fy0ph/GA==
X-Google-Smtp-Source: APXvYqwLuYNFj/5+ZL+cGbt1JR1uregIQbOuvEUmGSDoW1xn/cJDTS8oyJu5jv2ufkGEvQ67LhTgEA==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr29945317wrn.94.1562171293901; 
 Wed, 03 Jul 2019 09:28:13 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id x6sm3624372wru.0.2019.07.03.09.28.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:28:13 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0f413085-d9b1-e77b-53a1-bed5ed10de33@linaro.org>
Date: Wed, 3 Jul 2019 18:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703155244.28166-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 2/4] target/arm: handle A-profile T32
 semihosting at translate time
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 5:52 PM, Alex Bennée wrote:
> As for the other semihosting calls we can resolve this at translate
> time.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/translate.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


