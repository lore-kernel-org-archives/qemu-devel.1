Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0A4C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383E320775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3NsOrZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383E320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfSa-0007jU-DS
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfRB-0005yz-5t
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfR9-000247-A7
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:38:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfR9-00023f-18
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586947109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74s5Fg++pQBEC5Y45tiZ4bG3OttvPCGf5MQxemyekpw=;
 b=T3NsOrZNqbUw1x1yTdQuf9uhUVXhsHl/Z4h+LpOyHCJ4FqFiFsf57oEGUjUlSbE7YE4B0L
 ZmTs6Q630motx1bIur5jzumKMUEDdA/vVwytlLodgjDOeba93l3v1Mz6QU+UgybK4m5yZC
 yEOusIcOsNdZKp0zn8zGPu9RzR++UtU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-L_v_v_HOO6-jeJ96MBehgg-1; Wed, 15 Apr 2020 06:38:28 -0400
X-MC-Unique: L_v_v_HOO6-jeJ96MBehgg-1
Received: by mail-ed1-f69.google.com with SMTP id f25so2509334edt.23
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=74s5Fg++pQBEC5Y45tiZ4bG3OttvPCGf5MQxemyekpw=;
 b=mZ56B4352KcY6aqgUTZbbYYe73xDcO5f/VsUWZJkd0wFuerqW0AmftHGaXUfxzsp3E
 ixnN/hg2C33sKomx89gtfXrG5U5QZ4HJL0ZaBVtgGxoB/VncmqSB9X58oJdZsTzpOMLT
 hBPbZ0ou4WWYT8/7XZooWA0UMOay0cB2F0WsU2XvkC9B7AR2ZTWvEjGirhyAdbs6WPGk
 TWkVygtFut3ROP80fF4k8W9zMrNo5O5Vtbx/5YuKWx+9/eVrTPk07MPRiJZeOACUrcvu
 SMdJQNdoQksWMopkY18w1dkPSuawE340zBCQJlOFi8xRT6X3vTfJdMnp2YQbQ8fOfvgt
 KOPg==
X-Gm-Message-State: AGi0Pub5NpHxxnfKwMqbXREBDhL8smqCseePvOCzCPE4KIidUIfu62IB
 Qz3FxdBa04rh75kSmruQAajn9d77hExgOf0KNr7YhvP4tNyrfbejB4XtlTss5yLJ6g9jKB9TKMS
 iSqd2XEyJHTbmpVk=
X-Received: by 2002:a17:906:4bc9:: with SMTP id
 x9mr2612334ejv.27.1586947107414; 
 Wed, 15 Apr 2020 03:38:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/c5khlyDbYTihJdmuXSjPIv2WEFimeRyhD1ikw5F3z3VTGqPC4h3upGbkNLjC0RcsoBdfdg==
X-Received: by 2002:a17:906:4bc9:: with SMTP id
 x9mr2612311ejv.27.1586947107136; 
 Wed, 15 Apr 2020 03:38:27 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id bx16sm1057951ejc.83.2020.04.15.03.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 03:38:26 -0700 (PDT)
Subject: Re: [PATCH 13/16] nvme: factor out namespace setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-14-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f57886a-8645-eeda-f482-4353b423c80f@redhat.com>
Date: Wed, 15 Apr 2020 12:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-14-its@irrelevant.dk>
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
>   hw/block/nvme.c | 47 ++++++++++++++++++++++++++---------------------
>   1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f0989cbb4335..08f7ae0a48b3 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1359,13 +1359,35 @@ static int nvme_init_blk(NvmeCtrl *n, Error **errp)
>       return 0;
>   }
>   
> +static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> +{
> +    int64_t bs_size;
> +    NvmeIdNs *id_ns = &ns->id_ns;
> +
> +    bs_size = blk_getlength(n->conf.blk);
> +    if (bs_size < 0) {
> +        error_setg_errno(errp, -bs_size, "could not get backing file size");
> +        return -1;
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
> +
> +    return 0;
> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n = NVME(pci_dev);
>       NvmeIdCtrl *id = &n->id_ctrl;
>   
>       int i;
> -    int64_t bs_size;
>       uint8_t *pci_conf;
>   
>       if (nvme_check_constraints(n, errp)) {
> @@ -1374,12 +1396,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   
>       nvme_init_state(n);
>   
> -    bs_size = blk_getlength(n->conf.blk);
> -    if (bs_size < 0) {
> -        error_setg(errp, "could not get backing file size");
> -        return;
> -    }
> -
>       if (nvme_init_blk(n, errp)) {
>           return;
>       }
> @@ -1390,8 +1406,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>       pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
>       pcie_endpoint_cap_init(pci_dev, 0x80);
>   
> -    n->ns_size = bs_size / (uint64_t)n->num_namespaces;

I'm not sure this line belong to this patch.

> -
>       memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                             "nvme", n->reg_size);
>       pci_register_bar(pci_dev, 0,
> @@ -1455,18 +1469,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>       }
>   
>       for (i = 0; i < n->num_namespaces; i++) {
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
> -            cpu_to_le64(n->ns_size >>
> -                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
> +        if (nvme_init_namespace(n, &n->namespaces[i], errp)) {
> +            return;
> +        }
>       }
>   }
>   
> 


