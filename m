Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877EC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88222074F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Df4IipIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88222074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhwy-0001iX-0s
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhro-0002Pm-RL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhrn-0000Or-O2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:14:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhrn-0000Ne-Kd
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586956451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHz7mtn7qtvPjghEX66KIWD8OsT82bjFj4HktfHCaWs=;
 b=Df4IipIeDpZRLhw4rtD83cYmDBKztnGVa/V5cDK2kqRcZdFGvRSbRSzHJGJ2/wVgBFN+Ax
 gbC4MfstjgCtU5fJQoFy7BlNYxb6E6apAhTq7t1URgR9r8w2cSglkgzL/te7ZKJCe4Zcyw
 mSTvhI/HcrZ85Y77eFavCobBMfvqUDQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-fvfqS4zDM0Wls2CKEKJ5uw-1; Wed, 15 Apr 2020 09:14:08 -0400
X-MC-Unique: fvfqS4zDM0Wls2CKEKJ5uw-1
Received: by mail-ed1-f71.google.com with SMTP id b12so2900350edy.7
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hPKQB0LNb4alCRIiJsPfsa4YJFJL/OEF1XGY+WE6ihU=;
 b=tKhHwfL83xdk0A3DzcVhtDQBdFnify3aq7qegmryVAgbHZ6zm7crcEL5y380f4l1en
 Cn0g6XC61BNC7nJTzFpGNtssG9Op4MIDjKjyu/SBL7qfEmrOeS6dVFXzmkInul1TLNbh
 CWDMhZkEQP3DfHfgtaruHKwVmm5PPCCnw2u1EvVLdSGHxhIv2N03CY0qjuFBbbu/MRE5
 MSY2gG3k9w541Eph5JrW5Dkmqe0yL0lJb+bds/JhefVMiOwMcPZTPaDAZ8TdXL0u96Xn
 SrDRy3nFAt5jv423GfaEzg3mTau00nOfufxUvssbpGNczxc3KPPn/gh8QM5kJD7pANE0
 wzjQ==
X-Gm-Message-State: AGi0PuYKju2L4I7eMLxu7c4qdGUZ09Hm6BwsRUCGITCRUJjjXGrEDLXw
 utLiWYcNg3Dj2gipf1uSjZFc/lV5ewm6CdyIOOtT7xV8kt+tqP9JUQpu5zbTxGSq/CXO/7KI4ag
 aE08GTaYtFFngUvg=
X-Received: by 2002:a50:ee86:: with SMTP id f6mr10337197edr.123.1586956447413; 
 Wed, 15 Apr 2020 06:14:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKXkDh4SNgbn+qEz9Pbr44gXaPNts5JYiRfpQI4Sb59SDUBkuo8Cpa7vfHqb46Yi5wAtCtc7Q==
X-Received: by 2002:a50:ee86:: with SMTP id f6mr10337183edr.123.1586956447244; 
 Wed, 15 Apr 2020 06:14:07 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id by9sm2625320ejb.16.2020.04.15.06.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:14:06 -0700 (PDT)
Subject: Re: [PATCH v2 14/16] nvme: factor out pci setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-15-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <056035e2-2dc8-7394-f03e-fa381d8c77fd@redhat.com>
Date: Wed, 15 Apr 2020 15:14:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-15-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 4/15/20 3:01 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 30 ++++++++++++++++++------------
>   1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 2b007115c302..906ae595025a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1379,6 +1379,22 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeN=
amespace *ns, Error **errp)
>       id_ns->nuse =3D id_ns->ncap;
>   }
>  =20
> +static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    uint8_t *pci_conf =3D pci_dev->config;
> +
> +    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
> +    pci_config_set_prog_interface(pci_conf, 0x2);
> +    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
> +    pcie_endpoint_cap_init(pci_dev, 0x80);
> +
> +    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme=
",
> +                          n->reg_size);
> +    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
> +    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n =3D NVME(pci_dev);
> @@ -1402,19 +1418,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>           return;
>       }
>  =20
> +    nvme_init_pci(n, pci_dev);
> +
>       pci_conf =3D pci_dev->config;
> -    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
> -    pci_config_set_prog_interface(pci_dev->config, 0x2);
> -    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
> -    pcie_endpoint_cap_init(pci_dev, 0x80);
> -
> -    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
> -                          "nvme", n->reg_size);
> -    pci_register_bar(pci_dev, 0,
> -        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
> -        &n->iomem);
> -    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
> -
>       id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>       id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEN=
DOR_ID));
>       strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


