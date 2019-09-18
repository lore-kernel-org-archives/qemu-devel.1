Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB33C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3DA218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBQGPxP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DA218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAbbs-00084U-8A
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAbaa-0006yS-IF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAbaY-0003X2-CQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:09:52 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAbaS-0003RS-8P
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:09:44 -0400
Received: by mail-pg1-x544.google.com with SMTP id m29so26275pgc.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z+IsGNwzXWZ3nCeFtv4S2oivecUVMyJE4X+eIHtkKPw=;
 b=ZBQGPxP7zrdIT80gkis3WuQ0y79tZhwJApHpskzseUCZWcTilxrDJ4B7tf/iVMtSpD
 UQ8Yv4r9MHxFCcD4Z2zLxa5p3sGYtzyZnvK1o+LVV5KEFvP9Af1HwxOjpav6zqkILxnl
 leyxQ5pKFTjfsVy0gDKbpOYd9rHSKjUceJBXfeq7JG++xuRSPNsOEucNmNgsklmkkiPF
 MRqo+zzc/T3Z6zCbaKcVU6N4ypwOObPyUH2kIlD+L/Lpxl/bdDVQYGD6t7LeJIb1pvuq
 DPvqhNxTbcVvnJR6aNEd33PVlgBZHotDrlu0joVjmkJGhF59ngvoqQHVuLSCUNCgtKur
 O62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z+IsGNwzXWZ3nCeFtv4S2oivecUVMyJE4X+eIHtkKPw=;
 b=tXUQLQAtQK+cjCmSh3IjozzvTuQzEKJn1VxK8eBH/f+AKaFSn1PKsH4UdTCkGAxxt0
 cT3TLamVFuFQp6E/vJiNW5CPpEOtwFBFO8B01vilevfRQ8HRiVpcBxUXUuFXWmv1fcBf
 VTWRQBD9dD/PisSHBKq9KGhTss+qRIFlJQP/CucWx5gt8mcjrSAWUIyH2E+Aqn2LCXCC
 kpI9pqNYrXrG4WrjFECCWgnamjmaDatiK4UuDMU566nC5oyWAM5TY2FTB4a/elWTgSTz
 MzUnI5wDuJWc3JPfUXHWgC1Df3BF0L4WOdRW5QYT03qJiK0mZjCevSL/tmQ0R2xGJOLO
 kirA==
X-Gm-Message-State: APjAAAXomxJKLULF7TUfjr9Jn2BNnyAUOM6m0vkPv0jG1wBHHf5bBGSa
 y1nt3UjIJS6d/B3YfalJhOgijw==
X-Google-Smtp-Source: APXvYqz8zBEh8/nzZGEsTVia4oU/coO7S5SkWmwpN8rIMeS/5vkl5B5HLY6dX5MNAhr3Tomy+SeCPg==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr2001436pgk.71.1568819382284; 
 Wed, 18 Sep 2019 08:09:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t14sm7387325pgb.33.2019.09.18.08.09.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Sep 2019 08:09:41 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
References: <1568817169-1721-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6d7f7fd1-b0be-a944-f558-ca5d788f728c@linaro.org>
Date: Wed, 18 Sep 2019 08:09:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568817169-1721-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] ppc: Use FPSCR defines instead of constants
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 7:32 AM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> There are FPSCR-related defines in target/ppc/cpu.h which can be used in
> place of constants and explicit shifts which arguably improve the code a
> bit in places.
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
> I confirmed that the generated assembly is identical before and after
> the patch.
> 
>  target/ppc/dfp_helper.c |   8 ++--
>  target/ppc/fpu_helper.c | 122 ++++++++++++++++++++++++------------------------
>  2 files changed, 65 insertions(+), 65 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

