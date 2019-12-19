Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 03:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE0721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 03:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE0721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihmIS-0004Fw-K6
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 22:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1ihmHI-00035L-Fe
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 22:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1ihmHH-0006Oy-7h
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 22:15:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1ihmHG-0006Lf-Tc
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 22:15:03 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJ382x3045220
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 22:15:01 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x00sf0n9c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 22:15:01 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Thu, 19 Dec 2019 03:14:59 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Dec 2019 03:14:57 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBJ3EDwn25625056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2019 03:14:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DB81A4054;
 Thu, 19 Dec 2019 03:14:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62772A405B;
 Thu, 19 Dec 2019 03:14:55 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.85.82.30])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Dec 2019 03:14:55 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Date: Thu, 19 Dec 2019 08:44:45 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219031445.8949-1-bharata@linux.ibm.com>
References: <20191219031445.8949-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121903-4275-0000-0000-000003908A39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121903-4276-0000-0000-000038A455A8
Message-Id: <20191219031445.8949-3-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=1 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190025
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: paulus@ozlabs.org, linuxram@us.ibm.com,
 Bharata B Rao <bharata@linux.ibm.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A pseries guest can be run as a secure guest on Ultravisor-enabled
POWER platforms. When such a secure guest is reset, we need to
release/reset a few resources both on ultravisor and hypervisor side.
This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
machine reset path.

As part of this ioctl, the secure guest is essentially transitioned
back to normal mode so that it can reboot like a regular guest and
become secure again.

This ioctl has no effect when invoked for a normal guest. If this ioctl
fails for a secure guest, the guest is terminated.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 hw/ppc/spapr.c       |  1 +
 target/ppc/kvm.c     | 15 +++++++++++++++
 target/ppc/kvm_ppc.h |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f11422fc41..e62c89b3dd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *machine)
     void *fdt;
     int rc;
 
+    kvmppc_svm_off(&error_fatal);
     spapr_caps_apply(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7406d18945..5e24ae701f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2900,3 +2900,18 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
         kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
     }
 }
+
+/*
+ * Don't set error if KVM_PPC_SVM_OFF ioctl is invoked on kernels
+ * that don't support this ioctl.
+ */
+void kvmppc_svm_off(Error **errp)
+{
+    int rc;
+    KVMState *s = KVM_STATE(current_machine->accelerator);
+
+    rc = kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
+    if (rc && rc != -ENOTTY) {
+        error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
+    }
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 47b08a4030..9a9bca1b72 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
+void kvmppc_svm_off(Error **errp);
 #ifndef CONFIG_USER_ONLY
 bool kvmppc_spapr_use_multitce(void);
 int kvmppc_spapr_enable_inkernel_multitce(void);
@@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
     return 0;
 }
 
+static inline void kvmppc_svm_off(Error **errp)
+{
+    return;
+}
+
 static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
                                              unsigned int online)
 {
-- 
2.21.0


