Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278A5C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93CD2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT9IF9g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93CD2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyGn-0005d7-0A
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jIyFR-0004CB-B6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jIyFP-0005Em-RO
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:30:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jIyFP-0005E0-Mp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585589451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IV/RlnuWDyVAq/CY6VloTUUQJCsYYqNTqzlcq2lSUms=;
 b=eT9IF9g1Fk3ojHSP5vhUIlbHqdDIwOdO3gaA9k3gV9JJHuoB0D1AJhXHRzYT/6ICDKoM9Q
 4kkcocbvRAgKEMySspRKJG0eiQulkHki2EUmdyTKKbVnOEONptsNnn/1uM1awANKQWuesp
 IvnYkL7xEsB6yX5Ih2lXBBZ8UbLKrXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-BF3CDHVkMCuqbqSNNoh2sA-1; Mon, 30 Mar 2020 13:30:49 -0400
X-MC-Unique: BF3CDHVkMCuqbqSNNoh2sA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7246A1005516;
 Mon, 30 Mar 2020 17:30:47 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6387D5D9E2;
 Mon, 30 Mar 2020 17:30:31 +0000 (UTC)
Subject: Re: [PATCH v2 06/22] hw/pci: introduce
 pci_device_set/unset_iommu_context()
To: Liu Yi L <yi.l.liu@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, peterx@redhat.com
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-7-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <01381db5-6f5f-8022-6891-e1a8dd7c3e65@redhat.com>
Date: Mon, 30 Mar 2020 19:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-7-git-send-email-yi.l.liu@intel.com>
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
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com, yi.y.sun@intel.com,
 pbonzini@redhat.com, hao.wu@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yi,
On 3/30/20 6:24 AM, Liu Yi L wrote:
> This patch adds pci_device_set/unset_iommu_context() to set/unset
> host_iommu_context for a given device. New callback is added in
> PCIIOMMUOps. As such, vIOMMU could make use of host IOMMU capability.
> e.g setup nested translation.

I think you need to explain what this practically is supposed to do.
such as: by attaching such context to a PCI device (for example VFIO
assigned?), you tell the host that this PCIe device is protected by a FL
stage controlled by the guest or something like that - if this is
correct understanding (?) -
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/pci/pci.c         | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
>  include/hw/pci/pci.h | 10 ++++++++++
>  2 files changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index aa9025c..af3c1a1 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2638,7 +2638,8 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>      }
>  }
>  
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> +                              PCIBus **pbus, uint8_t *pdevfn)
>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
> @@ -2683,14 +2684,52 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  
>          iommu_bus = parent_bus;
>      }
> -    if (iommu_bus && iommu_bus->iommu_ops &&
> -                     iommu_bus->iommu_ops->get_address_space) {
> -        return iommu_bus->iommu_ops->get_address_space(bus,
> -                                 iommu_bus->iommu_opaque, devfn);
> +    *pbus = iommu_bus;
> +    *pdevfn = devfn;
> +}
> +
> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &devfn);
> +    if (bus && bus->iommu_ops &&
> +        bus->iommu_ops->get_address_space) {
> +        return bus->iommu_ops->get_address_space(bus,
> +                                bus->iommu_opaque, devfn);
>      }
>      return &address_space_memory;
>  }
>  
> +int pci_device_set_iommu_context(PCIDevice *dev,
> +                                 HostIOMMUContext *iommu_ctx)
> +{
> +    PCIBus *bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &devfn);
> +    if (bus && bus->iommu_ops &&
> +        bus->iommu_ops->set_iommu_context) {
> +        return bus->iommu_ops->set_iommu_context(bus,
> +                              bus->iommu_opaque, devfn, iommu_ctx);
> +    }
> +    return -ENOENT;
> +}
> +
> +void pci_device_unset_iommu_context(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &devfn);
> +    if (bus && bus->iommu_ops &&
> +        bus->iommu_ops->unset_iommu_context) {
> +        bus->iommu_ops->unset_iommu_context(bus,
> +                                 bus->iommu_opaque, devfn);
> +    }
> +}
> +
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>  {
>      bus->iommu_ops = ops;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index ffe192d..0ec5680 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -9,6 +9,8 @@
>  
>  #include "hw/pci/pcie.h"
>  
> +#include "hw/iommu/host_iommu_context.h"
> +
>  extern bool pci_available;
>  
>  /* PCI bus */
> @@ -489,9 +491,17 @@ typedef struct PCIIOMMUOps PCIIOMMUOps;
>  struct PCIIOMMUOps {
>      AddressSpace * (*get_address_space)(PCIBus *bus,
>                                  void *opaque, int32_t devfn);
> +    int (*set_iommu_context)(PCIBus *bus, void *opaque,
> +                             int32_t devfn,
> +                             HostIOMMUContext *iommu_ctx);
> +    void (*unset_iommu_context)(PCIBus *bus, void *opaque,
> +                                int32_t devfn);
>  };
>  
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +int pci_device_set_iommu_context(PCIDevice *dev,
> +                                 HostIOMMUContext *iommu_ctx);
> +void pci_device_unset_iommu_context(PCIDevice *dev);
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
>  
>  static inline void
> 
Thanks

Eric


