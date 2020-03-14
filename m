Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97627C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63877206B7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCqYOoU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63877206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2PQ-0006HE-IW
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Oq-0005pI-Cv
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Op-00042X-FC
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:44:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2Op-0003wz-8M
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:44:03 -0400
Received: by mail-pg1-x544.google.com with SMTP id t24so6443283pgj.7
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w7+iLPw7Dg4Nw7LXN5Qa3rWY9fzDj6UFmgdia/iOeuE=;
 b=SCqYOoU1XruvlC6KudCKwdaS0fKhiu1dq5SjX7JlEe7jHjophevNa9Jkmn1j62Ty65
 ymgTNV3CERWLVZQaUonmINaQqDQIQSC2T4Zew0NVsNFyTc42FBQStE0tCLly34R8LcJT
 0PSl9v8CIDCcVqA1hYdtopTew1EEflrmnwCH8cVeh0TF4lIhayLJOVqVvi3tvjh7nfkQ
 qlyKHrLIlv/XV1ST1jNQYb6N8Da8/164Wz1K1Uw9AMqkizhGZdvwuW8P0N0dqapt9XyD
 h7UwXkII8QGpMjQjCMpO6y3pW90BqWx0uLmpVMp8E169tSE8YVfZLPAkqv69UGOf2o/O
 JixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w7+iLPw7Dg4Nw7LXN5Qa3rWY9fzDj6UFmgdia/iOeuE=;
 b=a6i58PCTfqsQNVJfHW67Zru6j089OMXtmUP0wk+KlyLmBaY0iNwrGxaWRp8kcQBZ/t
 ULzsmRhtgbAewrc5C5XCAaSVPU3IE0tKOVMR4VB0feoXu2bJKBYigi62TFD/is5GGBRl
 JWJ3NJxm2GcCjvjGVtbt7jf0PwjzmvpHSUD0s88JYsGBeTEqQxHEtLOOprJkHQjZRqqi
 ZM+vx5wI9q5RNYnRFKJVB3nLTgupBFSZVdIIuH4kQYauNl+yucgWkabrI/cZHmuEJWIQ
 pBZUFsIZCDskMXeBl7eCD4n7A3OwkDXMY+u/+IT9i+BLE1M6NWDlI4jB1xaFWBFqULH3
 XSyg==
X-Gm-Message-State: ANhLgQ1Nt581DYIhHeXYmvkMch2FCQSf86kXw0ahK9RfFKv3GeFMNc/z
 7dJV7UOeYvicflJQquxSyhonzw==
X-Google-Smtp-Source: ADFU+vtNhaY3ysWD3Ty1zzrRQkLYH3DNL/62vKaDWarbfZYJbD0WxWOnFsUKliE+NnTDDLzkdX8e8Q==
X-Received: by 2002:aa7:951d:: with SMTP id b29mr18394603pfp.30.1584175442216; 
 Sat, 14 Mar 2020 01:44:02 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e10sm18244257pfm.121.2020.03.14.01.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:44:01 -0700 (PDT)
Subject: Re: [PATCH v5 31/60] target/riscv: vector single-width floating-point
 multiply/divide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-32-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ebb2c3f1-2978-de02-82e7-4fad1676d2ff@linaro.org>
Date: Sat, 14 Mar 2020 01:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-32-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   | 16 +++++++++
>  target/riscv/insn32.decode              |  5 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  7 ++++
>  target/riscv/vector_helper.c            | 48 +++++++++++++++++++++++++
>  4 files changed, 76 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

