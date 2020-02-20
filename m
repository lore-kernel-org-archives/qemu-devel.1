Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2AC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2909224654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2909224654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lRV-0002mg-2R
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lOl-00065t-Gw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lOk-0006We-6Y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10326
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j4lOk-0006WM-2D
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01KCtG89093004
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubygpbh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:45 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 20 Feb 2020 12:57:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Feb 2020 12:57:40 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01KCvdj837290040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 12:57:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21DF8AE053;
 Thu, 20 Feb 2020 12:57:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 020B9AE045;
 Thu, 20 Feb 2020 12:57:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.185.143])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2020 12:57:37 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/16] s390x: Add SIDA memory ops
Date: Thu, 20 Feb 2020 07:56:29 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220125638.7241-1-frankja@linux.ibm.com>
References: <20200220125638.7241-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022012-0008-0000-0000-00000354BF59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022012-0009-0000-0000-00004A75CF3B
Message-Id: <20200220125638.7241-8-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_03:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=618
 spamscore=0 suspectscore=1 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200097
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Protected guests save the instruction control blocks in the SIDA
instead of QEMU/KVM directly accessing the guest's memory.

Let's introduce new functions to access the SIDA.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 linux-headers/linux/kvm.h |  2 ++
 target/s390x/cpu.h        |  7 ++++++-
 target/s390x/kvm.c        | 23 +++++++++++++++++++++++
 target/s390x/kvm_s390x.h  |  2 ++
 target/s390x/mmu_helper.c |  9 +++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 2e647f2d9b..7ccf5988d2 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -483,6 +483,8 @@ struct kvm_s390_mem_op {
 /* types for kvm_s390_mem_op->op */
 #define KVM_S390_MEMOP_LOGICAL_READ	0
 #define KVM_S390_MEMOP_LOGICAL_WRITE	1
+#define KVM_S390_MEMOP_SIDA_READ	2
+#define KVM_S390_MEMOP_SIDA_WRITE	3
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index cbc53c99cf..491d6860a8 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -823,7 +823,12 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
 void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
-
+int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset,  void *hostbuf,
+                       int len, bool is_write);
+#define s390_cpu_pv_mem_read(cpu, offset, dest, len)    \
+        s390_cpu_pv_mem_rw(cpu, offset, dest, len, false)
+#define s390_cpu_pv_mem_write(cpu, offset, dest, len)       \
+        s390_cpu_pv_mem_rw(cpu, offset, dest, len, true)
 
 /* sigp.c */
 int s390_cpu_restart(S390CPU *cpu);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index eec0b92479..f222836df5 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -846,6 +846,29 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
     return ret;
 }
 
+int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
+                       int len, bool is_write)
+{
+    int ret = 0;
+    struct kvm_s390_mem_op mem_op = {
+        .sida_offset = offset,
+        .size = len,
+        .op = is_write ? KVM_S390_MEMOP_SIDA_WRITE
+                       : KVM_S390_MEMOP_SIDA_READ,
+        .buf = (uint64_t)hostbuf,
+    };
+
+    if (!cap_mem_op) {
+        return -ENOSYS;
+    }
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
+    if (ret < 0) {
+        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
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
index c9f3f34750..ad485399db 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -474,6 +474,15 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
     return 0;
 }
 
+int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
+                       int len, bool is_write)
+{
+    int ret;
+
+    ret = kvm_s390_mem_op_pv(cpu, offset, hostbuf, len, is_write);
+    return ret;
+}
+
 /**
  * s390_cpu_virt_mem_rw:
  * @laddr:     the logical start address
-- 
2.20.1


