Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47A7C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4524021D43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhGvXUDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4524021D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeeS-0005gi-6L
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeaP-0005TB-6g
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeZi-0006qm-45
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VUrfo15vNafeYg0h4TuIp0D8UFhdJzYacZhDlojTCw=;
 b=HhGvXUDxQ+4XXUJ0pgoq621A7+XUM026bmF8Xb6po2aQbyRdVxrVaGUwJT2shnxTDAC7z5
 /g0WKWrnXerXuXd/NvURrA3IjySEy4ctquaqNHQ04Npn8klgRMedGsggBbInxxJXzqGv+P
 D6MPtZvjozMaghlZK0qucGVMSMIpax8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-rq2Bu_SkOFCay8n-R_6RPg-1; Tue, 08 Sep 2020 10:26:18 -0400
X-MC-Unique: rq2Bu_SkOFCay8n-R_6RPg-1
Received: by mail-wm1-f69.google.com with SMTP id u5so4540232wme.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8VUrfo15vNafeYg0h4TuIp0D8UFhdJzYacZhDlojTCw=;
 b=OolI6nddd+1hE97L55LgYw8mY/DQchZ7zf66yIz4iapyCNjJOS736xm0UPENSeHdc2
 VDNu4v5WKEyP+Ysk5ODMsDcjlO06eRmmiUC0JiX94uqmg2cAIpeNaCo813GVnJexZXiS
 r8NwOwgtcgFkR336hyC3CcItAozQh8xVzUuLlqgXR0xee3Mu/Y1jq8Mrs8IvciDhop/3
 WGCdazlCpLkdEF3xJN+GyDme1x3h9RUIPsEzBNorM3GI7F0JZTccP/CJb+0DkT/8PHAc
 G8d0jhi0CjuBZ8cmcUtprgnHgcxdJ/y1HIUdRc2FoziTMmwGCsmyqAuyrD1XGJajgUoM
 32Ow==
X-Gm-Message-State: AOAM533Pa31hpTyuVAuAhCtPa2rSmu6Fo4EbMpOes59A3X9TW3uPx0jL
 OyE1+sGCBctoiiK69nP2HEqUSDlkPkED2yknZKbJzdADd5q+GaVPtns5zFRXbPDmK/cBwpDZ3Di
 Vk10zr/z6Tt4xbto=
X-Received: by 2002:adf:ded0:: with SMTP id i16mr28998781wrn.372.1599575176516; 
 Tue, 08 Sep 2020 07:26:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkszmGXOLnkk3CcObVMEgsSL3kaacDO7vyqNMMFdP08ftv4yg2yphpdxx/O0+be5EyVAQmTg==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr28998760wrn.372.1599575176292; 
 Tue, 08 Sep 2020 07:26:16 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 188sm56090648wmz.2.2020.09.08.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:26:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] stubs: Split accelerator / hardware related stubs
Date: Tue,  8 Sep 2020 16:25:57 +0200
Message-Id: <20200908142559.192945-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908142559.192945-1-philmd@redhat.com>
References: <20200908142559.192945-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move hardware stubs unrelated from the accelerator to xen-hw-stub.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 accel/stubs/xen-stub.c | 41 +----------------------------------
 stubs/xen-hw-stub.c    | 49 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS            |  1 +
 stubs/meson.build      |  1 +
 4 files changed, 52 insertions(+), 40 deletions(-)
 create mode 100644 stubs/xen-hw-stub.c

diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index fa3dddbce57..7ba0b697f49 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -6,50 +6,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "qapi/qapi-commands-misc.h"
 
 bool xen_allowed;
 
-void xenstore_store_pv_console_info(int i, Chardev *chr)
-{
-}
-
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
-{
-    return -1;
-}
-
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
-{
-}
-
-void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
-{
-}
-
-void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
-{
-}
-
-int xen_is_pirq_msi(uint32_t msi_data)
-{
-    return 0;
-}
-
-qemu_irq *xen_interrupt_controller_init(void)
-{
-    return NULL;
-}
-
-void xen_register_framebuffer(MemoryRegion *mr)
-{
-}
-
-void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
-{
-}
-
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
 }
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
new file mode 100644
index 00000000000..d14efef49e9
--- /dev/null
+++ b/stubs/xen-hw-stub.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2014       Citrix Systems UK Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/xen/xen.h"
+
+void xenstore_store_pv_console_info(int i, Chardev *chr)
+{
+}
+
+int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
+{
+    return -1;
+}
+
+void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+{
+}
+
+void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
+{
+}
+
+void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
+{
+}
+
+int xen_is_pirq_msi(uint32_t msi_data)
+{
+    return 0;
+}
+
+qemu_irq *xen_interrupt_controller_init(void)
+{
+    return NULL;
+}
+
+void xen_register_framebuffer(MemoryRegion *mr)
+{
+}
+
+void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
+{
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 7d0a5e91e4f..b3366713903 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -480,6 +480,7 @@ F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
+F: stubs/xen-hw-stub.c
 
 Guest CPU Cores (HAXM)
 ---------------------
diff --git a/stubs/meson.build b/stubs/meson.build
index e0b322bc282..c3e318a57f3 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -46,4 +46,5 @@ stub_ss.add(files('vm-stop.c'))
 stub_ss.add(files('win32-kbd-hook.c'))
 if have_system
   stub_ss.add(files('semihost.c'))
+  stub_ss.add(when: 'CONFIG_XEN', if_false: files('xen-hw-stub.c'))
 endif
-- 
2.26.2


