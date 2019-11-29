Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C85F206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C85F206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadBQ-00072D-Cb
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iactK-0002q8-Jv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iactE-0003ev-RJ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9818
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iactE-0003N6-Kh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT9mZCC089256
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:37 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxskxqc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:36 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 09:48:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 09:48:23 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT9mLS158720480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 09:48:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2707A4051;
 Fri, 29 Nov 2019 09:48:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC673A4057;
 Fri, 29 Nov 2019 09:48:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 09:48:19 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/13] s390x: protvirt: Add diag308 subcodes 8 - 10
Date: Fri, 29 Nov 2019 04:47:57 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129094809.26684-1-frankja@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112909-4275-0000-0000-00000387EFC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112909-4276-0000-0000-0000389B844F
Message-Id: <20191129094809.26684-2-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_02:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=3
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290086
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
 hw/s390x/ipl.h      | 33 +++++++++++++++++++++++++++++++
 target/s390x/diag.c | 26 ++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ca544d64c5..a077926f36 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -529,15 +529,56 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
     return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
 }
 
+int s390_ipl_pv_check_comp(IplParameterBlock *iplb)
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
@@ -552,7 +593,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
 {
     S390IPLState *ipl = get_ipl_device();
 
-    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
+    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL ||
+        reset_type == S390_RESET_PV) {
         /* use CPU 0 for full resets */
         ipl->reset_cpu_index = 0;
     } else {
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d4813105db..7b8a493509 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -15,6 +15,24 @@
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
+    uint8_t  reserved[84];
+    uint8_t  reserved67[3];
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
@@ -71,6 +89,7 @@ union IplParameterBlock {
         union {
             IplBlockCcw ccw;
             IplBlockFcp fcp;
+            IPLBlockPV pv;
             IplBlockQemuScsi scsi;
         };
     } QEMU_PACKED;
@@ -84,9 +103,11 @@ union IplParameterBlock {
 typedef union IplParameterBlock IplParameterBlock;
 
 int s390_ipl_set_loadparm(uint8_t *loadparm);
+int s390_ipl_pv_check_comp(IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
+IplParameterBlock *s390_ipl_get_iplb_secure(void);
 
 enum s390_reset {
     /* default is a reset not triggered by a CPU e.g. issued by QMP */
@@ -94,6 +115,7 @@ enum s390_reset {
     S390_RESET_REIPL,
     S390_RESET_MODIFIED_CLEAR,
     S390_RESET_LOAD_NORMAL,
+    S390_RESET_PV,
 };
 void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
 void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type);
@@ -133,6 +155,7 @@ struct S390IPLState {
     /*< private >*/
     DeviceState parent_obj;
     IplParameterBlock iplb;
+    IplParameterBlock iplb_pbt5;
     QemuIplParameters qipl;
     uint64_t start_addr;
     uint64_t compat_start_addr;
@@ -140,6 +163,7 @@ struct S390IPLState {
     uint64_t compat_bios_start_addr;
     bool enforce_bios;
     bool iplb_valid;
+    bool iplb_valid_pbt5;
     bool netboot;
     /* reset related properties don't have to be migrated or reset */
     enum s390_reset reset_type;
@@ -161,9 +185,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
+#define S390_IPL_TYPE_PV 0x05
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
 
 #define S390_IPLB_HEADER_LEN 8
+#define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
@@ -185,4 +211,11 @@ static inline bool iplb_valid_fcp(IplParameterBlock *iplb)
            iplb->pbt == S390_IPL_TYPE_FCP;
 }
 
+static inline bool iplb_valid_se(IplParameterBlock *iplb)
+{
+    return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_PV_LEN &&
+           iplb->pbt == S390_IPL_TYPE_PV;
+}
+
+
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b5aec06d6b..112a6c92e0 100644
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
+            !(iplb_valid_se(iplb) && s390_ipl_pv_check_comp(iplb) >= 0)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
@@ -128,10 +135,15 @@ out:
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
@@ -139,6 +151,16 @@ out:
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
         }
         return;
+        break;
+    case DIAG308_PV_START:
+        iplb = s390_ipl_get_iplb_secure();
+        if (!iplb_valid_se(iplb)) {
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


