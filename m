Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC0C0044D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752002071B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLHrI6La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752002071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDIV0-0005gN-Kt
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 21:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDIU5-000595-1t
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDIU3-0006lw-2f
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:54:32 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDIU2-0006hi-No
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:54:31 -0400
Received: by mail-pl1-x642.google.com with SMTP id a23so6175297plm.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OTSphg/7spynbkKjgV3IISJwXHBHCMFIRYULb83xpTA=;
 b=fLHrI6LaGneXX6Oqe1x0Gnn2uaxmNIljlq+w6iUIu8RUtAlf7IDHvf6L5oubAl2qah
 awg8XkxpnZpcqVf2u7qR2Dbc1CY/6kmnTKFWtvjGOQ1HO6hhZ4s/aimePJXGIU3zOAgg
 pDkIM0tiTRzIXe9vz494sgIQihbYRttDBmpYvV0HG+yQRy/rh1PYlTu5rl918XQ4INhr
 0vbyhrsl653axt4k62ArPiTH06WTgXpxU7v2bDGex2On+OElGtZTRJTp6dYtBGWQPzct
 LNpLBbHgMHbloouGXicScyxtLBpSYxHNFm0qiSnBaLubTcMEuWXsMWkptC/V1KLZGebx
 1cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OTSphg/7spynbkKjgV3IISJwXHBHCMFIRYULb83xpTA=;
 b=cyEEzH+Vam9EgOtnATjqdvCn9u6xH4FGW1IisaY9XWBGy20zHd95p+cZXwKCqwC1eh
 ECbQCBxSNIcSQQNHO6TSZsclKwKIN1bhdTO9ydekiuXSl4V/+B9L2NlzMRp/P/zD5Vjn
 voB45gU4U0PINjcCKZV8r7mQulIyV1hoRAr63q0gVxjbCUg8EW8M+rhywbKgvmlMeLuO
 SCoqhE8pbaJLY5X9NgSSR6sLlOLodIiBMzTgXhyGEUWb6xsVWXgVjvcoS6yXFR6z0s3y
 8X4XKwR3LUE9SODCEMkR9GNz5xz1iUlWCiXvlCTbh20K7HisXOo16vLhAmKUdAq8P3K3
 YVrw==
X-Gm-Message-State: ANhLgQ3XRZ5OuH3akCdVzcS5aWpZ3tr7DBuwdeK7+ZJhxoXxy4LnBf/C
 BjQ3doiUdu4WJ9c90zr0EcGpxw==
X-Google-Smtp-Source: ADFU+vtjGooFmwO021q0bhA6r9I+4oNh7WDdgy3JflmyiLrawJJCKF5GJ+m86PGHViv8raQPeHktsA==
X-Received: by 2002:a17:902:be0d:: with SMTP id
 r13mr19805210pls.273.1584237268317; 
 Sat, 14 Mar 2020 18:54:28 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x21sm11514177pfa.212.2020.03.14.18.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 18:54:27 -0700 (PDT)
Subject: Re: [PATCH v5 53/60] target/riscv: vector element index instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-54-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d5d45b2-770b-be40-4e74-ce3cdb1cd48c@linaro.org>
Date: Sat, 14 Mar 2020 18:54:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-54-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  5 +++++
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 21 ++++++++++++++++++++
>  target/riscv/vector_helper.c            | 26 +++++++++++++++++++++++++
>  4 files changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


