Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A928C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5B5217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9a4HOLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5B5217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TE6-0002FK-Tz
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TCg-0001NL-0f
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TCf-0001mS-1y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:35:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TCe-0001lv-S3
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:35:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id q139so13226123pfc.13
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QSmbtUEjqqJ7N49ucH99eHLtO6korQ3ly0i20ZBrvak=;
 b=W9a4HOLOQ0nKqt5s43i68U9Ke2KKcKvdDculQwY/GaJBMdD4srdkrZIkqFL/OpucbH
 RUmXmn1aHLl7wkoKxxBG34FNq8DJi+iB2ihCHT8Ep4Gv5PxDuhNOCoFUzdXbkK7C05de
 Ti1ubCQlx9TSNILoc3vWdtendHjznujp7Lbk+ge2o62E58J5ZTRyYL5SUxsBY00kTkPJ
 iLj0m4t0+LkiOkbplbP5B6jfG45F4swyxFmNMefnRS/RT2poEOCeCtlGjj4sSwTT8qW0
 kalR0teszANDAh5I70W5ansIdCR7wJHBV79amE6dIwqeKdWUb08VQ8APkCbQgWYl8fNx
 2GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QSmbtUEjqqJ7N49ucH99eHLtO6korQ3ly0i20ZBrvak=;
 b=b+zx+wr6gUBaeY7BSZIHYyxkLI36BYOSvnAfpk7WmECwh4hHuyNFoojJjic68rIsKT
 ThojFHyHi74F3b9CVviRmwuW7CM3KCm8hN7jmQkzMSulbgw6/TpVr4s5kbNwlAs6Npci
 YrP2JtMJyj2WCgQ3QqLDj/2kS1mZcz7AVRhjfgPBMKDEfhUvK2fnAdW6yw+m6C9ldNHo
 wEIWNIGj2HPPRv2C+c8zHbz8LBj0iz0FCqKPxmBKVreI9vrZi6gfXfdqvy3X5UacCoZJ
 DpuF17d4ig3WkJwgzmNGn78aUikweC2PEpIWblSVBL5QSD+rpfzIyD1goOUZCPF9OU7n
 pNJg==
X-Gm-Message-State: APjAAAVWQn/Eqf/g0ieavrSkbmH7N//8FhOpuyy0yceBqC8vFpIKGkaA
 ZxzOI45RjbBQ4gl549HrmU3SGL/3
X-Google-Smtp-Source: APXvYqyzxiADcTnXczcLo6kvec+yBLDM8WVtcq1Q9KJPEljzWdvMXsTl4jrgwI0smJDGPZjPmpq8Lg==
X-Received: by 2002:a63:6a4a:: with SMTP id f71mr19202438pgc.409.1566880531490; 
 Mon, 26 Aug 2019 21:35:31 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 y13sm19661364pfb.48.2019.08.26.21.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:35:31 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:35:29 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827043529.GJ24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-6-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 05/13] target/openrisc: Move VR, UPR,
 DMMCFGR, IMMCFGR to cpu init
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 05:07:37PM -0700, Richard Henderson wrote:
> These registers are read-only and implementation specific.
> Initiailize VR for the first time; take the OR1200 values
> from the verilog source.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>

> ---
>  target/openrisc/cpu.h        |  8 ++++----
>  target/openrisc/cpu.c        | 23 ++++++++++++++++-------
>  target/openrisc/sys_helper.c |  4 ++--
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 755282f95d..18d7445e74 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -260,10 +260,6 @@ typedef struct CPUOpenRISCState {
>      target_ulong sr_cy;       /* the SR_CY bit, values 0, 1.  */
>      target_long  sr_ov;       /* the SR_OV bit (in the sign bit only) */
>      uint32_t sr;              /* Supervisor register, without SR_{F,CY,OV} */
> -    uint32_t vr;              /* Version register */
> -    uint32_t upr;             /* Unit presence register */
> -    uint32_t dmmucfgr;        /* DMMU configure register */
> -    uint32_t immucfgr;        /* IMMU configure register */
>      uint32_t esr;             /* Exception supervisor register */
>      uint32_t evbar;           /* Exception vector base address register */
>      uint32_t pmr;             /* Power Management Register */
> @@ -283,7 +279,11 @@ typedef struct CPUOpenRISCState {
>      struct {} end_reset_fields;
>  
>      /* Fields from here on are preserved across CPU reset. */
> +    uint32_t vr;              /* Version register */
> +    uint32_t upr;             /* Unit presence register */
>      uint32_t cpucfgr;         /* CPU configure register */
> +    uint32_t dmmucfgr;        /* DMMU configure register */
> +    uint32_t immucfgr;        /* IMMU configure register */

Note for me, others, just moving these doesn't require updating the machine
serialization.
 

