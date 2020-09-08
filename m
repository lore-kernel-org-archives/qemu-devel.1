Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F199020658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcVbZUX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F199020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFg14-0000J9-Ou
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyT-0004d6-Jw
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:56:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyQ-0003yQ-0o
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599580555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VUrfo15vNafeYg0h4TuIp0D8UFhdJzYacZhDlojTCw=;
 b=HcVbZUX9ycdboCHsra5YfpKr5bApn2CMydJGD9G0n8MEtm3+DOZ1NowXteG8udRdXp9ddV
 OFHLCWBacUsSffuVbtOnQQu+qzTSf1qKKZ8vNZW6tzDQkp0m4sXtj+yMyR2LvvAqOSux7n
 uC9odwrmW48VsTSq2ZD2El9qj6W3+qE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-UMiK_vl1MsOeXhnsrjJMyg-1; Tue, 08 Sep 2020 11:55:54 -0400
X-MC-Unique: UMiK_vl1MsOeXhnsrjJMyg-1
Received: by mail-wr1-f72.google.com with SMTP id r16so7096497wrm.18
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 08:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8VUrfo15vNafeYg0h4TuIp0D8UFhdJzYacZhDlojTCw=;
 b=TmICcXL4fJHLG4smzSMehm4gCSZOxKabF4QeUetp1st62rRr9shqQy4xgZXlSQv7on
 29qnW/CnIaHAg6YVQMTLvQlaKP5n5jXwL7VmAqLkUDb3Zp++dfybR/+gZyysSiDsOvbd
 /mxqCZSxp3rBWdZPMA06VBqb05/+IgP59pw6xYd7ywQLMjaI2PQePTrgqEOq/wdhcxF+
 4Y6siLwbp/I72TiwZ3nlEDabf4UNhEBZLgtZIO18EA4/uMnyyysS/SAieDEiGrubTZM/
 cYNlU08+NMahgdVl19kEuHorJmUUino7vOzic0g77qWGluSacfipCbkNxfbKrATXjwUT
 WLzw==
X-Gm-Message-State: AOAM530nClvqXfGe3oVWB19kJi0nIG1peX8hVxk1BJcbbZzbaudhtZeT
 d32UcqHiEGpTJOWNO8eUkkcUsI+SopSkwp06S0wR5wWqXYM6scO3WzIys3qf7wBhB7byLaudVZO
 dhy1j5l83n/E3BY8=
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr270732wrs.99.1599580552696;
 Tue, 08 Sep 2020 08:55:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEdHc1pv7BGXCTe+BIUfFARswN/4qnGyClHhLRspWocVPg/ArmCIreq1geKKgL3FqYCE8gsQ==
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr270716wrs.99.1599580552510;
 Tue, 08 Sep 2020 08:55:52 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o5sm31934683wmc.33.2020.09.08.08.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:55:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] stubs: Split accelerator / hardware related stubs
Date: Tue,  8 Sep 2020 17:55:28 +0200
Message-Id: <20200908155530.249806-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908155530.249806-1-philmd@redhat.com>
References: <20200908155530.249806-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
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


