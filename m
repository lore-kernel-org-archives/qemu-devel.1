Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F9C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1585F20716
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPY2Mlsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1585F20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHske-00030V-4c
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jHsjo-0002aW-Om
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jHsjm-0006IV-3E
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:25:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jHsjl-0006HH-Sx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585329941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pjc35xFK4bFr3t5dXBVOy2iGeocSMSesPRX8AD/UN7c=;
 b=dPY2MlsjildHyeNhBbMa6202F2QrAd6fkOlNiRQDguQLkUag6D0QPYpCXi0FZQpFCGbHe9
 Sd0AglcsrpPNYVSqiOqXTrSVvQb9WzSixjfNVyxDa73hWGDYrlsgdK62kVt86UYotTozrJ
 ZPhB1FEA8mgdAyqnMNQVxVn67fHZR+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Pj6ZkXKVOwy57EShOzoeGw-1; Fri, 27 Mar 2020 13:25:39 -0400
X-MC-Unique: Pj6ZkXKVOwy57EShOzoeGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BA3C19057A0;
 Fri, 27 Mar 2020 17:25:38 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 013635C1C3;
 Fri, 27 Mar 2020 17:25:37 +0000 (UTC)
Date: Fri, 27 Mar 2020 11:25:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: yan.y.zhao@intel.com
Subject: Re: [PATCH] hw/vfio: let readonly flag take effect for mmaped regions
Message-ID: <20200327112537.2efd65ac@w520.home>
In-Reply-To: <20200327111934.71066-1-yan.y.zhao@intel.com>
References: <20200327111934.71066-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: pbonzini@redhat.com, Xin Zeng <xin.zeng@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 11:19:34 +0000
yan.y.zhao@intel.com wrote:

> From: Yan Zhao <yan.y.zhao@intel.com>
> 
> currently, vfio regions without VFIO_REGION_INFO_FLAG_WRITE are only
> read-only when VFIO_REGION_INFO_FLAG_MMAP is not set.
> 
> regions with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP
> are only read-only in host page table for qemu.
> 
> This patch sets corresponding ept page entries read-only for regions
> with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP.
> 
> accordingly, it ignores guest write when guest writes to the read-only
> regions are trapped.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---

Currently we set the r/w protection on the mmap, do I understand
correctly that the change in the vfio code below results in KVM exiting
to QEMU to handle a write to a read-only region and therefore we need
the memory.c change to drop the write?  This prevents a SIGBUS or
similar?

Meanwhile vfio_region_setup() uses the same vfio_region_ops for all
regions and vfio_region_write() would still allow writes, so if the
device were using x-no-mmap=on, I think we'd still get a write to this
region and expect the vfio device to drop it.  Should we prevent that
write in QEMU as well?

Can you also identify what device and region requires this so that we
can decide whether this is QEMU 5.0 or 5.1 material?  PCI BARs are of
course always R/W and the ROM uses different ops and doesn't support
mmap, so this is a device specific region of some sort.  Thanks,

Alex


>  hw/vfio/common.c | 4 ++++
>  memory.c         | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3593b3c0..e901621ca0 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -971,6 +971,10 @@ int vfio_region_mmap(VFIORegion *region)
>                                            name, region->mmaps[i].size,
>                                            region->mmaps[i].mmap);
>          g_free(name);
> +
> +        if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> +            memory_region_set_readonly(&region->mmaps[i].mem, true);
> +        }
>          memory_region_add_subregion(region->mem, region->mmaps[i].offset,
>                                      &region->mmaps[i].mem);
>  
> diff --git a/memory.c b/memory.c
> index 601b749906..4b1071dc74 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1313,6 +1313,9 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>      MemoryRegion *mr = opaque;
>  
>      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> +    if (mr->readonly) {
> +        return;
> +    }
>  
>      switch (size) {
>      case 1:


