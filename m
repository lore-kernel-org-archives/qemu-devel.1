Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F23C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CD92071E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD92071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieD5m-0008NA-OL
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 02:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1ieD24-0004Cb-1M
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1ieD22-0008Pc-Ps
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:00:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36722
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1ieD20-0008NM-6B
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:00:33 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB96vLNj130717
 for <qemu-devel@nongnu.org>; Mon, 9 Dec 2019 02:00:31 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wrtkrmnms-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 02:00:31 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Mon, 9 Dec 2019 07:00:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Dec 2019 07:00:28 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB970Rmr50594008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2019 07:00:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE32052050;
 Mon,  9 Dec 2019 07:00:26 +0000 (GMT)
Received: from bharata.in.ibm.com (unknown [9.109.247.23])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CABBE52071;
 Mon,  9 Dec 2019 07:00:24 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Date: Mon,  9 Dec 2019 12:30:12 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191209070012.14766-1-bharata@linux.ibm.com>
References: <20191209070012.14766-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120907-0008-0000-0000-0000033EFFE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120907-0009-0000-0000-00004A5E2B54
Message-Id: <20191209070012.14766-3-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=1 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090059
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
Cc: linuxram@us.ibm.com, Bharata B Rao <bharata@linux.ibm.com>,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
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

This ioctl has no effect when invoked for a normal guest.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 hw/ppc/spapr.c       | 1 +
 target/ppc/kvm.c     | 7 +++++++
 target/ppc/kvm_ppc.h | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f11422fc41..4c7ad3400d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *machine)
     void *fdt;
     int rc;
 
+    kvmppc_svm_off();
     spapr_caps_apply(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7406d18945..1a86fa4f0c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2900,3 +2900,10 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
         kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
     }
 }
+
+int kvmppc_svm_off(void)
+{
+    KVMState *s = KVM_STATE(current_machine->accelerator);
+
+    return kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 47b08a4030..5cc812e486 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
+int kvmppc_svm_off(void);
 #ifndef CONFIG_USER_ONLY
 bool kvmppc_spapr_use_multitce(void);
 int kvmppc_spapr_enable_inkernel_multitce(void);
@@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
     return 0;
 }
 
+static inline int kvmppc_svm_off(void)
+{
+    return 0;
+}
+
 static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
                                              unsigned int online)
 {
-- 
2.21.0


