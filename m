Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F1BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628B12065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qqwy+4P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628B12065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8sJ-0007TC-Hb
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ8rc-0006Xn-BN
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:05:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ8rb-0004IO-Iy
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589443505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuFg2sBb2NJ7d2r9HQUEO5VfESPgctovDySONJwcf64=;
 b=Qqwy+4P5u6ZxdzZ8HIwjJtY/8elvvTKht2wGWRfeG1wVAjQGKrnrf1iLB9HDNZS4+fdq8v
 Z+vRa6Ynyvehaic1ZWzmzbSwu0La3Yhz2cpkXwbdV8abc72aBPTIp8daM6ep9qRpeJuSj5
 iD8h+X1jaI3VM7gPKXW2WJVvv+7ezxw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7--RNGPPsXOtuwN8iqA4V7Aw-1; Thu, 14 May 2020 04:05:02 -0400
X-MC-Unique: -RNGPPsXOtuwN8iqA4V7Aw-1
Received: by mail-wm1-f69.google.com with SMTP id a206so5884740wmh.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 01:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MuFg2sBb2NJ7d2r9HQUEO5VfESPgctovDySONJwcf64=;
 b=CPCpssktgq+QW2pcKFtHHcFiLnvARUCuft5aVurgyjEbMFe6Rdw1n0yuEbT6y8lKiG
 VD8POSSZkawR1GU46qK8AwAdKR+HUWgsnoBUx+fzEW74g3ibEC43+vy5hgMIyXhYC91k
 VfqoCLy7wWyUeNdQr4x4UnZJhHzGHdZXhhuX0ImdP/aiHn2bRcrDtrOg9LEDJDnO9Rkz
 dt5uqjF3nObk0g/aN1AAT1rjHhTaV7CzAzblAoHkyeHvX+JQcB4QKoKbHUFYomQCVWGL
 D0sl2AZX72xs7fLJ3r1uOW6gJoSIP3JkSl5dVRHl5HHgEFk3gmg0I5varITC/UiAQWzo
 79dA==
X-Gm-Message-State: AOAM530HBudqxfs8iNy0tP+zpvQyHM5wgsVWrnk6El2kamG1QP9U52Mj
 oeSwYd8nFTE4BbHryQmPC4pxvfUfBWQJ8GnurdaijLeiuHzcg5/GyXf/7J10uP0MioD4uqJaqyo
 UvErm+cexw4k6nUo=
X-Received: by 2002:a05:600c:206:: with SMTP id
 6mr13034754wmi.170.1589443501014; 
 Thu, 14 May 2020 01:05:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLP0E7wgKkGI38OyfVRi00Fwky9c6ldCWmt9vfAnZtrq8LVRxvzMDXXKegwaSdptQtFZia7Q==
X-Received: by 2002:a05:600c:206:: with SMTP id
 6mr13034718wmi.170.1589443500744; 
 Thu, 14 May 2020 01:05:00 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v11sm2779793wrv.53.2020.05.14.01.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 01:04:59 -0700 (PDT)
Subject: Re: [PATCH v6 19/20] hw/block/nvme: do cmb/pmr init as part of pci
 init
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200514044611.734782-1-its@irrelevant.dk>
 <20200514044611.734782-20-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0cecef81-5df2-6bdf-b7da-b910e2d5714b@redhat.com>
Date: Thu, 14 May 2020 10:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514044611.734782-20-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Having the patch subject duplicated ease review (not all email client 
display email subject close to email content):

"Do cmb/pmr init as part of pci init."

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7254b66ae199..2addcc86034a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1527,6 +1527,12 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>       pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                        PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
>       msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
> +
> +    if (n->params.cmb_size_mb) {
> +        nvme_init_cmb(n, pci_dev);
> +    } else if (n->pmrdev) {
> +        nvme_init_pmr(n, pci_dev);
> +    }
>   }
>   
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> @@ -1588,12 +1594,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>       n->bar.vs = 0x00010200;
>       n->bar.intmc = n->bar.intms = 0;
>   
> -    if (n->params.cmb_size_mb) {
> -        nvme_init_cmb(n, pci_dev);
> -    } else if (n->pmrdev) {
> -        nvme_init_pmr(n, pci_dev);
> -    }
> -
>       for (i = 0; i < n->num_namespaces; i++) {
>           nvme_init_namespace(n, &n->namespaces[i], &local_err);
>           if (local_err) {
> 


