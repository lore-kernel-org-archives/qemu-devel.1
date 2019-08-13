Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214BDC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D759D206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwgTrysY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D759D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxOoH-00077Z-7L
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 00:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOnu-0006hu-Iy
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOnt-0004Zs-Q4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:53:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxOnt-0004ZZ-J5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:53:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id y8so546361wrn.10
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hWH5r5gwtHEoSMoCJdMTs+et5cHIFCBsjjk7+0JmKsM=;
 b=uwgTrysYMxofP5tpMsXyyh70F80x7/dzpH2G9ca5lOm3MOxyBy2lq06Nd2KznpqpTe
 1iZ21qb1wAh8nBhgzTI+RKzosM8OWrGWKwCN9O7NPAkoTRKg/8qOZaUbFPeTXtD+e0j3
 S4K+cGdzYlmfo9j94I2mK8OFr5Ku3BVENKbG5V3BIvdVrx0K3qa6KB6rL8EYFzvaLYCT
 0knnSEJ7w74YkFiB189JixIAvgN2V049eGPbVGFvzxqnYVJAkwvIeR5nbSEjYT+Inrpg
 wBVfaaoKe/0sZ3B7Vz62oS0lS5h6YKEvcCmTgCSRHk7Z7DUJkdTk501J1bQvB1ThpTtp
 I5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hWH5r5gwtHEoSMoCJdMTs+et5cHIFCBsjjk7+0JmKsM=;
 b=js9NYSsmuocJkx0AbS+kAOYyLQmDjGvIbaDnoWt5uRNnTZj4IDs2sXzU51yivpPTaJ
 HGNZ+XEUdVQczGdPb68MlYsWMXkMkOiV0AoNSE1WRRnfKPG67ZKmLoiwtp/xAcThalM9
 L5jbOQJaNbv00zNawHSqRp0d+1IwaNWaREU5AsPNtN02wg6bkAV+EW9/1zpoC/3s3zkz
 C87YM3Sbp9fdzKSAM+TljcDddMFovjF+xLjYNsxwJfzkAb3XmfrKS+G5+AmPCQcyxao2
 v6bhEEV7Wlg+TQ0hzMZDrAqbinoN2IWYSEzQueOvBGFBRUeS9eeuOfeRPfnohaYk0CtP
 dVqA==
X-Gm-Message-State: APjAAAXk/7euGyTZY6ChlaB+bWuTam9EE1pgBpOamDl7MRIe7a2ZIYrQ
 wakZYGI6NYDeWaJFkOWYHbuxDg==
X-Google-Smtp-Source: APXvYqz/OWSwG8NO6VFhhF6eXeo/Y4N/Qw64KhgzfCmz5MMWF6wl1eQYTWF0h5WDyKHuN5RFS0GfWA==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr15885747wrc.354.1565671980119; 
 Mon, 12 Aug 2019 21:53:00 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id z5sm260038wmf.48.2019.08.12.21.52.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 21:52:59 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-10-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <23f5986e-7f23-6a83-acbb-480adbbf135e@linaro.org>
Date: Tue, 13 Aug 2019 05:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-10-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/39] target/i386: make variable
 is_xmm const
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> The variable is_xmm does not change value after assignment, so make
> this fact explicit by marking it const.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


