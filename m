Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC70C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE9220737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hky2ryfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE9220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfau-0005vS-SX
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfW6-0004l7-N5
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfW5-0003ej-Gn
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:43:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfW5-0003eZ-DJ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586947417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofi8je2wP1nCW9e7McQzsNRAwCMXxB7OTGUAKTQ0Cr0=;
 b=Hky2ryfwnLoCA9XgASRnmAugtP7aI+Aid2S+pKKuqb30gid2nPezC6Ao1TRcB/ueQC6XT/
 9Tr+hreNslaENNMNbgjr+uzA5xEvER+BMomDnZqRXd/C2RmEO+3gxReI2Icu0M6++66Yuh
 bgmIsKLswLNunh6s9Ts6wYtIBFwzilo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395--rzA_fStNLu_Ecye_pIcgQ-1; Wed, 15 Apr 2020 06:43:35 -0400
X-MC-Unique: -rzA_fStNLu_Ecye_pIcgQ-1
Received: by mail-ed1-f72.google.com with SMTP id f11so2575196edc.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ofi8je2wP1nCW9e7McQzsNRAwCMXxB7OTGUAKTQ0Cr0=;
 b=UfXEez1yotZ/qSoLUOkbYQPeWE1uwCRjomm0rv8vtS0FV9SJA5rDJ22t76PkAkTnuz
 zqRr8jtnPRz/uAdVgZLT66GlhvBnizsEu7yOP4ZN8YP1XMbZm8RwveewMmBdhZk7eSvK
 4I5AwoicVkhXIfjjiN1KiJ9lcBZkcuJQQ1On3UA/UY9vFzS4r3GoUa++WsVXbiewKWoV
 dDBpAFg4NFm25pXBNTd5BTlqMnfnhHhaMQWw6eVupFRx3+uoJnXndwH4ty/Mv7/Kngrt
 fxhGG3I8K5jXwpS5Wku+SYEMtMJNZLVznf59KqPj0si3btKfxz+iD87MoPUldk9v1Q4w
 uAiw==
X-Gm-Message-State: AGi0PuaZK+1DbJbaZKVSrUfCeNX0Ae29LSRuupsbw2d8amXnYyZRTEIP
 h8Cb6a3gyrxNYglEffI2N7uyTrYrzQqrGXN6c1dNSH5QRSDpnbXHuX6gn1w4q7qa5ZgjlZhUQou
 LrZpsHBhcUJd7iw4=
X-Received: by 2002:a50:dac9:: with SMTP id s9mr22102784edj.313.1586947414298; 
 Wed, 15 Apr 2020 03:43:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypJWrM3veihm/2OnGLiNiD4resWu+jHDWM8hkbRsmHq4eRLPvmqjf8fdVzbGA31Z8gpLP61QFQ==
X-Received: by 2002:a50:dac9:: with SMTP id s9mr22102764edj.313.1586947414050; 
 Wed, 15 Apr 2020 03:43:34 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d19sm1150883edx.49.2020.04.15.03.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 03:43:33 -0700 (PDT)
Subject: Re: [PATCH 14/16] nvme: factor out pci setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-15-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bcb8fd8b-9eae-9b38-5360-d9c9b3447529@redhat.com>
Date: Wed, 15 Apr 2020 12:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-15-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 12:24 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 08f7ae0a48b3..16d01af53a07 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1382,6 +1382,24 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>       return 0;
>   }
>   
> +static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    uint8_t *pci_conf = pci_dev->config;
> +
> +    pci_conf[PCI_INTERRUPT_PIN] = 1;
> +    pci_config_set_prog_interface(pci_conf, 0x2);

<--

> +    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> +    pci_config_set_device_id(pci_conf, 0x5845);

-->

This is new. Already inherited by nvme_class_init().

> +    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
> +    pcie_endpoint_cap_init(pci_dev, 0x80);
> +
> +    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
> +                          n->reg_size);
> +    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
> +    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n = NVME(pci_dev);
> @@ -1400,19 +1418,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>           return;
>       }
>   
> +    nvme_init_pci(n, pci_dev);
> +
>       pci_conf = pci_dev->config;
> -    pci_conf[PCI_INTERRUPT_PIN] = 1;
> -    pci_config_set_prog_interface(pci_dev->config, 0x2);
> -    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
> -    pcie_endpoint_cap_init(pci_dev, 0x80);
> -
> -    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
> -                          "nvme", n->reg_size);
> -    pci_register_bar(pci_dev, 0,
> -        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
> -        &n->iomem);
> -    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
> -
>       id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>       id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
>       strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
> 


