Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2985C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6951A206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM0JbT2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6951A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK3N-0003Sg-J4
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJv5-00041L-JR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJuh-0003Qw-US
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXl8SdrC6gJcuUf4RdSR9CPL8V4r7Zumagbz+u+q9UQ=;
 b=jM0JbT2r3ICeKcVOeinHfFENhpcIeDdjLdg5jOXJqhHvT3zKZF4593k8suNAmaHRRgYoJy
 118qpHhN2nLbCvHTvw3CHT4Wg86hK8whWDoBXF8UTBiW9PuHnB6p6DTsBffeXzdEqq+9Bh
 wllE4Xqx3GAyEzy60wsQOIcjf4rBEzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-B_3ZmyXiPeir9eZqT0Wi3g-1; Fri, 02 Oct 2020 08:11:45 -0400
X-MC-Unique: B_3ZmyXiPeir9eZqT0Wi3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F44D1074644;
 Fri,  2 Oct 2020 12:11:44 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C539810013BD;
 Fri,  2 Oct 2020 12:11:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/19] s390/sclp: add extended-length sccb support for kvm guest
Date: Fri,  2 Oct 2020 14:11:06 +0200
Message-Id: <20201002121118.180315-8-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Collin Walling <walling@linux.ibm.com>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20200915194416.107460-7-walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c                     | 43 +++++++++++++++++++++++++----
 include/hw/s390x/sclp.h             |  1 +
 target/s390x/cpu_features_def.h.inc |  1 +
 target/s390x/gen-features.c         |  1 +
 target/s390x/kvm.c                  |  8 ++++++
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 1df67c99bfb9..caf40f41b69e 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -49,13 +49,30 @@ static inline bool sclp_command_code_valid(uint32_t code)
     return false;
 }
 
-static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t sccb_len)
+static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t sccb_len,
+                                 uint32_t code)
 {
     uint64_t sccb_max_addr = sccb_addr + sccb_len - 1;
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
 
-    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length))) {
+    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length), code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
@@ -302,7 +333,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length))) {
+    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length), code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 374ea83e7811..88fb65aef44b 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -111,6 +111,7 @@ typedef struct CPUEntry {
     uint8_t reserved1;
 } QEMU_PACKED CPUEntry;
 
+#define SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET     128
 typedef struct ReadInfo {
     SCCBHeader h;
     uint16_t rnmax;
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 5942f81f1659..1c04cc18f40f 100644
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
index 8ddeebc54419..6857f657fbad 100644
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
index f2f75d2a57e8..a2d5ad78f652 100644
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
2.25.4


