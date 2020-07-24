Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD09BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586FA20737
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n0zBs27t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586FA20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyo01-0007GR-BM
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 23:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuQ-0007NB-5i; Thu, 23 Jul 2020 22:58:06 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuO-00061i-6F; Thu, 23 Jul 2020 22:58:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCYlw0lN1z9sTH; Fri, 24 Jul 2020 12:57:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595559468;
 bh=Oy4RlJb/Bjycm/HhrLyUbyYuUJPIz3gMN+mQh6H8/u4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n0zBs27t5hcUyQFkH4E/1ktWWBZ+c3ZmHt0tdrUktlpOzPYjZvwh6q2aO3c0+v1tK
 ur1QYvSNzrnjuElvIEy3qTA68pRjKgy7lEzRHqYhl1AHevAdpjaopdo5cs7FxslqeL
 At78BKwQczW28ygQEUul8Bsr9hU4sTErkSIFmxX0=
From: David Gibson <david@gibson.dropbear.id.au>
To: dgilbert@redhat.com, frankja@linux.ibm.com, pair@us.ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com
Subject: [for-5.2 v4 07/10] spapr: Add PEF based host trust limitation
Date: Fri, 24 Jul 2020 12:57:41 +1000
Message-Id: <20200724025744.69644-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724025744.69644-1-david@gibson.dropbear.id.au>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
 Ram Pai <linuxram@us.ibm.com>, mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some upcoming POWER machines have a system called PEF (Protected
Execution Facility) which uses a small ultravisor to allow guests to
run in a way that they can't be eavesdropped by the hypervisor.  The
effect is roughly similar to AMD SEV, although the mechanisms are
quite different.

Most of the work of this is done between the guest, KVM and the
ultravisor, with little need for involvement by qemu.  However qemu
does need to tell KVM to allow secure VMs.

Because the availability of secure mode is a guest visible difference
which depends on having the right hardware and firmware, we don't
enable this by default.  In order to run a secure guest you need to
create a "pef-guest" object and set the host-trust-limitation machine
property to point to it.

Note that this just *allows* secure guests, the architecture of PEF is
such that the guest still needs to talk to the ultravisor to enter
secure mode.  Qemu has no directly way of knowing if the guest is in
secure mode, and certainly can't know until well after machine
creation time.

To start a PEF-capable guest, use the command line options:
    -object pef-guest,id=pef0 -machine host-trust-limitation=pef0

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Ram Pai <linuxram@us.ibm.com>
---
 target/ppc/Makefile.objs |  2 +-
 target/ppc/pef.c         | 83 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 target/ppc/pef.c

diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index e8fa18ce13..ac93b9700e 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -6,7 +6,7 @@ obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o arch_dump.o
 obj-$(TARGET_PPC64) += mmu-hash64.o mmu-book3s-v3.o compat.o
 obj-$(TARGET_PPC64) += mmu-radix64.o
 endif
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM) += kvm.o pef.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-y += dfp_helper.o
 obj-y += excp_helper.o
diff --git a/target/ppc/pef.c b/target/ppc/pef.c
new file mode 100644
index 0000000000..53a6af0347
--- /dev/null
+++ b/target/ppc/pef.c
@@ -0,0 +1,83 @@
+/*
+ * PEF (Protected Execution Facility) for POWER support
+ *
+ * Copyright David Gibson, Redhat Inc. 2020
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/kvm.h"
+#include "migration/blocker.h"
+#include "exec/host-trust-limitation.h"
+
+#define TYPE_PEF_GUEST "pef-guest"
+#define PEF_GUEST(obj)                                  \
+    OBJECT_CHECK(PefGuestState, (obj), TYPE_PEF_GUEST)
+
+typedef struct PefGuestState PefGuestState;
+
+/**
+ * PefGuestState:
+ *
+ * The PefGuestState object is used for creating and managing a PEF
+ * guest.
+ *
+ * # $QEMU \
+ *         -object pef-guest,id=pef0 \
+ *         -machine ...,host-trust-limitation=pef0
+ */
+struct PefGuestState {
+    Object parent_obj;
+};
+
+static int pef_kvm_init(HostTrustLimitation *gmpo, Error **errp)
+{
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_SECURE_GUEST)) {
+        error_setg(errp,
+                   "KVM implementation does not support Secure VMs (is an ultravisor running?)");
+        return -1;
+    } else {
+        int ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_SECURE_GUEST, 0, 1);
+
+        if (ret < 0) {
+            error_setg(errp,
+                       "Error enabling PEF with KVM");
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static void pef_guest_class_init(ObjectClass *oc, void *data)
+{
+    HostTrustLimitationClass *gmpc = HOST_TRUST_LIMITATION_CLASS(oc);
+
+    gmpc->kvm_init = pef_kvm_init;
+}
+
+static const TypeInfo pef_guest_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_PEF_GUEST,
+    .instance_size = sizeof(PefGuestState),
+    .class_init = pef_guest_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOST_TRUST_LIMITATION },
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void
+pef_register_types(void)
+{
+    type_register_static(&pef_guest_info);
+}
+
+type_init(pef_register_types);
-- 
2.26.2


