Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC60C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D847D2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUJ1t4dN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D847D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAT3-0004ai-1V
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRAS2-0003v0-PU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRAS0-0004nh-He
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:09:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRARz-0004gP-Vq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587542982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCTZ8XfKc2zjU6sSZpZ6JoYtMDaGXNJZO4v0NqUWau0=;
 b=iUJ1t4dNlsyrTqJNbXdKqxBAdxs3LfCShbzyHOqpP6O3WVdyNXiYG51N23bcoAxgozEulj
 3LZLD+atPd71JKG65UWDdC7BZcfOtcmGvF40yGCkTa5wKyu85ZC3AwaCQrN6xABFbB/jQ7
 BJspTaqt06X5fm6oB8XRntt/w3HkAJk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-bds4lQ74OVyfG4YpIVRHCw-1; Wed, 22 Apr 2020 04:09:40 -0400
X-MC-Unique: bds4lQ74OVyfG4YpIVRHCw-1
Received: by mail-wr1-f71.google.com with SMTP id d17so659007wrr.17
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 01:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LCTZ8XfKc2zjU6sSZpZ6JoYtMDaGXNJZO4v0NqUWau0=;
 b=RhfJNzfcVtID/mEAVcYpQINR8Uwx03dQxhxNJi6c6DCrUxeolWkeZtv9KPEglJCkzU
 ROMB/F6FJzsQR+nb4g61AX61nMt39AOYHGtbSjYjeRr9M/UN4wWl5lv1OVYg1Q1/NWhz
 jVieVv/EcYS0xzTXqPRzuDnW5qdCSQ2KzyOX48e2lIwjZcX/Z3s9b35BdCOgZYtXm+3w
 NW8sfFVN6RXZYXIVchTJYbkmsQXGawTR57bJzPbU9+cnFfuyehRc6vLW8/xqUJhImrde
 uZVvsW7wnoTc7Sz5vH0X9nh/SKSzzDpuYnOEElN4YUbYAPEZ0fXwX13rKZY1jEHLR3du
 rURw==
X-Gm-Message-State: AGi0PubARN4SG/cVah2SeYTD1UJES75t4bcD2S4bfWOj+BBEDLSMH0Ee
 iQvjrX9IZoaP2EV6AzQ3VL3miUNLDOSHmMs87dIS0RWyGnKVMD3VRyUoIuKIiz/6NiqCokTTpUa
 lBn+X5s2FXLesrp8=
X-Received: by 2002:a7b:c850:: with SMTP id c16mr8698616wml.108.1587542979679; 
 Wed, 22 Apr 2020 01:09:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLff8F0nq6sHBNttG3xuSP/Q4A3Q6khEeqON/+MyoEB7d1j7znjQiK3Yk5S8YZ92nzndXTyRw==
X-Received: by 2002:a7b:c850:: with SMTP id c16mr8698583wml.108.1587542979342; 
 Wed, 22 Apr 2020 01:09:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b85sm7006961wmb.21.2020.04.22.01.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 01:09:38 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] nvme: factor out cmb/pmr setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200422070927.373048-1-its@irrelevant.dk>
 <20200422070927.373048-16-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b07e9238-40a5-e806-5523-74b084ee198a@redhat.com>
Date: Wed, 22 Apr 2020 10:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422070927.373048-16-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

On 4/22/20 9:09 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 146 ++++++++++++++++++++++++++----------------------
>   1 file changed, 79 insertions(+), 67 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 5dddb97a7394..bc4f6b20045b 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -57,6 +57,7 @@
>   
>   #define NVME_REG_SIZE 0x1000
>   #define NVME_DB_SIZE  4
> +#define NVME_CMB_BIR 2
>   
>   #define NVME_GUEST_ERR(trace, fmt, ...) \
>       do { \
> @@ -1436,6 +1437,78 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>       id_ns->nuse = id_ns->ncap;
>   }
[...]
>   static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>   {
>       uint8_t *pci_conf = pci_dev->config;
> @@ -1450,6 +1523,12 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>       pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                        PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
>       msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
> +
> +    if (n->params.cmb_size_mb) {
> +        nvme_init_cmb(n, pci_dev);
> +    } else if (n->pmrdev) {
> +        nvme_init_pmr(n, pci_dev);

Why not splitting this in 2 trivial patches? The easiest a patch is to 
review, the less likely bug can be missed. Here I'm scrolling over 2 
different blocks so to feel confident I'm not missing something I'd have 
to manually edit and re-do your patch.

> +    }
>   }
>   
[...]


