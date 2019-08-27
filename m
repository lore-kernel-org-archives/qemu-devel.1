Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AB3C3A5A6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44312077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbVan9pX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44312077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TKt-0008RW-N6
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2THt-0006C1-O3
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2THs-0004BV-U9
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:40:57 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2THs-0004B2-Oj
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:40:56 -0400
Received: by mail-pl1-x644.google.com with SMTP id z3so11158094pln.6
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2OleW7eQd+x/8bAnH0mS0XUOvvfisfmBO5OlBKh23wo=;
 b=lbVan9pXFp6J6zGaIQp2JZgSwWxt0ngTADJnR5xrq7pFmvz3tYQ6aeXYIqQpi1jDN2
 /CrZNHU34vT8VGgFV2coNpnAHc2LxUg2WCrbOP2zsTraMv7KQOYk69CpYRv7n8VedKfi
 L3uVAzSsxEchnE3XG8HJYN0EG9f2qBHEVtTv+2zcBqO/ovLmMt7ypyA7zTNE+eivJm0i
 AzmfLp8E5IhkrHUGPsG2vYU4nI8andbJEszGwBlaIWzvlTUDULp1SJzHQM62LoXLHHcQ
 wl5LJhbTZDAQSJwAoLvN2aJduJgoYPU8qaFxGhoGZ45cMByYr6uPLXHDV89UKcuW8Gdz
 ggZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2OleW7eQd+x/8bAnH0mS0XUOvvfisfmBO5OlBKh23wo=;
 b=RwruAcchJze4JqNf9FySWOMmSTMTENvQfbevYjuNvgv5BRmpCiXZUrDp6VAC5p/Mbu
 oUrAA5c8d1EbzHKZri8zcpCuEU1598engbl4XaBZIW0xlRqJh8xVgi8RN30VqXDdKkMY
 H8ZFsLGORT1z0v2WxQJuUmwLDGqunQL38ad2veKo2xyfRu3NUzpKIv3rpDmR04vMP6bn
 Fcky5FkXs2obLcYP+N8G2PbWIppQedCFM+HSRmoPFLrj1TKcDsl7vlRXAjv5jUH6JphG
 EviysFp8HrRR1ZE7rhNVOuGq02LdtllF86FYVO0CkqPpZPf73McNNhfwv5+Kg6fZgogZ
 1T9A==
X-Gm-Message-State: APjAAAWTeSmQGrgX/OAToXrTVH60WjQ2SmS5nSIF+7RNc3V5LbBjRCc+
 BtrdACuHH7m8tbzteHBTLYU=
X-Google-Smtp-Source: APXvYqyw1YdC+s6dpYpd11AGDevVNFeg2J9+yZqKPAY2rGH3VjRvuvHVJ1A30jyvzxpkq4x2Uzo2Pw==
X-Received: by 2002:a17:902:43:: with SMTP id
 61mr22909991pla.145.1566880855571; 
 Mon, 26 Aug 2019 21:40:55 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 n70sm1051457pjc.3.2019.08.26.21.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:40:55 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:40:53 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827044053.GN24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-10-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 09/13] target/openrisc: Add support for
 ORFPX64A32
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

On Mon, Aug 26, 2019 at 05:07:41PM -0700, Richard Henderson wrote:
> This is hardware support for double-precision floating-point
> using pairs of 32-bit registers.  Fix a latent bug in the
> heretofore unused helper_itofd.  Include the bit for cpu "any".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
 

