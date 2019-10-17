Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CBEFA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033B0222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbWv9HYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033B0222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL87g-000368-S3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7Lt-0008Q4-FF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7Ls-00084U-0A
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:06:09 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL7Lr-000846-3H
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:06:07 -0400
Received: by mail-pg1-x543.google.com with SMTP id i32so1512138pgl.10
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V6X4clHtSIaRsBNECbaft6W4/XawFKKZNohXWvfYc9A=;
 b=tbWv9HYxvG2QIPs47ulv9bl6KPXQgcKu/4uCR4onm+AcOCaHOxicQNPXp4Ejl9E+ux
 +3lPX1VHiksxcJGRPJDDCZHU0YwRvgnx8I0pzIIhQTiB5QD2DN/egf9/e+4e6vgdUbTC
 LUwdKofcQT01CvrTeoAURid+sbHNl+I8C+KnB+m3fVF4cWPpWvy0x4bvAyPqdIr22+Lt
 1+U8Bvz9Dabut2odNZQkA8wg5eZvVGcGBZCDk0HsEGr5LrpLVnTEMDkLJw/Twodcense
 MjzPazk3ckncnHfnyc2zXDXyXj+2kgPiwcDEWGYaqIFDz8IOMxqi8R2DUl/A7HETt345
 KP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V6X4clHtSIaRsBNECbaft6W4/XawFKKZNohXWvfYc9A=;
 b=CZVdWbzdJ+WRIxT+Z/mTzrTmkL0Yy001mhhSS6TTdJ47cXY9Ljcw6hGh/P0WJl9ryG
 jc303zu0gIK9jngoT4ThheRmnVbi9MAEj+i9H7NjsXQiGhspil0RLi8pn12ETmFJOxaO
 UCAgjvD5QTs4muItpruPU4tekogKlfwNNNJkrNuZQn6PHIvj8IENlQ7qp0dsj6TwRDvj
 ZGkGBxWT+7ZK4/TdrN0ZuQ8teoFBjftvVzZkXqDLwv6y6ygmmjJryqPor37BCZ42Cttd
 1mGEngg/HMdorzNPvb1AQd4ZrLp1yGWayabGLDmt1wR7ixwv+osiui7IgzoOB4hKla+I
 wh1A==
X-Gm-Message-State: APjAAAUfOPU1yW3p7F1dd91eZKj+4gHdO2xkx/foGmdasJGnZ/Gz59XG
 Qdx7Gz46rBMI4vwHlDpIXm5/ww==
X-Google-Smtp-Source: APXvYqzx7tb3f5oFWnbXOQ7nexgcoPFnqngxlDgYfSTsn8D0TFCWe7iypoFDZFRZ1LapFSGxvyo99w==
X-Received: by 2002:aa7:955a:: with SMTP id w26mr707235pfq.193.1571324766055; 
 Thu, 17 Oct 2019 08:06:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x20sm5453341pfp.120.2019.10.17.08.06.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:06:05 -0700 (PDT)
Subject: Re: [PATCH 6/8] hw/watchdog/etraxfs_timer.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <50dabcc1-7a2c-b4fa-7cff-bf25811ea5c0@linaro.org>
Date: Thu, 17 Oct 2019 08:06:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:29 AM, Peter Maydell wrote:
> Switch the etraxfs_timer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/etraxfs_timer.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

