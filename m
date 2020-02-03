Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A867C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B1B2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsG4sHoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B1B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydEf-00070c-8O
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iydC7-0004R4-U1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iydC5-0006MG-4q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:59:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57667
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iydC5-0006Lg-0Z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580741960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqceLiY3S591vKOQnUB30kG+6CBzB/cGGA7eYMgdWWw=;
 b=ZsG4sHoD3fvpvD7WjHSJ/Euqz/tlYzaO649Ve6Ol0uw9GacPtc728zWQcLrd9J/oxT6saQ
 XQWr+f/rUocRF1mKqYn3rheSXO6v+gUnJbhgqzFNOlb3vUAz2U3HvqR6bVcu1kxrXNxWbS
 7VL1ouYVSnZQei0lA2/83luJf5y/1dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-2poryNGzNvmKYPkwrX-U6A-1; Mon, 03 Feb 2020 09:59:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA7B610107BE;
 Mon,  3 Feb 2020 14:59:13 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72B9D84D81;
 Mon,  3 Feb 2020 14:59:03 +0000 (UTC)
Subject: Re: [PATCH v13 03/10] virtio-iommu: Implement attach/detach command
To: Peter Xu <peterx@redhat.com>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-4-eric.auger@redhat.com>
 <20200203134915.GA155875@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ce49f691-d944-2e5e-87a3-7e7c9651c2af@redhat.com>
Date: Mon, 3 Feb 2020 15:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203134915.GA155875@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2poryNGzNvmKYPkwrX-U6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/3/20 2:49 PM, Peter Xu wrote:
> On Sat, Jan 25, 2020 at 06:19:48PM +0100, Eric Auger wrote:
>> This patch implements the endpoint attach/detach to/from
>> a domain.
>>
>> Domain and endpoint internal datatypes are introduced.
>> Both are stored in RB trees. The domain owns a list of
>> endpoints attached to it. Also helpers to get/put
>> end points and domains are introduced.
>>
>> As for the IOMMU memory regions, a callback is called on
>> PCI bus enumeration that initializes for a given device
>> on the bus hierarchy an IOMMU memory region. The PCI bus
>> hierarchy is stored locally in IOMMUPciBus and IOMMUDevice
>> objects.
>>
>> At the time of the enumeration, the bus number may not be
>> computed yet.
>>
>> So operations that will need to retrieve the IOMMUdevice
>> and its IOMMU memory region from the bus number and devfn,
>> once the bus number is garanteed to be frozen, use an array
>> of IOMMUPciBus, lazily populated.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v12 -> v13:
>> - squashed v12 4, 5, 6 into this patch
>> - rename virtio_iommu_get_sid into virtio_iommu_get_bdf
>>
>> v11 -> v12:
>> - check the device is protected by the iommu on attach
>> - on detach, check the domain id the device is attached to matches
>>   the one used in the detach command
>> - fix mapping ref counter and destroy the domain when no end-points
>>   are attached anymore
>> ---
>>  hw/virtio/trace-events           |   6 +
>>  hw/virtio/virtio-iommu.c         | 315 ++++++++++++++++++++++++++++++-
>>  include/hw/virtio/virtio-iommu.h |   3 +
>>  3 files changed, 322 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index f7141aa2f6..15595f8cd7 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -64,3 +64,9 @@ virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
>>  virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
>>  virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64 " phys_start=0x%"PRIx64" flags=%d"
>>  virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
>> +virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, int flag) "mr=%s rid=%d addr=0x%"PRIx64" flag=%d"
>> +virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
>> +virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=%d"
>> +virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=%d"
>> +virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>> +virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 9d1b997df7..e5cc94138b 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -23,6 +23,8 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/virtio/virtio.h"
>>  #include "sysemu/kvm.h"
>> +#include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>  #include "trace.h"
>>  
>>  #include "standard-headers/linux/virtio_ids.h"
>> @@ -30,19 +32,234 @@
>>  #include "hw/virtio/virtio-bus.h"
>>  #include "hw/virtio/virtio-access.h"
>>  #include "hw/virtio/virtio-iommu.h"
>> +#include "hw/pci/pci_bus.h"
>> +#include "hw/pci/pci.h"
>>  
>>  /* Max size */
>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>  
>> +typedef struct VirtIOIOMMUDomain {
>> +    uint32_t id;
>> +    GTree *mappings;
>> +    QLIST_HEAD(, VirtIOIOMMUEndpoint) endpoint_list;
>> +} VirtIOIOMMUDomain;
>> +
>> +typedef struct VirtIOIOMMUEndpoint {
>> +    uint32_t id;
>> +    VirtIOIOMMUDomain *domain;
>> +    QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
>> +} VirtIOIOMMUEndpoint;
>> +
>> +typedef struct VirtIOIOMMUInterval {
>> +    uint64_t low;
>> +    uint64_t high;
>> +} VirtIOIOMMUInterval;
>> +
>> +static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
>> +{
>> +    return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
>> +}
>> +
>> +/**
>> + * The bus number is used for lookup when SID based operations occur.
>> + * In that case we lazily populate the IOMMUPciBus array from the bus hash
>> + * table. At the time the IOMMUPciBus is created (iommu_find_add_as), the bus
>> + * numbers may not be always initialized yet.
>> + */
>> +static IOMMUPciBus *iommu_find_iommu_pcibus(VirtIOIOMMU *s, uint8_t bus_num)
>> +{
>> +    IOMMUPciBus *iommu_pci_bus = s->iommu_pcibus_by_bus_num[bus_num];
>> +
>> +    if (!iommu_pci_bus) {
>> +        GHashTableIter iter;
>> +
>> +        g_hash_table_iter_init(&iter, s->as_by_busptr);
>> +        while (g_hash_table_iter_next(&iter, NULL, (void **)&iommu_pci_bus)) {
>> +            if (pci_bus_num(iommu_pci_bus->bus) == bus_num) {
>> +                s->iommu_pcibus_by_bus_num[bus_num] = iommu_pci_bus;
>> +                return iommu_pci_bus;
>> +            }
>> +        }
>> +        return NULL;
>> +    }
>> +    return iommu_pci_bus;
>> +}
>> +
>> +static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
>> +{
>> +    uint8_t bus_n, devfn;
>> +    IOMMUPciBus *iommu_pci_bus;
>> +    IOMMUDevice *dev;
>> +
>> +    bus_n = PCI_BUS_NUM(sid);
>> +    iommu_pci_bus = iommu_find_iommu_pcibus(s, bus_n);
>> +    if (iommu_pci_bus) {
>> +        devfn = sid & PCI_DEVFN_MAX;
>> +        dev = iommu_pci_bus->pbdev[devfn];
>> +        if (dev) {
>> +            return &dev->iommu_mr;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>> +{
>> +    VirtIOIOMMUInterval *inta = (VirtIOIOMMUInterval *)a;
>> +    VirtIOIOMMUInterval *intb = (VirtIOIOMMUInterval *)b;
>> +
>> +    if (inta->high < intb->low) {
>> +        return -1;
>> +    } else if (intb->high < inta->low) {
>> +        return 1;
>> +    } else {
>> +        return 0;
>> +    }
>> +}
>> +
>> +static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>> +{
>> +    QLIST_REMOVE(ep, next);
>> +    g_tree_unref(ep->domain->mappings);
> 
> Here domain->mapping is unreferenced for each endpoint, while at [1]
> below you only reference the domain->mappings if it's the first
> endpoint.  Is that problematic?
in [1] I take a ref to the domain->mappings if it is *not* the 1st
endpoint. This aims at deleting the mappings gtree when the last EP is
detached from the domain.

This fixes the issue reported by Jean in:
https://patchwork.kernel.org/patch/11258267/#23046313
> 
>> +    ep->domain = NULL;
>> +}
>> +
>> +static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>> +                                                      uint32_t ep_id)
>> +{
>> +    VirtIOIOMMUEndpoint *ep;
>> +
>> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
>> +    if (ep) {
>> +        return ep;
>> +    }
>> +    if (!virtio_iommu_mr(s, ep_id)) {
>> +        return NULL;
>> +    }
>> +    ep = g_malloc0(sizeof(*ep));
>> +    ep->id = ep_id;
>> +    trace_virtio_iommu_get_endpoint(ep_id);
>> +    g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
>> +    return ep;
>> +}
>> +
>> +static void virtio_iommu_put_endpoint(gpointer data)
>> +{
>> +    VirtIOIOMMUEndpoint *ep = (VirtIOIOMMUEndpoint *)data;
>> +
>> +    assert(!ep->domain);
>> +
>> +    trace_virtio_iommu_put_endpoint(ep->id);
>> +    g_free(ep);
>> +}
>> +
>> +static VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s,
>> +                                                  uint32_t domain_id)
>> +{
>> +    VirtIOIOMMUDomain *domain;
>> +
>> +    domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
>> +    if (domain) {
>> +        return domain;
>> +    }
>> +    domain = g_malloc0(sizeof(*domain));
>> +    domain->id = domain_id;
>> +    domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
>> +                                   NULL, (GDestroyNotify)g_free,
>> +                                   (GDestroyNotify)g_free);
>> +    g_tree_insert(s->domains, GUINT_TO_POINTER(domain_id), domain);
>> +    QLIST_INIT(&domain->endpoint_list);
>> +    trace_virtio_iommu_get_domain(domain_id);
>> +    return domain;
>> +}
>> +
>> +static void virtio_iommu_put_domain(gpointer data)
>> +{
>> +    VirtIOIOMMUDomain *domain = (VirtIOIOMMUDomain *)data;
>> +    VirtIOIOMMUEndpoint *iter, *tmp;
>> +
>> +    QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
>> +        virtio_iommu_detach_endpoint_from_domain(iter);
>> +    }
> 
> Do you need to destroy the domain->mappings here?  Is it leaked?
AFIU as we detach all EPs in the loop above, the whole "mappings" gtree
is destroyed so there is no leak.
> 
>> +    trace_virtio_iommu_put_domain(domain->id);
>> +    g_free(domain);
>> +}
>> +
>> +static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>> +                                              int devfn)
>> +{
>> +    VirtIOIOMMU *s = opaque;
>> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>> +    static uint32_t mr_index;
>> +    IOMMUDevice *sdev;
>> +
>> +    if (!sbus) {
>> +        sbus = g_malloc0(sizeof(IOMMUPciBus) +
>> +                         sizeof(IOMMUDevice *) * PCI_DEVFN_MAX);
>> +        sbus->bus = bus;
>> +        g_hash_table_insert(s->as_by_busptr, bus, sbus);
>> +    }
>> +
>> +    sdev = sbus->pbdev[devfn];
>> +    if (!sdev) {
>> +        char *name = g_strdup_printf("%s-%d-%d",
>> +                                     TYPE_VIRTIO_IOMMU_MEMORY_REGION,
>> +                                     mr_index++, devfn);
>> +        sdev = sbus->pbdev[devfn] = g_malloc0(sizeof(IOMMUDevice));
>> +
>> +        sdev->viommu = s;
>> +        sdev->bus = bus;
>> +        sdev->devfn = devfn;
>> +
>> +        trace_virtio_iommu_init_iommu_mr(name);
>> +
>> +        memory_region_init_iommu(&sdev->iommu_mr, sizeof(sdev->iommu_mr),
>> +                                 TYPE_VIRTIO_IOMMU_MEMORY_REGION,
>> +                                 OBJECT(s), name,
>> +                                 UINT64_MAX);
>> +        address_space_init(&sdev->as,
>> +                           MEMORY_REGION(&sdev->iommu_mr), TYPE_VIRTIO_IOMMU);
>> +        g_free(name);
>> +    }
>> +    return &sdev->as;
>> +}
>> +
>>  static int virtio_iommu_attach(VirtIOIOMMU *s,
>>                                 struct virtio_iommu_req_attach *req)
>>  {
>>      uint32_t domain_id = le32_to_cpu(req->domain);
>>      uint32_t ep_id = le32_to_cpu(req->endpoint);
>> +    VirtIOIOMMUDomain *domain;
>> +    VirtIOIOMMUEndpoint *ep;
>>  
>>      trace_virtio_iommu_attach(domain_id, ep_id);
>>  
>> -    return VIRTIO_IOMMU_S_UNSUPP;
>> +    ep = virtio_iommu_get_endpoint(s, ep_id);
>> +    if (!ep) {
>> +        return VIRTIO_IOMMU_S_NOENT;
>> +    }
>> +
>> +    if (ep->domain) {
>> +        VirtIOIOMMUDomain *previous_domain = ep->domain;
>> +        /*
>> +         * the device is already attached to a domain,
>> +         * detach it first
>> +         */
>> +        virtio_iommu_detach_endpoint_from_domain(ep);
>> +        if (QLIST_EMPTY(&previous_domain->endpoint_list)) {
>> +            g_tree_remove(s->domains, GUINT_TO_POINTER(previous_domain->id));
>> +        }
>> +    }
>> +
>> +    domain = virtio_iommu_get_domain(s, domain_id);
>> +    if (!QLIST_EMPTY(&domain->endpoint_list)) {
>> +        g_tree_ref(domain->mappings);
> 
> [1]
!QLIST_EMPTY
> 
>> +    }
>> +    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
>> +
>> +    ep->domain = domain;
>> +
>> +    return VIRTIO_IOMMU_S_OK;
>>  }
>>  
>>  static int virtio_iommu_detach(VirtIOIOMMU *s,
>> @@ -50,10 +267,34 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
>>  {
>>      uint32_t domain_id = le32_to_cpu(req->domain);
>>      uint32_t ep_id = le32_to_cpu(req->endpoint);
>> +    VirtIOIOMMUDomain *domain;
>> +    VirtIOIOMMUEndpoint *ep;
>>  
>>      trace_virtio_iommu_detach(domain_id, ep_id);
>>  
>> -    return VIRTIO_IOMMU_S_UNSUPP;
>> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
>> +    if (!ep) {
>> +        return VIRTIO_IOMMU_S_NOENT;
>> +    }
>> +
>> +    domain = ep->domain;
>> +
>> +    if (!domain || domain->id != domain_id) {
>> +        return VIRTIO_IOMMU_S_INVAL;
>> +    }
>> +
>> +    virtio_iommu_detach_endpoint_from_domain(ep);
>> +
>> +    /*
>> +     * when the last EP is detached, simply remove the domain for
>> +     * the domain list and destroy it. Note its mappings were already
>> +     * freed by the ref count mechanism. Next operation involving
>> +     * the same domain id will re-create one domain object.
>> +     */
>> +    if (QLIST_EMPTY(&domain->endpoint_list)) {
>> +        g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
>> +    }
>> +    return VIRTIO_IOMMU_S_OK;
>>  }
>>  
>>  static int virtio_iommu_map(VirtIOIOMMU *s,
>> @@ -172,6 +413,27 @@ out:
>>      }
>>  }
>>  
>> +static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>> +                                            IOMMUAccessFlags flag,
>> +                                            int iommu_idx)
>> +{
>> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
>> +    uint32_t sid;
>> +
>> +    IOMMUTLBEntry entry = {
>> +        .target_as = &address_space_memory,
>> +        .iova = addr,
>> +        .translated_addr = addr,
>> +        .addr_mask = ~(hwaddr)0,
>> +        .perm = IOMMU_NONE,
>> +    };
>> +
>> +    sid = virtio_iommu_get_bdf(sdev);
>> +
>> +    trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
>> +    return entry;
>> +}
>> +
>>  static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>  {
>>      VirtIOIOMMU *dev = VIRTIO_IOMMU(vdev);
>> @@ -218,6 +480,13 @@ static const VMStateDescription vmstate_virtio_iommu_device = {
>>      .unmigratable = 1,
>>  };
>>  
>> +static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>> +{
>> +    guint ua = GPOINTER_TO_UINT(a);
>> +    guint ub = GPOINTER_TO_UINT(b);
>> +    return (ua > ub) - (ua < ub);
>> +}
>> +
>>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>  {
>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> @@ -226,6 +495,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>      virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
>>                  sizeof(struct virtio_iommu_config));
>>  
>> +    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_num));
>> +
>>      s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
>>                               virtio_iommu_handle_command);
>>      s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
>> @@ -244,18 +515,43 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
>>  
>>      qemu_mutex_init(&s->mutex);
>> +
>> +    s->as_by_busptr = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>> +
>> +    if (s->primary_bus) {
>> +        pci_setup_iommu(s->primary_bus, virtio_iommu_find_add_as, s);
>> +    } else {
>> +        error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
>> +    }
>>  }
>>  
>>  static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
>>  {
>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
>> +
>> +    g_tree_destroy(s->domains);
>> +    g_tree_destroy(s->endpoints);
>>  
>>      virtio_cleanup(vdev);
>>  }
>>  
>>  static void virtio_iommu_device_reset(VirtIODevice *vdev)
>>  {
>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
>> +
>>      trace_virtio_iommu_device_reset();
>> +
>> +    if (s->domains) {
>> +        g_tree_destroy(s->domains);
>> +    }
>> +    if (s->endpoints) {
>> +        g_tree_destroy(s->endpoints);
>> +    }
> 
> Is it a must to free domians first then the endpoints here?
> 
> I see that virtio_iommu_put_domain() will unlink the domains and
> endpoints, then in virtio_iommu_put_endpoint() you assert that
> ep->domain is NULL.  It's fine but I'm a bit curious on why not call
> virtio_iommu_detach_endpoint_from_domain() too when put the endpoint
> then iiuc we don't even need this ordering constraint.  Though in
> virtio_iommu_detach_endpoint_from_domain() we should also need:

Yes today an EP is meant to be deleted if it is detached from any domain.

I may add virtio_iommu_detach_endpoint_from_domain in put_domain though.

> 
>   if (!ep->domain)
>     return;
> 
> Otherwise it looks good to me.  Thanks,
Thanks

Eric
> 
>> +    s->domains = g_tree_new_full((GCompareDataFunc)int_cmp,
>> +                                 NULL, NULL, virtio_iommu_put_domain);
>> +    s->endpoints = g_tree_new_full((GCompareDataFunc)int_cmp,
>> +                                   NULL, NULL, virtio_iommu_put_endpoint);
>>  }
>>  
>>  static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
>> @@ -301,6 +597,14 @@ static void virtio_iommu_class_init(ObjectClass *klass, void *data)
>>      vdc->vmsd = &vmstate_virtio_iommu_device;
>>  }
>>  
>> +static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>> +                                                  void *data)
>> +{
>> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>> +
>> +    imrc->translate = virtio_iommu_translate;
>> +}
>> +
>>  static const TypeInfo virtio_iommu_info = {
>>      .name = TYPE_VIRTIO_IOMMU,
>>      .parent = TYPE_VIRTIO_DEVICE,
>> @@ -309,9 +613,16 @@ static const TypeInfo virtio_iommu_info = {
>>      .class_init = virtio_iommu_class_init,
>>  };
>>  
>> +static const TypeInfo virtio_iommu_memory_region_info = {
>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>> +    .name = TYPE_VIRTIO_IOMMU_MEMORY_REGION,
>> +    .class_init = virtio_iommu_memory_region_class_init,
>> +};
>> +
>>  static void virtio_register_types(void)
>>  {
>>      type_register_static(&virtio_iommu_info);
>> +    type_register_static(&virtio_iommu_memory_region_info);
>>  }
>>  
>>  type_init(virtio_register_types)
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index 041f2c9390..2a2c2ecf83 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -28,6 +28,8 @@
>>  #define VIRTIO_IOMMU(obj) \
>>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
>>  
>> +#define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
>> +
>>  typedef struct IOMMUDevice {
>>      void         *viommu;
>>      PCIBus       *bus;
>> @@ -48,6 +50,7 @@ typedef struct VirtIOIOMMU {
>>      struct virtio_iommu_config config;
>>      uint64_t features;
>>      GHashTable *as_by_busptr;
>> +    IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>>      PCIBus *primary_bus;
>>      GTree *domains;
>>      QemuMutex mutex;
>> -- 
>> 2.20.1
>>
> 


