Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D389C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 17:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D54320768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 17:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D54320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMEE6-00058p-1J
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 13:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1jMEDR-0004bz-Mb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 13:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1jMEDQ-0002OC-DH
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 13:10:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52790
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1jMEDQ-0002NP-95
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 13:10:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 038H3fFe090215
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2020 13:10:14 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30921gv7ym-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 13:10:14 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Wed, 8 Apr 2020 18:09:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 8 Apr 2020 18:09:44 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 038HA8tx53411934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Apr 2020 17:10:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95E73A405D;
 Wed,  8 Apr 2020 17:10:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE063A4051;
 Wed,  8 Apr 2020 17:10:05 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.185.131])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  8 Apr 2020 17:10:05 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: david@gibson.dropbear.id.au
Subject: [PATCH] target/ppc: Fix wrong interpretation of the disposition flag.
Date: Wed,  8 Apr 2020 22:39:44 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 20040817-4275-0000-0000-000003BC263A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040817-4276-0000-0000-000038D18B2B
Message-Id: <20200408170944.16003-1-ganeshgr@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_10:2020-04-07,
 2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080127
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
Cc: mahesh@linux.vnet.ibm.com, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bitwise AND with kvm_run->flags to evaluate if we recovered from
MCE or not is not correct, As disposition in kvm_run->flags is a
two-bit integer value and not a bit map, So check for equality
instead of bitwise AND.

Without the fix qemu treats any unrecoverable mce error as recoverable
and ends up in a mce loop inside the guest, Below are the MCE logs before
and after the fix.

Before fix:

[   66.775757] MCE: CPU0: Initiator CPU
[   66.775891] MCE: CPU0: Unknown
[   66.776587] MCE: CPU0: machine check (Harmless) Host UE Indeterminate [Recovered]
[   66.776857] MCE: CPU0: NIP: [c0080000000e00b8] mcetest_tlbie+0xb0/0x128 [mcetest_tlbie]

After fix:

[ 20.650577] CPU: 0 PID: 1415 Comm: insmod Tainted: G M O 5.6.0-fwnmi-arv+ #11
[ 20.650618] NIP: c0080000023a00e8 LR: c0080000023a00d8 CTR: c000000000021fe0
[ 20.650660] REGS: c0000001fffd3d70 TRAP: 0200 Tainted: G M O (5.6.0-fwnmi-arv+)
[ 20.650708] MSR: 8000000002a0b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE> CR: 42000222 XER: 20040000
[ 20.650758] CFAR: c00000000000b940 DAR: c0080000025e00e0 DSISR: 00000200 IRQMASK: 0
[ 20.650758] GPR00: c0080000023a00d8 c0000001fddd79a0 c0080000023a8500 0000000000000039
[ 20.650758] GPR04: 0000000000000001 0000000000000000 0000000000000000 0000000000000007
[ 20.650758] GPR08: 0000000000000007 c0080000025e00e0 0000000000000000 00000000000000f7
[ 20.650758] GPR12: 0000000000000000 c000000001900000 c00000000101f398 c0080000025c052f
[ 20.650758] GPR16: 00000000000003a8 c0080000025c0000 c0000001fddd7d70 c0000000015b7940
[ 20.650758] GPR20: 000000000000fff1 c000000000f72c28 c0080000025a0988 0000000000000000
[ 20.650758] GPR24: 0000000000000100 c0080000023a05d0 c0000000001f1d70 0000000000000000
[ 20.650758] GPR28: c0000001fde20000 c0000001fd02b2e0 c0080000023a0000 c0080000025e0000
[ 20.651178] NIP [c0080000023a00e8] mcetest_tlbie+0xe8/0xf0 [mcetest_tlbie]
[ 20.651220] LR [c0080000023a00d8] mcetest_tlbie+0xd8/0xf0 [mcetest_tlbie]
[ 20.651262] Call Trace:
[ 20.651280] [c0000001fddd79a0] [c0080000023a00d8] mcetest_tlbie+0xd8/0xf0 [mcetest_tlbie] (unreliable)
[ 20.651340] [c0000001fddd7a10] [c00000000001091c] do_one_initcall+0x6c/0x2c0
[ 20.651390] [c0000001fddd7af0] [c0000000001f7998] do_init_module+0x90/0x298
[ 20.651433] [c0000001fddd7b80] [c0000000001f61a8] load_module+0x1f58/0x27a0
[ 20.651476] [c0000001fddd7d40] [c0000000001f6c70] __do_sys_finit_module+0xe0/0x100
[ 20.651526] [c0000001fddd7e20] [c00000000000b9d0] system_call+0x5c/0x68
[ 20.651567] Instruction dump:
[ 20.651594] e8410018 3c620000 e8638020 480000cd e8410018 3c620000 e8638028 480000bd
[ 20.651646] e8410018 7be904e4 39400000 612900e0 <7d434a64> 4bffff74 3c4c0001 38428410
[ 20.651699] ---[ end trace 4c40897f016b4340 ]---
[ 20.653310]
Bus error
[ 20.655575] MCE: CPU0: machine check (Harmless) Host UE Indeterminate [Not recovered]
[ 20.655575] MCE: CPU0: NIP: [c0080000023a00e8] mcetest_tlbie+0xe8/0xf0 [mcetest_tlbie]
[ 20.655576] MCE: CPU0: Initiator CPU
[ 20.655576] MCE: CPU0: Unknown

Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
---
 target/ppc/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 03d0667e8f..2692f76130 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2816,11 +2816,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 #if defined(TARGET_PPC64)
 int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
 {
-    bool recovered = run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
+    uint16_t flags = run->flags & KVM_RUN_PPC_NMI_DISP_MASK;
 
     cpu_synchronize_state(CPU(cpu));
 
-    spapr_mce_req_event(cpu, recovered);
+    spapr_mce_req_event(cpu, flags == KVM_RUN_PPC_NMI_DISP_FULLY_RECOV);
 
     return 0;
 }
-- 
2.17.2


