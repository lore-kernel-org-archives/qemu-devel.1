Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9297C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861AE20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X522TnMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861AE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYHk-0001gm-SG
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYEK-0007HZ-LY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYEJ-0004RI-D9
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:31:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYEJ-0004QA-2X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:31:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so5617772ote.13
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HiFghyU4ZLqrSlVnhJgSlUerIG9qkOU9Oq9qBUelGbQ=;
 b=X522TnMiOjXlZZA1QADOtxi9vgk6h/mrBJVfyGgzUx1bOJc7EU+/XxL10jvAwMM/A5
 wVhpQrE6AySwhi5I3K+IrsJdxKqVP1nLQUeEOThdI86vtTkzolGakjVaq3m8h3w1AHJT
 DR1g/A2tTQZCSOBnzZ+U/kTGoPIyCnJp+3quZzUCe7UoZWHG4jfDbFEW6fLEORjrzgSU
 6xTldtBXI5idooytES3JRuHzZhYLGjyM5P1dKdYb5uMeEVD4xLOJvU103+VaDQQ6p9E8
 3ZsOYZunNFr7AIxTg+km3JFRKVLStrIx0L9jfuGxbsSMYSBpv6bs6YrhZYMIu5Oj17i3
 to0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HiFghyU4ZLqrSlVnhJgSlUerIG9qkOU9Oq9qBUelGbQ=;
 b=DZYeHedwZlKPXlgU9Rg9FGELaxK/kc3zVLERqPucC8/s7nwyVhjXWwIlLsKaPOfn0c
 B871zDjm71sW6nWGuxEgtiGi23vKE5HzKCnCJwXFyVblPSthjrBW46sHmuLwN7tTZk8w
 G3zcKZa/7vUsq2MV+AQFQjMx9mgEbiMke854c0xI8j0f98xnGz+VPkNpjluB5zkH2oqB
 cvWmC/bu8QEZMFg1E3jabnIaZM0KDssmioS9zqaUIYN8CwpDZ0tSjeJX/QPR/w3BGG+K
 Dbfz65ZGaNQwasQiuqr94H13drqrtcrJqmu0U0v4Zoj15eoTWFNqRnsq4HfcbywHHe0M
 I4zA==
X-Gm-Message-State: APjAAAXYBnym2EIFVijtsXsIT5Nunu0K1eQi9gYV3Z8EZHBzQkqppYS8
 M5pAFEioRsyMKkCM3O7ByvTPB8mAlT0uf2L4PBpWVA==
X-Google-Smtp-Source: APXvYqx+mCEWX4z69XmpynZvhXUv5QIOATon6exHGPgzs3eBOR2vcKr+vvSSUggHzoIMiR1exzOgVCnjdH2FLSC0rJY=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr2984973otj.97.1562848278116; 
 Thu, 11 Jul 2019 05:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
 <20190702150606.24851-3-mst@redhat.com>
In-Reply-To: <20190702150606.24851-3-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 13:31:07 +0100
Message-ID: <CAFEAcA-t_zMa94b711ypm4+aFSDLZ7uAhsk83An9jFgFm+QB9A@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 02/22] pcie: check that slt ctrl changed
 before deleting
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> During boot, linux would sometimes overwrites control of a powered off
> slot before powering it on. Unfortunately QEMU interprets that as a
> power off request and ejects the device.
>
> For example:
>
> /x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
>     -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
>     -monitor stdio disk.qcow2
> (qemu)device_add virtio-balloon-pci,id=balloon,bus=pcie_root_port_0
> (qemu)cont
>
> Balloon is deleted during guest boot.
>
> To fix, save control beforehand and check that power
> or led state actually change before ejecting.
>
> Note: this is more a hack than a solution, ideally we'd
> find a better way to detect ejects, or move away
> from ejects completely and instead monitor whether
> it's safe to delete device due to e.g. its power state.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Igor Mammedov <imammedo@redhat.com>

Hi; Coverity points out (CID 1403007) that...

> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index e30334d74d..8d90c0e193 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -107,7 +107,8 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev);
>
>  void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
>  void pcie_cap_slot_reset(PCIDevice *dev);
> -void pcie_cap_slot_write_config(PCIDevice *dev,
> +void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slot_ctl, uint16_t *slt_sta);

...in the declaration of pci_cap_slot_get() the last 2
arguments are slot_ctl then slt_sta...

> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -31,10 +31,13 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
>  {
>      uint32_t root_cmd =
>          pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
> +    uint16_t slt_ctl, slt_sta;
> +
> +    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);

...which is the order we use here...

>
>      pci_bridge_write_config(d, address, val, len);
>      rp_aer_vector_update(d);
> -    pcie_cap_slot_write_config(d, address, val, len);
> +    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
>      pcie_aer_write_config(d, address, val, len);
>      pcie_aer_root_write_config(d, address, val, len, root_cmd);
>  }
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 264e37d6a6..899b0fd6c9 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -41,9 +41,12 @@
>  static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>                                           uint32_t val, int len)
>  {
> +    uint16_t slt_ctl, slt_sta;
> +
> +    pcie_cap_slot_get(d, &slt_sta, &slt_ctl);

...but in this callsite we pass slt_sta, slt_ctl.

Presumably this is a bug?

Also, but more trivially, the function declarations for
pci_cap_slot_get and pci_cap_slot_write_config call the argument
"slot_ctl", but the function definitions and all the call
sites drop the 'o' and call it "slt_ctl". Could we be consistent?

thanks
-- PMM

