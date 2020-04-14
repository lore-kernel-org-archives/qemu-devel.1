Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A870AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3CA20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oviq4tQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3CA20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOZn-0000pm-I5
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOORF-0003ID-Q7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOORA-0008Vc-6W
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:29:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOORA-0008V3-1J
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:29:24 -0400
Received: by mail-pg1-x542.google.com with SMTP id r4so117049pgg.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=5RQ2wSpsjJpzp7+16tdJJpRXhZ+KgD3tAKq0P8YKk4c=;
 b=Oviq4tQkcduoMSH0vwqoGkfkLL/gchTHIcCcSG/EoYi0HA1smeA9/6tf1deSzaM0Zt
 LBaBRX/GYKre/3tfvkSkN9C9aOmPveg7nbJHK1+iGcWSz3hnleW71ZHUkUuvqzbK3hvv
 g6wybJu7VZry3HQcBkKVa4pRApdFcffPNLoglTg+i8wcpU8d6SuSWl6dzO9QUfHdMSu2
 u24Q49WgL5NjHdX68HxMpUeAf6+wCgjOxW3moPTWOJjMdlELE9OHSl/1Ec6uhUwWLSAT
 ibltO+tA0SSVnct2jrvATCxp+/uxih8FfJ3DDLxb9jAjeWePVuPnlKdH95Stv6Xd3Hj9
 cgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5RQ2wSpsjJpzp7+16tdJJpRXhZ+KgD3tAKq0P8YKk4c=;
 b=CQuCXC2PTKOYd9ZyZalrsbW2Sk9gwuTce9En9cofE5luiRhOR/jsCA8TN1KV+X6Nmr
 ywh3hipp2KKB7mrohs+Au1VrY9PJ5k0/rKv1ymwxuMXHTKGTs+xTaPJvSuQ3xiMBiIh4
 3uVY3RZCqNIxlORWfiwfmPAP3VOivFhabPaA2Pe7JeaC/H5m4768ePfevSak2JcdyJRh
 RlUxUha0Dz0d1ViJfNoEfCGT3dQXIEQ2KW8YAIPXlYWZnuXtMV8PYPGpEn1jhaMfjdID
 Q4KPQnWKaCQkaaUBiM0dr4VmyETJzknGxL+51R9PPGDHXzYE3UA2kWv92GurkAF1gtMF
 9zYw==
X-Gm-Message-State: AGi0PuZWAZ5sQvkPV2HaOyf7dLXjmpV2sSrbFGgjOQWbDjJAuocCEZMw
 76bIadvKHyq6qNdAAWpjr+iQd+1Ly8g=
X-Google-Smtp-Source: APiQypJlW2yLQFO5wNjcyQF1fO7jaLshzsqDC77i/mDxk9lEOtFnty5O+LoFap+dv6cELLeObxMMkQ==
X-Received: by 2002:a63:e80b:: with SMTP id s11mr22175390pgh.350.1586881762325; 
 Tue, 14 Apr 2020 09:29:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c59sm12634846pje.10.2020.04.14.09.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 09:29:21 -0700 (PDT)
Subject: Re: [for-5.0] Deprecate KVM support for AArch32
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200414120935.12719-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6bb58601-5614-b01e-5ac5-5d3331aaeac9@linaro.org>
Date: Tue, 14 Apr 2020 09:29:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414120935.12719-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 5:09 AM, Peter Maydell wrote:
> The Linux kernel has dropped support for allowing 32-bit Arm systems
> to host KVM guests (kernel commit 541ad0150ca4aa663a2, which just
> landed upstream in the 5.7 merge window).  Mark QEMU's support for
> this configuration as deprecated, so that we can delete that support
> code in 5.2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I was reading the 5.7 merge window writeup on LWN this weekend
> and saw that the dropping of 32-bit support had gone in; just
> enough time to squeeze our deprecation warning into 5.0 so we
> can drop the code in 5.2 rather than 6.0...
> 
>  docs/system/deprecated.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

