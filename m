Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84223C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488A52074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rcvlkm6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488A52074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2Rj-0007SQ-Gc
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Qu-0006yr-A6
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Qt-00031f-Bb
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:46:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2Qt-00030f-57
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:46:11 -0400
Received: by mail-pl1-x643.google.com with SMTP id g2so2952053plo.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mPDY3hmf0gb6iDEElCxRUKeNbw9Im0NdxwliR+IOBfk=;
 b=Rcvlkm6nun8vVVxuZBwrqj66fcxhPnV1gGTv9c+KIMkZZTNNk1OMFWNyZS3QyoYv0o
 qSOno+MBtVuhl6z6e0s8utle3vG5dJY52nb3ZQ3uXYFvppH39oIhNRsnEERY86uT05vC
 5htVjI5msVOEU9CERTotWMzfwU/YrkcG1SyOkU9XVS2n3EuhF59MIGxxWtTbZE6lpYWW
 lxxVVRFQ1lRqFlnbuybHQ/8hA90wNUyPsgARh77fSG/22Oq2XzBGMvlB7Na3IIm7qG/q
 lwzF+LeIt8NtR1NYuZBLlmOg4BoXocGGBwztT4c3kyZ8pkicMOVLNNzK1EanKVD7hYu9
 hfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mPDY3hmf0gb6iDEElCxRUKeNbw9Im0NdxwliR+IOBfk=;
 b=kf/8ofeMJUTK8rsQWVd56Wj+L9MNVPqwKfNieNDk3KAQmuTtsLUwyZ5T+gvR5ivAFc
 oJYUZHQWh/cQi9gaKuKDqbi7b0GSMIB/W9toejBq92j2OS+s/exRLo2N9OdQ3DY6cprI
 eWgz9JMXpMbYHc5IVwce1+WmMLAeZiPBfVn7CrNjRVNawZsR74v8Rf/CgBNUoD9Ix4NZ
 EzhLYIhklhQ7JN15wMSOtDv3r4EmKH1S+221YXkTKMlEbd3AxKjaTDYncPI0LHc2AbLO
 S9qTqP6oaWzUXbfPKWt/XFAOfnnyCJ2Cx4a59iSGfAuJnRax/KrA/EXOx6HAygjg0xw0
 jviw==
X-Gm-Message-State: ANhLgQ35aT41SiCNVmclkommJdPW0dQdfm6wZhk71GpLrD55chFnlF5x
 8BAcxJW5gjGH30jqDmY03ApzCw==
X-Google-Smtp-Source: ADFU+vvYImFaqDfaTWB5enZoCa1ezNPJBtwOtZWSmH9zCLWHsAaeW99Y5pUTcGBqk/IbbHtOJvh9AQ==
X-Received: by 2002:a17:90a:c687:: with SMTP id
 n7mr14424592pjt.155.1584175569562; 
 Sat, 14 Mar 2020 01:46:09 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o129sm7469832pfb.61.2020.03.14.01.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:46:08 -0700 (PDT)
Subject: Re: [PATCH v5 32/60] target/riscv: vector widening floating-point
 multiply
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-33-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <496260bd-968d-fbc1-faca-37944adf12e9@linaro.org>
Date: Sat, 14 Mar 2020 01:46:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-33-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
>  target/riscv/insn_trans/trans_rvv.inc.c |  4 ++++
>  target/riscv/vector_helper.c            | 22 ++++++++++++++++++++++
>  4 files changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

