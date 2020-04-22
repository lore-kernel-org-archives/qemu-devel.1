Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19938C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD4720706
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekffncWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD4720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR6y5-00056u-1h
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR6wa-0004R9-FZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR6wZ-0006hE-FT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:25:04 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR6wY-000631-VC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:25:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id h11so416859plr.11
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tdQDoUztRv6XvgHSmvPyCM3uW87+jm3LK61yOenytJs=;
 b=ekffncWjIuUieS8S+hRbCcsHpmOSRI54JYedJrfScEznOmfUid9A9j86ebMHLB3TAU
 OWbZlv91bZfwWMvN6T97EJpU5UzYtNhoPPv0Sk/XsNmrSOYNQhhCZADfu3Chac3HkFO+
 fknxhYPf48PRK0++5UEOj6t4c91r+G9jmOPv2w67yx4sj78G7vJO5wZT739YRZwimp+i
 kPLo4pLhOAHoY/4B/WXkTxIFJt9GrstciDVJFa5S2AHcM55GVBHv3fD09Aasdaf1k1PM
 bszG9PjS4L8oYkRGDBzNS6FSTpEFuClmfZR6Dc1cEeJloWCsm8jTiVRbH3ZWBPwBKBz+
 DmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tdQDoUztRv6XvgHSmvPyCM3uW87+jm3LK61yOenytJs=;
 b=CMf2uDaqsm2D5nF4DfeoeLFC+62UiBsu2rYaI/miMNO9bOpyaA0JGGbHGwwGaTls1a
 fke1STISEKrkZOpbiigO133AbdgeSOy7Si401Qh9Ma9qfaH2szl8vuHJ/6DUEIq2b6wy
 UZ8C5tCc75pjdf5C6OZDPBk2YtMvUzgYCuKy/SuqLh2ylClJsl88h5o8YRxRpB2ZMxt3
 GSonhgxSx5m7MfcHkvwbQbl+WPGhQVqZuACKQbFgogUNdQsh1tGBfF3dn/ptBNizG/S+
 3N8lT7rHzS/q4aIRBvXTXQSXcOd81p8FYSQhkt+03N8NgYTk1M/pBbShY0q8LPUhXXoJ
 eLBw==
X-Gm-Message-State: AGi0PuZAIScYThZPe+DH/U0oiaLeM1bnfcWD6PWNf/GDtGawAwgy0V4Y
 JyQA8Z2gaI08nr1w92mbV+0yhw==
X-Google-Smtp-Source: APiQypKCZn2X8QjZapQDBNhNG07KtWOi5EbdJJagZN1Lyzkl1x8XjRGMvCIcwoP1OtdZCl2lE2fyCg==
X-Received: by 2002:a17:90a:ba88:: with SMTP id
 t8mr9595561pjr.182.1587529498437; 
 Tue, 21 Apr 2020 21:24:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t80sm4152243pfc.23.2020.04.21.21.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 21:24:57 -0700 (PDT)
Subject: Re: [PATCH 6/6] target/arm: Restrict TCG cpus to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200421131926.12116-1-philmd@redhat.com>
 <20200421131926.12116-7-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e2864e76-90a7-03f6-7bf0-e409980a2900@linaro.org>
Date: Tue, 21 Apr 2020 21:24:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421131926.12116-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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

On 4/21/20 6:19 AM, Philippe Mathieu-Daudé wrote:
> A KVM-only build won't be able to run TCG cpus.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> This patch review is funnier using:
> 'git-diff --color-moved=dimmed-zebra'
> ---
>  target/arm/cpu.c         | 634 -------------------------------------
>  target/arm/cpu_tcg.c     | 663 +++++++++++++++++++++++++++++++++++++++
>  target/arm/Makefile.objs |   1 +
>  3 files changed, 664 insertions(+), 634 deletions(-)
>  create mode 100644 target/arm/cpu_tcg.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

