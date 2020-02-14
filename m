Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A35FC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608782168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608782168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2clV-0004qn-E3
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciW-0006wk-MF
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciV-0006B9-FH
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j2ciV-0006AK-7t
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01EFGZve006910
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:18 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j8gmhq6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:18 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 14 Feb 2020 15:17:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Feb 2020 15:17:14 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01EFHDgw37028084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 15:17:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8874A4051;
 Fri, 14 Feb 2020 15:17:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B575A4057;
 Fri, 14 Feb 2020 15:17:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.191.187])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 15:17:12 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/17] s390x: protvirt: Set guest IPL PSW
Date: Fri, 14 Feb 2020 10:16:31 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151636.8764-1-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021415-0008-0000-0000-00000352DDEB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021415-0009-0000-0000-00004A738AF0
Message-Id: <20200214151636.8764-13-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-14_04:2020-02-12,
 2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140121
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
Cc: mihajlov@linux.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handling of CPU reset and setting of the IPL psw from guest storage at
offset 0 is done by a Ultravisor call. Let's only fetch it if
necessary.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/pv.c             |  6 ++++++
 hw/s390x/pv.h             |  2 ++
 linux-headers/linux/kvm.h |  1 +
 target/s390x/cpu.c        | 23 ++++++++++++++---------
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index 5b6a26cba9..845764859c 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -28,6 +28,7 @@ const char* cmd_names[] = {
     "VM_UNSHARE_ALL",
     "VCPU_CREATE",
     "VCPU_DESTROY",
+    "VCPU_SET_IPL_PSW",
     NULL
 };
 
@@ -124,6 +125,11 @@ int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
     return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
 }
 
+void s390_pv_set_ipl_psw(CPUState *cs)
+{
+    s390_pv_cmd_vcpu_exit(cs, KVM_PV_VCPU_SET_IPL_PSW, NULL);
+}
+
 /*
  * Called for each component in the SE type IPL parameter block 0.
  */
diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
index 7d20bdd12e..3d37af01ad 100644
--- a/hw/s390x/pv.h
+++ b/hw/s390x/pv.h
@@ -19,6 +19,7 @@ void s390_pv_vm_destroy(void);
 void s390_pv_vcpu_destroy(CPUState *cs);
 int s390_pv_vcpu_create(CPUState *cs);
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
+void s390_pv_set_ipl_psw(CPUState *cs);
 int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
 void s390_pv_perf_clear_reset(void);
 int s390_pv_verify(void);
@@ -29,6 +30,7 @@ void s390_pv_vm_destroy(void) {}
 void s390_pv_vcpu_destroy(CPUState *cs) {}
 int s390_pv_vcpu_create(CPUState *cs) { return 0; }
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) { return 0; }
+void s390_pv_set_ipl_psw(CPUState *cs) {}
 int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0: }
 void s390_pv_perf_clear_reset(void) {}
 int s390_pv_verify(void) { return 0; }
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c6f0d04115..85094bf443 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1503,6 +1503,7 @@ enum pv_cmd_id {
 	KVM_PV_VM_UNSHARE_ALL,
 	KVM_PV_VCPU_CREATE,
 	KVM_PV_VCPU_DESTROY,
+	KVM_PV_VCPU_SET_IPL_PSW,
 };
 
 struct kvm_pv_cmd {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1dbd84b9d7..24bb0d83ae 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -78,16 +78,21 @@ static bool s390_cpu_has_work(CPUState *cs)
 static void s390_cpu_load_normal(CPUState *s)
 {
     S390CPU *cpu = S390_CPU(s);
-    uint64_t spsw = ldq_phys(s->as, 0);
-
-    cpu->env.psw.mask = spsw & 0xffffffff80000000ULL;
-    /*
-     * Invert short psw indication, so SIE will report a specification
-     * exception if it was not set.
-     */
-    cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
-    cpu->env.psw.addr = spsw & 0x7fffffffULL;
+    CPUS390XState *env = &cpu->env;
+    uint64_t spsw;
 
+    if (!env->pv) {
+        spsw = ldq_phys(s->as, 0);
+        cpu->env.psw.mask = spsw & 0xffffffff80000000ULL;
+        /*
+         * Invert short psw indication, so SIE will report a specification
+         * exception if it was not set.
+         */
+        cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
+        cpu->env.psw.addr = spsw & 0x7fffffffULL;
+    } else {
+        s390_pv_set_ipl_psw(s);
+    }
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 #endif
-- 
2.20.1


