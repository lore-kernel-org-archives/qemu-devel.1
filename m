Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62226C433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E14620737
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I8R/r6K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E14620737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jynxR-0003wS-D8
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 23:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuL-0007El-9L; Thu, 23 Jul 2020 22:58:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59865 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuJ-00060G-BL; Thu, 23 Jul 2020 22:58:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCYlv33w0z9sSt; Fri, 24 Jul 2020 12:57:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595559467;
 bh=aXMwhPSEkPHTpzErQPz4f4zNkJ2AVJxzRI0h3KgdOaE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I8R/r6K0P/IZg9wSKSjVg8EjaXlXMJmGktM9HhxalYdYd1gB7LXXgFxkcmHIyQHqn
 yxPqtlhIW670eVcVZpL3C3m1uB0rstBiBaYembN8TPTdsKUsNqvjo+wNjHOe5V8GXt
 lrZfMdVdBphNf6F/mciBlXPWMn31lLx5pZr4iUis=
From: David Gibson <david@gibson.dropbear.id.au>
To: dgilbert@redhat.com, frankja@linux.ibm.com, pair@us.ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com
Subject: [for-5.2 v4 01/10] host trust limitation: Introduce new host trust
 limitation interface
Date: Fri, 24 Jul 2020 12:57:35 +1000
Message-Id: <20200724025744.69644-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724025744.69644-1-david@gibson.dropbear.id.au>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 22:57:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
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

To (partially) unify handling for these, this introduces a new
HostTrustLimitation QOM interface.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 backends/Makefile.objs               |  2 ++
 backends/host-trust-limitation.c     | 29 ++++++++++++++++++++++++
 include/exec/host-trust-limitation.h | 33 ++++++++++++++++++++++++++++
 include/qemu/typedefs.h              |  1 +
 4 files changed, 65 insertions(+)
 create mode 100644 backends/host-trust-limitation.c
 create mode 100644 include/exec/host-trust-limitation.h

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 22d204cb48..dcb8f58d31 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -21,3 +21,5 @@ common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
 common-obj-$(CONFIG_GIO) += dbus-vmstate.o
 dbus-vmstate.o-cflags = $(GIO_CFLAGS)
 dbus-vmstate.o-libs = $(GIO_LIBS)
+
+common-obj-y += host-trust-limitation.o
diff --git a/backends/host-trust-limitation.c b/backends/host-trust-limitation.c
new file mode 100644
index 0000000000..96a381cd8a
--- /dev/null
+++ b/backends/host-trust-limitation.c
@@ -0,0 +1,29 @@
+/*
+ * QEMU Host Trust Limitation interface
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
+#include "exec/host-trust-limitation.h"
+
+static const TypeInfo host_trust_limitation_info = {
+    .name = TYPE_HOST_TRUST_LIMITATION,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(HostTrustLimitationClass),
+};
+
+static void host_trust_limitation_register_types(void)
+{
+    type_register_static(&host_trust_limitation_info);
+}
+
+type_init(host_trust_limitation_register_types)
diff --git a/include/exec/host-trust-limitation.h b/include/exec/host-trust-limitation.h
new file mode 100644
index 0000000000..03887b1be1
--- /dev/null
+++ b/include/exec/host-trust-limitation.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU Host Trust Limitation interface
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
+#ifndef QEMU_HOST_TRUST_LIMITATION_H
+#define QEMU_HOST_TRUST_LIMITATION_H
+
+#include "qom/object.h"
+
+#define TYPE_HOST_TRUST_LIMITATION "host-trust-limitation"
+#define HOST_TRUST_LIMITATION(obj)                                    \
+    INTERFACE_CHECK(HostTrustLimitation, (obj),                       \
+                    TYPE_HOST_TRUST_LIMITATION)
+#define HOST_TRUST_LIMITATION_CLASS(klass)                            \
+    OBJECT_CLASS_CHECK(HostTrustLimitationClass, (klass),             \
+                       TYPE_HOST_TRUST_LIMITATION)
+#define HOST_TRUST_LIMITATION_GET_CLASS(obj)                          \
+    OBJECT_GET_CLASS(HostTrustLimitationClass, (obj),                 \
+                     TYPE_HOST_TRUST_LIMITATION)
+
+typedef struct HostTrustLimitationClass {
+    InterfaceClass parent;
+} HostTrustLimitationClass;
+
+#endif /* QEMU_HOST_TRUST_LIMITATION_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 427027a970..624d59c037 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -51,6 +51,7 @@ typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
 typedef struct HostMemoryBackend HostMemoryBackend;
+typedef struct HostTrustLimitation HostTrustLimitation;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
 typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
-- 
2.26.2


