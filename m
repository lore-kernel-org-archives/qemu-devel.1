Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B8C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2096F2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BR7SmeG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2096F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEKS-0006rH-B8
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUE1g-0008E7-KL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUE1f-00045Y-Uh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:35:12 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUE1f-000446-GZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:35:11 -0400
Received: by mail-pg1-x541.google.com with SMTP id n11so3181464pgl.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=+SfNLTHB7OlpSFGRIdIInO8wWUmEfnk2kky7W8E7omI=;
 b=BR7SmeG38LVLzYoPtvRUMrvrBVKbmmYtT5cHvcJuBDwrLak7vF23K2v4Ep2c6mQ6PP
 aG6qL/A7lLDUnz76wWUBUJ4YTMe+QHJt1LZt6VZ/Rw0Rxxf1hsVbTAv0bC9RFyhtzdqV
 /Ambkv/OXy0+xjaZNUqCN/FN/t9MqvF2FbQZCRKQ5/lezWxkMy/n+cipnQDU3RPqkeDE
 8mhVDhfiITsxdn2pTdPZfv4TeEGIMwn2iWG+5arwRoYLapq2dVArV4fB8Py8J3fJo+Do
 rx2hlz/SmZzdgBSii0SuNsUSF8d74OjhRLdWZ9ZMz6phd6Uja+W5JTvT1cTlCQyfAcq8
 QafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+SfNLTHB7OlpSFGRIdIInO8wWUmEfnk2kky7W8E7omI=;
 b=STWodd1PLsMBPClvK4xOgG3JIItmyBCCD7XfubbQNSUbXA63K5r+Mcj0vWH0KyIn97
 XFkhfqB3ZgeRDmbiiC8szyVhONWZmEpHHQfIU2gQqL1a5yGAzcriIhgSyo90i7Ae474Y
 aBqA/MF1swMZuWgOvyVqJeunhVmjfhd0QDNONqVzzi4/wfumSw86nWXwjsKFocWJ0By0
 PJsYjhQiGqVUgdOCdbnZvkIC19exHJP6qDul73QfJS/ol5lc+HfLqgaz/jHVEAqOtlNL
 WwhoweE/K0XovVEn0Myx4Y9iWtLN/0aT39rYMylL3jl//TSgleptEcBgTK/lMGVR3eJv
 87dA==
X-Gm-Message-State: AGi0Pubbu0WnA/S7F5fToj1zubRlYYssi1cDb2OEH7sT9YY4X3pt4Z/F
 zr30XE56YSy1x8q9IM5amgMOkX7GIX8=
X-Google-Smtp-Source: APiQypL5Que9aYRXdrC0Oieigz2HWssnXSuM0vgVvuw+87C10YKTcw0BRvx8W6vOpQazRpBc9Vhznw==
X-Received: by 2002:a63:1348:: with SMTP id 8mr269239pgt.350.1588271709649;
 Thu, 30 Apr 2020 11:35:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 1sm406839pff.180.2020.04.30.11.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 11:35:08 -0700 (PDT)
Subject: Re: [PATCH 05/36] target/arm: Convert VCADD (vector) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7899c66a-7f4d-48d6-7ddf-43fc81360eed@linaro.org>
Date: Thu, 30 Apr 2020 11:35:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the VCADD (vector) insns to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 37 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 11 +---------
>  target/arm/neon-shared.decode   |  3 +++
>  3 files changed, 41 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

