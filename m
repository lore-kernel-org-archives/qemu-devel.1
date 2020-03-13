Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203BEC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4B12072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4B12072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkt9-00088w-4I
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>) id 1jCkrb-0005bX-I9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <remi@remlab.net>) id 1jCkrZ-00015p-PH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:00:35 -0400
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:49728
 helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <remi@remlab.net>)
 id 1jCkrV-0000fY-K3; Fri, 13 Mar 2020 10:00:29 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 0419B5FDA7;
 Fri, 13 Mar 2020 15:00:24 +0100 (CET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To: qemu-arm@nongnu.org
Subject: [PATCH 4/5] target/arm: MTE privileged system mode assembly
Date: Fri, 13 Mar 2020 16:00:22 +0200
Message-Id: <20200313140023.83844-4-remi@remlab.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41d0:2:5a1a::
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>

This adds all remaining MTE instructions for EL1, EL2 and EL3 on a
processor with ID_AA64PFR1_EL1.MTE =3D=3D 1.

Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu64.c         |  8 +++---
 target/arm/helper.c        | 19 ++++++++++++++
 target/arm/translate-a64.c | 52 +++++++++++++++++++++++++++++++++++---
 3 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a72dfd3d98..749eb93872 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -665,13 +665,11 @@ static void aarch64_max_initfn(Object *obj)
=20
         t =3D cpu->isar.id_aa64pfr1;
         t =3D FIELD_DP64(t, ID_AA64PFR1, BT, 1);
-#ifdef CONFIG_USER_ONLY
-        /* All MTE instructions and processor states are supported for u=
ser
-         * mode. This corresponds to feature field value 1 (field value =
2
-         * implies MemTag memory support).
+        /* All MTE instructions and processor states are supported. This
+         * corresponds to feature field value 1 (field value 2 implies M=
emTag
+         * memory support).
          */
         t =3D FIELD_DP64(t, ID_AA64PFR1, MTE, 1);
-#endif
         cpu->isar.id_aa64pfr1 =3D t;
=20
         t =3D cpu->isar.id_aa64mmfr1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index dd64fcb4ef..630dc04302 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6906,10 +6906,29 @@ static const ARMCPRegInfo mte_reginfo[] =3D {
       .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 14, .opc2 =3D 5,
       .access =3D PL0_W, .type =3D ARM_CP_NOP,
       .accessfn =3D aa64_cacheop_poc_access },
+    { .name =3D "RGSR_EL1", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 0, .crn =3D 1, .crm =3D 0, .opc2 =3D 5,
+      .access =3D PL1_RW, .fieldoffset =3D offsetof(CPUARMState, rgsr_el=
1) },
+    { .name =3D "GCR_EL1", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 0, .crn =3D 1, .crm =3D 0, .opc2 =3D 6,
+      .access =3D PL1_RW, .fieldoffset =3D offsetof(CPUARMState, gcr_el1=
) },
     { .name =3D "TCO", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 4, .crm =3D 2, .opc2 =3D 7,
       .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW,
       .readfn =3D tco_read, .writefn =3D tco_write },
+    { .name =3D "TFSR_EL1", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 0, .crn =3D 6, .crm =3D 5, .opc2 =3D 0,
+      .access =3D PL1_RW, .fieldoffset =3D offsetof(CPUARMState, tfsr_el=
[1]) },
+    { .name =3D "TFSR_EL2", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 6, .crm =3D 5, .opc2 =3D 0,
+      .access =3D PL2_RW, .type =3D ARM_CP_ALIAS,
+      .fieldoffset =3D offsetof(CPUARMState, tfsr_el[1]) },
+    { .name =3D "TFSR_EL3", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 6, .crn =3D 6, .crm =3D 5, .opc2 =3D 0,
+      .access =3D PL3_RW, .fieldoffset =3D offsetof(CPUARMState, tfsr_el=
[3]) },
+    { .name =3D "TFSRE0_EL1", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 0, .crn =3D 6, .crm =3D 6, .opc2 =3D 1,
+      .access =3D PL1_RW, .fieldoffset =3D offsetof(CPUARMState, tfsre0_=
el1) },
     REGINFO_SENTINEL
 };
 #endif
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6d86480043..9382f53794 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2716,6 +2716,38 @@ static void disas_ld_lit(DisasContext *s, uint32_t=
 insn)
     tcg_temp_free_i64(clean_addr);
 }
=20
+#ifndef CONFIG_USER_ONLY
+static void disas_ldst_memtag_vec(DisasContext *s, int rn, int rt,
+                                  bool is_load)
+{
+    TCGv_i64 tcg_addr;
+
+    if (rn =3D=3D rt) {
+        return;
+    }
+
+    if (rn =3D=3D 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    /* The starting point between the specified address and the aligned
+     * address is implementation defined. We start at the aligned addres=
s.
+     */
+    tcg_addr =3D tcg_temp_new_i64();
+    tcg_gen_andi_i64(tcg_addr, cpu_reg_sp(s, rn),
+                     ~((16 * ARM_TAG_GRANULE) - 1));
+
+    /* In principles, memory access permissions should be checked here. =
*/
+    if (is_load) {
+        tcg_gen_movi_i64(cpu_reg(s, rt), 0);
+    }
+
+    tcg_gen_addi_i64(cpu_reg_sp(s, rn), tcg_addr, 16 * ARM_TAG_GRANULE);
+
+    tcg_temp_free_i64(tcg_addr);
+}
+#endif
+
 /* LDG, LDGV(EL1), ST(Z)(2)G, STGV */
 static void disas_ldst_memtag(DisasContext *s, uint32_t insn)
 {
@@ -2736,9 +2768,23 @@ static void disas_ldst_memtag(DisasContext *s, uin=
t32_t insn)
         return;
     }
=20
-    if (op2 =3D=3D 0 && opc !=3D 1) {
-        unallocated_encoding(s);
-        return;
+    if (op2 =3D=3D 0) {
+        switch (opc) {
+        case 1:
+            break;
+#ifndef CONFIG_USER_ONLY
+        case 2:
+        case 3:
+            if (s->current_el > 0 && offset =3D=3D 0) {
+                disas_ldst_memtag_vec(s, rn, rt, opc & 1);
+                return;
+            }
+#endif
+            /* fall through */
+        default:
+            unallocated_encoding(s);
+            return;
+        }
     }
=20
     if (rn =3D=3D 31) {
--=20
2.25.1


