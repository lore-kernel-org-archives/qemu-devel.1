Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0DCC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB726206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRMwxi8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB726206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ0y2-0008JK-TG
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 16:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jJ0xK-0007a9-9W
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jJ0xH-0001fj-VV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:24:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jJ0xH-0001d0-Mf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585599859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfQISzj/ilt4GyJFjxI4+6LKkBOP9h7E1fZIhpfx85M=;
 b=KRMwxi8oaxGo57UKvxZ1x6lDfOS27MsZJsbrAMnVLMA0dAaa7O2iSiJh8LxaTl8hSY4vRZ
 /exQsierIVET266XNhnnuzEJIbatglrKkmZLUrKNx6jenoarh+ZWYSfsHjjoSTuGBMGHD7
 HbKvYPPQEpyz1zXv7UQOT2d5WmGeSJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468--zE0xz2LN4SjOxIkd46I-w-1; Mon, 30 Mar 2020 16:24:16 -0400
X-MC-Unique: -zE0xz2LN4SjOxIkd46I-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 385E28010E5;
 Mon, 30 Mar 2020 20:24:14 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 012E35DDA5;
 Mon, 30 Mar 2020 20:23:55 +0000 (UTC)
Subject: Re: [PATCH v2 07/22] intel_iommu: add set/unset_iommu_context callback
To: Liu Yi L <yi.l.liu@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, peterx@redhat.com
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-8-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a444318b-32c7-d43c-112a-d35a870b162d@redhat.com>
Date: Mon, 30 Mar 2020 22:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-8-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, yi.y.sun@intel.com, pbonzini@redhat.com,
 hao.wu@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yi,

On 3/30/20 6:24 AM, Liu Yi L wrote:
> This patch adds set/unset_iommu_context() impelementation in Intel
This patch implements the set/unset_iommu_context() ops for Intel vIOMMU.
> vIOMMU. For Intel platform, pass-through modules (e.g. VFIO) could
> set HostIOMMUContext to Intel vIOMMU emulator.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c         | 71 ++++++++++++++++++++++++++++++++++++++++---
>  include/hw/i386/intel_iommu.h | 21 ++++++++++---
>  2 files changed, 83 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4b22910..fd349c6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3354,23 +3354,33 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
>      },
>  };
>  
> -VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
> +/**
> + * Fetch a VTDBus instance for given PCIBus. If no existing instance,
> + * allocate one.
> + */
> +static VTDBus *vtd_find_add_bus(IntelIOMMUState *s, PCIBus *bus)
>  {
>      uintptr_t key = (uintptr_t)bus;
>      VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
> -    VTDAddressSpace *vtd_dev_as;
> -    char name[128];
>  
>      if (!vtd_bus) {
>          uintptr_t *new_key = g_malloc(sizeof(*new_key));
>          *new_key = (uintptr_t)bus;
>          /* No corresponding free() */
> -        vtd_bus = g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *) * \
> -                            PCI_DEVFN_MAX);
> +        vtd_bus = g_malloc0(sizeof(VTDBus));
>          vtd_bus->bus = bus;
>          g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
>      }
> +    return vtd_bus;
> +}
>  
> +VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
> +{
> +    VTDBus *vtd_bus;
> +    VTDAddressSpace *vtd_dev_as;
> +    char name[128];
> +
> +    vtd_bus = vtd_find_add_bus(s, bus);
>      vtd_dev_as = vtd_bus->dev_as[devfn];
>  
>      if (!vtd_dev_as) {
> @@ -3436,6 +3446,55 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>      return vtd_dev_as;
>  }
>  
> +static int vtd_dev_set_iommu_context(PCIBus *bus, void *opaque,
> +                                     int devfn,
> +                                     HostIOMMUContext *iommu_ctx)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDBus *vtd_bus;
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +
> +    vtd_bus = vtd_find_add_bus(s, bus);
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_dev_icx = vtd_bus->dev_icx[devfn];
> +
> +    assert(!vtd_dev_icx);
> +
> +    vtd_bus->dev_icx[devfn] = vtd_dev_icx =
> +                    g_malloc0(sizeof(VTDHostIOMMUContext));
> +    vtd_dev_icx->vtd_bus = vtd_bus;
> +    vtd_dev_icx->devfn = (uint8_t)devfn;
> +    vtd_dev_icx->iommu_state = s;
> +    vtd_dev_icx->iommu_ctx = iommu_ctx;
> +
> +    vtd_iommu_unlock(s);
> +
> +    return 0;
> +}
> +
> +static void vtd_dev_unset_iommu_context(PCIBus *bus, void *opaque, int devfn)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDBus *vtd_bus;
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +
> +    vtd_bus = vtd_find_add_bus(s, bus);
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_dev_icx = vtd_bus->dev_icx[devfn];
> +    g_free(vtd_dev_icx);
> +    vtd_bus->dev_icx[devfn] = NULL;
> +
> +    vtd_iommu_unlock(s);
> +}
> +
>  static uint64_t get_naturally_aligned_size(uint64_t start,
>                                             uint64_t size, int gaw)
>  {
> @@ -3731,6 +3790,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  
>  static PCIIOMMUOps vtd_iommu_ops = {
>      .get_address_space = vtd_host_dma_iommu,
> +    .set_iommu_context = vtd_dev_set_iommu_context,
> +    .unset_iommu_context = vtd_dev_unset_iommu_context,
>  };
>  
>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 3870052..b5fefb9 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -64,6 +64,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
>  typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
>  typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
>  typedef struct VTDPASIDEntry VTDPASIDEntry;
> +typedef struct VTDHostIOMMUContext VTDHostIOMMUContext;
>  
>  /* Context-Entry */
>  struct VTDContextEntry {
> @@ -112,10 +113,20 @@ struct VTDAddressSpace {
>      IOVATree *iova_tree;          /* Traces mapped IOVA ranges */
>  };
>  
> +struct VTDHostIOMMUContext {


> +    VTDBus *vtd_bus;
> +    uint8_t devfn;
> +    HostIOMMUContext *iommu_ctx;
I don't get why we don't have standard QOM inheritance instead of this
handle?
VTDHostContext parent_obj;

like IOMMUMemoryRegion <- MemoryRegion <- Object
> +    IntelIOMMUState *iommu_state;
> +};
> +
>  struct VTDBus {
> -    PCIBus* bus;		/* A reference to the bus to provide translation for */
> +    /* A reference to the bus to provide translation for */
> +    PCIBus *bus;
>      /* A table of VTDAddressSpace objects indexed by devfn */
> -    VTDAddressSpace *dev_as[];
> +    VTDAddressSpace *dev_as[PCI_DEVFN_MAX];
> +    /* A table of VTDHostIOMMUContext objects indexed by devfn */
> +    VTDHostIOMMUContext *dev_icx[PCI_DEVFN_MAX];
At this point of the review, it is unclear to me why the context is
associated to a device. Up to now you have not explained it should. If
so why isn't it part of VTDAddressSpace?

Thanks

Eric
>  };
>  
>  struct VTDIOTLBEntry {
> @@ -269,8 +280,10 @@ struct IntelIOMMUState {
>      bool dma_drain;                 /* Whether DMA r/w draining enabled */
>  
>      /*
> -     * Protects IOMMU states in general.  Currently it protects the
> -     * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
> +     * iommu_lock protects below:
> +     * - per-IOMMU IOTLB caches
> +     * - context entry cache in VTDAddressSpace
> +     * - HostIOMMUContext pointer cached in vIOMMU
>       */
>      QemuMutex iommu_lock;
>  };
> 


