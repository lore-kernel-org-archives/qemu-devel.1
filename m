Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13264C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDB0206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="DQRAJNqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDB0206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40487 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuZk-0006K8-Aa
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:43:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJuXH-0004kH-Nj
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJuXF-0002Mc-P3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:40:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hJuXD-0002CT-St
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:40:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id f36so1050493plb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ybV9kHf5pGdkpLbZ9xOAuFpezDKIa4EDuAjGApnx/xA=;
	b=DQRAJNqTjn/XdX2e4q21UXu3hLwFQZWsz3e89zEiyT2wB6Q+BMSPxDKorGqsPqkIHf
	gyZhn9i+k/4Nr2JSL3det3L/rFY/t8SYYiFxKU7hqtJYHQS/2dLm4CUbXDd+FFL4Z040
	zVRRzML+kh89dO5H/0pkG2kWLp8bIqVOF6nAJDgLSnxmGKVkpAu/iaBR2F3C4mW9iIF7
	KXN/mXf3Us/9cX/JHfGOwZADctCFH4yDpahzKG5Pw1PyK975FO+Qyy5debBdMMW/i2oF
	wpT20ahYGo+3YRx+mCL9AErY6t/auAA9okJOgfp2MXBQY/7IAEke+SddaTYHnsDcSCO7
	+teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=ybV9kHf5pGdkpLbZ9xOAuFpezDKIa4EDuAjGApnx/xA=;
	b=nH6WoMqDgs8yjYRvQBtpXT+a+30BooA2ZUI35FHdH8lONFcGyMW2g+67TFnaIJ8lpD
	tVzpJeZKg+1oIQmzJoxtIuDMj+VpFM+H5y0f/dCqcOyKdE2TSWCwTwSBvdEEq+JLKps6
	xiFB20ZEsJPOUViAy4KwKqsYzFxZKzm7bjPX1fTg/iVK0fJY1RO7B60l7LdZ+/HBj4w3
	U3FscwOJtgXMB/+Pr0jNGyavYToAqzmxmirCr0jjoC4o5Ja8/OPln+A5Lrh7djAGv+rs
	xC5aEkoXtAUVfwzfi2sFZ1szqwNLrzZeplKpGD9fzVMG+mdcB+mIceERJF1lqs26325C
	nPvg==
X-Gm-Message-State: APjAAAXVuvYMX4kVfT/CP7P+CMMWScl7hsTlJbrEFP+RUwp3aHjI+/eD
	nMP+qskTHqDQ1Xp6A87CBJZKnA==
X-Google-Smtp-Source: APXvYqxnEPH2CmefjjLJYcrAy4hlw4onbAkS9x3QUoQDBOuIXNuibWNsJbjkdGLHUPjW6NMopCKa3Q==
X-Received: by 2002:a17:902:e48b:: with SMTP id
	cj11mr1792119plb.223.1556260823805; 
	Thu, 25 Apr 2019 23:40:23 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	e11sm10056656pfd.151.2019.04.25.23.40.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 23:40:22 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, Greg Kurz <groug@kaod.org>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
	<20190424041959.4087-4-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
	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
Message-ID: <0890a0ab-e176-5549-1ec9-98c00a9c8026@ozlabs.ru>
Date: Fri, 26 Apr 2019 16:40:17 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424041959.4087-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/3] pcie: Simplify
 pci_adjust_config_limit()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426064017.vjRgq7VI8Up9PxbPC6p6XGJwCehgJOXf0DhI_149ey4@z>



On 24/04/2019 14:19, David Gibson wrote:
> Since c2077e2c "pci: Adjust PCI config limit based on bus topology",
> pci_adjust_config_limit() has been used in the config space read and write
> paths to only permit access to extended config space on buses which permit
> it.  Specifically it prevents access on devices below a vanilla-PCI bus via
> some combination of bridges, even if both the host bridge and the device
> itself are PCI-E.
> 
> It accomplishes this with a somewhat complex call up the chain of bridges
> to see if any of them prohibit extended config space access.  This is
> overly complex, since we can always know if the bus will support such
> access at the point it is constructed.
> 
> This patch simplifies the test by using a flag in the PCIBus instance
> indicating whether extended configuration space is accessible.  It is
> false for vanilla PCI buses.  For PCI-E buses, it is true for root
> buses and equal to the parent bus's's capability otherwise.
> 
> For the special case of sPAPR's paravirtualized PCI root bus, which
> acts mostly like vanilla PCI, but does allow extended config space
> access, we override the default value of the flag from the host bridge
> code.
> 
> This should cause no behavioural change.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>cd
> ---
>  hw/pci/pci.c             | 41 ++++++++++++++++++++++------------------
>  hw/pci/pci_host.c        | 13 +++----------
>  hw/ppc/spapr_pci.c       | 34 ++++++++++-----------------------
>  include/hw/pci/pci.h     |  1 -
>  include/hw/pci/pci_bus.h |  9 ++++++++-
>  5 files changed, 44 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index ea5941fb22..59ee034331 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -120,6 +120,27 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
>  }
>  
> +static void pcie_bus_realize(BusState *qbus, Error **errp)
> +{
> +    PCIBus *bus = PCI_BUS(qbus);
> +
> +    pci_bus_realize(qbus, errp);
> +
> +    /*
> +     * A PCI-E bus can support extended config space if it's the root
> +     * bus, or if the bus/bridge above it does as well
> +     */
> +    if (pci_bus_is_root(bus)) {
> +        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +    } else {
> +        PCIBus *parent_bus = pci_get_bus(bus->parent_dev);


g_assert(bus->parent_dev) ?

Slightly confusingly bus->parent_dev is not the same as bus->qbus.parent
and can be NULL, I'd even look into ditching parent_dev and using
bus->qbus.parent instead (if possible).


> +
> +        if (pci_bus_allows_extended_config_space(parent_bus)) {
> +            bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +        }
> +    }
> +}
> +
>  static void pci_bus_unrealize(BusState *qbus, Error **errp)
>  {
>      PCIBus *bus = PCI_BUS(qbus);
> @@ -142,11 +163,6 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
>      return NUMA_NODE_UNASSIGNED;
>  }
>  
> -static bool pcibus_allows_extended_config_space(PCIBus *bus)
> -{
> -    return false;
> -}
> -
>  static void pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
> @@ -161,7 +177,6 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
>  
>      pbc->bus_num = pcibus_num;
>      pbc->numa_node = pcibus_numa_node;
> -    pbc->allows_extended_config_space = pcibus_allows_extended_config_space;
>  }
>  
>  static const TypeInfo pci_bus_info = {
> @@ -182,16 +197,11 @@ static const TypeInfo conventional_pci_interface_info = {
>      .parent        = TYPE_INTERFACE,
>  };
>  
> -static bool pciebus_allows_extended_config_space(PCIBus *bus)
> -{
> -    return true;
> -}
> -
>  static void pcie_bus_class_init(ObjectClass *klass, void *data)
>  {
> -    PCIBusClass *pbc = PCI_BUS_CLASS(klass);
> +    BusClass *k = BUS_CLASS(klass);
>  
> -    pbc->allows_extended_config_space = pciebus_allows_extended_config_space;
> +    k->realize = pcie_bus_realize;
>  }
>  
>  static const TypeInfo pcie_bus_info = {
> @@ -410,11 +420,6 @@ bool pci_bus_is_express(PCIBus *bus)
>      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
>  }
>  
> -bool pci_bus_allows_extended_config_space(PCIBus *bus)
> -{
> -    return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
> -}
> -
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                const char *name,
>                                MemoryRegion *address_space_mem,
> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index 9d64b2e12f..5f3497256c 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -53,16 +53,9 @@ static inline PCIDevice *pci_dev_find_by_addr(PCIBus *bus, uint32_t addr)
>  
>  static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
>  {
> -    if (*limit > PCI_CONFIG_SPACE_SIZE) {
> -        if (!pci_bus_allows_extended_config_space(bus)) {
> -            *limit = PCI_CONFIG_SPACE_SIZE;
> -            return;
> -        }
> -
> -        if (!pci_bus_is_root(bus)) {
> -            PCIDevice *bridge = pci_bridge_get_device(bus);
> -            pci_adjust_config_limit(pci_get_bus(bridge), limit);
> -        }
> +    if ((*limit > PCI_CONFIG_SPACE_SIZE) &&
> +        !pci_bus_allows_extended_config_space(bus)) {
> +        *limit = PCI_CONFIG_SPACE_SIZE;
>      }
>  }
>  
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index f62e6833b8..65a86be29c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1638,28 +1638,6 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
>      memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
>  }
>  
> -static bool spapr_phb_allows_extended_config_space(PCIBus *bus)
> -{
> -    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(BUS(bus)->parent);
> -
> -    return sphb->pcie_ecs;
> -}
> -
> -static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data)
> -{
> -    PCIBusClass *pbc = PCI_BUS_CLASS(klass);
> -
> -    pbc->allows_extended_config_space = spapr_phb_allows_extended_config_space;
> -}
> -
> -#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
> -
> -static const TypeInfo spapr_phb_root_bus_info = {
> -    .name = TYPE_SPAPR_PHB_ROOT_BUS,
> -    .parent = TYPE_PCI_BUS,
> -    .class_init = spapr_phb_root_bus_class_init,
> -};
> -
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
> @@ -1765,7 +1743,16 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>                                  pci_spapr_set_irq, pci_spapr_map_irq, sphb,
>                                  &sphb->memspace, &sphb->iospace,
>                                  PCI_DEVFN(0, 0), PCI_NUM_PINS,
> -                                TYPE_SPAPR_PHB_ROOT_BUS);
> +                                TYPE_PCI_BUS);
> +
> +    /*
> +     * Despite resembling a vanilla PCI bus in most ways, the PAPR
> +     * para-virtualized PCI bus *does* permit PCI-E extended config
> +     * space access
> +     */
> +    if (sphb->pcie_ecs) {
> +        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +    }
>      phb->bus = bus;
>      qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
>  
> @@ -2348,7 +2335,6 @@ void spapr_pci_rtas_init(void)
>  static void spapr_pci_register_types(void)
>  {
>      type_register_static(&spapr_phb_info);
> -    type_register_static(&spapr_phb_root_bus_info);
>  }
>  
>  type_init(spapr_pci_register_types)
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 33ccce320c..0edfaabbb0 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -395,7 +395,6 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
>  #define TYPE_PCIE_BUS "PCIE"
>  
>  bool pci_bus_is_express(PCIBus *bus);
> -bool pci_bus_allows_extended_config_space(PCIBus *bus);
>  
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                const char *name,
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index aea98d5040..2d5f74b7c1 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -17,12 +17,13 @@ typedef struct PCIBusClass {
>  
>      int (*bus_num)(PCIBus *bus);
>      uint16_t (*numa_node)(PCIBus *bus);
> -    bool (*allows_extended_config_space)(PCIBus *bus);
>  } PCIBusClass;
>  
>  enum PCIBusFlags {
>      /* This bus is the root of a PCI domain */
>      PCI_BUS_IS_ROOT                                         = 0x0001,
> +    /* PCIe extended configuration space is accessible on this bus */
> +    PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
>  };
>  
>  struct PCIBus {
> @@ -57,4 +58,10 @@ static inline bool pci_bus_is_root(PCIBus *bus)
>      return !!(bus->flags & PCI_BUS_IS_ROOT);
>  }
>  
> +static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
> +{
> +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> +}
> +
> +

An extra empty line.

Anyway, these are minor comments, so

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




>  #endif /* QEMU_PCI_BUS_H */
> 

-- 
Alexey

