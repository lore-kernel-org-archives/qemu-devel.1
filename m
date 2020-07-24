Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934AE2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWK4FnS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934AE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyytv-0000MH-SN
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyr9-0004DM-Nx
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:39:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyr7-0005jA-QT
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nRggL5zxzjIAsO7gyoMqTDoUEqTrKmVpKuZXCETtsg=;
 b=VWK4FnS/WxqcVt2yjSdNqqDjFrRHxHa80eSsVno8vi1kqxUOR1u4hOTnVO8MGAkxteiwmN
 H0AVRqZAceBSDxlJuRsN2dnyH1ijaWIH0U14swiE6qfDetwSyNzVLi+SqnyH7uCa3TOvvm
 AXl241NwS8RtBRHVlqTk1KVk0wLdrhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-k-R5_GGuNtWpX1DMAVIBxQ-1; Fri, 24 Jul 2020 10:38:12 -0400
X-MC-Unique: k-R5_GGuNtWpX1DMAVIBxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B57E1C7468;
 Fri, 24 Jul 2020 14:38:10 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D71C710AC;
 Fri, 24 Jul 2020 14:38:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv3 4/9] s390x: prepare for more diag500 hypercalls
Date: Fri, 24 Jul 2020 16:37:45 +0200
Message-Id: <20200724143750.59836-5-david@redhat.com>
In-Reply-To: <20200724143750.59836-1-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's generalize, abstacting the virtio bits. diag500 is now a generic
hypercall to handle QEMU/KVM specific things. Explicitly specify all
already defined subcodes, including legacy ones (so we know what we can
use for new hypercalls). While at it, move exception handling into the
handler.

We'll rename the files separately, so git properly detects the rename.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-hcall.c | 14 +++++++-------
 hw/s390x/s390-virtio-hcall.h | 12 ++++++------
 target/s390x/kvm.c           | 15 +++------------
 target/s390x/misc_helper.c   |  3 ++-
 4 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index 5e14bd49b7..7c4ca5d3b2 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390
+ * Support for QEMU/KVM-specific hypercalls on s390
  *
  * Copyright 2012 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -44,18 +44,18 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t queue)
     return 0;
 }
 
-int s390_virtio_hypercall(CPUS390XState *env)
+void handle_diag_500(CPUS390XState *env, uintptr_t ra)
 {
      const uint64_t subcode = env->regs[1];
 
      switch (subcode) {
-     case KVM_S390_VIRTIO_NOTIFY:
+     case DIAG500_VIRTIO_NOTIFY:
          env->regs[2] = handle_virtio_notify(env->regs[2]);
-         return 0;
-     case KVM_S390_VIRTIO_CCW_NOTIFY:
+         break;
+     case DIAG500_VIRTIO_CCW_NOTIFY:
          env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
-         return 0;
+         break;
      default:
-         return -EINVAL;
+         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
      }
 }
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 67e11ea39a..2214216ce8 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390x
+ * Support for QEMU/KVM-specific hypercalls on s390
  *
  * Copyright IBM Corp. 2012, 2017
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -12,10 +12,10 @@
 #ifndef HW_S390_VIRTIO_HCALL_H
 #define HW_S390_VIRTIO_HCALL_H
 
-#include "standard-headers/asm-s390/virtio-ccw.h"
+#define DIAG500_VIRTIO_NOTIFY          0 /* legacy, implemented as a NOP */
+#define DIAG500_VIRTIO_RESET           1 /* legacy */
+#define DIAG500_VIRTIO_SET_STATUS      2 /* legacy */
+#define DIAG500_VIRTIO_CCW_NOTIFY      3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
 
-/* The only thing that we need from the old kvm_virtio.h file */
-#define KVM_S390_VIRTIO_NOTIFY 0
-
-int s390_virtio_hypercall(CPUS390XState *env);
+void handle_diag_500(CPUS390XState *env, uintptr_t ra);
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f2f75d2a57..dc00750387 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1551,18 +1551,9 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
     return r;
 }
 
-static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
+static void handle_hypercall(S390CPU *cpu, struct kvm_run *run)
 {
-    CPUS390XState *env = &cpu->env;
-    int ret;
-
-    ret = s390_virtio_hypercall(env);
-    if (ret == -EINVAL) {
-        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
-        return 0;
-    }
-
-    return ret;
+    handle_diag_500(&cpu->env, RA_IGNORED);
 }
 
 static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
@@ -1621,7 +1612,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
         kvm_handle_diag_308(cpu, run);
         break;
     case DIAG_KVM_HYPERCALL:
-        r = handle_hypercall(cpu, run);
+        handle_hypercall(cpu, run);
         break;
     case DIAG_KVM_BREAKPOINT:
         r = handle_sw_breakpoint(cpu, run);
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 58dbc023eb..cfcbfbe50c 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -119,8 +119,9 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     case 0x500:
         /* KVM hypercall */
         qemu_mutex_lock_iothread();
-        r = s390_virtio_hypercall(env);
+        handle_diag_500(env, GETPC());
         qemu_mutex_unlock_iothread();
+        r = 0;
         break;
     case 0x44:
         /* yield */
-- 
2.26.2


