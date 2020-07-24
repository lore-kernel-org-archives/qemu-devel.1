Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC84020737
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pSuzO9oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC84020737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyo18-0000qw-0I
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 23:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuR-0007QF-9y; Thu, 23 Jul 2020 22:58:07 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36865 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuO-00061o-BI; Thu, 23 Jul 2020 22:58:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCYlw2nzSz9sTT; Fri, 24 Jul 2020 12:57:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595559468;
 bh=/o46AHd29VbcsNq9WcZf6nE94CsdYc+R5nZVL/Rr/HI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pSuzO9oG4N0zQaZIvbeJU7FN70QP4ZKEEpvcOr/jb4KRvrGtL4GgERFkyKACeAnXN
 C3V2s+HwQakiko3lp4TBXkrCi7CoBZhihn8CuBdR0/9T1ELAjFSeGV7tcu2j5wPuxC
 6hX7tzTwsR/GqgVUfC1xdRMGLpbwYxSnB6k/qEEE=
From: David Gibson <david@gibson.dropbear.id.au>
To: dgilbert@redhat.com, frankja@linux.ibm.com, pair@us.ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com
Subject: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Date: Fri, 24 Jul 2020 12:57:44 +1000
Message-Id: <20200724025744.69644-11-david@gibson.dropbear.id.au>
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
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least some s390 cpu models support "Protected Virtualization" (PV),
a mechanism to protect guests from eavesdropping by a compromised
hypervisor.

This is similar in function to other mechanisms like AMD's SEV and
POWER's PEF, which are controlled bythe "host-trust-limitation"
machine option.  s390 is a slightly special case, because we already
supported PV, simply by using a CPU model with the required feature
(S390_FEAT_UNPACK).

To integrate this with the option used by other platforms, we
implement the following compromise:

 - When the host-trust-limitation option is set, s390 will recognize
   it, verify that the CPU can support PV (failing if not) and set
   virtio default options necessary for encrypted or protected guests,
   as on other platforms.  i.e. if host-trust-limitation is set, we
   will either create a guest capable of entering PV mode, or fail
   outright

 - If host-trust-limitation is not set, guest's might still be able to
   enter PV mode, if the CPU has the right model.  This may be a
   little surprising, but shouldn't actually be harmful.

To start a guest supporting Protected Virtualization using the new
option use the command line arguments:
    -object s390-pv-guest,id=pv0 -machine host-trust-limitation=pv0

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/s390x/pv.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index ab3a2482aa..4bf3b345b6 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -14,8 +14,11 @@
 #include <linux/kvm.h>
 
 #include "cpu.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "qom/object_interfaces.h"
+#include "exec/host-trust-limitation.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/pv.h"
 
@@ -111,3 +114,61 @@ void s390_pv_inject_reset_error(CPUState *cs)
     /* Report that we are unable to enter protected mode */
     env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
 }
+
+#define TYPE_S390_PV_GUEST "s390-pv-guest"
+#define S390_PV_GUEST(obj)                              \
+    OBJECT_CHECK(S390PVGuestState, (obj), TYPE_S390_PV_GUEST)
+
+typedef struct S390PVGuestState S390PVGuestState;
+
+/**
+ * S390PVGuestState:
+ *
+ * The S390PVGuestState object is basically a dummy used to tell the
+ * host trust limitation system to use s390's PV mechanism.  guest.
+ *
+ * # $QEMU \
+ *         -object s390-pv-guest,id=pv0 \
+ *         -machine ...,host-trust-limitation=pv0
+ */
+struct S390PVGuestState {
+    Object parent_obj;
+};
+
+static int s390_pv_kvm_init(HostTrustLimitation *gmpo, Error **errp)
+{
+    if (!s390_has_feat(S390_FEAT_UNPACK)) {
+        error_setg(errp,
+                   "CPU model does not support Protected Virtualization");
+        return -1;
+    }
+
+    return 0;
+}
+
+static void s390_pv_guest_class_init(ObjectClass *oc, void *data)
+{
+    HostTrustLimitationClass *gmpc = HOST_TRUST_LIMITATION_CLASS(oc);
+
+    gmpc->kvm_init = s390_pv_kvm_init;
+}
+
+static const TypeInfo s390_pv_guest_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_S390_PV_GUEST,
+    .instance_size = sizeof(S390PVGuestState),
+    .class_init = s390_pv_guest_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOST_TRUST_LIMITATION },
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void
+s390_pv_register_types(void)
+{
+    type_register_static(&s390_pv_guest_info);
+}
+
+type_init(s390_pv_register_types);
-- 
2.26.2


