Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C4CC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 02:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D16206F1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 02:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ey4UwKwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D16206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI0sV-0007tB-05
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 22:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI0rl-0007Sd-69
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 22:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI0rj-0001YW-TR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 22:06:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI0rj-0001Wk-Ii
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 22:06:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id b72so5410001pfb.11
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FmLAljmekYVZCwDl3aOlnyPdywDPCiVnaPAEy0My6YA=;
 b=Ey4UwKwku5tUBhXSdxgBymgtHPNaEEllmkSKxdTqGCvpQPQujaTSqGvOC9jLfem2fn
 YNWvG+dt1vWXXWl7pOdm0JLtP0Kmc6v6isQNlQOcJ+9TimjnuVIptKGlv1v5aq+t5DOA
 Mo+DKjed+E0xTkPqDEqZGCM1os1XTBkNykgLYKeU5+HF5OGoJBlXvpEfuCI46UzSSAz1
 gdXPMTUpAuUph6M1SCkLrlXQqEqKufVMAeT+S2rvfb/MluMtsWDHwzvPdDYKu15Ilhs7
 qEUNaZPxQ6j8704Gti6ti8CbXGDNd1gDO00ML8J0HCLi7CsIsh4kBuczVhnWbnZZ5xFu
 sw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FmLAljmekYVZCwDl3aOlnyPdywDPCiVnaPAEy0My6YA=;
 b=eY27UDKELXUs/9lmB/svpb9maJnYiqNMLDtaTLEZaUVh/H8UiTlN1hnx2lFJ3ppgCb
 zfSicrxmuFJqdH6uJFvhstBwADg0aU6HDQ/K1asl0kpeMCg0YfvT5CaswV4WQzcC5JRP
 Ix7iEa7DgmmObDtRDCdgmVbhPevG7x9M3FUJCYB4dqa7qnnwGv1AMrbOe6G6zEiqW/I+
 pdonuX1jNIDnDLC6qCujyluZv5SfvA1w6ODPd8VFNzcdeSD7oISB9xwPlyh1fzyKLex2
 /RmiLNzTeu/uB5uERJ7CLusdJ4yOCCaZgGa6xmFJMvtL9WmzjS+qO0klogeBylgOP3GN
 2oDw==
X-Gm-Message-State: ANhLgQ1g7x8fBLll/pe2/vntT57lOJ75CVffsnC9cJVxOLArYyORz8Oa
 y5MwyT0CB5Onv97RoyiqAKuoug==
X-Google-Smtp-Source: ADFU+vuLtak0pQ0UE0lwDWTyv21r1tdUMPvb4Kg8Npu3zqtWG44V6FFYvn7fYG3pvwtE0fEq9c8RJA==
X-Received: by 2002:a65:49cf:: with SMTP id t15mr2191566pgs.375.1585361186269; 
 Fri, 27 Mar 2020 19:06:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id b198sm2664738pga.71.2020.03.27.19.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 19:06:25 -0700 (PDT)
Subject: Re: [PATCH v6 40/61] target/riscv: vector floating-point classify
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-41-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <73d2e780-6121-5180-836c-00542d8ca522@linaro.org>
Date: Fri, 27 Mar 2020 19:06:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-41-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/fpu_helper.c               | 33 +--------
>  target/riscv/helper.h                   |  4 ++
>  target/riscv/insn32.decode              |  1 +
>  target/riscv/insn_trans/trans_rvv.inc.c |  3 +
>  target/riscv/internals.h                |  5 ++
>  target/riscv/vector_helper.c            | 93 +++++++++++++++++++++++++
>  6 files changed, 109 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

