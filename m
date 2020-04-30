Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D1C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3161020731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y51hAl7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3161020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFtC-0002V8-7U
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 16:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFrT-00015j-MX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFr8-0005Pa-OF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:32:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUFr7-0005Ja-LE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:32:25 -0400
Received: by mail-pf1-x443.google.com with SMTP id f7so435295pfa.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=j2fS6QADm15/ZKJNAPQHdkffjFrG03za1uyeIWbDmqM=;
 b=y51hAl7F2ErJMYIlBQM4Ov2laCvVN5XpyzBBEhUbbqj/axTkHYpkB8VaRQPyE2P89S
 XlhjKyyw0qTDuInGEJ26ySQzC/Ggr4Qtyx0TgOg5aUX9nhe0BXGxhER1S3rY7pB02bS7
 lBO1FdGilM/fUFzyvirDR6tgT7aq02W7aspa+7U0f5vwWZU2s1feeLGKhXwsMapKuIhs
 HEkOPti64h8CnX/tqW7rllzhSqJxrADiV8MqFGdKTNMmqUM4YzTzbn8GhgpkgqFU8b98
 zA5kzaY9vTbCPiJz1LSODLsRv83mZaoZIj3EJHr/OOkO68xwzxMAwWDacb++qUVjyR6b
 7Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j2fS6QADm15/ZKJNAPQHdkffjFrG03za1uyeIWbDmqM=;
 b=KMvZ3ftQSySkf4+hfmw7Bapv6FXmRWyqEYKkwu8xC5lUEC+1tSZ9l8yIu5yFV1aK+k
 rM75G4DqBbFK/qe3Lz8QGZvReqBSgBrmxHy3pY4HfJbHe0b99jC+3Lyf/U2wMrKe43jY
 6zA1BAN3TNQ/Vhl79IMMgr2XFt0I4zwYRAslA/cbct4UzyAYkQkA/bcP+LieQBU7Qgou
 LMBvs1mxa1sM46cGbSfSkGcNvPABmowRLtiD7vsnESXBsmCdBvSdht3NMwtWL1wSFDft
 mIQbS4rgqQY2TkxSl4Sx840CN3cNpcjlB0Fg5etC6fSCkbrzAIWU+DjDERYRhIErmok+
 QSSg==
X-Gm-Message-State: AGi0PuZtXkmu6m0VFACx3VJTwnR5x0SoxPm9bzRUyOxSfVN0uCWmolu2
 lpeTkHGYlBf/FIMLeIxw/p+mOfvP2tA=
X-Google-Smtp-Source: APiQypIiucZlU7rWrQ+QnyaOi+rz0KohZrXfxREvl7rQM5RP5q/Ya+cLkM8qkia6npcW1pkgon5CbA==
X-Received: by 2002:a62:6dc3:: with SMTP id i186mr476475pfc.273.1588278742987; 
 Thu, 30 Apr 2020 13:32:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h31sm551911pjb.33.2020.04.30.13.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 13:32:22 -0700 (PDT)
Subject: Re: [PATCH 22/36] target/arm: Move gen_ function typedefs to
 translate.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <899e8b62-1f2f-4e8f-d297-c83204058a11@linaro.org>
Date: Thu, 30 Apr 2020 13:32:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::443
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
> We're going to want at least some of the NeonGen* typedefs
> for the refactored 32-bit Neon decoder, so move them all
> to translate.h since it makes more sense to keep them in
> one group.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.h     | 17 +++++++++++++++++
>  target/arm/translate-a64.c | 17 -----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

