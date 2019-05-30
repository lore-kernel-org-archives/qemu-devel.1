Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE8C072B1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4355F2541F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="VH15R3ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4355F2541F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWDu8-0004q9-HF
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 01:47:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hWDqh-0002Eb-Nl
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hWDqf-0000Ja-Rt
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:43:35 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hWDqf-0000Em-9F
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:43:33 -0400
Received: by mail-pg1-x544.google.com with SMTP id h17so1338798pgv.0
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 22:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dDxKXo/1zwCOhT99jMg4R3l6P+TOLO8YBfYp4+0Ua9w=;
	b=VH15R3ZJOOI9KPT9f87YZn0NQ2KX0CkexKjis3oB/xwhOO/TRLpY3Aub4wrtU284l7
	mNOPCj3De8Lv2MehdMBs38bGghM/ehntXAO2rM8LgGVfMAJaycXlGc2R5NhIIFIgCKjR
	kDZcv1t7kGOK9DrCnwgeOkmkhEWYV8sGWK1gK3qnN5CC2i3Q8h4YV8tRGCT7TDe4ICGB
	jrLo69KFgq/4VwGG4fLGiFZqVFalU4Pw1I5i6l6pHRVjaif1OjQK48ehdpWuOOLltjgx
	q+7MgIVJ4fRiTAWaCELY71MjFTdkQ0IzrAdXHEpdaUjhzlifhO0KxKAkwMrE69thWtGL
	Zpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=dDxKXo/1zwCOhT99jMg4R3l6P+TOLO8YBfYp4+0Ua9w=;
	b=bcknZIzDVCq1m0OpPrF18JCNjvymizdYwq1chZcL0Xwl7FSm7NcIE0yNEW4OAKDLKx
	5FQwHB9pf7x0Ncbza9xXDMQ+yierjJu3VOKLsPXa+RqxxwW/VLre4U+mNY7JS6K+EvQr
	4mFUx9e9WDum1lgacpNnGCYfDW3p6zA9cQ6Bh8LcxXqJGAmqdip4nkytWYn3JSqZ7n4L
	8vN4Yb7rrO78v5QNQJyDMub+r+SzwmJwLIkY5KZL7ZjfLHCeFq70O0Ud/IyUf3yaX287
	kLAyvMz0JitSIVd4q44O6TAKDyteanM03aQz2MA4O58xlCv39H5/bWnz/N0K2rtcowFS
	0XHA==
X-Gm-Message-State: APjAAAUOuY0ciaK1qEBX+i4PyUCFarB2WhjQ9pSi0eKfqELmoeCTERoc
	6da5ckU2ptnd53q1cThgHpa3ZA==
X-Google-Smtp-Source: APXvYqw+xDTQugPHv+Uo/c/mXtcB7eBGDrVbSKpCiSw2Eup0N1Rv2j/C4/uJZgGh7qpshAE+ncdzBg==
X-Received: by 2002:a17:90a:cb82:: with SMTP id
	a2mr2100125pju.80.1559195011801; 
	Wed, 29 May 2019 22:43:31 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	m101sm2323053pjb.2.2019.05.29.22.43.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 22:43:31 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190523052918.1129-3-david@gibson.dropbear.id.au>
	<5d839aa6-5308-2612-05fb-2ba446b293d7@ozlabs.ru>
	<20190530053316.GF2017@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
	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
Message-ID: <3e0e0805-42ac-5fcd-012a-e428bafbec16@ozlabs.ru>
Date: Thu, 30 May 2019 15:43:26 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530053316.GF2017@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/8] spapr: Clean up dt creation
 for PCI buses
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
Cc: mst@redhat.com, groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	clg@kaod.org, mdroth@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 30/05/2019 15:33, David Gibson wrote:
> On Fri, May 24, 2019 at 03:31:54PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 23/05/2019 15:29, David Gibson wrote:
>>> Device nodes for PCI bridges (both host and P2P) describe both the bridge
>>> device itself and the bus hanging off it, handling of this is a bit of a
>>> mess.
>>>
>>> spapr_dt_pci_device() has a few things it only adds for non-bridges, but
>>> always adds #address-cells and #size-cells which should only appear for
>>> bridges.  But the walking down the subordinate PCI bus is done in one of
>>> its callers spapr_populate_pci_devices_dt().  The PHB dt creation in
>>> spapr_populate_pci_dt() open codes some similar logic to the bridge case.
>>>
>>> This patch consolidates things in a bunch of ways:
>>>  * Bus specific dt info is now created in spapr_dt_pci_bus() used for both
>>>    P2P bridges and the host bridge.  This includes walking subordinate
>>>    devices
>>>  * spapr_dt_pci_device() now calls spapr_dt_pci_bus() when called on a
>>>    P2P bridge
>>>  * We do detection of bridges with the is_bridge field of the device class,
>>>    rather than checking PCI config space directly, for consistency with
>>>    qemu's core PCI code.
>>>  * Several things are renamed for brevity and clarity
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  hw/ppc/spapr.c              |   7 +-
>>>  hw/ppc/spapr_pci.c          | 140 +++++++++++++++++++-----------------
>>>  include/hw/pci-host/spapr.h |   4 +-
>>>  3 files changed, 79 insertions(+), 72 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index e2b33e5890..44573adce7 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -1309,8 +1309,7 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
>>>      }
>>>  
>>>      QLIST_FOREACH(phb, &spapr->phbs, list) {
>>> -        ret = spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
>>> -                                    spapr->irq->nr_msis, NULL);
>>> +        ret = spapr_dt_phb(phb, PHANDLE_INTC, fdt, spapr->irq->nr_msis, NULL);
>>>          if (ret < 0) {
>>>              error_report("couldn't setup PCI devices in fdt");
>>>              exit(1);
>>> @@ -3917,8 +3916,8 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>>>          return -1;
>>>      }
>>>  
>>> -    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
>>> -                              fdt_start_offset)) {
>>> +    if (spapr_dt_phb(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
>>> +                     fdt_start_offset)) {
>>>          error_setg(errp, "unable to create FDT node for PHB %d", sphb->index);
>>>          return -1;
>>>      }
>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>> index 4075b433fd..c166df4145 100644
>>> --- a/hw/ppc/spapr_pci.c
>>> +++ b/hw/ppc/spapr_pci.c
>>> @@ -1219,6 +1219,60 @@ static const char *dt_name_from_class(uint8_t class, uint8_t subclass,
>>>  static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
>>>                                              PCIDevice *pdev);
>>>  
>>> +typedef struct PciWalkFdt {
>>> +    void *fdt;
>>> +    int offset;
>>> +    SpaprPhbState *sphb;
>>> +    int err;
>>> +} PciWalkFdt;
>>> +
>>> +static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
>>> +                               void *fdt, int parent_offset);
>>> +
>>> +static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
>>> +                                   void *opaque)
>>> +{
>>> +    PciWalkFdt *p = opaque;
>>> +    int err;
>>> +
>>> +    if (p->err) {
>>> +        /* Something's already broken, don't keep going */
>>> +        return;
>>> +    }
>>> +
>>> +    err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
>>> +    if (err < 0) {
>>> +        p->err = err;
>>> +    }
>>> +}
>>> +
>>> +/* Augment PCI device node with bridge specific information */
>>> +static int spapr_dt_pci_bus(SpaprPhbState *sphb, PCIBus *bus,
>>> +                               void *fdt, int offset)
>>> +{
>>> +    PciWalkFdt cbinfo = {
>>> +        .fdt = fdt,
>>> +        .offset = offset,
>>> +        .sphb = sphb,
>>> +        .err = 0,
>>> +    };
>>> +
>>> +    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells",
>>> +                          RESOURCE_CELLS_ADDRESS));
>>> +    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
>>> +                          RESOURCE_CELLS_SIZE));
>>> +
>>> +    if (bus) {
>>> +        pci_for_each_device_reverse(bus, pci_bus_num(bus),
>>> +                                    spapr_dt_pci_device_cb, &cbinfo);
>>> +        if (cbinfo.err) {
>>> +            return cbinfo.err;
>>> +        }
>>> +    }
>>> +
>>> +    return offset;
>>
>>
>> This spapr_dt_pci_bus() returns 0 or an offset or an error.
>>
>> But:
>> spapr_dt_phb() returns 0 or error; and so does spapr_dt_drc().
>>
>> Not extremely consistent.
> 
> No, it's not.  But the inconsistency is already there between the
> device function which needs to return an offset and the PHB function
> and others which don't.
> 
> I have some ideas for how to clean this up, along with a bunch of
> other dt creation stuff, but I don't think it's reasonably in scope
> for this series.
> 
>> It looks like spapr_dt_pci_bus() does not need to return @offset as it
>> does not change it and the caller - spapr_dt_pci_device() - can have 1
>> "return offset" in the end.
> 
> True, but changing this here just shuffles the inconsistency around
> without really improving it.  I've put cleaning this up more widely on
> my list of things to tackle when I have time.
> 
>>
>>
>>> +}
>>> +
>>>  /* create OF node for pci device and required OF DT properties */
>>>  static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
>>>                                 void *fdt, int parent_offset)
>>> @@ -1228,10 +1282,9 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
>>>      char *nodename;
>>>      int slot = PCI_SLOT(dev->devfn);
>>>      int func = PCI_FUNC(dev->devfn);
>>> +    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
>>>      ResourceProps rp;
>>>      uint32_t drc_index = spapr_phb_get_pci_drc_index(sphb, dev);
>>> -    uint32_t header_type = pci_default_read_config(dev, PCI_HEADER_TYPE, 1);
>>> -    bool is_bridge = (header_type == PCI_HEADER_TYPE_BRIDGE);
>>>      uint32_t vendor_id = pci_default_read_config(dev, PCI_VENDOR_ID, 2);
>>>      uint32_t device_id = pci_default_read_config(dev, PCI_DEVICE_ID, 2);
>>>      uint32_t revision_id = pci_default_read_config(dev, PCI_REVISION_ID, 1);
>>> @@ -1268,13 +1321,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
>>>          _FDT(fdt_setprop_cell(fdt, offset, "interrupts", irq_pin));
>>>      }
>>>  
>>> -    if (!is_bridge) {
>>> -        uint32_t min_grant = pci_default_read_config(dev, PCI_MIN_GNT, 1);
>>> -        uint32_t max_latency = pci_default_read_config(dev, PCI_MAX_LAT, 1);
>>> -        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
>>> -        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latency));
>>> -    }
>>> -
>>>      if (subsystem_id) {
>>>          _FDT(fdt_setprop_cell(fdt, offset, "subsystem-id", subsystem_id));
>>>      }
>>> @@ -1309,11 +1355,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
>>>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index));
>>>      }
>>>  
>>> -    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells",
>>> -                          RESOURCE_CELLS_ADDRESS));
>>> -    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
>>> -                          RESOURCE_CELLS_SIZE));
>>> -
>>>      if (msi_present(dev)) {
>>>          uint32_t max_msi = msi_nr_vectors_allocated(dev);
>>>          if (max_msi) {
>>> @@ -1338,7 +1379,18 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
>>>  
>>>      spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
>>>  
>>> -    return offset;
>>> +    if (!pc->is_bridge) {
>>> +        /* Properties only for non-bridges */
>>> +        uint32_t min_grant = pci_default_read_config(dev, PCI_MIN_GNT, 1);
>>> +        uint32_t max_latency = pci_default_read_config(dev, PCI_MAX_LAT, 1);
>>> +        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
>>> +        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latency));
>>> +        return offset;
>>> +    } else {
>>> +        PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
>>> +
>>> +        return spapr_dt_pci_bus(sphb, sec_bus, fdt, offset);
>>> +    }
>>>  }
>>>  
>>>  /* Callback to be called during DRC release. */
>>> @@ -2063,44 +2115,6 @@ static const TypeInfo spapr_phb_info = {
>>>      }
>>>  };
>>>  
>>> -typedef struct SpaprFdt {
>>> -    void *fdt;
>>> -    int node_off;
>>> -    SpaprPhbState *sphb;
>>> -} SpaprFdt;
>>> -
>>> -static void spapr_populate_pci_devices_dt(PCIBus *bus, PCIDevice *pdev,
>>> -                                          void *opaque)
>>> -{
>>> -    PCIBus *sec_bus;
>>> -    SpaprFdt *p = opaque;
>>> -    int offset;
>>> -    SpaprFdt s_fdt;
>>> -
>>> -    offset = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->node_off);
>>> -    if (!offset) {
>>> -        error_report("Failed to create pci child device tree node");
>>> -        return;
>>> -    }
>>> -
>>> -    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=
>>> -         PCI_HEADER_TYPE_BRIDGE)) {
>>> -        return;
>>> -    }
>>> -
>>> -    sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>>> -    if (!sec_bus) {
>>> -        return;
>>> -    }
>>> -
>>> -    s_fdt.fdt = p->fdt;
>>> -    s_fdt.node_off = offset;
>>> -    s_fdt.sphb = p->sphb;
>>> -    pci_for_each_device_reverse(sec_bus, pci_bus_num(sec_bus),
>>> -                                spapr_populate_pci_devices_dt,
>>> -                                &s_fdt);
>>> -}
>>> -
>>>  static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>>>                                             void *opaque)
>>>  {
>>> @@ -2138,8 +2152,8 @@ static void spapr_phb_pci_enumerate(SpaprPhbState *phb)
>>>  
>>>  }
>>>  
>>> -int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>>> -                          uint32_t nr_msis, int *node_offset)
>>> +int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>>> +                 uint32_t nr_msis, int *node_offset)
>>>  {
>>>      int bus_off, i, j, ret;
>>>      uint32_t bus_range[] = { cpu_to_be32(0), cpu_to_be32(0xff) };
>>> @@ -2186,8 +2200,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>>>                                  cpu_to_be32(0x0),
>>>                                  cpu_to_be32(phb->numa_node)};
>>>      SpaprTceTable *tcet;
>>> -    PCIBus *bus = PCI_HOST_BRIDGE(phb)->bus;
>>> -    SpaprFdt s_fdt;
>>>      SpaprDrc *drc;
>>>      Error *errp = NULL;
>>>  
>>> @@ -2200,8 +2212,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>>>      /* Write PHB properties */
>>>      _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
>>>      _FDT(fdt_setprop_string(fdt, bus_off, "compatible", "IBM,Logical_PHB"));
>>> -    _FDT(fdt_setprop_cell(fdt, bus_off, "#address-cells", 0x3));
>>> -    _FDT(fdt_setprop_cell(fdt, bus_off, "#size-cells", 0x2));
>>>      _FDT(fdt_setprop_cell(fdt, bus_off, "#interrupt-cells", 0x1));
>>>      _FDT(fdt_setprop(fdt, bus_off, "used-by-rtas", NULL, 0));
>>>      _FDT(fdt_setprop(fdt, bus_off, "bus-range", &bus_range, sizeof(bus_range)));
>>> @@ -2266,13 +2276,11 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>>>      spapr_phb_pci_enumerate(phb);
>>>      _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
>>>  
>>> -    /* Populate tree nodes with PCI devices attached */
>>> -    s_fdt.fdt = fdt;
>>> -    s_fdt.node_off = bus_off;
>>> -    s_fdt.sphb = phb;
>>> -    pci_for_each_device_reverse(bus, pci_bus_num(bus),
>>> -                                spapr_populate_pci_devices_dt,
>>> -                                &s_fdt);
>>> +    /* Walk the bridge and subordinate buses */
>>> +    ret = spapr_dt_pci_bus(phb, PCI_HOST_BRIDGE(phb)->bus, fdt, bus_off);
>>> +    if (ret) {
>>
>>
>> if (ret < 0)
>>
>> otherwise it returns prematurely and NVLink stuff does not make it to
>> the FDT.
>>
>>
>> Otherwise the whole patchset is a good cleanup and seems working fine.


Just to double check you have not missed this bit :)



-- 
Alexey

