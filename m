Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9379C433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B754220838
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkfUWuLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B754220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04CL-0005Or-VC
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04As-0003Hd-El
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Aq-0001Fe-IJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwIlVv8mpoXRCi0ZFuXKLtwB0wnN7U1sjQ8Afgj5tJo=;
 b=SkfUWuLS9yBp6XzeONGMtje/Focmnon+/vKxVLHwL12l5/yXE1nuTVi9ancdvdMoLxXYWn
 kTJ7Q9S2y/WPxzgI9Z3zkSZS0FKG3rzKrRyy/r20VVoEfwStADFP7hhmfrol+aNaoVGOfK
 Xc+6wdV6lRGEWk+XLvu5mwxi55W81Qw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-TkUryo_RNpiiQtzK9RLUxw-1; Mon, 27 Jul 2020 10:32:11 -0400
X-MC-Unique: TkUryo_RNpiiQtzK9RLUxw-1
Received: by mail-wr1-f71.google.com with SMTP id z1so4001961wrn.18
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hwIlVv8mpoXRCi0ZFuXKLtwB0wnN7U1sjQ8Afgj5tJo=;
 b=HtPtgNAzjWhihfepJsBne6jvalDDiFICuHGHlPPsXTmS4NFDgWHF9HJGYvmoz2Utr4
 wQ8BBfl3YdkuzdO9qa/UlCRyVrpifRM9I4V7bFlnHwzGFvcrg2y7LWFgfPikCK4BdmYv
 /5q+wwcAC16QE/ycsJK03RS5cY85+zg7Y+lZ/Vgau/wJIWkka6btTemqcxCZszbmytZy
 8vrtTzVZ2aWOWomOv923FJAhXOn908/zyCSreEqmIFO4EnGZV++GUNEg9gHijly/5RA4
 bFjNTpe8wlBpDDVwNDuCHPmdtWeDaG+AhhjPeof3C1Q1/39qE2JWWvDFe+BlftCFnAIS
 rnqA==
X-Gm-Message-State: AOAM532GdoCvG7s6vb5mwXPHnoxer1KhLmeJGPrVRPhRDpz6QAT5enLZ
 WnfXkHcRVuHaNfAyLwla2YkLBnnEDkQeCyvc1+UkTQWqxGiu6oKAdYGYJ+bdd6UkmTKDGMLYGiA
 dwcI+Yy3jeofDHss=
X-Received: by 2002:adf:c386:: with SMTP id p6mr20577667wrf.344.1595860329876; 
 Mon, 27 Jul 2020 07:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykqx3SEGQdIvzADljKBLZvmJOTkswsBclBGhDa8qwzmeeoGQnOuXJ4I7qRKB2f13laqdwF/Q==
X-Received: by 2002:adf:c386:: with SMTP id p6mr20577642wrf.344.1595860329561; 
 Mon, 27 Jul 2020 07:32:09 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id 8sm4800427wrl.7.2020.07.27.07.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:32:08 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:32:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 2/6] hw/pci-host: save/restore pci host config register
Message-ID: <20200727143104.97776-3-mst@redhat.com>
References: <20200727143104.97776-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727143104.97776-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Hogan Wang <king.wang@huawei.com>, qemu-stable@nongnu.org,
 Hogan Wang <hogan.wang@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hogan Wang <king.wang@huawei.com>

The pci host config register is used to save PCI address for
read/write config data. If guest writes a value to config register,
and then QEMU pauses the vcpu to migrate, after the migration, the guest
will continue to write pci config data, and the write data will be ignored
because of new qemu process losing the config register state.

To trigger the bug:
1. guest is booting in seabios.
2. guest enables the SMRAM in seabios:piix4_apmc_smm_setup, and then
   expects to disable the SMRAM by pci_config_writeb.
3. after guest writes the pci host config register, QEMU pauses vcpu
   to finish migration.
4. guest write of config data(0x0A) fails to disable the SMRAM because
   the config register state is lost.
5. guest continues to boot and crashes in ipxe option ROM due to SMRAM
   in enabled state.

Example Reproducer:

step 1. Make modifications to seabios and qemu for increase reproduction
efficiency, write 0xf0 to 0x402 port notify qemu to stop vcpu after
0x0cf8 port wrote i440 configure register. qemu stop vcpu when catch
0x402 port wrote 0xf0.

seabios:/src/hw/pci.c
@@ -52,6 +52,11 @@ void pci_config_writeb(u16 bdf, u32 addr, u8 val)
         writeb(mmconfig_addr(bdf, addr), val);
     } else {
         outl(ioconfig_cmd(bdf, addr), PORT_PCI_CMD);
+       if (bdf == 0 && addr == 0x72 && val == 0xa) {
+            dprintf(1, "stop vcpu\n");
+            outb(0xf0, 0x402); // notify qemu to stop vcpu
+            dprintf(1, "resume vcpu\n");
+        }
         outb(val, PORT_PCI_DATA + (addr & 3));
     }
 }

qemu:hw/char/debugcon.c
@@ -60,6 +61,9 @@ static void debugcon_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     printf(" [debugcon: write addr=0x%04" HWADDR_PRIx " val=0x%02" PRIx64 "]\n", addr, val);
 #endif

+    if (ch == 0xf0) {
+        vm_stop(RUN_STATE_PAUSED);
+    }
     /* XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks */
     qemu_chr_fe_write_all(&s->chr, &ch, 1);

step 2. start vm1 by the following command line, and then vm stopped.
$ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=kvm\
 -netdev tap,ifname=tap-test,id=hostnet0,vhost=on,downscript=no,script=no\
 -device virtio-net-pci,netdev=hostnet0,id=net0,bus=pci.0,addr=0x13,bootindex=3\
 -device cirrus-vga,id=video0,vgamem_mb=16,bus=pci.0,addr=0x2\
 -chardev file,id=seabios,path=/var/log/test.seabios,append=on\
 -device isa-debugcon,iobase=0x402,chardev=seabios\
 -monitor stdio

step 3. start vm2 to accept vm1 state.
$ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=kvm\
 -netdev tap,ifname=tap-test1,id=hostnet0,vhost=on,downscript=no,script=no\
 -device virtio-net-pci,netdev=hostnet0,id=net0,bus=pci.0,addr=0x13,bootindex=3\
 -device cirrus-vga,id=video0,vgamem_mb=16,bus=pci.0,addr=0x2\
 -chardev file,id=seabios,path=/var/log/test.seabios,append=on\
 -device isa-debugcon,iobase=0x402,chardev=seabios\
 -monitor stdio \
 -incoming tcp:127.0.0.1:8000

step 4. execute the following qmp command in vm1 to migrate.
(qemu) migrate tcp:127.0.0.1:8000

step 5. execute the following qmp command in vm2 to resume vcpu.
(qemu) cont
Before this patch, we get KVM "emulation failure" error on vm2.
This patch fixes it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
Message-Id: <20200727084621.3279-1-hogan.wang@huawei.com>
Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_host.h |  1 +
 hw/core/machine.c         |  1 +
 hw/i386/pc.c              |  3 ++-
 hw/pci/pci_host.c         | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 9ce088bd13..6210a7e14d 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -45,6 +45,7 @@ struct PCIHostState {
     MemoryRegion data_mem;
     MemoryRegion mmcfg;
     uint32_t config_reg;
+    bool mig_enabled;
     PCIBus *bus;
 
     QLIST_ENTRY(PCIHostState) next;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2f881d6d75..8d1a90c6cf 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,7 @@
 #include "migration/vmstate.h"
 
 GlobalProperty hw_compat_5_0[] = {
+    { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
     { "virtio-balloon-device", "page-poison", "false" },
     { "vmport", "x-read-set-eax", "off" },
     { "vmport", "x-signal-unsupported-cmd", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d419d5991..47c5ca3e34 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,7 +97,8 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
-GlobalProperty pc_compat_5_0[] = {};
+GlobalProperty pc_compat_5_0[] = {
+};
 const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
 
 GlobalProperty pc_compat_4_2[] = {
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index ce7bcdb1d5..8ca5fadcbd 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -22,8 +22,10 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 /* debug PCI */
@@ -200,12 +202,43 @@ const MemoryRegionOps pci_host_data_be_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static bool pci_host_needed(void *opaque)
+{
+    PCIHostState *s = opaque;
+    return s->mig_enabled;
+}
+
+const VMStateDescription vmstate_pcihost = {
+    .name = "PCIHost",
+    .needed = pci_host_needed,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(config_reg, PCIHostState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property pci_host_properties_common[] = {
+    DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
+                     mig_enabled, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pci_host_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_props(dc, pci_host_properties_common);
+    dc->vmsd = &vmstate_pcihost;
+}
+
 static const TypeInfo pci_host_type_info = {
     .name = TYPE_PCI_HOST_BRIDGE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .abstract = true,
     .class_size = sizeof(PCIHostBridgeClass),
     .instance_size = sizeof(PCIHostState),
+    .class_init = pci_host_class_init,
 };
 
 static void pci_host_register_types(void)
-- 
MST


