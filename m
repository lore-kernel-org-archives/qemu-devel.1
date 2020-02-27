Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8DFC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EF820726
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJtgVPpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EF820726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hlp-0001OM-Fo
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7Hkk-0007zH-7F
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7Hki-000197-RG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7Hki-00018T-Mm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582804492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+t71KbZiwkfgBw6etbVkkrRPpGOORRsCMblOeHZ43rE=;
 b=aJtgVPpKFnQOWn78koxfJIdeDGMWjNTI2eq4C6oX/vfRdCKtWDDfUAx0Eyyae3aZwDCtGN
 nfEd/dpsr2rUKm/cGjboT7ytBnEMwVmBdMRP9EVWYrba9v7pYvHe5Xe2tsr3PfNUsiEQ1x
 +SobrhuE7omuBX57MY6Ugqe404LGLE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-ae-WZPW3NYmeDq9jCLvdcw-1; Thu, 27 Feb 2020 06:54:48 -0500
X-MC-Unique: ae-WZPW3NYmeDq9jCLvdcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A0941937FC3;
 Thu, 27 Feb 2020 11:54:47 +0000 (UTC)
Received: from localhost (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76D2F90A01;
 Thu, 27 Feb 2020 11:54:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/7] s390x: Add missing vcpu reset functions
Date: Thu, 27 Feb 2020 12:54:27 +0100
Message-Id: <20200227115431.32364-4-cohuck@redhat.com>
In-Reply-To: <20200227115431.32364-1-cohuck@redhat.com>
References: <20200227115431.32364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
for the initial reset, which was also called for the clear reset. To
be architecture compliant, we also need to clear local interrupts on a
normal reset.

Because of this and the upcoming protvirt support we need to add
ioctls for the missing clear and normal resets.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200214151636.8764-3-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c       | 14 ++++++++++++--
 target/s390x/kvm-stub.c  | 10 +++++++++-
 target/s390x/kvm.c       | 42 ++++++++++++++++++++++++++++++++--------
 target/s390x/kvm_s390x.h |  4 +++-
 4 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index cf84d307c6a6..8da1905485f9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -144,8 +144,18 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type=
 type)
     }
=20
     /* Reset state inside the kernel that we cannot access yet from QEMU. =
*/
-    if (kvm_enabled() && type !=3D S390_CPU_RESET_NORMAL) {
-        kvm_s390_reset_vcpu(cpu);
+    if (kvm_enabled()) {
+        switch (type) {
+        case S390_CPU_RESET_CLEAR:
+            kvm_s390_reset_vcpu_clear(cpu);
+            break;
+        case S390_CPU_RESET_INITIAL:
+            kvm_s390_reset_vcpu_initial(cpu);
+            break;
+        case S390_CPU_RESET_NORMAL:
+            kvm_s390_reset_vcpu_normal(cpu);
+            break;
+        }
     }
 }
=20
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 5152e2bdf19b..c4cd497f850e 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -83,7 +83,15 @@ void kvm_s390_cmma_reset(void)
 {
 }
=20
-void kvm_s390_reset_vcpu(S390CPU *cpu)
+void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
+{
+}
+
+void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
+{
+}
+
+void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
 {
 }
=20
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 30112e529c2e..1d6fd6a27b48 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -151,6 +151,7 @@ static int cap_s390_irq;
 static int cap_ri;
 static int cap_gs;
 static int cap_hpage_1m;
+static int cap_vcpu_resets;
=20
 static int active_cmma;
=20
@@ -342,6 +343,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
+    cap_vcpu_resets =3D kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
=20
     if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
@@ -406,17 +408,41 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
     return 0;
 }
=20
-void kvm_s390_reset_vcpu(S390CPU *cpu)
+static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
 {
     CPUState *cs =3D CPU(cpu);
=20
-    /* The initial reset call is needed here to reset in-kernel
-     * vcpu data that we can't access directly from QEMU
-     * (i.e. with older kernels which don't support sync_regs/ONE_REG).
-     * Before this ioctl cpu_synchronize_state() is called in common kvm
-     * code (kvm-all) */
-    if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
-        error_report("Initial CPU reset failed on CPU %i", cs->cpu_index);
+    /*
+     * The reset call is needed here to reset in-kernel vcpu data that
+     * we can't access directly from QEMU (i.e. with older kernels
+     * which don't support sync_regs/ONE_REG).  Before this ioctl
+     * cpu_synchronize_state() is called in common kvm code
+     * (kvm-all).
+     */
+    if (kvm_vcpu_ioctl(cs, type)) {
+        error_report("CPU reset failed on CPU %i type %lx",
+                     cs->cpu_index, type);
+    }
+}
+
+void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
+{
+    kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
+}
+
+void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
+{
+    if (cap_vcpu_resets) {
+        kvm_s390_reset_vcpu(cpu, KVM_S390_CLEAR_RESET);
+    } else {
+        kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
+    }
+}
+
+void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
+{
+    if (cap_vcpu_resets) {
+        kvm_s390_reset_vcpu(cpu, KVM_S390_NORMAL_RESET);
     }
 }
=20
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index caf985955ba5..0b21789796d7 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -34,7 +34,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifi=
er, uint32_t sch,
                                     int vq, bool assign);
 int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
-void kvm_s390_reset_vcpu(S390CPU *cpu);
+void kvm_s390_reset_vcpu_clear(S390CPU *cpu);
+void kvm_s390_reset_vcpu_normal(S390CPU *cpu);
+void kvm_s390_reset_vcpu_initial(S390CPU *cpu);
 int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
 void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void kvm_s390_crypto_reset(void);
--=20
2.21.1


