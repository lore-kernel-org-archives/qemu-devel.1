Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C54C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDB8206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTPYJN4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDB8206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxIi-0007jy-WD
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 08:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxI2-00075v-Kh
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:59:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33355
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxI0-0005XO-GI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595595543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uBk2dj9pHB85RmqoKqWN1DCTtY5iLgQUMAa9leh2p0=;
 b=gTPYJN4eWEma8hUUcCncZo3KIptdlyvC/+Tw+bWAxe5s1jyTD1i18NG1oIgdx/sAs/E2o0
 YH7SYPVcj6wNqP2NYJ478MV6XB5ZDTBU+FS//k2KoIBNhr6SIiPREZrVtvc1eO4uuIA36A
 H6iC670uLefj3vNRaWOdTlkbJLFWpms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-CM9xpsfuNKKkKH3zlhXsrQ-1; Fri, 24 Jul 2020 08:59:01 -0400
X-MC-Unique: CM9xpsfuNKKkKH3zlhXsrQ-1
Received: by mail-wm1-f72.google.com with SMTP id e15so3937458wme.8
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 05:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3uBk2dj9pHB85RmqoKqWN1DCTtY5iLgQUMAa9leh2p0=;
 b=dU/Iv28GzBeNp+5IWQgRwpWhPJeuNsUCD83//E0YKUdpBT3IyJptATJJ3VPurDDrQn
 Fm6akRllhjG+DhPLK+2rU/8ok2wGFJ5MvOVDvWdd+8+J8MQEamLAlJD3otaEvoPqaGa4
 NjUhesvZYaCwZrs01SGxK19UtRXOXxg+NZZJNenvHTT8bsC7BkEdwrgxeXnOkpGH0VHz
 MfUu7jehFgPfcYXGbJbXnHoQDnbR2N6dSglx0h7pLeNvxwCwnaEVltGonS8qatkb/dLh
 6bmbLH9E/Vko+2wlU2YD3v6le20ezrkcNLDc9tXIvkkyD3e0l94WgLFL6WcafxsNh7j3
 1lPg==
X-Gm-Message-State: AOAM530m59da35wqcNHYWzlp7iHgSHPmbSqBFu7RY7HTwPIXZshI/P0r
 zhq8yqtH70gfNjbtiE8X08CC6p0gGLqEr1fq3wLelTql+QmIJ36ayuE8Zu+LZwLwLP1ekkzkMIh
 NtFQF3wJlihfYPoE=
X-Received: by 2002:adf:92a1:: with SMTP id 30mr9225778wrn.56.1595595540575;
 Fri, 24 Jul 2020 05:59:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuxwpucaTwEz85r0R3uv72JVWCKKhGe2o1kQkIvyqgVy6UrG6wEB4P1Ny53ECCdxvSaksxsg==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr9225751wrn.56.1595595540198;
 Fri, 24 Jul 2020 05:59:00 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id z207sm7196935wmc.2.2020.07.24.05.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 05:58:59 -0700 (PDT)
Date: Fri, 24 Jul 2020 08:58:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v1] hw/pci-host: save/restore pci host config register
Message-ID: <20200724085825-mutt-send-email-mst@kernel.org>
References: <20200723125303.2390-1-king.wang@huawei.com>
 <20200723085516-mutt-send-email-mst@kernel.org>
 <20200723130923.GK2621@work-vm>
 <20200723114756-mutt-send-email-mst@kernel.org>
 <20200723160453.GT2621@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200723160453.GT2621@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jusual@redhat.com,
 qemu-devel@nongnu.org, Wang King <king.wang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 05:04:53PM +0100, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Thu, Jul 23, 2020 at 02:12:54PM +0100, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Thu, Jul 23, 2020 at 08:53:03PM +0800, Wang King wrote:
> > > > > From: Hogan Wang <king.wang@huawei.com>
> > > > > 
> > > > > The pci host config register is used to save PCI address for
> > > > > read/write config data. If guest write a value to config register,
> > > > > and then pause the vcpu to migrate, After the migration, the guest
> > > > > continue to write pci config data, and the write data will be ignored
> > > > > because of new qemu process lost the config register state.
> > > > > 
> > > > > Reproduction steps are:
> > > > > 1. guest booting in seabios.
> > > > > 2. guest enable the SMRAM in seabios:piix4_apmc_smm_setup, and then
> > > > >    expect to disable the SMRAM by pci_config_writeb.
> > > > > 3. after guest write the pci host config register, and then pasued vcpu
> > > > >    to finish migration.
> > > > > 4. guest write config data(0x0A) fail to disable the SMRAM becasue of
> > > > >    config register state lost.
> > > > > 5. guest continue to boot and crash in ipxe option ROM due to SMRAM in
> > > > >    enabled state.
> > > > > 
> > > > > Signed-off-by: Hogan Wang <king.wang@huawei.com>
> > > > 
> > > > I guess this is like v3 right?
> > > > 
> > > > thanks a lot for the patch!
> > > > 
> > > > My question stands : does anyone see a way to pass this
> > > > info around without breaking migration for all existing
> > > > machine types?
> > > 
> > > You need a .needed clause in the vmstate_i440fx_pcihost and
> > > vmstate_q35_pcihost which is a pointer to a function which enables it on
> > > new machine types and ignores it on old ones.
> > > 
> > > Or, if it always crashes if the SMRAM is enabled, then the migration is
> > > dead anyway; so you could make the .needed only save the config if
> > > the SMRAM is opened, so you'd get a unknown section error, which is
> > > nasty but it would only happen in the case it would crash anyway.
> > > 
> > > Dave
> > 
> > Problem is we never know whether it's needed.
> > 
> > For example: guest programs cf8, then cfc.
> > Guest on destination can crash if migrated after
> > writing cf8 before writing cfc.
> > But in theory it can also crash if guest assumes
> > cf8 is unchanged and just writes cfc.
> > 
> > So what I'd prefer to do is put it in some data that
> > old qemu ignores. Then once qemu on destination
> > is updated, it will start interpreting it.
> 
> We don't have a way to do that; the choice is:
>   a) Not sending it for old versions, so you only get the
>     fix for new machine types
> 
>   b) Trying to second guess when it will crash
> 
> I recommend (a) generally - but the format has no
> way to ignore unknown data.
> 
> Dave

How about adding that finally, so we have a way to fix bugs like this one?

> > 
> > > > 
> > > > > ---
> > > > >  hw/pci-host/i440fx.c       | 11 +++++++++++
> > > > >  hw/pci-host/q35.c          | 11 +++++++++++
> > > > >  hw/pci/pci_host.c          | 11 +++++++++++
> > > > >  hw/pci/pcie_host.c         | 11 +++++++++++
> > > > >  include/hw/pci/pci_host.h  | 10 ++++++++++
> > > > >  include/hw/pci/pcie_host.h | 10 ++++++++++
> > > > >  6 files changed, 64 insertions(+)
> > > > > 
> > > > > diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> > > > > index 8ed2417f0c..17705bb025 100644
> > > > > --- a/hw/pci-host/i440fx.c
> > > > > +++ b/hw/pci-host/i440fx.c
> > > > > @@ -118,6 +118,16 @@ static const VMStateDescription vmstate_i440fx = {
> > > > >      }
> > > > >  };
> > > > >  
> > > > > +static const VMStateDescription vmstate_i440fx_pcihost = {
> > > > > +    .name = "I440FX_PCIHost",
> > > > > +    .version_id = 1,
> > > > > +    .minimum_version_id = 1,
> > > > > +    .fields = (VMStateField[]) {
> > > > > +        VMSTATE_PCI_HOST(parent_obj, I440FXState),
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    }
> > > > > +};
> > > > > +
> > > > >  static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
> > > > >                                                const char *name, void *opaque,
> > > > >                                                Error **errp)
> > > > > @@ -398,6 +408,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
> > > > >      hc->root_bus_path = i440fx_pcihost_root_bus_path;
> > > > >      dc->realize = i440fx_pcihost_realize;
> > > > >      dc->fw_name = "pci";
> > > > > +    dc->vmsd = &vmstate_i440fx_pcihost;
> > > > >      device_class_set_props(dc, i440fx_props);
> > > > >      /* Reason: needs to be wired up by pc_init1 */
> > > > >      dc->user_creatable = false;
> > > > > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > > > > index b67cb9c29f..5e323be2e3 100644
> > > > > --- a/hw/pci-host/q35.c
> > > > > +++ b/hw/pci-host/q35.c
> > > > > @@ -165,6 +165,16 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
> > > > >      visit_type_uint64(v, name, &value, errp);
> > > > >  }
> > > > >  
> > > > > +static const VMStateDescription vmstate_q35_pcihost = {
> > > > > +    .name = "Q35_PCIHost",
> > > > > +    .version_id = 1,
> > > > > +    .minimum_version_id = 1,
> > > > > +    .fields = (VMStateField[]) {
> > > > > +        VMSTATE_PCIE_HOST(parent_obj, Q35PCIHost),
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    }
> > > > > +};
> > > > > +
> > > > >  /*
> > > > >   * NOTE: setting defaults for the mch.* fields in this table
> > > > >   * doesn't work, because mch is a separate QOM object that is
> > > > > @@ -194,6 +204,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
> > > > >  
> > > > >      hc->root_bus_path = q35_host_root_bus_path;
> > > > >      dc->realize = q35_host_realize;
> > > > > +    dc->vmsd = &vmstate_q35_pcihost;
> > > > >      device_class_set_props(dc, q35_host_props);
> > > > >      /* Reason: needs to be wired up by pc_q35_init */
> > > > >      dc->user_creatable = false;
> > > > > diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> > > > > index ce7bcdb1d5..7cdd5a3ea3 100644
> > > > > --- a/hw/pci/pci_host.c
> > > > > +++ b/hw/pci/pci_host.c
> > > > > @@ -24,6 +24,7 @@
> > > > >  #include "hw/pci/pci_host.h"
> > > > >  #include "qemu/module.h"
> > > > >  #include "hw/pci/pci_bus.h"
> > > > > +#include "migration/vmstate.h"
> > > > >  #include "trace.h"
> > > > >  
> > > > >  /* debug PCI */
> > > > > @@ -200,6 +201,16 @@ const MemoryRegionOps pci_host_data_be_ops = {
> > > > >      .endianness = DEVICE_BIG_ENDIAN,
> > > > >  };
> > > > >  
> > > > > +const VMStateDescription vmstate_pcihost = {
> > > > > +    .name = "PCIHost",
> > > > > +    .version_id = 1,
> > > > > +    .minimum_version_id = 1,
> > > > > +    .fields = (VMStateField[]) {
> > > > > +        VMSTATE_UINT32(config_reg, PCIHostState),
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    }
> > > > > +};
> > > > > +
> > > > >  static const TypeInfo pci_host_type_info = {
> > > > >      .name = TYPE_PCI_HOST_BRIDGE,
> > > > >      .parent = TYPE_SYS_BUS_DEVICE,
> > > > > diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
> > > > > index 3534006f99..a653c39bb7 100644
> > > > > --- a/hw/pci/pcie_host.c
> > > > > +++ b/hw/pci/pcie_host.c
> > > > > @@ -24,6 +24,7 @@
> > > > >  #include "hw/pci/pcie_host.h"
> > > > >  #include "qemu/module.h"
> > > > >  #include "exec/address-spaces.h"
> > > > > +#include "migration/vmstate.h"
> > > > >  
> > > > >  /* a helper function to get a PCIDevice for a given mmconfig address */
> > > > >  static inline PCIDevice *pcie_dev_find_by_mmcfg_addr(PCIBus *s,
> > > > > @@ -121,6 +122,16 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
> > > > >      memory_region_transaction_commit();
> > > > >  }
> > > > >  
> > > > > +const VMStateDescription vmstate_pciehost = {
> > > > > +    .name = "PCIEHost",
> > > > > +    .version_id = 1,
> > > > > +    .minimum_version_id = 1,
> > > > > +    .fields = (VMStateField[]) {
> > > > > +        VMSTATE_PCI_HOST(pci, PCIExpressHost),
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    }
> > > > > +};
> > > > > +
> > > > >  static const TypeInfo pcie_host_type_info = {
> > > > >      .name = TYPE_PCIE_HOST_BRIDGE,
> > > > >      .parent = TYPE_PCI_HOST_BRIDGE,
> > > > > diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> > > > > index 9ce088bd13..fc88305e04 100644
> > > > > --- a/include/hw/pci/pci_host.h
> > > > > +++ b/include/hw/pci/pci_host.h
> > > > > @@ -70,4 +70,14 @@ extern const MemoryRegionOps pci_host_conf_be_ops;
> > > > >  extern const MemoryRegionOps pci_host_data_le_ops;
> > > > >  extern const MemoryRegionOps pci_host_data_be_ops;
> > > > >  
> > > > > +extern const VMStateDescription vmstate_pcihost;
> > > > > +
> > > > > +#define VMSTATE_PCI_HOST(_field, _state) {                           \
> > > > > +    .name       = (stringify(_field)),                               \
> > > > > +    .size       = sizeof(PCIHostState),                              \
> > > > > +    .vmsd       = &vmstate_pcihost,                                  \
> > > > > +    .flags      = VMS_STRUCT,                                        \
> > > > > +    .offset     = vmstate_offset_value(_state, _field, PCIHostState),\
> > > > > +}
> > > > > +
> > > > >  #endif /* PCI_HOST_H */
> > > > > diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
> > > > > index 3f7b9886d1..e8856f03e9 100644
> > > > > --- a/include/hw/pci/pcie_host.h
> > > > > +++ b/include/hw/pci/pcie_host.h
> > > > > @@ -78,4 +78,14 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
> > > > >                                           PCIE_MMCFG_DEVFN_MASK)
> > > > >  #define PCIE_MMCFG_CONFOFFSET(addr)     ((addr) & PCIE_MMCFG_CONFOFFSET_MASK)
> > > > >  
> > > > > +extern const VMStateDescription vmstate_pciehost;
> > > > > +
> > > > > +#define VMSTATE_PCIE_HOST(_field, _state) {                            \
> > > > > +    .name       = (stringify(_field)),                                 \
> > > > > +    .size       = sizeof(PCIExpressHost),                              \
> > > > > +    .vmsd       = &vmstate_pciehost,                                   \
> > > > > +    .flags      = VMS_STRUCT,                                          \
> > > > > +    .offset     = vmstate_offset_value(_state, _field, PCIExpressHost),\
> > > > > +}
> > > > > +
> > > > >  #endif /* PCIE_HOST_H */
> > > > > -- 
> > > > > 2.23.0
> > > > > 
> > > > 
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


