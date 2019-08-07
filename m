Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4BC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EDC22305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QzcKYxFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EDC22305
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHnt-0001EE-HJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHnT-0000k3-Qe
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHnS-0001LT-Pd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:59:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvHnS-0001Kk-JJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:59:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id r21so95377686otq.6
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eacNwtaXWw/Hsq3kq5Twu3UW189Htkm1zesFhiJ/biY=;
 b=QzcKYxFC781REm3liC3WhNwjXElyj3n3hGP7AwBrkx3npX4MsE/OBota3ecvB0XFiP
 gpy1DaUQMR2JCyWnF6j504fsMsViSMN91ttZIvqcnAVnR5DavKcJQt87djQ2AMZNEtKt
 7RgjLaTohJswTFfEXWgC0lS3R+v++Ahdbky1KQsEYNXfMgXvqI8pM1wgg1bYZHsZUsAb
 jzuVdqCtnzcYcFbbn45nbRLZLX+tbl5iu9tg6UtNw0UN3KZbYGRZTuLbpeXufEfUGZ1n
 HvdvsPvJumcIBEZkAjzok+nlkEkvQ0bp0nsUt7bjUbM36B2sddeOVCCvMIQDNYxU5vfN
 8DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eacNwtaXWw/Hsq3kq5Twu3UW189Htkm1zesFhiJ/biY=;
 b=oT48L3oAzA3e+GHe6f93Rceszj76Xr9DqBdnvxrGJQm/NUeTXNH5NbpglfmLJHW6o7
 +cdsPCGf664y7RYah7ycqRs94yBSVZImfy6bqkQEMzlbJmiCZuLkFS7nG2eIPyVxKKnk
 XdPhApJDYCub+v+fmnPKhTsvwt0rL0s225usae7omPHFnjaBPGAk6XakyyP08RyuPVas
 aqa6Ocwfs5jry36xEV9ziO4mG+6qTicn4wUxaNYDTzPk1Eiy0GIgRsKhRnJgRf068nB0
 oZFj3NauKUuNiV2ljvz8lxT5AejdLuaYWP0iPlHw2L9gk2PVq5rSLvGquOVYdgg8JizI
 dYwg==
X-Gm-Message-State: APjAAAUD3foSSJPKAGEsHptdgcmWJ/uf4eh8+TaiJKiCca1+ODGIaRAT
 +hNzxZO2UeCFs5daxoaJ+vkNPoCYer2n16Er0vxa3w==
X-Google-Smtp-Source: APXvYqzVQWpFZJ+b3RyKX/TemCFmTTPYfDg88isRmjIaZzzCWs5VuT8jbgIgpOWCaMdwOPkCRt3ERlgGVv6JGsB7ZDo=
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr8303949ior.163.1565168389566; 
 Wed, 07 Aug 2019 01:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-13-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565163924-18621-13-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 7 Aug 2019 16:59:38 +0800
Message-ID: <CAEiOBXV9cxVEboMNsvEoHgW3BiFm697BL68YHC49U41V3Hewfg@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 12/28] riscv: sifive_e: prci: Fix a typo
 of hfxosccfg register programming
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 3:48 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> It should use SIFIVE_PRCI_HFXOSCCFG_RDY and SIFIVE_PRCI_HFXOSCCFG_EN
> for hfxosccfg register programming.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>
> Changes in v2: None
>
>  hw/riscv/sifive_e_prci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
> index acb914d..c906f11 100644
> --- a/hw/riscv/sifive_e_prci.c
> +++ b/hw/riscv/sifive_e_prci.c
> @@ -89,7 +89,7 @@ static void sifive_prci_init(Object *obj)
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
>      s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
> -    s->hfxosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
> +    s->hfxosccfg = (SIFIVE_PRCI_HFXOSCCFG_RDY | SIFIVE_PRCI_HFXOSCCFG_EN);
>      s->pllcfg = (SIFIVE_PRCI_PLLCFG_REFSEL | SIFIVE_PRCI_PLLCFG_BYPASS |
>                  SIFIVE_PRCI_PLLCFG_LOCK);
>      s->plloutdiv = SIFIVE_PRCI_PLLOUTDIV_DIV1;
> --
> 2.7.4
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
