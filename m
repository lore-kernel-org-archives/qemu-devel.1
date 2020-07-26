Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B15FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 09:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE44206E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 09:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWl/bGuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE44206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzcxc-0008Do-85
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 05:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzcww-0007nx-Sh
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 05:28:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30012
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzcwt-0003GM-R8
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 05:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595755681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMGQNy2h27hkTMM4Cxs+FFnlu9fYF4kWJLCYcTGwdgU=;
 b=GWl/bGuXFQzjuMSvYS609b86eCPd+87AsSf1cdG1FCo/oOiRHE+Mrjcztuh6rp7FN2mGFS
 F7puhhH/KjeaG2luRV5AjBBFQNi3f3hzU/h4wH6PwRalBZZbntZke5KJVE3hSMBIL8Nqab
 xjygaDCChzKIL6xhzfK1PD6xM7+62S8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-5jD7kFISOuaO7ltMsV23Hg-1; Sun, 26 Jul 2020 05:27:59 -0400
X-MC-Unique: 5jD7kFISOuaO7ltMsV23Hg-1
Received: by mail-wr1-f70.google.com with SMTP id w7so654225wre.11
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 02:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WMGQNy2h27hkTMM4Cxs+FFnlu9fYF4kWJLCYcTGwdgU=;
 b=SEXk/G/WfSOp+XE/Lz9FXJCALQyWzGmR3rucXOzMHq6xUvpxmcbOal2+nZb70vU1nm
 dg0kezevY+DglZc1BKAQrstkEPfoi70H/CbFiKUJJEThx2cY+98KXjqiD5v55nSicUEn
 9CbUWrkCu3dihyJET83QQoUK/qp5YfhpWP0wHKYRKUxODjeppkWXVTxEFMVTmU68g161
 Xog4b/J04I/962C0MvjNePmQZ3gzVfwmWF6vxRNETVjefCANbbozpFFEh8tWA2dwWmR+
 c/ilKswrixfd7ZtZ4C71LzUIK4w0zjZIGZlZ+DBzPF3u5ZqxQPIRMBYI+8MJK7HFkty9
 wOew==
X-Gm-Message-State: AOAM530b+y5hqo/qzLCalBJdBLgtrNw97wMQhAqz6xjekZ3rPfy1VkxU
 98tpvSJWPza2RU7Bp99GlqUBDHkcSHGPZsjaZZn7dTpfkIZefER7yIGIzHKhh/hbnbseUmYwOUD
 CQzl7CrOH5NJFsqY=
X-Received: by 2002:a05:600c:245:: with SMTP id
 5mr13879149wmj.22.1595755678423; 
 Sun, 26 Jul 2020 02:27:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+GiE7O/1hHhlaKB89MON+GxljqC5DaxuPZP8bbXyXhZrMGYSjvyLP9PAhZKpvmiuUdNXsgQ==
X-Received: by 2002:a05:600c:245:: with SMTP id
 5mr13879127wmj.22.1595755678051; 
 Sun, 26 Jul 2020 02:27:58 -0700 (PDT)
Received: from redhat.com (93-172-53-68.bb.netvision.net.il. [93.172.53.68])
 by smtp.gmail.com with ESMTPSA id 130sm8678730wme.26.2020.07.26.02.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2020 02:27:56 -0700 (PDT)
Date: Sun, 26 Jul 2020 05:27:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hogan Wang <hogan.wang@huawei.com>
Subject: Re: [PATCH v3 1/2] hw/pci-host: save/restore pci host config register
Message-ID: <20200726052046-mutt-send-email-mst@kernel.org>
References: <20200725125437.2825-1-hogan.wang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200725125437.2825-1-hogan.wang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 05:28:01
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
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jusual@redhat.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 25, 2020 at 08:54:36PM +0800, Hogan Wang wrote:
> The pci host config register is used to save PCI address for
> read/write config data. If guest write a value to config register,
> and then pause the vcpu to migrate, After the migration, the guest
> continue to write pci config data, and the write data will be ignored
> because of new qemu process lost the config register state.
> 
> Reproduction steps are:
> 1. guest booting in seabios.
> 2. guest enable the SMRAM in seabios:piix4_apmc_smm_setup, and then
>    expect to disable the SMRAM by pci_config_writeb.
> 3. after guest write the pci host config register, and then pasued vcpu
>    to finish migration.
> 4. guest write config data(0x0A) fail to disable the SMRAM becasue of
>    config register state lost.
> 5. guest continue to boot and crash in ipxe option ROM due to SMRAM in
>    enabled state.
> 
> Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
> ---
>  hw/i386/pc.c               |  5 ++++-
>  hw/pci-host/i440fx.c       | 20 ++++++++++++++++++++
>  hw/pci-host/q35.c          | 19 +++++++++++++++++++
>  hw/pci/pci_host.c          | 11 +++++++++++
>  hw/pci/pcie_host.c         | 11 +++++++++++
>  include/hw/pci-host/q35.h  |  1 +
>  include/hw/pci/pci_host.h  | 10 ++++++++++
>  include/hw/pci/pcie_host.h | 10 ++++++++++
>  8 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3d419d5991..517f185992 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -97,7 +97,10 @@
>  #include "fw_cfg.h"
>  #include "trace.h"
>  
> -GlobalProperty pc_compat_5_0[] = {};
> +GlobalProperty pc_compat_5_0[] = {
> +    { "i440FX-pcihost", "migration-enabled", "off" },
> +    { "q35-pcihost", "migration-enabled", "off" },
> +};
>  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
>  
>  GlobalProperty pc_compat_4_2[] = {

Okay so let's make it more explicit: "x-config-reg-migration-enabled".
The property and all the code can then be on the pci host, not x86 specific.


> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index 8ed2417f0c..c662903dbb 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -49,6 +49,7 @@ typedef struct I440FXState {
>      Range pci_hole;
>      uint64_t pci_hole64_size;
>      bool pci_hole64_fix;
> +    bool migration_enabled;
>      uint32_t short_root_bus;
>  } I440FXState;
>  
> @@ -118,6 +119,23 @@ static const VMStateDescription vmstate_i440fx = {
>      }
>  };
>  
> +static bool i440fx_pcihost_needed(void *opaque)
> +{
> +    I440FXState *s = opaque;
> +    return s->migration_enabled;
> +}
> +
> +static const VMStateDescription vmstate_i440fx_pcihost = {
> +    .name = "I440FX_PCIHost",
> +    .needed = i440fx_pcihost_needed,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_HOST(parent_obj, I440FXState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
>                                                const char *name, void *opaque,
>                                                Error **errp)
> @@ -387,6 +405,7 @@ static Property i440fx_props[] = {
>                       pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT),
>      DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
>      DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
> +    DEFINE_PROP_BOOL("migration-enabled", I440FXState, migration_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -398,6 +417,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
>      hc->root_bus_path = i440fx_pcihost_root_bus_path;
>      dc->realize = i440fx_pcihost_realize;
>      dc->fw_name = "pci";
> +    dc->vmsd = &vmstate_i440fx_pcihost;
>      device_class_set_props(dc, i440fx_props);
>      /* Reason: needs to be wired up by pc_init1 */
>      dc->user_creatable = false;
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index b67cb9c29f..bb41665da4 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -165,6 +165,23 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
>      visit_type_uint64(v, name, &value, errp);
>  }
>  
> +static bool q35_host_needed(void *opaque)
> +{
> +    Q35PCIHost *s = opaque;
> +    return s->migration_enabled;
> +}
> +
> +static const VMStateDescription vmstate_q35_host = {
> +    .name = "Q35_PCIHost",
> +    .needed = q35_host_needed,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCIE_HOST(parent_obj, Q35PCIHost),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  /*
>   * NOTE: setting defaults for the mch.* fields in this table
>   * doesn't work, because mch is a separate QOM object that is
> @@ -184,6 +201,7 @@ static Property q35_host_props[] = {
>      DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
>                       mch.above_4g_mem_size, 0),
>      DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
> +    DEFINE_PROP_BOOL("migration-enabled", Q35PCIHost, migration_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -194,6 +212,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
>  
>      hc->root_bus_path = q35_host_root_bus_path;
>      dc->realize = q35_host_realize;
> +    dc->vmsd = &vmstate_q35_host;
>      device_class_set_props(dc, q35_host_props);
>      /* Reason: needs to be wired up by pc_q35_init */
>      dc->user_creatable = false;
> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index ce7bcdb1d5..7cdd5a3ea3 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -24,6 +24,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "qemu/module.h"
>  #include "hw/pci/pci_bus.h"
> +#include "migration/vmstate.h"
>  #include "trace.h"
>  
>  /* debug PCI */
> @@ -200,6 +201,16 @@ const MemoryRegionOps pci_host_data_be_ops = {
>      .endianness = DEVICE_BIG_ENDIAN,
>  };
>  
> +const VMStateDescription vmstate_pcihost = {
> +    .name = "PCIHost",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(config_reg, PCIHostState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const TypeInfo pci_host_type_info = {
>      .name = TYPE_PCI_HOST_BRIDGE,
>      .parent = TYPE_SYS_BUS_DEVICE,
> diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
> index 3534006f99..a653c39bb7 100644
> --- a/hw/pci/pcie_host.c
> +++ b/hw/pci/pcie_host.c
> @@ -24,6 +24,7 @@
>  #include "hw/pci/pcie_host.h"
>  #include "qemu/module.h"
>  #include "exec/address-spaces.h"
> +#include "migration/vmstate.h"
>  
>  /* a helper function to get a PCIDevice for a given mmconfig address */
>  static inline PCIDevice *pcie_dev_find_by_mmcfg_addr(PCIBus *s,
> @@ -121,6 +122,16 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
>      memory_region_transaction_commit();
>  }
>  
> +const VMStateDescription vmstate_pciehost = {
> +    .name = "PCIEHost",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_HOST(pci, PCIExpressHost),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const TypeInfo pcie_host_type_info = {
>      .name = TYPE_PCIE_HOST_BRIDGE,
>      .parent = TYPE_PCI_HOST_BRIDGE,
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index 070305f83d..02906e8159 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -65,6 +65,7 @@ typedef struct Q35PCIHost {
>      /*< public >*/
>  
>      bool pci_hole64_fix;
> +    bool migration_enabled;
>      MCHPCIState mch;
>  } Q35PCIHost;
>  
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index 9ce088bd13..fc88305e04 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -70,4 +70,14 @@ extern const MemoryRegionOps pci_host_conf_be_ops;
>  extern const MemoryRegionOps pci_host_data_le_ops;
>  extern const MemoryRegionOps pci_host_data_be_ops;
>  
> +extern const VMStateDescription vmstate_pcihost;
> +
> +#define VMSTATE_PCI_HOST(_field, _state) {                           \
> +    .name       = (stringify(_field)),                               \
> +    .size       = sizeof(PCIHostState),                              \
> +    .vmsd       = &vmstate_pcihost,                                  \
> +    .flags      = VMS_STRUCT,                                        \
> +    .offset     = vmstate_offset_value(_state, _field, PCIHostState),\
> +}
> +
>  #endif /* PCI_HOST_H */
> diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
> index 3f7b9886d1..e8856f03e9 100644
> --- a/include/hw/pci/pcie_host.h
> +++ b/include/hw/pci/pcie_host.h
> @@ -78,4 +78,14 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
>                                           PCIE_MMCFG_DEVFN_MASK)
>  #define PCIE_MMCFG_CONFOFFSET(addr)     ((addr) & PCIE_MMCFG_CONFOFFSET_MASK)
>  
> +extern const VMStateDescription vmstate_pciehost;
> +
> +#define VMSTATE_PCIE_HOST(_field, _state) {                            \
> +    .name       = (stringify(_field)),                                 \
> +    .size       = sizeof(PCIExpressHost),                              \
> +    .vmsd       = &vmstate_pciehost,                                   \
> +    .flags      = VMS_STRUCT,                                          \
> +    .offset     = vmstate_offset_value(_state, _field, PCIExpressHost),\
> +}
> +
>  #endif /* PCIE_HOST_H */
> -- 
> 2.27.0
> 


