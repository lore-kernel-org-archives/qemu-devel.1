Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E599C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3DE2084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DE2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlrGs-000865-Hk
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 04:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hlrGd-0007W1-QC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hlrGc-0005VJ-Qe
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:50:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hlrGc-0005To-KM
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:50:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so8155968wmg.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 01:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ycES0mpRUstBY++vSyVaZobWD0QKPhc4BrviZEzqok4=;
 b=pI0hc2y4pm8JJDfGAueUNrzFaE/EQGdooZRpSNKCkD6U3dFat5/TVi7f86I5D3N5TZ
 PCMjxGeoIdK5prCRg9mSTr0Qz0aPOiBqN7KREeWwHtKa1Ytg9c0VZ0sUxh3wDuD0Z+G4
 /F4wQqsG009dMjZFs/mfMeOvlYmRhvjbn+r+7Ouj/evJ9RGeMDYOuCSWh4UBjr3Md6+W
 AovHjYoPRBBaJ5txrc8bfzzJ0dZxEawDidmVkS32ShuAtzKR46HPJZQp3k6zmmCNAkSj
 d3hT6hbmzxTEty6727nBX+8EolOq/okTSR0dfztarBGMduXA6gfpv41LqRiby+UgxgFd
 6B0Q==
X-Gm-Message-State: APjAAAWgjKzQbz2mdQ5DHPGsIdw8Lg0cKFP67aEjXPzhH2Wdb/zxkcwf
 wtPj8/qK0yhh6R36dngbMDbaAA==
X-Google-Smtp-Source: APXvYqwfs4Tyrh1nECMV5CM/bue7SXO5bPB/Q6Oi/Ls1KfwIaQYhFoHyA2OXyPGanGgWRx96VrYKKw==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr8609740wmc.30.1562921457450;
 Fri, 12 Jul 2019 01:50:57 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id f17sm7222758wmf.27.2019.07.12.01.50.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 01:50:56 -0700 (PDT)
Date: Fri, 12 Jul 2019 10:50:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190712085054.srd4zossmrsdvl6k@steredhat>
References: <20190712073554.21918-1-pagupta@redhat.com>
 <20190712073554.21918-2-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712073554.21918-2-pagupta@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/3] virtio pmem: fix wrong mem region
 condition
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 01:05:52PM +0530, Pankaj Gupta wrote:
> Coverity reported memory region returns zero
> for non-null value. This is because of wrong
> arguments to '?:' , fixing this.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  hw/virtio/virtio-pmem-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
> index 8b2d0dbccc..0da6627469 100644
> --- a/hw/virtio/virtio-pmem-pci.c
> +++ b/hw/virtio/virtio-pmem-pci.c
> @@ -57,7 +57,7 @@ static uint64_t virtio_pmem_pci_get_plugged_size(const MemoryDeviceState *md,
>      MemoryRegion *mr = vpc->get_memory_region(pmem, errp);
>  
>      /* the plugged size corresponds to the region size */
> -    return mr ? 0 : memory_region_size(mr);
> +    return mr ? memory_region_size(mr) : 0;
>  }
>  
>  static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md,
> -- 
> 2.14.5

