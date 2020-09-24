Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E1DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F96F21D24
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV41tYEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F96F21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOE3-0003Vj-RH
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUo-0003JN-92
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUh-0006Dx-5G
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSnQvBe46TQHYaLjorM/ZllLfxRsnLhFi+ylixqOnQo=;
 b=LV41tYEWKHs5RT4q6pwj73G54Rj47J6j2ZgsMy+UWfHe1bft02q8diiNUzZPXgu9wu/KcI
 2rMdXpEnY2DR71DwqlbvGw/NtjHWOr2HMFbjpMo2QF1kn088C3MbeGW3jAd2UexxPchLfg
 mhe5h+ApfFQOoxIHca+nxyBdOH08RVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-87JkxBihPUy34OUaQiSsxg-1; Thu, 24 Sep 2020 05:24:47 -0400
X-MC-Unique: 87JkxBihPUy34OUaQiSsxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0189E1009443
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A88E25C1C7;
 Thu, 24 Sep 2020 09:24:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 78/92] hw/xen: Split x86-specific declaration from generic
 hardware ones
Date: Thu, 24 Sep 2020 05:23:00 -0400
Message-Id: <20200924092314.1722645-79-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

xen_hvm_init() is restricted to the X86 architecture.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908155530.249806-6-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c        |  2 +-
 hw/i386/xen/xen-hvm.c    |  1 +
 include/hw/xen/xen-x86.h | 15 +++++++++++++++
 include/hw/xen/xen.h     |  2 --
 stubs/xen-hw-stub.c      |  1 +
 5 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/xen/xen-x86.h

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9eaf8d6e0d..7d5aa6d1ba 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -46,7 +46,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/arch_init.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/xen/xen.h"
+#include "hw/xen/xen-x86.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 49748cda3f..e03c59e53d 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -22,6 +22,7 @@
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen-bus.h"
+#include "hw/xen/xen-x86.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
diff --git a/include/hw/xen/xen-x86.h b/include/hw/xen/xen-x86.h
new file mode 100644
index 0000000000..85e3db1b8d
--- /dev/null
+++ b/include/hw/xen/xen-x86.h
@@ -0,0 +1,15 @@
+/*
+ * Xen X86-specific
+ *
+ * Copyright 2020 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_XEN_X86_H
+#define QEMU_HW_XEN_X86_H
+
+#include "hw/i386/pc.h"
+
+void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory);
+
+#endif /* QEMU_HW_XEN_X86_H */
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index b2b459964c..1406648ca5 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -30,8 +30,6 @@ qemu_irq *xen_interrupt_controller_init(void);
 
 void xenstore_store_pv_console_info(int i, struct Chardev *chr);
 
-void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory);
-
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
 #endif /* QEMU_HW_XEN_H */
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index d14efef49e..2ea8190921 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/xen/xen.h"
+#include "hw/xen/xen-x86.h"
 
 void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
-- 
2.26.2



