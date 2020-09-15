Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2294C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B1C208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsyYCJmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B1C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF20-0000cP-EY
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIEkY-0001Ri-L5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIEkW-0004Tm-67
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600190890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6/plQ62wU4RuI7IyczbzKXCfIn4xPKd2XrKSCbsK/nM=;
 b=WsyYCJmLFzPaWNDwQ1yCUqv7EkvS58STfUokSabtEo/jhSetZ19uuHmewLG2Hxx5/mu+Pm
 scp91DpKLqNSgSVoef7XqUqe+c7vFadA/2OJv4N01HsTth2pkikKWoCeY0VwOvAyQZfczS
 rn2NUQnTr/h+dnW3xvJXXD1rVBazvHc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-FNuW9ihUMG-XbzIrBMSCtQ-1; Tue, 15 Sep 2020 13:28:06 -0400
X-MC-Unique: FNuW9ihUMG-XbzIrBMSCtQ-1
Received: by mail-wm1-f72.google.com with SMTP id m125so70129wmm.7
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6/plQ62wU4RuI7IyczbzKXCfIn4xPKd2XrKSCbsK/nM=;
 b=JsfT1e61/Sc8/Nj6IHmY05UxpJdpids/SOEnheo7xAxLfeA7MJLNOw937fyloS5WiL
 BRe9MXxMygWLxQhKWvVY3fZ64KuC97ZEMpLssFr0jY9FYx6TCvXd6E5VeBFev43ycP/Q
 qaA9ME2yeg4g1D1eLdF2ke6ptGNrdm9fQ0EkxNCmdsNVpZ8Qc5S1ZymFAA2lWocxN7R2
 mmyzLxxqs0kiCY+lxX8oX7kgyGlrQA9JCgMOQv9IpJL74/0ReiahDYFGObdg7u6C68rV
 VmqMrQQpCkhFwG2nyRiRjc2kisWtM4iqgrJ85n0jnt/xh/x9twSoMw4yU3jxdkL8St0b
 jBdw==
X-Gm-Message-State: AOAM5317CDVXfJP2CyCRAZSM4E7MeGxZtOBCwIFiCGS7aS+teYRf5FYO
 Jeo4fTYvIDpCjvTYhcH/ssQ8Az8t8BNKVMtLsQThdYlvuGjDbaJbSil8S/kMCho/setMk+ygUM2
 qOQCMqdRXK5cdQ74=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr394478wmi.163.1600190884725; 
 Tue, 15 Sep 2020 10:28:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOi/nAFR+UtibIj6JBCznYRgV3QpPnfxRG+pSWECNZ8/6CFZdASfIsiLgU9QkCHU4Cn7VbGw==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr394458wmi.163.1600190884476; 
 Tue, 15 Sep 2020 10:28:04 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d23sm461447wmb.6.2020.09.15.10.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:28:03 -0700 (PDT)
Subject: Re: [PATCH 00/13] dma: Let the DMA API take MemTxAttrs argument and
 propagate MemTxResult
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <060061dd-1241-d669-3fcc-e8cd03a67898@redhat.com>
Date: Tue, 15 Sep 2020 19:28:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 11:54:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is fully review.

Paolo, does it belong to your tree?

On 9/4/20 5:44 PM, Philippe Mathieu-Daudé wrote:
> Salvaging cleanups patches from the RFC series "Forbid DMA write
> accesses to MMIO regions" [*], propagating MemTxResult and
> adding documentation.
> 
> [*] https://www.mail-archive.com/qemu-block@nongnu.org/msg72924.html
> 
> Klaus Jensen (1):
>   pci: pass along the return value of dma_memory_rw
> 
> Philippe Mathieu-Daudé (12):
>   docs/devel/loads-stores: Add regexp for DMA functions
>   dma: Document address_space_map/address_space_unmap() prototypes
>   dma: Let dma_memory_set() propagate MemTxResult
>   dma: Let dma_memory_rw() propagate MemTxResult
>   dma: Let dma_memory_read() propagate MemTxResult
>   dma: Let dma_memory_write() propagate MemTxResult
>   dma: Let dma_memory_valid() take MemTxAttrs argument
>   dma: Let dma_memory_set() take MemTxAttrs argument
>   dma: Let dma_memory_rw_relaxed() take MemTxAttrs argument
>   dma: Let dma_memory_rw() take MemTxAttrs argument
>   dma: Let dma_memory_read/write() take MemTxAttrs argument
>   dma: Let dma_memory_map() take MemTxAttrs argument
> 
>  docs/devel/loads-stores.rst   |   2 +
>  include/hw/pci/pci.h          |   7 +-
>  include/hw/ppc/spapr_vio.h    |  11 ++-
>  include/sysemu/dma.h          | 156 +++++++++++++++++++++++++++-------
>  dma-helpers.c                 |  16 ++--
>  hw/arm/musicpal.c             |  13 +--
>  hw/arm/smmu-common.c          |   3 +-
>  hw/arm/smmuv3.c               |  14 +--
>  hw/core/generic-loader.c      |   3 +-
>  hw/display/virtio-gpu.c       |   8 +-
>  hw/dma/pl330.c                |  12 ++-
>  hw/dma/sparc32_dma.c          |  16 ++--
>  hw/dma/xlnx-zynq-devcfg.c     |   6 +-
>  hw/dma/xlnx_dpdma.c           |  10 ++-
>  hw/hyperv/vmbus.c             |   8 +-
>  hw/i386/amd_iommu.c           |  16 ++--
>  hw/i386/intel_iommu.c         |  28 +++---
>  hw/ide/ahci.c                 |   9 +-
>  hw/ide/macio.c                |   2 +-
>  hw/intc/spapr_xive.c          |   3 +-
>  hw/intc/xive.c                |   7 +-
>  hw/misc/bcm2835_property.c    |   3 +-
>  hw/misc/macio/mac_dbdma.c     |  10 ++-
>  hw/net/allwinner-sun8i-emac.c |  21 +++--
>  hw/net/ftgmac100.c            |  25 ++++--
>  hw/net/imx_fec.c              |  32 ++++---
>  hw/nvram/fw_cfg.c             |  12 ++-
>  hw/pci-host/pnv_phb3.c        |   5 +-
>  hw/pci-host/pnv_phb3_msi.c    |   9 +-
>  hw/pci-host/pnv_phb4.c        |   7 +-
>  hw/sd/allwinner-sdhost.c      |  14 +--
>  hw/sd/sdhci.c                 |  35 +++++---
>  hw/usb/hcd-dwc2.c             |   8 +-
>  hw/usb/hcd-ehci.c             |   6 +-
>  hw/usb/hcd-ohci.c             |  28 +++---
>  hw/usb/libhw.c                |   3 +-
>  hw/virtio/virtio.c            |   6 +-
>  37 files changed, 385 insertions(+), 189 deletions(-)
> 


