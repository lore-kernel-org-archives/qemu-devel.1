Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CDCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1842206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEvoE5vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1842206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJx7-0005yP-Lk
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJv7-000473-NX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJuo-0003RU-Bd
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abVZ3FcABTc+KqwUm7gI/8jwP4oT5KYGo4dBwqfo9uI=;
 b=CEvoE5vRC/gZozFqA4Bi8uPZjBJQnvsO+WYHmhcFE8lwRhEOkxAT+dO8E4HpDVIPT+fdEu
 trcWhbyHyhC40xYYJtxTgAri/lttPiWwA2SzIGvJs4s2Hm/4ZCOgYeFZpy6En2gdZNjsIh
 lkAvAS+74robtXBve/qG71P98Jo5wxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-cWeeJJP2PRe4kYGohsK2pA-1; Fri, 02 Oct 2020 08:11:50 -0400
X-MC-Unique: cWeeJJP2PRe4kYGohsK2pA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 773681DDFB;
 Fri,  2 Oct 2020 12:11:49 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DCC978806;
 Fri,  2 Oct 2020 12:11:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/19] s390: guest support for diagnose 0x318
Date: Fri,  2 Oct 2020 14:11:07 +0200
Message-Id: <20201002121118.180315-9-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Collin Walling <walling@linux.ibm.com>

DIAGNOSE 0x318 (diag318) is an s390 instruction that allows the storage
of diagnostic information that is collected by the firmware in the case
of hardware/firmware service events.

QEMU handles the instruction by storing the info in the CPU state. A
subsequent register sync will communicate the data to the hypervisor.

QEMU handles the migration via a VM State Description.

This feature depends on the Extended-Length SCCB (els) feature. If
els is not present, then a warning will be printed and the SCLP bit
that allows the Linux kernel to execute the instruction will not be
set.

Availability of this instruction is determined by byte 134 (aka fac134)
bit 0 of the SCLP Read Info block. This coincidentally expands into the
space used for CPU entries, which means VMs running with the diag318
capability may not be able to read information regarding all CPUs
unless the guest kernel supports an extended-length SCCB.

This feature is not supported in protected virtualization mode.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20200915194416.107460-9-walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c                     |  5 ++++
 include/hw/s390x/sclp.h             |  8 ++++++
 target/s390x/cpu.h                  |  2 ++
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  3 +++
 target/s390x/cpu_models.c           |  1 +
 target/s390x/gen-features.c         |  1 +
 target/s390x/kvm.c                  | 39 +++++++++++++++++++++++++++++
 target/s390x/machine.c              | 17 +++++++++++++
 9 files changed, 77 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index caf40f41b69e..00f1e4648db2 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -139,6 +139,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
 
+    if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
+        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
+                            &read_info->fac134);
+    }
+
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
 
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 88fb65aef44b..d3ade40a5a8d 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -134,7 +134,15 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t  _reserved7[134 - 128];     /* 128-133 */
+    uint8_t  fac134;
+    uint8_t  _reserved8[144 - 135];     /* 135-143 */
     struct CPUEntry entries[];
+    /*
+     * When the Extended-Length SCCB (ELS) feature is enabled the
+     * start of the entries field begins at an offset denoted by the
+     * offset_cpu field, otherwise it's at an offset of 128.
+     */
 } QEMU_PACKED ReadInfo;
 
 typedef struct ReadCpuInfo {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 035427521cec..f875ebf0f491 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -112,6 +112,8 @@ struct CPUS390XState {
     uint16_t external_call_addr;
     DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
 
+    uint64_t diag318_info;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 2a2947549387..ef52ffce83ec 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -23,6 +23,7 @@ typedef enum {
     S390_FEAT_TYPE_STFL,
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
+    S390_FEAT_TYPE_SCLP_FAC134,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 1c04cc18f40f..f82b4b5ec16a 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -122,6 +122,9 @@ DEF_FEAT(SIE_CMMA, "cmma", SCLP_CONF_CHAR_EXT, 1, "SIE: Collaborative-memory-man
 DEF_FEAT(SIE_PFMFI, "pfmfi", SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility")
 DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility")
 
+/* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
+DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
+
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
 DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b97e9596ab03..ca484bfda7be 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -824,6 +824,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
+        { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6857f657fbad..a1f0a6f3c6fc 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -523,6 +523,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
     S390_FEAT_EXTENDED_LENGTH_SCCB,
+    S390_FEAT_DIAG_318,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index a2d5ad78f652..f13eff688caf 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -105,6 +105,7 @@
 
 #define DIAG_TIMEREVENT                 0x288
 #define DIAG_IPL                        0x308
+#define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
 
@@ -602,6 +603,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ETOKEN;
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_DIAG318)) {
+        cs->kvm_run->s.regs.diag318 = env->diag318_info;
+        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
+    }
+
     /* Finally the prefix */
     if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
         cs->kvm_run->s.regs.prefix = env->psa;
@@ -741,6 +747,10 @@ int kvm_arch_get_registers(CPUState *cs)
         }
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_DIAG318)) {
+        env->diag318_info = cs->kvm_run->s.regs.diag318;
+    }
+
     return 0;
 }
 
@@ -1601,6 +1611,27 @@ static int handle_sw_breakpoint(S390CPU *cpu, struct kvm_run *run)
     return -ENOENT;
 }
 
+static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
+{
+    uint64_t reg = (run->s390_sieic.ipa & 0x00f0) >> 4;
+    uint64_t diag318_info = run->s.regs.gprs[reg];
+
+    /*
+     * DIAG 318 can only be enabled with KVM support. As such, let's
+     * ensure a guest cannot execute this instruction erroneously.
+     */
+    if (!s390_has_feat(S390_FEAT_DIAG_318)) {
+        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
+    }
+
+    cpu->env.diag318_info = diag318_info;
+
+    if (can_sync_regs(CPU(cpu), KVM_SYNC_DIAG318)) {
+        run->s.regs.diag318 = diag318_info;
+        run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
+    }
+}
+
 #define DIAG_KVM_CODE_MASK 0x000000000000ffff
 
 static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
@@ -1620,6 +1651,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
     case DIAG_IPL:
         kvm_handle_diag_308(cpu, run);
         break;
+    case DIAG_SET_CONTROL_PROGRAM_CODES:
+        handle_diag_318(cpu, run);
+        break;
     case DIAG_KVM_HYPERCALL:
         r = handle_hypercall(cpu, run);
         break;
@@ -2464,6 +2498,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
      */
     set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
 
+    /* DIAGNOSE 0x318 is not supported under protected virtualization */
+    if (!s390_is_pv() && kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
+        set_bit(S390_FEAT_DIAG_318, model->features);
+    }
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 549bb6c2808f..5b4e82f1ab99 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -234,6 +234,22 @@ const VMStateDescription vmstate_etoken = {
     }
 };
 
+static bool diag318_needed(void *opaque)
+{
+    return s390_has_feat(S390_FEAT_DIAG_318);
+}
+
+const VMStateDescription vmstate_diag318 = {
+    .name = "cpu/diag318",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = diag318_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.diag318_info, S390CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_s390_cpu = {
     .name = "cpu",
     .post_load = cpu_post_load,
@@ -270,6 +286,7 @@ const VMStateDescription vmstate_s390_cpu = {
         &vmstate_gscb,
         &vmstate_bpbc,
         &vmstate_etoken,
+        &vmstate_diag318,
         NULL
     },
 };
-- 
2.25.4


