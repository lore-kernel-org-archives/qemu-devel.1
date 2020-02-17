Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEC8C34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAC7222D9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdvHusJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAC7222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lME-00020E-L5
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lLO-0000zR-TJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lLN-00004u-TS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:42:10 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lLN-0008VM-MD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:42:09 -0500
Received: by mail-pg1-x541.google.com with SMTP id g3so9524947pgs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9zgbaluwRbltVrZpLNNXGxJTjVUh7N3R2hFdxrS7EHI=;
 b=CdvHusJPRn3RRSr8v1K0bW/vX7RYYXS0luwk4UfwHtazZoqYIWSQl3v/HcXoXQVqv+
 ioK+0RK8TcgE2Q9sgVzOrjllD/eJOoQK5wI/8H+3d4H2PUC9Kf1TmWxn2O0a5gUkiulg
 5qgT5HsIVlWW76gqL8KNE3yu4ADCErSBglt1mydmUQgyqrlMKeCMSdH9yx/VgCnUQjwP
 e/jhCPV5BtgVs9er29HJ0tPpLndOOlz0IEouXB1mwPb4D0z14KJJJP+vKEXWfQO1Ubkp
 RlIBgr94g6hTSEIqB8PUvtlWxKK3m2+kYwOhfgwg71Eo4QZdnXCMYJG5l8UxGwds3r/N
 9fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9zgbaluwRbltVrZpLNNXGxJTjVUh7N3R2hFdxrS7EHI=;
 b=Xk7N0bBIcgDPJMQrwB0JXnO9yahs4+/RAaa42d7yt8xhdqgWGrFNRCwKcCUPnkYp4m
 Ykysck/7AsjmTKFC1kJVx4erFtFiDDSQuF6+e37KtTzP9KXAl+ulM6D+QnIrHQICzAmy
 WWqPv7j5SvJIKm8VwnbrhLnmnZ10rajQzKA5DnrZXTObDurMWk5mVZUfnj953NukXOzu
 WfGBJj1TiUcOO2xlIpIO/XHbrDLYouwVZcAeSbxHev75vuWeoTFZALyV0yk1Hn42kXCN
 gqa5XO+tZylHahAYL3chCKk7SHv9O7dU5sw2Qp+s9DK0KNvC8P8yZIPlcC/R+6XDUbXw
 95iA==
X-Gm-Message-State: APjAAAWYyD0j9auSIpax/N4IKePKHxovowYFcoP/4d338AtExv8bApjE
 4SZtsiLwjCqpEAhDA3TUzl5UFg==
X-Google-Smtp-Source: APXvYqxLmbCkyXjfdfRcjImGhDy+AD3FKeuwD0sFTyeWsWvJPhskQ8BvdS8nXLbJrsSCf5ZLHSgBmA==
X-Received: by 2002:aa7:8552:: with SMTP id y18mr17831608pfn.176.1581964928393; 
 Mon, 17 Feb 2020 10:42:08 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a36sm1592448pga.32.2020.02.17.10.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:42:07 -0800 (PST)
Subject: Re: [PATCH v5 01/79] numa: remove deprecated -mem-path fallback to
 anonymous RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-2-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57f7dab5-afa1-7370-1d03-7e7fe735f903@linaro.org>
Date: Mon, 17 Feb 2020 10:42:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-2-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> it has been deprecated since 4.0 by commit
>  cb79224b7 (deprecate -mem-path fallback to anonymous RAM)
> Deprecation period ran out and it's time to remove it
> so it won't get in a way of switching to using hostmem
> backend for RAM.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC:libvir-list@redhat.com
> CC: ehabkost@redhat.com
> ---
>  hw/core/numa.c       | 18 +-----------------
>  qemu-deprecated.texi |  9 ---------
>  2 files changed, 1 insertion(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

