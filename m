Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85922C3B19F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F71420848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F71420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cma-00076Z-Ip
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciU-0006r9-NJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciT-000693-49
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j2ciS-00068b-T6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:17 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01EFDdfM068879
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:16 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j87vg02-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:10 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 14 Feb 2020 15:17:02 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Feb 2020 15:17:00 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01EFGxTO58261592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 15:16:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79A1FA404D;
 Fri, 14 Feb 2020 15:16:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17B7BA4053;
 Fri, 14 Feb 2020 15:16:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.191.187])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 15:16:57 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/17] s390x: protvirt: Add diag308 subcodes 8 - 10
Date: Fri, 14 Feb 2020 10:16:23 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151636.8764-1-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021415-0028-0000-0000-000003DA8A45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021415-0029-0000-0000-0000249F053B
Message-Id: <20200214151636.8764-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-14_04:2020-02-12,
 2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
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

For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
holds the address and length of the secure execution header, as well
as a list of guest components.

Each component is a block of memory, for example kernel or initrd,
which needs to be decrypted by the Ultravisor in order to run a
protected VM. The secure execution header instructs the Ultravisor on
how to handle the protected VM and its components.

Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
start the protected guest.

Subcodes 8-10 are not valid in protected mode, we have to do a subcode
3 and then the 8 and 10 combination for a protected reboot.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/ipl.c      | 48 ++++++++++++++++++++++++++++++++++++++++++---
 hw/s390x/ipl.h      | 31 +++++++++++++++++++++++++++++
 target/s390x/diag.c | 27 ++++++++++++++++++++++---
 3 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7773499d7f..db97a888ff 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -538,15 +538,56 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
     return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
 }
 
+int s390_ipl_pv_check_components(IplParameterBlock *iplb)
+{
+    int i;
+    IPLBlockPV *ipib_pv = &iplb->pv;
+
+    if (ipib_pv->num_comp == 0) {
+        return -EINVAL;
+    }
+
+    for (i = 0; i < ipib_pv->num_comp; i++) {
+
+        /* Addr must be 4k aligned */
+        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
+            return -EINVAL;
+        }
+
+        /* Tweak prefix is monotonously increasing with each component */
+        if (i < ipib_pv->num_comp - 1 &&
+            ipib_pv->components[i].tweak_pref >
+            ipib_pv->components[i + 1].tweak_pref) {
+            return -EINVAL;
+        }
+    }
+    return 1;
+}
+
 void s390_ipl_update_diag308(IplParameterBlock *iplb)
 {
     S390IPLState *ipl = get_ipl_device();
 
-    ipl->iplb = *iplb;
-    ipl->iplb_valid = true;
+    if (iplb->pbt == 5) {
+        ipl->iplb_pbt5 = *iplb;
+        ipl->iplb_valid_pbt5 = true;
+    } else {
+        ipl->iplb = *iplb;
+        ipl->iplb_valid = true;
+    }
     ipl->netboot = is_virtio_net_device(iplb);
 }
 
+IplParameterBlock *s390_ipl_get_iplb_secure(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    if (!ipl->iplb_valid_pbt5) {
+        return NULL;
+    }
+    return &ipl->iplb_pbt5;
+}
+
 IplParameterBlock *s390_ipl_get_iplb(void)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -561,7 +602,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
 {
     S390IPLState *ipl = get_ipl_device();
 
-    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
+    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL ||
+        reset_type == S390_RESET_PV) {
         /* use CPU 0 for full resets */
         ipl->reset_cpu_index = 0;
     } else {
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d4813105db..d0b8d90fa4 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -15,6 +15,23 @@
 #include "cpu.h"
 #include "hw/qdev-core.h"
 
+struct IPLBlockPVComp {
+    uint64_t tweak_pref;
+    uint64_t addr;
+    uint64_t size;
+} QEMU_PACKED;
+typedef struct IPLBlockPVComp IPLBlockPVComp;
+
+struct IPLBlockPV {
+    uint8_t  reserved[87];
+    uint8_t  version;
+    uint32_t num_comp;
+    uint64_t pv_header_addr;
+    uint64_t pv_header_len;
+    struct IPLBlockPVComp components[];
+} QEMU_PACKED;
+typedef struct IPLBlockPV IPLBlockPV;
+
 struct IplBlockCcw {
     uint8_t  reserved0[85];
     uint8_t  ssid;
@@ -71,6 +88,7 @@ union IplParameterBlock {
         union {
             IplBlockCcw ccw;
             IplBlockFcp fcp;
+            IPLBlockPV pv;
             IplBlockQemuScsi scsi;
         };
     } QEMU_PACKED;
@@ -84,9 +102,11 @@ union IplParameterBlock {
 typedef union IplParameterBlock IplParameterBlock;
 
 int s390_ipl_set_loadparm(uint8_t *loadparm);
+int s390_ipl_pv_check_components(IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
+IplParameterBlock *s390_ipl_get_iplb_secure(void);
 
 enum s390_reset {
     /* default is a reset not triggered by a CPU e.g. issued by QMP */
@@ -94,6 +114,7 @@ enum s390_reset {
     S390_RESET_REIPL,
     S390_RESET_MODIFIED_CLEAR,
     S390_RESET_LOAD_NORMAL,
+    S390_RESET_PV,
 };
 void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
 void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type);
@@ -133,6 +154,7 @@ struct S390IPLState {
     /*< private >*/
     DeviceState parent_obj;
     IplParameterBlock iplb;
+    IplParameterBlock iplb_pbt5;
     QemuIplParameters qipl;
     uint64_t start_addr;
     uint64_t compat_start_addr;
@@ -140,6 +162,7 @@ struct S390IPLState {
     uint64_t compat_bios_start_addr;
     bool enforce_bios;
     bool iplb_valid;
+    bool iplb_valid_pbt5;
     bool netboot;
     /* reset related properties don't have to be migrated or reset */
     enum s390_reset reset_type;
@@ -161,9 +184,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
+#define S390_IPL_TYPE_PV 0x05
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
 
 #define S390_IPLB_HEADER_LEN 8
+#define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
@@ -185,4 +210,10 @@ static inline bool iplb_valid_fcp(IplParameterBlock *iplb)
            iplb->pbt == S390_IPL_TYPE_FCP;
 }
 
+static inline bool iplb_valid_pv(IplParameterBlock *iplb)
+{
+    return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_PV_LEN &&
+           iplb->pbt == S390_IPL_TYPE_PV;
+}
+
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b5aec06d6b..4ba6033609 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -52,6 +52,8 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 #define DIAG_308_RC_OK              0x0001
 #define DIAG_308_RC_NO_CONF         0x0102
 #define DIAG_308_RC_INVALID         0x0402
+#define DIAG_308_RC_NO_PV_CONF      0x0a02
+#define DIAG_308_RC_INV_FOR_PV      0x0b02
 
 #define DIAG308_RESET_MOD_CLR       0
 #define DIAG308_RESET_LOAD_NORM     1
@@ -59,6 +61,9 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 #define DIAG308_LOAD_NORMAL_DUMP    4
 #define DIAG308_SET                 5
 #define DIAG308_STORE               6
+#define DIAG308_PV_SET              8
+#define DIAG308_PV_STORE            9
+#define DIAG308_PV_START            10
 
 static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
                               uintptr_t ra, bool write)
@@ -105,6 +110,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
         break;
     case DIAG308_SET:
+    case DIAG308_PV_SET:
         if (diag308_parm_check(env, r1, addr, ra, false)) {
             return;
         }
@@ -117,7 +123,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
 
-        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
+        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
+            !(iplb_valid_pv(iplb) && s390_ipl_pv_check_components(iplb) >= 0)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
@@ -128,17 +135,31 @@ out:
         g_free(iplb);
         return;
     case DIAG308_STORE:
+    case DIAG308_PV_STORE:
         if (diag308_parm_check(env, r1, addr, ra, true)) {
             return;
         }
-        iplb = s390_ipl_get_iplb();
+        if (subcode == DIAG308_PV_STORE) {
+            iplb = s390_ipl_get_iplb_secure();
+        } else {
+            iplb = s390_ipl_get_iplb();
+        }
         if (iplb) {
             cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
             env->regs[r1 + 1] = DIAG_308_RC_OK;
         } else {
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
         }
-        return;
+        break;
+    case DIAG308_PV_START:
+        iplb = s390_ipl_get_iplb_secure();
+        if (!iplb || !iplb_valid_pv(iplb)) {
+            env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
+            return;
+        }
+
+        s390_ipl_reset_request(cs, S390_RESET_PV);
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         break;
-- 
2.20.1


