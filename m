Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D87BC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AD620857
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8WT4GMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AD620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTBl-00067g-Hu
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPTAr-0005PT-1d
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPTAq-0005LV-6J
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:45:00 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPTAo-0005Ii-0W; Fri, 17 Apr 2020 11:44:58 -0400
Received: by mail-lj1-x243.google.com with SMTP id y4so2495060ljn.7;
 Fri, 17 Apr 2020 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=S7ZNopsLY+4c0MxDoi8HaUVT0NAryJP5GfzG/43hYZs=;
 b=F8WT4GMAXDUuOpKFcVQlNBgWQBVq6xUc8GU5Lj3oW+fXdqzoy7tR6GBt9Kp4uu2Yl9
 ffankAD4HKNDCSuV9pumY6SbG9Dlh1nkAzosJoRBHCddk2TXMiLEANk1TDDj5vLHwZQn
 Lf64srJnFATFsReyICN3CS0CLh/Ydc4YFP5Uvz+t1Z8gA9vbtnlxkPILPqh3hvFf//Z9
 B/GdkzQQFmQZdNg4M3wJ4n1AApKa0I58CUC1W4pSAYycqpJUY469wrEQTiQDdP3Ja6bl
 yGdAX1l0elsP8dxj8YMNEiETNTBMYMZuRPEwqqFeA6Li93equud5J0ADHps7doRUKKEK
 Ku4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=S7ZNopsLY+4c0MxDoi8HaUVT0NAryJP5GfzG/43hYZs=;
 b=kUwXdEUJVwqp5QIU66m3FzaBjDYxL6sk0op4/HRpWYxyvQRM/PRxxb+lpEvT41jOV/
 vztGXNCqoKo7yFo7UqxkHi+L3IMTysCjSUI8iQVIS0w830gSEs/b0Od0Tnkmn2P5kpfV
 K9ye7QQbwRJ0D9PlMC/I6/SnJaCWHxiF31DTZUpBlML4uPq2abQ5RsK6Fc09HXNoT9PG
 uFtPxTsupX6cVY2XjWOlE0iV3VKOcjPjv96ojXZLi+Z5pDtYOP68eqvy3Wgy0d8WCUfM
 9rspCk2VocBymCrq78EBZAwirruh+BkSCUN3H9cjd5mjmTOhB+b+K9dwV6vDcaTXb6VV
 xDKw==
X-Gm-Message-State: AGi0Pub3hISgANXhj8NwSbpCNrjDwwnsB6qSm3mburH4zSQU2AFLltNp
 FfEvMsoqMQwKfyEE4vNB7NY=
X-Google-Smtp-Source: APiQypLra0RKDRERVYZKe2kwBYfnwqq5zJhh3vOeh/TYlQmrcGt0MCOOOWynsZEJoedDp8ib5B91Mw==
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr2573867ljk.14.1587138296072; 
 Fri, 17 Apr 2020 08:44:56 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id y29sm16666917ljd.26.2020.04.17.08.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 08:44:55 -0700 (PDT)
Date: Fri, 17 Apr 2020 17:46:06 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] Cadence: gem: fix wraparound in 64bit descriptors
Message-ID: <20200417154606.GC2669@toto>
References: <20200416090247.353414-1-rfried.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416090247.353414-1-rfried.dev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, alistair@alistair23.me,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 12:02:47PM +0300, Ramon Fried wrote:
> Wraparound of TX descriptor cyclic buffer only updated
> the low 32 bits of the descriptor.
> Fix that by checking if we're working with 64bit descriptors.

Looks good to me, so with the indentation fix that Peter mentioned:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>  hw/net/cadence_gem.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 51ec5a072d..b8ae21cc0d 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1238,7 +1238,14 @@ static void gem_transmit(CadenceGEMState *s)
>              /* read next descriptor */
>              if (tx_desc_get_wrap(desc)) {
>                  tx_desc_set_last(desc);
> -                packet_desc_addr = s->regs[GEM_TXQBASE];
> +
> +            if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
> +                packet_desc_addr = s->regs[GEM_TBQPH];
> +                packet_desc_addr <<= 32;
> +            } else {
> +                packet_desc_addr = 0;
> +            }
> +                packet_desc_addr |= s->regs[GEM_TXQBASE];
>              } else {
>                  packet_desc_addr += 4 * gem_get_desc_len(s, false);
>              }
> -- 
> 2.26.0
> 

