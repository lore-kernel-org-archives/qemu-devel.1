Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75DC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6359820575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk3a5iuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6359820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8nB-0003QN-Ei
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ8mJ-0002iW-2u
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:59:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36274
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ8mH-0003Nr-KX
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589443176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGhQrYam6VIb5mcwoXCy3TWu/7CiTDFnBBkllt9pb7c=;
 b=fk3a5iuCFQ524GaWSgDAfP0QEWnFVZ8DGgzf/yvzey9IQbE95NAJpi4Omv6ayjqtuNpQuz
 gMzvjFWRoKxcK4XlFF2SWogw8oLaiWjncY1CMpuk/Q44ULUVEShxs/q8sUqJhQDEOBkYQc
 9qb63t5Dxc1aezF8P8Rdrj6DtmMScrc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-h_5W_DDBML-BhVcny4EKRA-1; Thu, 14 May 2020 03:59:35 -0400
X-MC-Unique: h_5W_DDBML-BhVcny4EKRA-1
Received: by mail-wr1-f72.google.com with SMTP id 37so1165879wrc.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 00:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iGhQrYam6VIb5mcwoXCy3TWu/7CiTDFnBBkllt9pb7c=;
 b=OHrIpCqUQVSu5E3vOKOtACuy5AAQPbfo3vRaLpE5xVpXvbtc7bdS4ROlbcdap73pXR
 H1Q8PSmGsO1d/SIaCQNErDqPHgmb69mFpciKJqAjWGjFPdVH2xVWNPeV/E7VYLAk/t9f
 5ViyaiyaYUdX0cZhStJ4BMgmCXsIbAkXmu9m3lVRShTZduorhEDb5RXLBjEuas5lH46y
 XmG8hLXWeCmT34wFLwyQU0AGRaZN9twQc7GXtZDXBrHdbslZcQVQgS0kmojO3Ahm6h9y
 HYaUKK9hufE1h9Fn6xpigUtMzgUxq5+32APTYmgdCCncy8Y39S7bPVVv/zJZ1FZIyYwe
 rBxw==
X-Gm-Message-State: AOAM53213LNxwjlMdlM/ipbfo8yxuy8D9EqK3EyhOe13eRmanAedxAD6
 MsWIN7eILCPNHlbbieiCHo+v6sfhSK+KY300EaZJ10cFXD3iypnDxiuFrgyGU/KWeYE9SrSmp/A
 3URXLBKPTqTknbKk=
X-Received: by 2002:adf:ef48:: with SMTP id c8mr3786154wrp.140.1589443173784; 
 Thu, 14 May 2020 00:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkqR/ciRfTFx0R7MDPmvAmrVq1mRL19vMnmxpuJ03zhFBtVh/mzIDq1GNQ5lgqex1GxNCKOQ==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr3786128wrp.140.1589443173536; 
 Thu, 14 May 2020 00:59:33 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s8sm2699999wrt.69.2020.05.14.00.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 00:59:32 -0700 (PDT)
Subject: Re: [PATCH v6 18/20] hw/block/nvme: factor out pmr setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200514044611.734782-1-its@irrelevant.dk>
 <20200514044611.734782-19-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c528722-0117-4842-cb5c-d37090ac71f2@redhat.com>
Date: Thu, 14 May 2020 09:59:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514044611.734782-19-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 6:46 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c | 95 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d71a5f142d51..7254b66ae199 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -58,6 +58,7 @@
>   #define NVME_REG_SIZE 0x1000
>   #define NVME_DB_SIZE  4
>   #define NVME_CMB_BIR 2
> +#define NVME_PMR_BIR 2
>   
>   #define NVME_GUEST_ERR(trace, fmt, ...) \
>       do { \
> @@ -1463,6 +1464,55 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
>                        PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
>   }
>   
> +static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    /* Controller Capabilities register */
> +    NVME_CAP_SET_PMRS(n->bar.cap, 1);
> +
> +    /* PMR Capabities register */
> +    n->bar.pmrcap = 0;
> +    NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
> +    NVME_PMRCAP_SET_WDS(n->bar.pmrcap, 0);
> +    NVME_PMRCAP_SET_BIR(n->bar.pmrcap, NVME_PMR_BIR);
> +    NVME_PMRCAP_SET_PMRTU(n->bar.pmrcap, 0);
> +    /* Turn on bit 1 support */
> +    NVME_PMRCAP_SET_PMRWBM(n->bar.pmrcap, 0x02);
> +    NVME_PMRCAP_SET_PMRTO(n->bar.pmrcap, 0);
> +    NVME_PMRCAP_SET_CMSS(n->bar.pmrcap, 0);
> +
> +    /* PMR Control register */
> +    n->bar.pmrctl = 0;
> +    NVME_PMRCTL_SET_EN(n->bar.pmrctl, 0);
> +
> +    /* PMR Status register */
> +    n->bar.pmrsts = 0;
> +    NVME_PMRSTS_SET_ERR(n->bar.pmrsts, 0);
> +    NVME_PMRSTS_SET_NRDY(n->bar.pmrsts, 0);
> +    NVME_PMRSTS_SET_HSTS(n->bar.pmrsts, 0);
> +    NVME_PMRSTS_SET_CBAI(n->bar.pmrsts, 0);
> +
> +    /* PMR Elasticity Buffer Size register */
> +    n->bar.pmrebs = 0;
> +    NVME_PMREBS_SET_PMRSZU(n->bar.pmrebs, 0);
> +    NVME_PMREBS_SET_RBB(n->bar.pmrebs, 0);
> +    NVME_PMREBS_SET_PMRWBZ(n->bar.pmrebs, 0);
> +
> +    /* PMR Sustained Write Throughput register */
> +    n->bar.pmrswtp = 0;
> +    NVME_PMRSWTP_SET_PMRSWTU(n->bar.pmrswtp, 0);
> +    NVME_PMRSWTP_SET_PMRSWTV(n->bar.pmrswtp, 0);
> +
> +    /* PMR Memory Space Control register */
> +    n->bar.pmrmsc = 0;
> +    NVME_PMRMSC_SET_CMSE(n->bar.pmrmsc, 0);
> +    NVME_PMRMSC_SET_CBA(n->bar.pmrmsc, 0);
> +
> +    pci_register_bar(pci_dev, NVME_PMRCAP_BIR(n->bar.pmrcap),
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmrdev->mr);
> +}
> +
>   static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>   {
>       uint8_t *pci_conf = pci_dev->config;
> @@ -1541,50 +1591,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>       if (n->params.cmb_size_mb) {
>           nvme_init_cmb(n, pci_dev);
>       } else if (n->pmrdev) {
> -        /* Controller Capabilities register */
> -        NVME_CAP_SET_PMRS(n->bar.cap, 1);
> -
> -        /* PMR Capabities register */
> -        n->bar.pmrcap = 0;
> -        NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
> -        NVME_PMRCAP_SET_WDS(n->bar.pmrcap, 0);
> -        NVME_PMRCAP_SET_BIR(n->bar.pmrcap, 2);
> -        NVME_PMRCAP_SET_PMRTU(n->bar.pmrcap, 0);
> -        /* Turn on bit 1 support */
> -        NVME_PMRCAP_SET_PMRWBM(n->bar.pmrcap, 0x02);
> -        NVME_PMRCAP_SET_PMRTO(n->bar.pmrcap, 0);
> -        NVME_PMRCAP_SET_CMSS(n->bar.pmrcap, 0);
> -
> -        /* PMR Control register */
> -        n->bar.pmrctl = 0;
> -        NVME_PMRCTL_SET_EN(n->bar.pmrctl, 0);
> -
> -        /* PMR Status register */
> -        n->bar.pmrsts = 0;
> -        NVME_PMRSTS_SET_ERR(n->bar.pmrsts, 0);
> -        NVME_PMRSTS_SET_NRDY(n->bar.pmrsts, 0);
> -        NVME_PMRSTS_SET_HSTS(n->bar.pmrsts, 0);
> -        NVME_PMRSTS_SET_CBAI(n->bar.pmrsts, 0);
> -
> -        /* PMR Elasticity Buffer Size register */
> -        n->bar.pmrebs = 0;
> -        NVME_PMREBS_SET_PMRSZU(n->bar.pmrebs, 0);
> -        NVME_PMREBS_SET_RBB(n->bar.pmrebs, 0);
> -        NVME_PMREBS_SET_PMRWBZ(n->bar.pmrebs, 0);
> -
> -        /* PMR Sustained Write Throughput register */
> -        n->bar.pmrswtp = 0;
> -        NVME_PMRSWTP_SET_PMRSWTU(n->bar.pmrswtp, 0);
> -        NVME_PMRSWTP_SET_PMRSWTV(n->bar.pmrswtp, 0);
> -
> -        /* PMR Memory Space Control register */
> -        n->bar.pmrmsc = 0;
> -        NVME_PMRMSC_SET_CMSE(n->bar.pmrmsc, 0);
> -        NVME_PMRMSC_SET_CBA(n->bar.pmrmsc, 0);
> -
> -        pci_register_bar(pci_dev, NVME_PMRCAP_BIR(n->bar.pmrcap),
> -            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
> -            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmrdev->mr);
> +        nvme_init_pmr(n, pci_dev);
>       }
>   
>       for (i = 0; i < n->num_namespaces; i++) {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


