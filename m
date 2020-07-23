Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0972080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMGbtZd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0972080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZjS-0003cb-Mq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyZie-0002tw-RP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:49:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24204
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyZic-0004Py-PX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595504937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efBikii2r+tkv89lYM47NWF/SlTpII+fHkaHkG+EBtA=;
 b=hMGbtZd/Lowa443ZUxcrp25qYWR4gXbyimlPB0vp/e+wVDGJbOSj/AtpZxA9YaHQVIS2m9
 16lEQWWd/VabvO2o3PLLaIgZithPF5vZSnXqnuHhk4IRHRhP0iG3EusMYebruuS8g99Y//
 Mrlpt1/lX1kPd2BjxN6XNIsZqTzX9Zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-Yv0DFLdlMoi5j9viNd8TrA-1; Thu, 23 Jul 2020 07:48:54 -0400
X-MC-Unique: Yv0DFLdlMoi5j9viNd8TrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD4EE800460;
 Thu, 23 Jul 2020 11:48:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-52.ams2.redhat.com
 [10.36.114.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84F2519C4F;
 Thu, 23 Jul 2020 11:48:48 +0000 (UTC)
Subject: Re: [PATCH] hw/pci-host: save/restore pci host config register
To: Wang King <king.wang@huawei.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
References: <20200723104935.2286-1-king.wang@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <164f2048-107d-3980-3387-6bf8987ee3f3@redhat.com>
Date: Thu, 23 Jul 2020 13:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200723104935.2286-1-king.wang@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/23/20 12:49, Wang King wrote:
> From: Hogan Wang <king.wang@huawei.com>
> 
> The pci host config register is used to save PCI address for
> read/write config data. If guest write a value to config register,
> and then pause the vcpu to migrate, After the migration, the guest
> continue to write pci config data, and the write data will be ignored
> because of new qemu process lost the config register state.
> 
> Example:
> 1. guest booting in seabios.
> 2. guest enabled the SMM memory window in piix4_apmc_smm_setup, and
> then try to close the SMM memory window.
> 3. pasued vcpu to finish migration.
> 4. guest close the SMM memory window fail becasue of config register
> state lost.
> 5. guest continue to boot and crash in ipxe option ROM (SMM memory
> window is enabled).
> 
> Due to the complex guest, the negative effect is unpredictable.
> ---
>  hw/pci-host/i440fx.c       | 11 +++++++++++
>  hw/pci-host/q35.c          | 11 +++++++++++
>  hw/pci/pci_host.c          | 11 +++++++++++
>  hw/pci/pcie_host.c         | 11 +++++++++++
>  include/hw/pci/pci_host.h  | 10 ++++++++++
>  include/hw/pci/pcie_host.h | 10 ++++++++++
>  6 files changed, 64 insertions(+)
> 
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index 8ed2417f0c..17705bb025 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -118,6 +118,16 @@ static const VMStateDescription vmstate_i440fx = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_i440fx_pcihost = {
> +    .name = "I440FX_PCIHost",
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
> @@ -398,6 +408,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
>      hc->root_bus_path = i440fx_pcihost_root_bus_path;
>      dc->realize = i440fx_pcihost_realize;
>      dc->fw_name = "pci";
> +    dc->vmsd = &vmstate_i440fx_pcihost;
>      device_class_set_props(dc, i440fx_props);
>      /* Reason: needs to be wired up by pc_init1 */
>      dc->user_creatable = false;
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index b67cb9c29f..5e323be2e3 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -165,6 +165,16 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
>      visit_type_uint64(v, name, &value, errp);
>  }
>  
> +static const VMStateDescription vmstate_q35_pcihost = {
> +    .name = "Q35_PCIHost",
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
> @@ -194,6 +204,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
>  
>      hc->root_bus_path = q35_host_root_bus_path;
>      dc->realize = q35_host_realize;
> +    dc->vmsd = &vmstate_q35_pcihost;
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
> index 3f7b9886d1..a91ba0241a 100644
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
> +    .vmsd       = &vmstate_pcihost,                                    \
> +    .flags      = VMS_STRUCT,                                          \
> +    .offset     = vmstate_offset_value(_state, _field, PCIExpressHost),\
> +}
> +
>  #endif /* PCIE_HOST_H */
> 

I won't claim that I understand half of what's going on, but the
"vmstate_pciehost" object is never used. The VMSTATE_PCIE_HOST macro
refers to "vmstate_pcihost", not "vmstate_pciehost".

Thanks
Laszlo


