Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACFDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECC420768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX+i6vvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECC420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyakl-0001Jg-R4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyaia-00064n-Kk
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:53:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyaiY-0007Uv-MS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJH9AvqDzu/jXmnglcLp11VTPlV2kAigSZWFXUTe+4s=;
 b=dX+i6vvcIbdUpcH9XWJlX0Qs/pie+eOQIkHOODSBZ+AJfIU3gG5SG/1gFRbiuy2Bqx/C+D
 jeC1tGJaT9CP5R/pUpWR/SGoCxUCAWvbhx2nUZjvkWtuQ+9I9en4o348CLuF9PloHRlXSL
 COfOr49XWbt1l40L/Yk9xGDCnCcKKDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-HEuVD0NMNfGDRs_-Y0VJhQ-1; Thu, 23 Jul 2020 08:52:53 -0400
X-MC-Unique: HEuVD0NMNfGDRs_-Y0VJhQ-1
Received: by mail-wr1-f71.google.com with SMTP id z1so1371025wrn.18
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vJH9AvqDzu/jXmnglcLp11VTPlV2kAigSZWFXUTe+4s=;
 b=hg8GoTjOq/Ulqxso+6OGCD2QKqH4y/ivHYPOf2uJ5Va895Nw2LpoyiGs+BDOhyxCel
 yeQXvlE/fD3ZQklBT4OkBVCT3B0AqB8qvNfQdeFGwehLy0px4AY3oqFjocuTQAifv/0f
 UfOM/JbdZ1RQejyWvUXH1jggeQmpYYCi+bLiNEHp5UjKMjNrso4xwR42fUZFWFthc2vb
 SwSVxj2i1jVqW1GVWLp1m7VYKZTLfWhO/TYCfC8Fdj81+uommdT0QY9VtCPLAFyAu05S
 Kz5ANB/Trs56qLZU6Rjt0/KRN9JnIKQRfSG7nSfTxKVFWlAtj2dOHD9k0XYKkP2sSFwM
 12bA==
X-Gm-Message-State: AOAM533aysHAIqVswojqSHKI6CqWWJAO73KEDUoxA3n6blSQUIpTNCtj
 WywhavDS7xB/oCbgHum9RhIISz+3XFknM2tkt1hspgZcCQFhgCrbWhme5JKufXaAqS13UUkML9o
 neHaB8+XGz6FCFXs=
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr3972048wmu.188.1595508772496; 
 Thu, 23 Jul 2020 05:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjSraZfsSjovHcnkA/aMH7G0K5Itx8iUzH1sKiDdt92n50bY/iHcxxL6MBeBBz+MrlX5o4VQ==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr3972014wmu.188.1595508772134; 
 Thu, 23 Jul 2020 05:52:52 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id i8sm1939863wro.34.2020.07.23.05.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 05:52:50 -0700 (PDT)
Date: Thu, 23 Jul 2020 08:52:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH] hw/pci-host: save/restore pci host config register
Message-ID: <20200723085213-mutt-send-email-mst@kernel.org>
References: <20200723104935.2286-1-king.wang@huawei.com>
 <164f2048-107d-3980-3387-6bf8987ee3f3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <164f2048-107d-3980-3387-6bf8987ee3f3@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com,
 Wang King <king.wang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 01:48:47PM +0200, Laszlo Ersek wrote:
> On 07/23/20 12:49, Wang King wrote:
> > From: Hogan Wang <king.wang@huawei.com>
> > 
> > The pci host config register is used to save PCI address for
> > read/write config data. If guest write a value to config register,
> > and then pause the vcpu to migrate, After the migration, the guest
> > continue to write pci config data, and the write data will be ignored
> > because of new qemu process lost the config register state.
> > 
> > Example:
> > 1. guest booting in seabios.
> > 2. guest enabled the SMM memory window in piix4_apmc_smm_setup, and
> > then try to close the SMM memory window.
> > 3. pasued vcpu to finish migration.
> > 4. guest close the SMM memory window fail becasue of config register
> > state lost.
> > 5. guest continue to boot and crash in ipxe option ROM (SMM memory
> > window is enabled).
> > 
> > Due to the complex guest, the negative effect is unpredictable.

Is there a way to build a unit test for this btw?
That would be great ...


> > ---
> >  hw/pci-host/i440fx.c       | 11 +++++++++++
> >  hw/pci-host/q35.c          | 11 +++++++++++
> >  hw/pci/pci_host.c          | 11 +++++++++++
> >  hw/pci/pcie_host.c         | 11 +++++++++++
> >  include/hw/pci/pci_host.h  | 10 ++++++++++
> >  include/hw/pci/pcie_host.h | 10 ++++++++++
> >  6 files changed, 64 insertions(+)
> > 
> > diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> > index 8ed2417f0c..17705bb025 100644
> > --- a/hw/pci-host/i440fx.c
> > +++ b/hw/pci-host/i440fx.c
> > @@ -118,6 +118,16 @@ static const VMStateDescription vmstate_i440fx = {
> >      }
> >  };
> >  
> > +static const VMStateDescription vmstate_i440fx_pcihost = {
> > +    .name = "I440FX_PCIHost",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_PCI_HOST(parent_obj, I440FXState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
> >                                                const char *name, void *opaque,
> >                                                Error **errp)
> > @@ -398,6 +408,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
> >      hc->root_bus_path = i440fx_pcihost_root_bus_path;
> >      dc->realize = i440fx_pcihost_realize;
> >      dc->fw_name = "pci";
> > +    dc->vmsd = &vmstate_i440fx_pcihost;
> >      device_class_set_props(dc, i440fx_props);
> >      /* Reason: needs to be wired up by pc_init1 */
> >      dc->user_creatable = false;
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index b67cb9c29f..5e323be2e3 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -165,6 +165,16 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
> >      visit_type_uint64(v, name, &value, errp);
> >  }
> >  
> > +static const VMStateDescription vmstate_q35_pcihost = {
> > +    .name = "Q35_PCIHost",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_PCIE_HOST(parent_obj, Q35PCIHost),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  /*
> >   * NOTE: setting defaults for the mch.* fields in this table
> >   * doesn't work, because mch is a separate QOM object that is
> > @@ -194,6 +204,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
> >  
> >      hc->root_bus_path = q35_host_root_bus_path;
> >      dc->realize = q35_host_realize;
> > +    dc->vmsd = &vmstate_q35_pcihost;
> >      device_class_set_props(dc, q35_host_props);
> >      /* Reason: needs to be wired up by pc_q35_init */
> >      dc->user_creatable = false;
> > diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> > index ce7bcdb1d5..7cdd5a3ea3 100644
> > --- a/hw/pci/pci_host.c
> > +++ b/hw/pci/pci_host.c
> > @@ -24,6 +24,7 @@
> >  #include "hw/pci/pci_host.h"
> >  #include "qemu/module.h"
> >  #include "hw/pci/pci_bus.h"
> > +#include "migration/vmstate.h"
> >  #include "trace.h"
> >  
> >  /* debug PCI */
> > @@ -200,6 +201,16 @@ const MemoryRegionOps pci_host_data_be_ops = {
> >      .endianness = DEVICE_BIG_ENDIAN,
> >  };
> >  
> > +const VMStateDescription vmstate_pcihost = {
> > +    .name = "PCIHost",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT32(config_reg, PCIHostState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const TypeInfo pci_host_type_info = {
> >      .name = TYPE_PCI_HOST_BRIDGE,
> >      .parent = TYPE_SYS_BUS_DEVICE,
> > diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
> > index 3534006f99..a653c39bb7 100644
> > --- a/hw/pci/pcie_host.c
> > +++ b/hw/pci/pcie_host.c
> > @@ -24,6 +24,7 @@
> >  #include "hw/pci/pcie_host.h"
> >  #include "qemu/module.h"
> >  #include "exec/address-spaces.h"
> > +#include "migration/vmstate.h"
> >  
> >  /* a helper function to get a PCIDevice for a given mmconfig address */
> >  static inline PCIDevice *pcie_dev_find_by_mmcfg_addr(PCIBus *s,
> > @@ -121,6 +122,16 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
> >      memory_region_transaction_commit();
> >  }
> >  
> > +const VMStateDescription vmstate_pciehost = {
> > +    .name = "PCIEHost",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_PCI_HOST(pci, PCIExpressHost),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const TypeInfo pcie_host_type_info = {
> >      .name = TYPE_PCIE_HOST_BRIDGE,
> >      .parent = TYPE_PCI_HOST_BRIDGE,
> > diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> > index 9ce088bd13..fc88305e04 100644
> > --- a/include/hw/pci/pci_host.h
> > +++ b/include/hw/pci/pci_host.h
> > @@ -70,4 +70,14 @@ extern const MemoryRegionOps pci_host_conf_be_ops;
> >  extern const MemoryRegionOps pci_host_data_le_ops;
> >  extern const MemoryRegionOps pci_host_data_be_ops;
> >  
> > +extern const VMStateDescription vmstate_pcihost;
> > +
> > +#define VMSTATE_PCI_HOST(_field, _state) {                           \
> > +    .name       = (stringify(_field)),                               \
> > +    .size       = sizeof(PCIHostState),                              \
> > +    .vmsd       = &vmstate_pcihost,                                  \
> > +    .flags      = VMS_STRUCT,                                        \
> > +    .offset     = vmstate_offset_value(_state, _field, PCIHostState),\
> > +}
> > +
> >  #endif /* PCI_HOST_H */
> > diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
> > index 3f7b9886d1..a91ba0241a 100644
> > --- a/include/hw/pci/pcie_host.h
> > +++ b/include/hw/pci/pcie_host.h
> > @@ -78,4 +78,14 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
> >                                           PCIE_MMCFG_DEVFN_MASK)
> >  #define PCIE_MMCFG_CONFOFFSET(addr)     ((addr) & PCIE_MMCFG_CONFOFFSET_MASK)
> >  
> > +extern const VMStateDescription vmstate_pciehost;
> > +
> > +#define VMSTATE_PCIE_HOST(_field, _state) {                            \
> > +    .name       = (stringify(_field)),                                 \
> > +    .size       = sizeof(PCIExpressHost),                              \
> > +    .vmsd       = &vmstate_pcihost,                                    \
> > +    .flags      = VMS_STRUCT,                                          \
> > +    .offset     = vmstate_offset_value(_state, _field, PCIExpressHost),\
> > +}
> > +
> >  #endif /* PCIE_HOST_H */
> > 
> 
> I won't claim that I understand half of what's going on, but the
> "vmstate_pciehost" object is never used. The VMSTATE_PCIE_HOST macro
> refers to "vmstate_pcihost", not "vmstate_pciehost".
> 
> Thanks
> Laszlo


