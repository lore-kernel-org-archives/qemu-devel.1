Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5518EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2343C20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GPSqg05B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2343C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbcFm-0001fq-9j
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7J-00037J-RE; Wed, 20 May 2020 23:43:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60887 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7I-0003Wy-B1; Wed, 20 May 2020 23:43:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SFns3n23z9sTq; Thu, 21 May 2020 13:43:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590032593;
 bh=5KLDWlcKYyTYo3NQYirtMT0jjuuJjP++orsplm2jw/g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GPSqg05BjZwbm6erLBBKafVtKtXNxUDW5hP+sPLfb1kphPhopYmRy2Gqgw3KSXVHu
 4PAshUTPvB228yu4FvEzJy1BXcoAw2appFcR2QEIunhprXziTsV6ilJqLAjQHaXXNN
 Am+4HY9hn40sP0efS/rBIyJhmF7TRy+ZgfZ5Syfo=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, brijesh.singh@amd.com, frankja@linux.ibm.com,
 dgilbert@redhat.com, pair@us.ibm.com
Subject: [RFC v2 10/18] guest memory protection: Add guest memory protection
 interface
Date: Thu, 21 May 2020 13:42:56 +1000
Message-Id: <20200521034304.340040-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521034304.340040-1-david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Several architectures have mechanisms which are designed to protect guest
memory from interference or eavesdropping by a compromised hypervisor.  AMD
SEV does this with in-chip memory encryption and Intel has a similar
mechanism.  POWER's Protected Execution Framework (PEF) accomplishes a
similar goal using an ultravisor and new memory protection features,
instead of encryption.

This introduces a new GuestMemoryProtection QOM interface which we'll use
to (partially) unify handling of these various mechanisms.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 backends/Makefile.objs                 |  2 ++
 backends/guest-memory-protection.c     | 29 +++++++++++++++++++++
 include/exec/guest-memory-protection.h | 36 ++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 backends/guest-memory-protection.c
 create mode 100644 include/exec/guest-memory-protection.h

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847cd57..e4fb4f5280 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -21,3 +21,5 @@ common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
 common-obj-$(CONFIG_GIO) += dbus-vmstate.o
 dbus-vmstate.o-cflags = $(GIO_CFLAGS)
 dbus-vmstate.o-libs = $(GIO_LIBS)
+
+common-obj-y += guest-memory-protection.o
diff --git a/backends/guest-memory-protection.c b/backends/guest-memory-protection.c
new file mode 100644
index 0000000000..7e538214f7
--- /dev/null
+++ b/backends/guest-memory-protection.c
@@ -0,0 +1,29 @@
+#/*
+ * QEMU Guest Memory Protection interface
+ *
+ * Copyright: David Gibson, Red Hat Inc. 2020
+ *
+ * Authors:
+ *  David Gibson <david@gibson.dropbear.id.au>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "exec/guest-memory-protection.h"
+
+static const TypeInfo guest_memory_protection_info = {
+    .name = TYPE_GUEST_MEMORY_PROTECTION,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(GuestMemoryProtectionClass),
+};
+
+static void guest_memory_protection_register_types(void)
+{
+    type_register_static(&guest_memory_protection_info);
+}
+
+type_init(guest_memory_protection_register_types)
diff --git a/include/exec/guest-memory-protection.h b/include/exec/guest-memory-protection.h
new file mode 100644
index 0000000000..38e9b01667
--- /dev/null
+++ b/include/exec/guest-memory-protection.h
@@ -0,0 +1,36 @@
+#/*
+ * QEMU Guest Memory Protection interface
+ *
+ * Copyright: David Gibson, Red Hat Inc. 2020
+ *
+ * Authors:
+ *  David Gibson <david@gibson.dropbear.id.au>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef QEMU_GUEST_MEMORY_PROTECTION_H
+#define QEMU_GUEST_MEMORY_PROTECTION_H
+
+#include "qom/object.h"
+
+typedef struct GuestMemoryProtection GuestMemoryProtection;
+
+#define TYPE_GUEST_MEMORY_PROTECTION "guest-memory-protection"
+#define GUEST_MEMORY_PROTECTION(obj)                                    \
+    INTERFACE_CHECK(GuestMemoryProtection, (obj),                       \
+                    TYPE_GUEST_MEMORY_PROTECTION)
+#define GUEST_MEMORY_PROTECTION_CLASS(klass)                            \
+    OBJECT_CLASS_CHECK(GuestMemoryProtectionClass, (klass),             \
+                       TYPE_GUEST_MEMORY_PROTECTION)
+#define GUEST_MEMORY_PROTECTION_GET_CLASS(obj)                          \
+    OBJECT_GET_CLASS(GuestMemoryProtectionClass, (obj),                 \
+                     TYPE_GUEST_MEMORY_PROTECTION)
+
+typedef struct GuestMemoryProtectionClass {
+    InterfaceClass parent;
+} GuestMemoryProtectionClass;
+
+#endif /* QEMU_GUEST_MEMORY_PROTECTION_H */
+
-- 
2.26.2


