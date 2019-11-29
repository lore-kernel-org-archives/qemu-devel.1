Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D6C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9FD215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9FD215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadV4-0005RQ-Ip
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iacto-0003Ha-5k
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iacti-0005MX-Bj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iactf-0005Gl-Tv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:08 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT9mw3G164552
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:49:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar9f7jk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:49:04 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 09:48:46 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 09:48:43 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT9mfKb51511516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 09:48:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FE77A4059;
 Fri, 29 Nov 2019 09:48:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 027C3A404D;
 Fri, 29 Nov 2019 09:48:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 09:48:39 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/13] s390x: protvirt: Set guest IPL PSW
Date: Fri, 29 Nov 2019 04:48:06 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129094809.26684-1-frankja@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112909-0016-0000-0000-000002CDD502
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112909-0017-0000-0000-0000332FBEE8
Message-Id: <20191129094809.26684-11-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_02:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=1 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911290086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handling of CPU reset and setting of the IPL psw from guest storage at
offset 0 is done by a Ultravisor call. Let's only fetch it if
necessary.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/pv.c              | 5 +++++
 hw/s390x/pv.h              | 1 +
 hw/s390x/s390-virtio-ccw.c | 2 +-
 linux-headers/linux/kvm.h  | 1 +
 target/s390x/cpu.c         | 9 ++++++++-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index 0218070322..106252833f 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -88,6 +88,11 @@ int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
     return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
 }
 
+int s390_pv_set_ipl_psw(CPUState *cs)
+{
+    return s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_SET_IPL_PSW, NULL);
+}
+
 /*
  * Called for each component in the SE type IPL parameter block 0.
  */
diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
index eb074e4bc9..e670c67270 100644
--- a/hw/s390x/pv.h
+++ b/hw/s390x/pv.h
@@ -18,6 +18,7 @@ int s390_pv_vm_destroy(void);
 int s390_pv_vcpu_destroy(CPUState *cs);
 int s390_pv_vcpu_create(CPUState *cs);
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
+int s390_pv_set_ipl_psw(CPUState *cs);
 int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
 int s390_pv_perf_clear_reset(void);
 int s390_pv_verify(void);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 6fcd695b81..1133de9423 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -408,7 +408,7 @@ static void s390_machine_reset(MachineState *machine)
         /* Verify integrity */
         s390_pv_verify();
         env->pv = true;
-        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
+        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     default:
         g_assert_not_reached();
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4448d59960..7c6118c703 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1484,6 +1484,7 @@ enum pv_cmd_id {
 	KVM_PV_VM_UNSHARE,
 	KVM_PV_VCPU_CREATE,
 	KVM_PV_VCPU_DESTROY,
+	KVM_PV_VCPU_SET_IPL_PSW,
 };
 
 struct kvm_pv_cmd {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 52fefa1586..8c673dab2c 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -37,6 +37,7 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
+#include "hw/s390x/pv.h"
 #include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
@@ -76,7 +77,13 @@ static bool s390_cpu_has_work(CPUState *cs)
 static void s390_cpu_load_normal(CPUState *s)
 {
     S390CPU *cpu = S390_CPU(s);
-    cpu->env.psw.addr = ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
+    CPUS390XState *env = &cpu->env;
+
+    if (!env->pv) {
+        cpu->env.psw.addr = ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
+    } else {
+        s390_pv_set_ipl_psw(s);
+    }
     cpu->env.psw.mask = PSW_MASK_32 | PSW_MASK_64;
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
-- 
2.20.1


