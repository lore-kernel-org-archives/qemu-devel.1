Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC80C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483D020828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483D020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGVa-0001uc-DD
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBGUQ-00004x-Bs
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBGUO-0004bR-TD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBGUO-0004ab-LL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029BLZ6R005535
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 07:22:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8n7361b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:22:27 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 11:22:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 11:22:22 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029BMLKj54067266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 11:22:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8853D4C04A;
 Mon,  9 Mar 2020 11:22:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2DFA4C044;
 Mon,  9 Mar 2020 11:22:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.87])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 11:22:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/15] s390x: Add SIDA memory ops
Date: Mon,  9 Mar 2020 07:21:57 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309112206.20261-1-frankja@linux.ibm.com>
References: <20200309112206.20261-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030911-0012-0000-0000-0000038E8E76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030911-0013-0000-0000-000021CB560D
Message-Id: <20200309112206.20261-7-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_02:2020-03-08,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=990 mlxscore=0 suspectscore=1 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090080
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Protected guests save the instruction control blocks in the SIDA
instead of QEMU/KVM directly accessing the guest's memory.

Let's introduce new functions to access the SIDA.

Also the new memops are available with KVM_CAP_S390_PROTECTED, so
let's check for that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h        |  7 ++++++-
 target/s390x/kvm.c        | 25 +++++++++++++++++++++++++
 target/s390x/kvm_s390x.h  |  2 ++
 target/s390x/mmu_helper.c | 14 ++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7e4d9d267c..72b7700dad 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -824,7 +824,12 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
 void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
-
+int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
+                       int len, bool is_write);
+#define s390_cpu_pv_mem_read(cpu, offset, dest, len)    \
+        s390_cpu_pv_mem_rw(cpu, offset, dest, len, false)
+#define s390_cpu_pv_mem_write(cpu, offset, dest, len)       \
+        s390_cpu_pv_mem_rw(cpu, offset, dest, len, true)
 
 /* sigp.c */
 int s390_cpu_restart(S390CPU *cpu);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index eec0b92479..cdcd538b4f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -154,6 +154,7 @@ static int cap_ri;
 static int cap_gs;
 static int cap_hpage_1m;
 static int cap_vcpu_resets;
+static int cap_protected;
 
 static int active_cmma;
 
@@ -346,6 +347,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
     cap_vcpu_resets = kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
+    cap_protected = kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
 
     if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
@@ -846,6 +848,29 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
     return ret;
 }
 
+int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
+                       int len, bool is_write)
+{
+    struct kvm_s390_mem_op mem_op = {
+        .sida_offset = offset,
+        .size = len,
+        .op = is_write ? KVM_S390_MEMOP_SIDA_WRITE
+                       : KVM_S390_MEMOP_SIDA_READ,
+        .buf = (uint64_t)hostbuf,
+    };
+    int ret;
+
+    if (!cap_mem_op || !cap_protected) {
+        return -ENOSYS;
+    }
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
+    if (ret < 0) {
+        error_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
+    }
+    return ret;
+}
+
 /*
  * Legacy layout for s390:
  * Older S390 KVM requires the topmost vma of the RAM to be
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 0b21789796..9c38f6ccce 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -19,6 +19,8 @@ void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
 void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
 int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
                     int len, bool is_write);
+int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
+                       bool is_write);
 void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 0be2f300bb..7d9f3059cd 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -474,6 +474,20 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
     return 0;
 }
 
+int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
+                       int len, bool is_write)
+{
+    int ret;
+
+    if (kvm_enabled()) {
+        ret = kvm_s390_mem_op_pv(cpu, offset, hostbuf, len, is_write);
+    } else {
+        /* Protected Virtualization is a KVM/Hardware only feature */
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
 /**
  * s390_cpu_virt_mem_rw:
  * @laddr:     the logical start address
-- 
2.20.1


