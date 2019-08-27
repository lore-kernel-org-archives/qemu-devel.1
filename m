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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18963C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AE9204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loLyld9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AE9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TFN-0003T5-1v
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TDZ-0002AG-B2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TDY-0002KY-BJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:36:29 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TDY-0002KA-1S
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:36:28 -0400
Received: by mail-pl1-x642.google.com with SMTP id bj8so11123804plb.4
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JjyXuznrUXTpIzsRGiqaRxGZNkGydyzvX8Sjm6QnC6A=;
 b=loLyld9F6qMR8/mTWE9nZWmPoIApXkWLEhvSyxHq5MFVCt2TZkRFhzO8UzBDhzBV0y
 qfod/iyGtTRl1XP1Q7JZq41UTL5M7Xo0HiFrac48Ww3UokCBRWA4eifhJlgjAKoueoWm
 SgbfmyY1AynNDABc5BBPbDY7lFeePHR73RLgfG1qVugKPFsBYaQow58x16ZkGsPBC+6e
 dP+xr3hf8RBNkn7UWWNK7uq/0wH6Cj1mbGSoeSb5dIkh8k+ifv0+ZlJb+OOoZv1Epfj6
 oxsYk+v+gRP7WoSJFs8JWLnrjsNgGzVpFfzyWQ2k6RxD8IWirINWnr79trkTT9XxH+xx
 W6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JjyXuznrUXTpIzsRGiqaRxGZNkGydyzvX8Sjm6QnC6A=;
 b=MyIw47nbF/AMWiuPY8c27vViRVXnbxxHcwZiy2vlw7SbjncGt18ZCs4FHSYqb6TyUk
 NOYfG9pN/01FGEkaKYKjCDVyh8F0/9yDxDE3Qb4D8E7a4zGN8nyro+VUunRou3oxMPA6
 xqO2ExmVrZuvlWFW/0pYtsalTbgc83Q5/eseLTRyzxQ/MBOKo/xQYWSwxuq2h2h6Riui
 5e3zb6u9fXJWtF67C0i/nOYbRfmHy5Z/krsfKDrqp6T857lj/1QEuJsTnM+WeerCEby3
 amAI2xgjiYGB4M++tn9QMAYw5U5yAIvRR6OXoauxCAiMHmVDoJWPY2lflUmSaxb/aDNV
 RIyw==
X-Gm-Message-State: APjAAAXObgNWPVuUNovfi0/4LH4rh11idthG6Voo4OBEHglxKoeNndm1
 01UQg1WxvaN1AtSA23dLrAA=
X-Google-Smtp-Source: APXvYqywULAXi3xzE0P+BjrxDAMsWdjoU//hWxa9F8R8IgRyGjdFlk0DVBxF5GxhytpWJGtQsEaVNg==
X-Received: by 2002:a17:902:3064:: with SMTP id
 u91mr22369825plb.244.1566880587082; 
 Mon, 26 Aug 2019 21:36:27 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 y188sm13708788pfy.57.2019.08.26.21.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:36:26 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:36:24 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827043624.GK24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-7-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 06/13] target/openrisc: Add VR2 and AVR
 special processor registers
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

On Mon, Aug 26, 2019 at 05:07:38PM -0700, Richard Henderson wrote:
> Update the CPUCFG bits to arch v1.3.
> Include support for AVRP for cpu "any".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/openrisc/cpu.h        | 11 +++++++----
>  target/openrisc/cpu.c        |  8 ++++++--
>  target/openrisc/sys_helper.c |  6 ++++++
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 18d7445e74..71c5959828 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -96,11 +96,12 @@ enum {
>      CPUCFGR_OF32S = (1 << 7),
>      CPUCFGR_OF64S = (1 << 8),
>      CPUCFGR_OV64S = (1 << 9),
> -    /* CPUCFGR_ND = (1 << 10), */
> -    /* CPUCFGR_AVRP = (1 << 11), */
> +    CPUCFGR_ND = (1 << 10),
> +    CPUCFGR_AVRP = (1 << 11),
>      CPUCFGR_EVBARP = (1 << 12),
> -    /* CPUCFGR_ISRP = (1 << 13), */
> -    /* CPUCFGR_AECSRP = (1 << 14), */
> +    CPUCFGR_ISRP = (1 << 13),
> +    CPUCFGR_AECSRP = (1 << 14),
> +    CPUCFGR_OF64A32S = (1 << 15),
>  };
>  
>  /* DMMU configure register */
> @@ -280,6 +281,8 @@ typedef struct CPUOpenRISCState {
>  
>      /* Fields from here on are preserved across CPU reset. */
>      uint32_t vr;              /* Version register */
> +    uint32_t vr2;             /* Version register 2 */
> +    uint32_t avr;             /* Architecture version register */

Do you need to update the serialization in machine.c?


