Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB29C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697FD2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJcXAR60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697FD2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUELS-0007wS-J4
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUE3U-0002Xe-F8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUE3T-0006Cy-Vc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:37:04 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUE3T-0006CV-9u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:37:03 -0400
Received: by mail-pl1-x642.google.com with SMTP id z6so2578656plk.10
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=HwR4zFUPFxcQy/cikLbpB1FXbScJZkDFf6i8QlBWwGQ=;
 b=OJcXAR60glMlU8ieSBlmaGQCru+CyC5oiI187WTDqV5BkGjMf5Yn1SEDGpLEuNlBbm
 BkhrvTVUjxe/Aa2k8Yw9xGlgRDvfanboFtwiSlByvNfZY4iPM1UC3QuVCC7qKtQ4Bd5B
 uPBvrgFqHU2/03SbwQT7g7sqgkN7mRjJ+8UjiNzK8WtN1Xm2Qk3KKZN4Dat9aXV/+nuT
 czt1VtwvkIIPXyGcKJkSbj5zQTTLSf4XLdikPSCRw3XR6lQ+UWz+IP99XWKfcmqxMmZ6
 rqifdb2ZVKZzci2SA8NFl0C9ldWvVtgAgFYFppv95bW44CdTD8AytaOyz9ou7ToHqHM3
 17kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HwR4zFUPFxcQy/cikLbpB1FXbScJZkDFf6i8QlBWwGQ=;
 b=WjY1695ICFsE7C0rH31jfCKfT5I/x6U1j3rUdt9APUG0EQ5XlIe5i+xVrCiA0aVZjY
 3pPDuVNALEtt4mkNLnX+khcoojkXGNv9jp3o5gb/3Olz4O8qJbnd1/UCotGjiMX4pAsP
 sr20BiBXnuqjx/LRWuXDcVAOTRco0b053A7BO/F6UczcDX5nR45U2tzLAEZL8hmf9+A9
 4avzRu7G7w1u+plj8+BpO0pHSyWzDFBKR/klrgUrquQe86PE6Puvq0Xqe9pHZmap8cmW
 LgwzvNlYtkYkfLAzF5YuwzqDdNoHL8eXTyDdNA9m5frEJOoZcmi7aZl8tylTjPebcxnx
 hR3A==
X-Gm-Message-State: AGi0PubIqfBxMXkDOqrOrSOPpOLtoPCHqfpx+tFoPrQr04za7L5SAhgK
 Y0VY3VGe9XkQmFn5uheJyuw0iKv+zh4=
X-Google-Smtp-Source: APiQypJDkeRp3d5XbZ6pb+gqvE4AxwusB507edzrjaQy2d7f20ggdhEHvbWJ1WkZq5gA5N0m3oNGiA==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr364269ple.102.1588271821232; 
 Thu, 30 Apr 2020 11:37:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id p64sm442082pjp.7.2020.04.30.11.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 11:37:00 -0700 (PDT)
Subject: Re: [PATCH 06/36] target/arm: Convert V[US]DOT (vector) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <475c43c3-f1da-e203-0faf-d321743fc396@linaro.org>
Date: Thu, 30 Apr 2020 11:36:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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
> Convert the V[US]DOT (vector) insns to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 32 ++++++++++++++++++++++++++++++++
>  target/arm/translate.c          |  9 +--------
>  target/arm/neon-shared.decode   |  4 ++++
>  3 files changed, 37 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

