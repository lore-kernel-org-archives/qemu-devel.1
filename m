Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECDC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EC121783
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kZ7xEsTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EC121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hddc1-0003W9-IA
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hddLy-0002g7-Rn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hddLw-0006qz-CG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hddLw-0006gn-1X
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGDi8a121580;
 Wed, 19 Jun 2019 16:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=UXe0e1TANKFu82uWO3nVvsP+tdQVKk7/VXjuuh4srmg=;
 b=kZ7xEsTS2gBeDq867/ec/BhbjZA47VEjsS/bI2qmmtk3ZespQqnQo2Z6Wr5lfTIPuqiU
 oedXCPeTtRNIdcT+sExgGwHke5O0JijX5wrclssAM8ZsHZxOeJmXVDAZ7ms+xGTJlkv1
 xL+oTzfhrlni6by7khWTJmIvtxtKfJEjgy07kFxAXakMVOEvaL6pkLf8hvWdQ8aHqqiQ
 ehU+2hnhgdi6dP2SOxBJVC5BlNyEy0lzY9avemBcoPslQF9Md2ayakzfIFYzlgZ+CDsq
 viNLoBcEzileNyXBJZ23x7bikuABkMrRZfie1J1n+0UZ7hmyONWGf8nLa/3L44wmDk4y Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t7809cgec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGLFLZ060021;
 Wed, 19 Jun 2019 16:22:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2t7rdwr2rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JGM5xg003070;
 Wed, 19 Jun 2019 16:22:05 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 09:22:04 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 19:21:32 +0300
Message-Id: <20190619162140.133674-3-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619162140.133674-1-liran.alon@oracle.com>
References: <20190619162140.133674-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=849 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [QEMU PATCH v4 02/10] KVM: Introduce
 kvm_arch_destroy_vcpu()
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, Liran Alon <liran.alon@oracle.com>,
 pbonzini@redhat.com, rth@twiddle.net, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simiar to how kvm_init_vcpu() calls kvm_arch_init_vcpu() to perform
arch-dependent initialisation, introduce kvm_arch_destroy_vcpu()
to be called from kvm_destroy_vcpu() to perform arch-dependent
destruction.

This was added because some architectures (Such as i386)
currently do not free memory that it have allocated in
kvm_arch_init_vcpu().

Suggested-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 accel/kvm/kvm-all.c  |  5 +++++
 include/sysemu/kvm.h |  1 +
 target/arm/kvm32.c   |  5 +++++
 target/arm/kvm64.c   |  5 +++++
 target/i386/kvm.c    | 12 ++++++++++++
 target/mips/kvm.c    |  5 +++++
 target/ppc/kvm.c     |  5 +++++
 target/s390x/kvm.c   | 10 ++++++++++
 8 files changed, 48 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 524c4ddfbd0f..59a3aa3a40da 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -292,6 +292,11 @@ int kvm_destroy_vcpu(CPUState *cpu)
 
     DPRINTF("kvm_destroy_vcpu\n");
 
+    ret = kvm_arch_destroy_vcpu(cpu);
+    if (ret < 0) {
+        goto err;
+    }
+
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190fed..64f55e519df7 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -371,6 +371,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level);
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
 int kvm_arch_init_vcpu(CPUState *cpu);
+int kvm_arch_destroy_vcpu(CPUState *cpu);
 
 bool kvm_vcpu_id_is_valid(int vcpu_id);
 
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 4e54e372a668..51f78f722b18 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -240,6 +240,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return kvm_arm_init_cpreg_list(cpu);
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+	return 0;
+}
+
 typedef struct Reg {
     uint64_t id;
     int offset;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 998d21f399f4..22d19c9aec6f 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -654,6 +654,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return kvm_arm_init_cpreg_list(cpu);
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
 bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 {
     /* Return true if the regidx is a register we should synchronize
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7aa7914a498c..efbecfc9d7f0 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1352,6 +1352,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return r;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    if (cpu->kvm_msr_buf) {
+        g_free(cpu->kvm_msr_buf);
+        cpu->kvm_msr_buf = NULL;
+    }
+
+    return 0;
+}
+
 void kvm_arch_reset_vcpu(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 8e72850962e1..938f8f144b74 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -91,6 +91,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return ret;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
 void kvm_mips_reset_vcpu(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3bf0a46c3352..1967ccc51791 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -521,6 +521,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return ret;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
 static void kvm_sw_tlb_put(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e5e2b691f253..c2747c31649b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -368,6 +368,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return 0;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    S390CPU *cpu = S390_CPU(cs);
+
+    g_free(cpu->irqstate);
+    cpu->irqstate = NULL;
+
+    return 0;
+}
+
 void kvm_s390_reset_vcpu(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
-- 
2.20.1


