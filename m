Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF51C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF2C24671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUAAx3Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF2C24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnmS-0000sA-V2
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ifnf1-0000By-TO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ifnf0-0001GK-A6
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ifnf0-0001FO-3y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RyiNGZBK+I1IuNyF19r9i05wMa4bRY1ZaqLueSYmug=;
 b=aUAAx3Wp3kDXNn6i29vNAAovvvnJ8yqDuVcmm/FTPyXhgDeP/9vxAFNokLHNNGzU9P2mei
 yD2VmqZzqa168M3GahAzKtw+8oeNDtvCAMKcx9ltiJZabWeURZUvS+0tg23Aho7/eKwHIg
 V3HXQtCRlZ7NSKUPIIkrn20FWv/Ndb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-UaX0mvpWMkmmNoGhZOZUZw-1; Fri, 13 Dec 2019 11:19:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1690A801E77;
 Fri, 13 Dec 2019 16:19:17 +0000 (UTC)
Received: from localhost (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AA3319C70;
 Fri, 13 Dec 2019 16:19:13 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/16] s390x: Move initial reset
Date: Fri, 13 Dec 2019 17:18:40 +0100
Message-Id: <20191213161851.24687-6-cohuck@redhat.com>
In-Reply-To: <20191213161851.24687-1-cohuck@redhat.com>
References: <20191213161851.24687-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UaX0mvpWMkmmNoGhZOZUZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's move the intial reset into the reset handler and cleanup
afterwards.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191128083723.11937-1-frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu-qom.h |  2 +-
 target/s390x/cpu.c     | 46 +++++++++++++++++-------------------------
 target/s390x/cpu.h     |  2 +-
 target/s390x/sigp.c    |  2 +-
 4 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index f3b71bac67c9..6f0a12042ed4 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -36,6 +36,7 @@ typedef struct S390CPUDef S390CPUDef;
=20
 typedef enum cpu_reset_type {
     S390_CPU_RESET_NORMAL,
+    S390_CPU_RESET_INITIAL,
 } cpu_reset_type;
=20
 /**
@@ -62,7 +63,6 @@ typedef struct S390CPUClass {
     void (*parent_reset)(CPUState *cpu);
     void (*load_normal)(CPUState *cpu);
     void (*reset)(CPUState *cpu, cpu_reset_type type);
-    void (*initial_cpu_reset)(CPUState *cpu);
 } S390CPUClass;
=20
 typedef struct S390CPU S390CPU;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 67d6fbfa4401..ca62fe768569 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -94,6 +94,23 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type t=
ype)
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
=20
     switch (type) {
+    case S390_CPU_RESET_INITIAL:
+        /* initial reset does not clear everything! */
+        memset(&env->start_initial_reset_fields, 0,
+               offsetof(CPUS390XState, end_reset_fields) -
+               offsetof(CPUS390XState, start_initial_reset_fields));
+
+        /* architectured initial value for Breaking-Event-Address register=
 */
+        env->gbea =3D 1;
+
+        /* architectured initial values for CR 0 and 14 */
+        env->cregs[0] =3D CR0_RESET;
+        env->cregs[14] =3D CR14_RESET;
+
+        /* tininess for underflow is detected before rounding */
+        set_float_detect_tininess(float_tininess_before_rounding,
+                                  &env->fpu_status);
+       /* fall through */
     case S390_CPU_RESET_NORMAL:
         env->pfault_token =3D -1UL;
         env->bpbc =3D false;
@@ -101,35 +118,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type=
 type)
     default:
         g_assert_not_reached();
     }
-}
-
-/* S390CPUClass::initial_reset() */
-static void s390_cpu_initial_reset(CPUState *s)
-{
-    S390CPU *cpu =3D S390_CPU(s);
-    CPUS390XState *env =3D &cpu->env;
-
-    s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
-    /* initial reset does not clear everything! */
-    memset(&env->start_initial_reset_fields, 0,
-        offsetof(CPUS390XState, end_reset_fields) -
-        offsetof(CPUS390XState, start_initial_reset_fields));
-
-    /* architectured initial values for CR 0 and 14 */
-    env->cregs[0] =3D CR0_RESET;
-    env->cregs[14] =3D CR14_RESET;
-
-    /* architectured initial value for Breaking-Event-Address register */
-    env->gbea =3D 1;
-
-    env->pfault_token =3D -1UL;
-
-    /* tininess for underflow is detected before rounding */
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->fpu_status);
=20
     /* Reset state inside the kernel that we cannot access yet from QEMU. =
*/
-    if (kvm_enabled()) {
+    if (kvm_enabled() && type !=3D S390_CPU_RESET_NORMAL) {
         kvm_s390_reset_vcpu(cpu);
     }
 }
@@ -481,7 +472,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *=
data)
     scc->load_normal =3D s390_cpu_load_normal;
 #endif
     scc->reset =3D s390_cpu_reset;
-    scc->initial_cpu_reset =3D s390_cpu_initial_reset;
     cc->reset =3D s390_cpu_full_reset;
     cc->class_by_name =3D s390_cpu_class_by_name,
     cc->has_work =3D s390_cpu_has_work;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 18123dfd5bd1..d2af13b345cc 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -748,7 +748,7 @@ static inline void s390_do_cpu_initial_reset(CPUState *=
cs, run_on_cpu_data arg)
 {
     S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
=20
-    scc->initial_cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_INITIAL);
 }
=20
 static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data a=
rg)
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 850139b9cd54..727875bb4ab9 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -254,7 +254,7 @@ static void sigp_initial_cpu_reset(CPUState *cs, run_on=
_cpu_data arg)
     SigpInfo *si =3D arg.host_ptr;
=20
     cpu_synchronize_state(cs);
-    scc->initial_cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_INITIAL);
     cpu_synchronize_post_reset(cs);
     si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
 }
--=20
2.21.0


