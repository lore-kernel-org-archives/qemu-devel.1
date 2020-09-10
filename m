Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F08C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A2020829
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ltHJSp0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A2020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJ53-0001gz-Iw
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ17-000268-3J; Thu, 10 Sep 2020 05:37:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ12-0003RB-2D; Thu, 10 Sep 2020 05:37:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A9WE0M037848; Thu, 10 Sep 2020 05:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=S6SzECKH5JU2Foafyqoxbj8o4JcCBBC9/OlmJtTNwPo=;
 b=ltHJSp0cUL/bzx59RAUDqao1/Me7BUG1c9Z3VmE1sijg0rkZU/iEGO+PqIiA2yUk+DDx
 Wa/+gKM4nyy1ap9suoJsjvQuiFXSikC7ETkHTERo0y4RinLQ7hjEy29b+Edq/wVt48Ar
 DJ9CCgBv21L9P006tFKmgUjnDfdLk7WV4CtDUdQMPfRqFlAETTr1gIIwlDJ9esZdWKM0
 QqqycMm+PTzGEl8OJzzjsk7/AkW7ovx8tkfrlfVivvZCg3B15cpJt17NsX4DBdx/MK/l
 nbiDZbQyxC/yJtgZC2FqhAK3Yz4W9KTcZdBoYxt9EZApPmxj6QaSblpvwi854RV/BU8x 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fgkfacd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:14 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A9Wijh039457;
 Thu, 10 Sep 2020 05:37:14 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fgkfaccr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:14 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9WKOo020313;
 Thu, 10 Sep 2020 09:37:13 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 33c2a9fww7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 09:37:13 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08A9bCaG16057088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 09:37:12 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 675F1112062;
 Thu, 10 Sep 2020 09:37:12 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 140C6112063;
 Thu, 10 Sep 2020 09:37:12 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.156.134])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 09:37:11 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v5 6/8] s390/sclp: add extended-length sccb support for kvm
 guest
Date: Thu, 10 Sep 2020 05:36:53 -0400
Message-Id: <20200910093655.255774-7-walling@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910093655.255774-1-walling@linux.ibm.com>
References: <20200910093655.255774-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_01:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:37:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As more features and facilities are added to the Read SCP Info (RSCPI)
response, more space is required to store them. The space used to store
these new features intrudes on the space originally used to store CPU
entries. This means as more features and facilities are added to the
RSCPI response, less space can be used to store CPU entries.

With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
the RSCPI command and determine if the SCCB is large enough to store a
complete reponse. If it is not large enough, then the required length
will be set in the SCCB header.

The caller of the SCLP command is responsible for creating a
large-enough SCCB to store a complete response. Proper checking should
be in place, and the caller should execute the command once-more with
the large-enough SCCB.

This facility also enables an extended SCCB for the Read CPU Info
(RCPUI) command.

When this facility is enabled, the boundary violation response cannot
be a result from the RSCPI, RSCPI Forced, or RCPUI commands.

In order to tolerate kernels that do not yet have full support for this
feature, a "fixed" offset to the start of the CPU Entries within the
Read SCP Info struct is set to allow for the original 248 max entries
when this feature is disabled.

Additionally, this is introduced as a CPU feature to protect the guest
from migrating to a machine that does not support storing an extended
SCCB. This could otherwise hinder the VM from being able to read all
available CPU entries after migration (such as during re-ipl).

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/sclp.c                     | 43 +++++++++++++++++++++++++----
 include/hw/s390x/sclp.h             |  1 +
 target/s390x/cpu_features_def.h.inc |  1 +
 target/s390x/gen-features.c         |  1 +
 target/s390x/kvm.c                  |  8 ++++++
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 803fdd5ed4..87d468087b 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -49,13 +49,30 @@ static inline bool sclp_command_code_valid(uint32_t code)
     return false;
 }
 
-static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t len)
+static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t len,
+                                 uint32_t code)
 {
     uint64_t sccb_max_addr = sccb_addr + be16_to_cpu(len) - 1;
     uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
 
-    if (sccb_max_addr < sccb_boundary) {
-        return true;
+    switch (code & SCLP_CMD_CODE_MASK) {
+    case SCLP_CMDW_READ_SCP_INFO:
+    case SCLP_CMDW_READ_SCP_INFO_FORCED:
+    case SCLP_CMDW_READ_CPU_INFO:
+        /*
+         * An extended-length SCCB is only allowed for Read SCP/CPU Info and
+         * is allowed to exceed the 4k boundary. The respective commands will
+         * set the length field to the required length if an insufficient
+         * SCCB length is provided.
+         */
+        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
+            return true;
+        }
+        /* fallthrough */
+    default:
+        if (sccb_max_addr < sccb_boundary) {
+            return true;
+        }
     }
 
     return false;
@@ -80,6 +97,12 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
 
 #define SCCB_REQ_LEN(s, max_cpus) (sizeof(s) + max_cpus * sizeof(CPUEntry))
 
+static inline bool ext_len_sccb_supported(SCCBHeader header)
+{
+    return s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) &&
+           header.control_mask[2] & SCLP_VARIABLE_LENGTH_RESPONSE;
+}
+
 /* Provide information about the configuration, CPUs and storage */
 static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 {
@@ -89,10 +112,15 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int rnsize, rnmax;
     IplParameterBlock *ipib = s390_ipl_get_iplb();
     int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
-    int offset_cpu = offsetof(ReadInfo, entries);
+    int offset_cpu = s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
+                     offsetof(ReadInfo, entries) :
+                     SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
     CPUEntry *entries_start = (void *)sccb + offset_cpu;
 
     if (be16_to_cpu(sccb->h.length) < required_len) {
+        if (ext_len_sccb_supported(sccb->h)) {
+            sccb->h.length = cpu_to_be16(required_len);
+        }
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
         return;
     }
@@ -153,6 +181,9 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
     int required_len = SCCB_REQ_LEN(ReadCpuInfo, machine->possible_cpus->len);
 
     if (be16_to_cpu(sccb->h.length) < required_len) {
+        if (ext_len_sccb_supported(sccb->h)) {
+            sccb->h.length = cpu_to_be16(required_len);
+        }
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
         return;
     }
@@ -249,7 +280,7 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
+    if (!sccb_verify_boundary(sccb, work_sccb->h.length, code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
@@ -303,7 +334,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
+    if (!sccb_verify_boundary(sccb, work_sccb->h.length, code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 98c4727984..141e57f765 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -110,6 +110,7 @@ typedef struct CPUEntry {
     uint8_t reserved1;
 } QEMU_PACKED CPUEntry;
 
+#define SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET     128
 typedef struct ReadInfo {
     SCCBHeader h;
     uint16_t rnmax;
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 5942f81f16..1c04cc18f4 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -97,6 +97,7 @@ DEF_FEAT(GUARDED_STORAGE, "gs", STFL, 133, "Guarded-storage facility")
 DEF_FEAT(VECTOR_PACKED_DECIMAL, "vxpd", STFL, 134, "Vector packed decimal facility")
 DEF_FEAT(VECTOR_ENH, "vxeh", STFL, 135, "Vector enhancements facility")
 DEF_FEAT(MULTIPLE_EPOCH, "mepoch", STFL, 139, "Multiple-epoch facility")
+DEF_FEAT(EXTENDED_LENGTH_SCCB, "els", STFL, 140, "Extended-length SCCB facility")
 DEF_FEAT(TEST_PENDING_EXT_INTERRUPTION, "tpei", STFL, 144, "Test-pending-external-interruption facility")
 DEF_FEAT(INSERT_REFERENCE_BITS_MULT, "irbm", STFL, 145, "Insert-reference-bits-multiple facility")
 DEF_FEAT(MSA_EXT_8, "msa8-base", STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8ddeebc544..6857f657fb 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -522,6 +522,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
+    S390_FEAT_EXTENDED_LENGTH_SCCB,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f2f75d2a57..a2d5ad78f6 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2456,6 +2456,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
         set_bit(S390_FEAT_AP, model->features);
     }
+
+    /*
+     * Extended-Length SCCB is handled entirely within QEMU.
+     * For PV guests this is completely fenced by the Ultravisor, as Service
+     * Call error checking and STFLE interpretation are handled via SIE.
+     */
+    set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
-- 
2.26.2


