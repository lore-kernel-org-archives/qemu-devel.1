Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15FC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83D6206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blLk3Rtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83D6206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvIK-000816-LQ
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvHa-0007QK-RB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvHZ-0000kx-RA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:57:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQvHZ-0000kc-Dl
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587484676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXpcJ4cRdDpSVPoOVpZb9RASmSdCfc2AHgyka6yIDwA=;
 b=blLk3Rtqii7c+BIOILbSZln5nzaN/GTOZXpTz/iYm6f/tdyNADcOltPzrr5QfRensQcfbQ
 IRpb/leRX2W2hgX+UgZeuU9m8u9OoBETzYAVEcJRJ0ALrTDwyByEFYQmSIws8dCK2fqywA
 kZSsOKaMomcAsudbxhp4Lmw1sM2djnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-IojBN7m_No2ioBw1w0cfKw-1; Tue, 21 Apr 2020 11:57:54 -0400
X-MC-Unique: IojBN7m_No2ioBw1w0cfKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45CDB1005510;
 Tue, 21 Apr 2020 15:57:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6A66B3A60;
 Tue, 21 Apr 2020 15:57:50 +0000 (UTC)
Message-ID: <5909a792ce6693c85606ad377f886094925503b8.camel@redhat.com>
Subject: Re: [PATCH v2 13/16] nvme: factor out namespace setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 18:57:49 +0300
In-Reply-To: <20200415130159.611361-14-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-14-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
>  hw/block/nvme.c | 46 ++++++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d5244102252c..2b007115c302 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1358,6 +1358,27 @@ static void nvme_init_blk(NvmeCtrl *n, Error **errp)
>                                    false, errp);
>  }
>  
> +static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> +{
> +    int64_t bs_size;
> +    NvmeIdNs *id_ns = &ns->id_ns;
> +
> +    bs_size = blk_getlength(n->conf.blk);
> +    if (bs_size < 0) {
> +        error_setg_errno(errp, -bs_size, "could not get backing file size");
> +        return;
> +    }
> +
> +    n->ns_size = bs_size;
> +
> +    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> +    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
> +
> +    /* no thin provisioning */
> +    id_ns->ncap = id_ns->nsze;
> +    id_ns->nuse = id_ns->ncap;
> +}
> +
>  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      NvmeCtrl *n = NVME(pci_dev);
> @@ -1365,7 +1386,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      Error *err = NULL;
>  
>      int i;
> -    int64_t bs_size;
>      uint8_t *pci_conf;
>  
>      nvme_check_constraints(n, &err);
> @@ -1376,12 +1396,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  
>      nvme_init_state(n);
>  
> -    bs_size = blk_getlength(n->conf.blk);
> -    if (bs_size < 0) {
> -        error_setg(errp, "could not get backing file size");
> -        return;
> -    }
> -
>      nvme_init_blk(n, &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -1394,8 +1408,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>  
> -    n->ns_size = bs_size / (uint64_t)n->num_namespaces;
> -
>      memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                            "nvme", n->reg_size);
>      pci_register_bar(pci_dev, 0,
> @@ -1459,17 +1471,11 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      }
>  
>      for (i = 0; i < n->num_namespaces; i++) {
> -        NvmeNamespace *ns = &n->namespaces[i];
> -        NvmeIdNs *id_ns = &ns->id_ns;
> -        id_ns->nsfeat = 0;
> -        id_ns->nlbaf = 0;
> -        id_ns->flbas = 0;
> -        id_ns->mc = 0;
> -        id_ns->dpc = 0;
> -        id_ns->dps = 0;
> -        id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> -        id_ns->ncap  = id_ns->nuse = id_ns->nsze =
> -            cpu_to_le64(nvme_ns_nlbas(n, ns));
> +        nvme_init_namespace(n, &n->namespaces[i], &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>      }
>  }
>  


Reviewed-by: Maxim Levitsky  <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



