Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C0CC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2E22068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AY4r3PXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2E22068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvJd-00018H-0I
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvIs-0000cz-VY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvIs-00018t-Fa
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:59:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQvIs-00018m-2i
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587484757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6KeVDo3QitVWWs+920o6iMB28jdDo7Epn74HqxiUt8=;
 b=AY4r3PXkFrCSB29mWgb09IFlDIeFk1ZkCMfV7tjgTRHwT8zR2pnPqYeGsMuY75SxWcP2MJ
 HYpFZserZBkzuhvbnIFCY1MIMdLENuzKI163VvxMoAcAVF/qKX5oBIgOnKoBx/sE1FWwHc
 7qrS1GT7oFFuuot4/DTgJKHBIEY/lQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-PL7MysUWOnmr5A4CmcK9PQ-1; Tue, 21 Apr 2020 11:59:15 -0400
X-MC-Unique: PL7MysUWOnmr5A4CmcK9PQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DED018C35A5;
 Tue, 21 Apr 2020 15:59:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFE7960C88;
 Tue, 21 Apr 2020 15:59:11 +0000 (UTC)
Message-ID: <26d32ff1b168f3a80a97e42e8f2394a53fccdb14.camel@redhat.com>
Subject: Re: [PATCH v2 14/16] nvme: factor out pci setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 18:59:10 +0300
In-Reply-To: <20200415130159.611361-15-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-15-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-04-15 at 15:01 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 2b007115c302..906ae595025a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1379,6 +1379,22 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>      id_ns->nuse = id_ns->ncap;
>  }
>  
> +static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    uint8_t *pci_conf = pci_dev->config;
> +
> +    pci_conf[PCI_INTERRUPT_PIN] = 1;
> +    pci_config_set_prog_interface(pci_conf, 0x2);
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
>  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      NvmeCtrl *n = NVME(pci_dev);
> @@ -1402,19 +1418,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> +    nvme_init_pci(n, pci_dev);
> +
>      pci_conf = pci_dev->config;
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
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
>      strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


