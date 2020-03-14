Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2322AC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B9C206FA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSUh99jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B9C206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCvLa-0000Xt-9W
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 21:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvKv-000055-5x
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvKt-0006ng-Rt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:11:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCvKt-0006kD-Jo
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:11:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id 2so6308099pfg.12
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 18:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V3+UwTRRFEzlzOlu/JhuAuuDfrVepuA+1dd2Y56MS/s=;
 b=RSUh99jDcl1uPlp3aVTGBVrfe/HDdzwC6tWdvgOTTK+DC3imNbtcaq+Or6DcdGWKSx
 6quZLLx6axi3ulHzh5/WxL0wTDMVc7CuthVtx1+82TFMB9gFXoVFz1lfneT95VghzACJ
 GSfspZhGnNbYEiGg01tcgZMGCYP7rSxO0Q5HTJpcaOW+XTlq1h/wPy7Y7RGhd029Vn8a
 pNYuQs2iFlPCpvVGHYDYLw4qpxnIVIcbDmkyHerJlVbYh289uEytdfZJlw/CCd36Tqh0
 WB6VrRtUXcCmNcaQqDHeH4+pdJHSgK/KVoR6f55WfsW4t0aekGKZNWjr60/DyUSM+srR
 89TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V3+UwTRRFEzlzOlu/JhuAuuDfrVepuA+1dd2Y56MS/s=;
 b=Wk6GQxzTs5FrmzQNVhz4N9QxXQ0ux5QT2n6nD8TeARBEm+huif5gkbwpxf7KrZKBfD
 UVbDkOqYpRy10CPZN5oEOpilftx+wVkiwNmpANDMQD/2r6dMUhNO+mz3wjDe33G4PlbE
 ym+Ajfb+5U3ZTQNX/ugvTilekH3CpeyvMLrbOp6Xacmm6NDLEK/BylBnE0NKekN/tz5A
 wNMBsAfIdRHStBf+wDnP45n93hHuuYlDJgnMGfXZ+MEeAdbOPbq0ZZ2/j/qEWibi6Y6a
 LazUD7GgYrELlRKIfaGEWZnxEnI6tWYZV4fdQqGR9wR1APpVfyEVNdWLQ7kHxKm7WfA/
 ysgg==
X-Gm-Message-State: ANhLgQ2oa71eA0qPox3ovIJORrJ2hKOwuWFJbp/1g0qp/ezqeLSPk19u
 l6RcwjodBNBMRnKJ42rLOlzWPQ==
X-Google-Smtp-Source: ADFU+vsCMynMtqW88pNTdwBLef+1fHHAhZ6KO0jyDnD9V43mvfFlNhl7yn3VE0SnbPLcQDwCTMiNEQ==
X-Received: by 2002:aa7:8618:: with SMTP id p24mr17060892pfn.3.1584148289691; 
 Fri, 13 Mar 2020 18:11:29 -0700 (PDT)
Received: from [192.168.1.11] ([97.126.123.70])
 by smtp.gmail.com with ESMTPSA id v123sm32198551pfb.85.2020.03.13.18.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 18:11:28 -0700 (PDT)
Subject: Re: [PATCH v5 03/60] target/riscv: support vector extension csr
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-4-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97ba9d00-324c-cca4-4e0c-459a83550132@linaro.org>
Date: Fri, 13 Mar 2020 18:11:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> The v0.7.1 specification does not define vector status within mstatus.
> A future revision will define the privileged portion of the vector status.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu_bits.h | 15 +++++++++
>  target/riscv/csr.c      | 75 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

