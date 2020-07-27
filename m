Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE7CC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6212070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rz1fom05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6212070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03Wt-00073r-A0
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vf-0005Cq-Mx
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51072
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vd-0001tR-OI
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5Jqd+SmkXSBC/JZYFI43kAGxEBE3DwOl1zZvCWvDdA=;
 b=Rz1fom05PIlgVmJ6p1GQtUe8Ed9WsIy5CWK9iwK1CQGBPwcOQC582rGHVExnlaPeWVEibU
 dmEs2IoccLGC2OXufDmrLMPn95qbBHwF+NuoOjyayiikYdYXm2IyJDgQWIEKogZjvG9hBM
 vH0+52SE4N8pVcfe2fnHn5PUZdGrE3U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-PQfYeY7CMPSHgiZX4n8FSg-1; Mon, 27 Jul 2020 09:49:37 -0400
X-MC-Unique: PQfYeY7CMPSHgiZX4n8FSg-1
Received: by mail-wr1-f70.google.com with SMTP id z12so3972500wrl.16
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G5Jqd+SmkXSBC/JZYFI43kAGxEBE3DwOl1zZvCWvDdA=;
 b=bXVUgzNIe8QyWmFT5WBYGZ3YvtISL8/DtUSqgqKTO8Y5wuKGHel6ochwxcqzxGwe0v
 ZCXz1MLLBlWjIxq2ccYyzb64HbTJZqxSpcijLm+ZB51T+WapEqsPV8WsDN/4aCj8HqRJ
 leZ2BQNczWMq/kwK8l7BlH8PILkJZ3mHpVEj5FixWyse9zVPW4UvFjaKs01JUyquJMyo
 7JX/pyhu1qwXUPLZg90PdNI3jdonCLWleFAsgYiym/mFOGeiiyPAeFlkEcVl4jHqCGsS
 BHl9JA8k8UeHpMQ6vRX///JjtMgJiBO9ybsetn4wYGo/MZIgShvGQGpx5AM5PEhevhRB
 w5aw==
X-Gm-Message-State: AOAM531DMbOxUTUdjDOepVdJE8UGU+fDnMFUMoJKY7e0CG/v3i54HZVw
 tx7ZjeQMu6EB9HqkfbP1IGnc9cf1JhBo7D/z+oWUT0yQit7HSHo+koC0B6g9irfyEgFx9/W/1sJ
 Eb3PYV13YldAltRU=
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr21796996wrq.12.1595857776076; 
 Mon, 27 Jul 2020 06:49:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdlVQyDbn+JMARwjE/qDBOF8uyA+C9le76/I9GiTPVRVdwWuBVAsr0/Gq6HQB+trX4CaahFw==
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr21796978wrq.12.1595857775857; 
 Mon, 27 Jul 2020 06:49:35 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id i6sm11782355wrp.92.2020.07.27.06.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:49:35 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:49:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] hw/pci-host: save/restore pci host config register
Message-ID: <20200727134614.96376-3-mst@redhat.com>
References: <20200727134614.96376-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727134614.96376-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 Hogan Wang <king.wang@huawei.com>, Hogan Wang <hogan.wang@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hogan Wang <king.wang@huawei.com>

The pci host config register is used to save PCI address for
read/write config data. If guest write a value to config register,
and then pause the vcpu to migrate, After the migration, the guest
continue to write pci config data, and the write data will be ignored
because of new qemu process lost the config register state.

Reproduction steps are:
1. guest booting in seabios.
2. guest enable the SMRAM in seabios:piix4_apmc_smm_setup, and then
   expect to disable the SMRAM by pci_config_writeb.
3. after guest write the pci host config register, and then pasued vcpu
   to finish migration.
4. guest write config data(0x0A) fail to disable the SMRAM becasue of
   config register state lost.
5. guest continue to boot and crash in ipxe option ROM due to SMRAM in
   enabled state.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
Message-Id: <20200727084621.3279-1-hogan.wang@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_host.h |  1 +
 hw/i386/pc.c              |  4 +++-
 hw/pci/pci_host.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

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
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d419d5991..f6ff0c5514 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,7 +97,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
-GlobalProperty pc_compat_5_0[] = {};
+GlobalProperty pc_compat_5_0[] = {
+    { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
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


