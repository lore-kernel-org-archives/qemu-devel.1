Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E27AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F151A206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWBDEQe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F151A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtoT-0007jA-DA
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFe-0005uG-VM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFd-0000ND-Lt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFd-0000KB-BO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id g17so8055345wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=9NSUuNQ9Jf+FzPsRmj7s9FDau0CX5jauhzpAS1A8igc=;
 b=YWBDEQe6D1eKZ9PcOGWcCkECUNXngyWNgZyJNhAyFKOSLQsudtuQnoU5YBxOR3v3P+
 aRqmtfVTGj12j3OyRbSPA/N6pFvzD+O5CTpQKwwZua0J57nAky/aJYLPCKUtVC23NxHZ
 MZUVnApZYjkpmsfLywDg7jTog/mu3+6raktWv9oNm6PkbOXRahyhm4y93aqUj9Qzr4Q2
 kP3FJJYUs4nVSrckEqMawc5yh3x+C1DcoimLSTCnXWXdFpGXzWRumZQkoHr9FOP0eFfd
 vFnEfnI2QYT24DKt8/BivCJceQ3r7RWi5YCe6dOillj1e5QewMfpmC6fAipIIldH4bqx
 kxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=9NSUuNQ9Jf+FzPsRmj7s9FDau0CX5jauhzpAS1A8igc=;
 b=EXlKNtVdRQMcKKHXoc9qHaCDIX7PKHpqZYvWBymi11mmaKXTmQpSVKS2Rhi2jt/5qZ
 gHLWOIrm9AO16L86Vlik+YtNRlAFPfN4EntCg5oaYGPsvQWyJ+WCkcfOf6mP6W8ICHu9
 OrXcQ+9Nh3mR+aAWeHcsqKroFvlKEA/OJ8cVX0VnmSZ9mi9ldJSUs4yCJ4YDpDh4URuf
 uqHV2AHTrkjlEfoozp3wcuawfRt+rYjDethQxqZCsGpKRQGa+J/S8joVOu7XvfI0CWo8
 Am8X8yE3+XHaiquYtOsVWs9UKckDmdmuAXbo+MrWYU8dh97GrvB/6WIaUrjDC+YQ3TRM
 yHMg==
X-Gm-Message-State: APjAAAXOikMcxdFNCDBT5skZW8IxOoAPJNUL4RG+zonf5dcuPtMSaOdU
 5GmohmqMqWihcT8HHiNIT/8bK10C
X-Google-Smtp-Source: APXvYqw+R9I8WJRF4Mg35XRkh2EHHVCyrthR7Lb75RfJ9J0jH8UZ3Akjza51/mN3N6lwL1KJalUuNQ==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr28683761wrs.179.1576513780139; 
 Mon, 16 Dec 2019 08:29:40 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/62] pc: stubify x86 iommu
Date: Mon, 16 Dec 2019 17:28:36 +0100
Message-Id: <1576513726-53700-53-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow building microvm without x86-iommu.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Kconfig          |  6 ++++++
 hw/i386/Makefile.objs    |  3 ++-
 hw/i386/x86-iommu-stub.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 hw/i386/x86-iommu-stub.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 5a49434..91cf584 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -103,11 +103,17 @@ config MICROVM
     select MC146818RTC
     select VIRTIO_MMIO
 
+config X86_IOMMU
+    bool
+    depends on PC
+
 config VTD
     bool
+    select X86_IOMMU
 
 config AMD_IOMMU
     bool
+    select X86_IOMMU
 
 config VMPORT
     bool
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 01ae202..1236c3b 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -6,7 +6,8 @@ obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
 obj-$(CONFIG_MICROVM) += microvm.o
 obj-y += fw_cfg.o
-obj-y += x86-iommu.o
+obj-$(CONFIG_X86_IOMMU) += x86-iommu.o
+obj-$(call lnot,$(CONFIG_X86_IOMMU)) += x86-iommu-stub.o
 obj-$(CONFIG_VTD) += intel_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
new file mode 100644
index 0000000..03576cd
--- /dev/null
+++ b/hw/i386/x86-iommu-stub.c
@@ -0,0 +1,34 @@
+/*
+ * Stubs for X86 IOMMU emulation
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i386/x86-iommu.h"
+
+void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
+                                     iec_notify_fn fn, void *data)
+{
+}
+
+X86IOMMUState *x86_iommu_get_default(void)
+{
+    return NULL;
+}
+
-- 
1.8.3.1



