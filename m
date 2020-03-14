Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0FFC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31A32074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cP+rrAR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31A32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCvjH-0005m0-Vo
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 21:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvih-0005LR-SN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvig-0005kq-Ko
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:36:07 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCvig-0005k5-DI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:36:06 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay11so5162765plb.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 18:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IV7e6pR/kWjyWJzEvmBm9Y6YrhPG/uI9G+yxH6w/iPk=;
 b=cP+rrAR+Nc0zC7LRPpMs50YArwVkYAUVdMxVcgQToiPYSGHWR9uMikHd9pD0RdUK7U
 vlVP6hK8nN/gny0ssrlyTG5OqdybLHLgmGQQApiiBI5GGTUSMzjvwC20FjtZ73W7hL8a
 VM0b8DV7XBTfcBrvI0UcECvLtzaL1mkB5Xt2WqZXE4r6v8vMxDk+x4cDtzookT/cnebg
 zhcB4nAJYQsFua6Ldg8rMn+0fE2ZK7L0XvN8X60Bnx1iWzby8P6pnvJIkgz227JIyjm+
 UiEOB0zhTC4XJKTVdkJdGm327alLL3tmtB/TbD99OnJQwCBAgDKCpjKOYTKSAXbMOhj4
 9SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IV7e6pR/kWjyWJzEvmBm9Y6YrhPG/uI9G+yxH6w/iPk=;
 b=a4RzTPm8GB7+AU4WlOqS/XIy0qFPC43fQyOa6sHyc/v9GBpY3tzaRBTM2zn9hdDukq
 jTlkDEgExeIh7yjT3rfK4x2dyIHAAMDfw0piCIRGIJHdr+fdyCGpej5XlsryZkJgXX/J
 l2nLmdNBNNwy7UwJ5LaWLerOTvkPfv0FLZlHicuf9ypXIWKBOrruq3r17Cg5zjnJuoTP
 cUFESdZN/oeUNcUVOhORPCL5czOXVslIfR6FmqCEf9P7Y99m/5zrJnQKH06Vk67Xth9L
 uCrkkvjjU1jD0qss+8VuJhLj3b8GPXolA4jpBGrhRIzrful/dyU982Bzv2zIJcwnWGId
 uZqQ==
X-Gm-Message-State: ANhLgQ3FZatpnXnL5KOQPJ5ENBiCzygv/gp3NbNysUH6pW5C5+NvlKrh
 k2BLB5FaBI7BaX3fMLDtcjFpSw==
X-Google-Smtp-Source: ADFU+vuxXyFbiBcI//V2MTPUQjKpmKV7z9GV3ibkx/bVC4/AdF69Ce8r0rYfFjwA5sXnMTy6rZiPlg==
X-Received: by 2002:a17:90a:ead6:: with SMTP id
 ev22mr13271734pjb.66.1584149764406; 
 Fri, 13 Mar 2020 18:36:04 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p9sm12909404pjo.28.2020.03.13.18.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 18:36:03 -0700 (PDT)
Subject: Re: [PATCH v5 05/60] target/riscv: add vector stride load and store
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-6-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7dbdc9b-3b27-c399-1c56-cf8db7c4f734@linaro.org>
Date: Fri, 13 Mar 2020 18:36:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-6-zhiwei_liu@c-sky.com>
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
> Vector strided operations access the first memory element at the base address,
> and then access subsequent elements at address increments given by the byte
> offset contained in the x register specified by rs2.
> 
> Vector unit-stride operations access elements stored contiguously in memory
> starting from the base effective address. It can been seen as a special
> case of strided operations.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.h                      |   6 +
>  target/riscv/helper.h                   | 105 ++++++
>  target/riscv/insn32.decode              |  32 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 340 ++++++++++++++++++++
>  target/riscv/translate.c                |   7 +
>  target/riscv/vector_helper.c            | 406 ++++++++++++++++++++++++
>  6 files changed, 896 insertions(+)

With the changes for has_ext,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



