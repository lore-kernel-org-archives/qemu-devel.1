Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C984BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F56220658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Io1GNKVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F56220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvAG-0005sg-NH
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuY2-0001AM-RP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuY1-0006bo-Ur
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:33:10 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuY1-0006Z7-NX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:33:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id d25so2418351pfn.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lVV/K8lHgtqmkaF3S5M0Wwc0dmga/0wizbIoLACeuYg=;
 b=Io1GNKVjwk/ZZdWBR+MBeDhK6NqpvEWpoyK++F/PBtLGFvfZl8r+HwPViHq7rMqVLg
 LHsvqNG70W5ovQAg4OHSZJVYHrNlXTAWy6OTGiB1mQmelXZppbC02M5otuTgMXDFnbCp
 SHSLuw16BJVgqgCQMdVAAWe4i9hq22NJwHoOSPbpFtw3f3Ve1yKHX8mFZlrqYMhpHgJq
 C7DoRHs5dbj0ICePGrvhevWG180Qx5rtKLgJHjAIJVwvfc3PVJgME/RqkBUuzA1L2z8Z
 6PA6IXok4hYkmdH8nenFwNPshDkt6BiaTur5+N+clwu1J4xFB37AZrwy1PxWhXR4ApeU
 PjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lVV/K8lHgtqmkaF3S5M0Wwc0dmga/0wizbIoLACeuYg=;
 b=JZCGEJkzVMomttEOys34+v6kd3AsKznOAqp4PQJSKKsr4xcsDpY6MD7yw3I8o19miH
 ibTRR1ZWstCnBvAbAU0fbPOihdyhGlD+Sm3ATBB374ffdhtPu6DFuXlYfExcMkgU9060
 mlDFaQRS/rdShTSdSZz/7CEHyrCd3tbxif+ZUQ071B7DKfxBpAddWuUqYyHk98bfpS7b
 sscCojJPxmWToAD3AXO/wRzHlemeOz89TYKnvSj/F2AsjGQsuZTIl7/vVB80OuthRde/
 EATPd+O/0nhyZ+pcAYDtnU0L44tckhb1skaEa/6njr92MJ558jg7wGphZI/8P7NpMdsI
 Nb3Q==
X-Gm-Message-State: ANhLgQ3B5xQd6xvULz+uffxLXirfMOpa1oFQkxYftlc4F3ftM0fYQVWg
 Js98boybv/tMdkp/RgXQY3oR2w==
X-Google-Smtp-Source: ADFU+vu1HZJ8/xJbLlq3PMLvCI3QPrHJwNlmTr3xmEHRCMcHLS5hOGZaD8VkKpnbAMQgpGpVg2FFpA==
X-Received: by 2002:aa7:8392:: with SMTP id u18mr932733pfm.41.1584383586593;
 Mon, 16 Mar 2020 11:33:06 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i13sm581150pfd.180.2020.03.16.11.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:33:05 -0700 (PDT)
Subject: Re: [PATCH 08/11] target/Kconfig: Allow targets to use Kconfig
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-9-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28b0e1a2-95ff-af2d-914e-a9f9ca9b73ab@linaro.org>
Date: Mon, 16 Mar 2020 11:33:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:00 AM, Philippe Mathieu-Daudé wrote:
> diff --git a/target/Kconfig b/target/Kconfig
> new file mode 100644
> index 0000000000..8b13789179
> --- /dev/null
> +++ b/target/Kconfig
> @@ -0,0 +1 @@
> +

Does this want a

# This file intentionally left blank.

?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

