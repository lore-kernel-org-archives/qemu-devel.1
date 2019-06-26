Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE6C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE28217D6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiQNBUaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE28217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCl0-0004hK-F7
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44181)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfV-0001Tt-Dr
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfU-0007xh-Gs
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfU-0007x4-9g
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so3877022wrs.5
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n3YkOEVUPRaKEULHS1Gzl/S5jvMt2zT4d79BA6WQFVk=;
 b=uiQNBUaXa29Gqmi5QC15DLBZoLVs0XXbFDquCUaCqd/6/tWYWyJfCQ1wiii6GBT1lq
 L3cUjsT3NBdopSZZDe4/41NvQCcEjVURS3YlJbCCRjffMkYNCB2kSY04OsmdAmlKx86W
 a7RVem45mdQRJ+xGqert/+rrniVuDU55MVCwUz8JkDREpx9DwWLkV89a+xl+vZWm7kSr
 g5ziA3mLeBy97Lj46+ow5b9iqMgq+iOb+IhmwRJZ/3IgQsNsXA/uWs+ywji9aLr3IjAZ
 hww5muX7T2LVNvPzChfMOyes2kSlyBoxTSOWHcAxVdCeCZF6Wh64SX4fbO+gjqiJDwSP
 4qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n3YkOEVUPRaKEULHS1Gzl/S5jvMt2zT4d79BA6WQFVk=;
 b=Sh9cZKXpZ0Ax+TlynKNu0oJHojkWcxYqYzUwDAeO9qjg1rgu7ejQ+3uapezLHMyXUU
 ULMtf6GoBSxFr0J7iqcYycga0hCji6IDxdcs6F3hPquu1A05qOGGLyE1LUK+KyG38a2i
 MbrfwNnynPkMWkYWz+RcYDMXRt5Ali1Q3RSzelsmE2WzGN0kEA3uXtx6RWjvQUEwDjXP
 TXFYT8YINNJmftFj1UDZq6xKetdLaw1pNkKm+fCG4KrclU6m6qBgfJ4uIAWajCJzgi0I
 CJqO30VWNjShSBTp6Yxr9hMO9WMsJhODpEw0A1kGNuQVX26UcsZGCNaZsrW1Byv0OIc4
 0EVQ==
X-Gm-Message-State: APjAAAVQWR8Gd5MSSXMrgbNmt4bliNkTggUm+BElogEcI/844bPP/+Gc
 TjsRQ5E3zfONJNsxA0w3JZ5Zig==
X-Google-Smtp-Source: APXvYqxS4k5Ds+/EqCduvsf9WJjkJc3fyPnY9jW2DFjyd+wSoBaHPHJbWa0nAaEacibQVVQdTsgvaw==
X-Received: by 2002:adf:f649:: with SMTP id x9mr4351295wrp.86.1561573755313;
 Wed, 26 Jun 2019 11:29:15 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id o11sm3350513wmh.37.2019.06.26.11.29.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:14 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-9-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <90009b4b-0f96-89b2-a401-9d84a8b2526e@linaro.org>
Date: Wed, 26 Jun 2019 13:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-9-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 08/14] target/arm/kvm64: Fix error
 returns
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> A couple return -EINVAL's forgot their '-'s.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


