Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB3C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037A4206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T67e43QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037A4206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6VQ-0008Je-7W
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kD6Up-0007nY-BV; Tue, 01 Sep 2020 09:38:47 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kD6Un-0007xM-Ny; Tue, 01 Sep 2020 09:38:47 -0400
Received: by mail-lf1-x143.google.com with SMTP id d2so804649lfj.1;
 Tue, 01 Sep 2020 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=2k/y4lk5ihDmDdbVF4BqKxsGhrcX/WsBiETwGXk31lE=;
 b=T67e43QC1sHRae/QKxpUGlTH9Jz3S41myrZ9x/R1G7wOZYXYsvF+qEbOjjHrrUUsvp
 hfuwUdeH+Ip9BgNv5EFqKJ8WZBO+C20sUkoBqxlzheVYKcIKnOHW9LlfJwrD7hu+ZIBl
 C1MviXx7FRogV0E5tMsb5Um/oUie8H8nkmVbHfFZ7zhuBSdexOxM3CkGiZLOHytuEdAa
 nyLBiQ3V3GgMdEVgab9eKJ0ARiGqGjs4Jss92bRyaDtdWhlokm8Y+kts5/5hoZZI6Ouf
 5THX48rOZduCA5zhBFgYhK1CKgLK0zAnhpcZKHvbFzemVHBd+wAltRTrqA44uIhdI2BE
 4+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=2k/y4lk5ihDmDdbVF4BqKxsGhrcX/WsBiETwGXk31lE=;
 b=RhG7w9e2aE3/PcGTJWChZ9l1c9JQQWnda8ZANwqZPa18p9L/YhmI81BB8bR0LufTPz
 lJERNbBAnuOputfCvzh0m6eCD3wauxTmjJEmhxpDUJJY/fHehqCQcaAZbQX6v/2Katnh
 G5UYk2cf66y1xWTHNvX28S+Z9imWRjqAC6RCl8rmIheTNXU4NyO4kvHcX+pm7BBUIJAT
 9GE7KGsTjA3w9lEbP9s257x9krI6l1fueFjH9eKPHPwyO8f8DTcbfxC9y4TuMYMRGuBx
 +L10PwBEc31Gyj+JZWVrHuL6nmPTf+bZIdzxwc+iAWYfiWIRDIAvQTAhCN/iVksSsSEv
 Zqgw==
X-Gm-Message-State: AOAM533PCBBB4w+qV76AleQ5boSXOja+nl532s5aWDPec6fSn05DZ0P8
 KSp0b0FroI7RgsU6zHb/kVg=
X-Google-Smtp-Source: ABdhPJzSbct6Lqdz0yFcB8PiaS6fBu+XK2P1rPM8It++uu+lsc3+M0wCbixaOLSppPOKpE3jBfVa6g==
X-Received: by 2002:a19:70c:: with SMTP id 12mr641473lfh.207.1598967523417;
 Tue, 01 Sep 2020 06:38:43 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 d13sm291521lfl.89.2020.09.01.06.38.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Sep 2020 06:38:42 -0700 (PDT)
Date: Tue, 1 Sep 2020 15:38:41 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/2] m25p80: Add the n25q256a SFDP table
Message-ID: <20200901133840.caw6abo4noq5choz@fralle-msi>
References: <20200827091130.3525790-1-clg@kaod.org>
 <20200827091130.3525790-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200827091130.3525790-3-clg@kaod.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cedric,

We need to rebase the patch and modify for meson build (I wasn't able to apply
it).

Best regards,
Francisco 

On [2020 Aug 27] Thu 11:11:30, Cédric Le Goater wrote:
> The same values were collected on 4 differents OpenPower systems,
> palmettos, romulus and tacoma.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/block/m25p80_sfdp.h |  2 ++
>  hw/block/m25p80.c      |  6 ++++--
>  hw/block/m25p80_sfdp.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>  hw/block/Makefile.objs |  2 +-
>  4 files changed, 56 insertions(+), 3 deletions(-)
>  create mode 100644 hw/block/m25p80_sfdp.c
> 
> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
> index b75fd0b0c13f..ca2658a676e0 100644
> --- a/hw/block/m25p80_sfdp.h
> +++ b/hw/block/m25p80_sfdp.h
> @@ -12,4 +12,6 @@
>  
>  #define M25P80_SFDP_AREA_SIZE 0x100
>  
> +extern const uint8_t m25p80_sfdp_n25q256a[M25P80_SFDP_AREA_SIZE];
> +
>  #endif
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 32925589ec7a..d053bdbb2805 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -233,11 +233,13 @@ static const FlashPartInfo known_devices[] = {
>      { INFO("n25q128a11",  0x20bb18,      0,  64 << 10, 256, ER_4K) },
>      { INFO("n25q128a13",  0x20ba18,      0,  64 << 10, 256, ER_4K) },
>      { INFO("n25q256a11",  0x20bb19,      0,  64 << 10, 512, ER_4K) },
> -    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K) },
> +    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K),
> +      .sfdp = m25p80_sfdp_n25q256a },
>      { INFO("n25q512a11",  0x20bb20,      0,  64 << 10, 1024, ER_4K) },
>      { INFO("n25q512a13",  0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>      { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
> -    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
> +    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K),
> +      .sfdp = m25p80_sfdp_n25q256a },
>      { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>      { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>      { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
> diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
> new file mode 100644
> index 000000000000..def94bd4ea02
> --- /dev/null
> +++ b/hw/block/m25p80_sfdp.c
> @@ -0,0 +1,49 @@
> +/*
> + * M25P80 Serial Flash Discoverable Parameter (SFDP)
> + *
> + * Copyright (c) 2020, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "m25p80_sfdp.h"
> +
> +/*
> + * Micron
> + */
> +const uint8_t m25p80_sfdp_n25q256a[M25P80_SFDP_AREA_SIZE] = {
> +    0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,
> +    0x00, 0x00, 0x01, 0x09, 0x30, 0x00, 0x00, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xe5, 0x20, 0xfb, 0xff, 0xff, 0xff, 0xff, 0x0f,
> +    0x29, 0xeb, 0x27, 0x6b, 0x08, 0x3b, 0x27, 0xbb,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x27, 0xbb,
> +    0xff, 0xff, 0x29, 0xeb, 0x0c, 0x20, 0x10, 0xd8,
> +    0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +};
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index 8855c2265639..b65a12c52b52 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -1,6 +1,6 @@
>  common-obj-y += block.o cdrom.o hd-geometry.o
>  common-obj-$(CONFIG_FDC) += fdc.o
> -common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
> +common-obj-$(CONFIG_SSI_M25P80) += m25p80.o m25p80_sfdp.o
>  common-obj-$(CONFIG_NAND) += nand.o
>  common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
>  common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
> -- 
> 2.25.4
> 

