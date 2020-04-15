Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2D1C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D077214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoVv5NGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D077214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOgLn-0002Bi-A0
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 07:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOgLA-0001g4-OT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOgL9-0006hy-Oj
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:36:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOgL9-0006hu-L9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586950583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrrfPhohZwP6hwS3VPiFER8r6ohPDmLhaxzVOogmix0=;
 b=RoVv5NGQ1sQuMTDBCyExrL4FSS04Ba3JWnyjr+xpIzisEqhdcKxMgcXbILpXayMiiOMHoq
 n+7Z4BF16GuAWiMY1KPhan8zuPFTfvfjYeNz1XPxHYa/ps+r/0azpMAs/m69HahmTp2ZiH
 xWhA4ubYkl8Q37uJJzY2i15DIte772Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-hTnyY-vkMby3t8491gnt1Q-1; Wed, 15 Apr 2020 07:36:21 -0400
X-MC-Unique: hTnyY-vkMby3t8491gnt1Q-1
Received: by mail-ed1-f70.google.com with SMTP id i10so2660472edk.13
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 04:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QrrfPhohZwP6hwS3VPiFER8r6ohPDmLhaxzVOogmix0=;
 b=iXm7gorVyvhHivwttdgyZXx5XXEcLJMsjd7H8csFlgnRcsIHE1nJEHxjVBmjZdngkF
 jzQ8oAWTqwOqy0Pf07vuGz3tjo8CT4CWbXFqpnjsmE+rl2rhgMdkjAJiy0qZl5KvOKVl
 xeUHYs8l1Sutc+T2dcBgXTn0SxAeluIAmJ6AEgTYObOI7sTOQ/LmRGYtRovKirhYQS/Y
 rnzkk86PpXob/JChC759kqXzSYZHiWcMQiNE6kfOhiK1bwcpyCqG8ZD4kbiPBTYE039m
 GSJPHZjpvhLHZLeuNmKKJieq7Bp2mrBItaqmMs5p2JWleqOEcrjgJ5LD2JA6E/2866cR
 4Vcg==
X-Gm-Message-State: AGi0PuaQRsIWtCeCpNWjS82Hjw7fan7c1VVBp7CCOozF/EncPDvHjY5r
 U3wCPV6Px8YuxpaTmicAuEUH4RcIHV8f88+cSqJ4iw67Opaks05LavOlYoHc9uxm6QVpo4mbkfa
 yY61WGvJCIWp9wyM=
X-Received: by 2002:a17:906:b7da:: with SMTP id
 fy26mr4679917ejb.327.1586950580493; 
 Wed, 15 Apr 2020 04:36:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypIFWZSCs8tB/sS35WaztReYncQa5fc9fc8s9jH2vwhJmthRLKd4r6YBoXAyiHzf5GwMY9IjgA==
X-Received: by 2002:a17:906:b7da:: with SMTP id
 fy26mr4679879ejb.327.1586950580181; 
 Wed, 15 Apr 2020 04:36:20 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b13sm2003557eje.13.2020.04.15.04.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 04:36:19 -0700 (PDT)
Subject: Re: [PATCH 02/16] nvme: rename trace events to nvme_dev
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-3-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <83edb49b-56b5-4504-8794-f7fcdf74fd67@redhat.com>
Date: Wed, 15 Apr 2020 13:36:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-3-its@irrelevant.dk>
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
> Change the prefix of all nvme device related trace events to 'nvme_dev'

Another option is 'pci_nvme'. None of them make me happy but I can't 
find a better name.

> to not clash with trace events from the nvme block driver.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c       | 190 +++++++++++++++++++++---------------------
>   hw/block/trace-events | 172 +++++++++++++++++++-------------------
>   2 files changed, 180 insertions(+), 182 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 77f9c151a665..316cfc4d36e0 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -112,16 +112,16 @@ static void nvme_irq_assert(NvmeCtrl *n, NvmeCQueue *cq)
>   {
>       if (cq->irq_enabled) {
>           if (msix_enabled(&(n->parent_obj))) {
> -            trace_nvme_irq_msix(cq->vector);
> +            trace_nvme_dev_irq_msix(cq->vector);
>               msix_notify(&(n->parent_obj), cq->vector);
>           } else {
> -            trace_nvme_irq_pin();
> +            trace_nvme_dev_irq_pin();
>               assert(cq->cqid < 64);
>               n->irq_status |= 1 << cq->cqid;
>               nvme_irq_check(n);
>           }
>       } else {
> -        trace_nvme_irq_masked();
> +        trace_nvme_dev_irq_masked();
>       }
>   }
[...]


