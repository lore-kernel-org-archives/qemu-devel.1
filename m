Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAA2C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D90208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D90208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIMf-0004v5-4q
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZGzy-0003ZH-Cq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGwq-0001Z9-J2
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:38:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGwq-0001Wp-BK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:38:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DAAC3001702;
 Fri,  7 Jun 2019 15:38:31 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2752498BD;
 Fri,  7 Jun 2019 15:38:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:37:10 +0200
Message-Id: <20190607153725.18055-15-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-1-philmd@redhat.com>
References: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 07 Jun 2019 15:38:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 14/29] target/rx: Convert to
 CPUClass::tlb_fill
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The interface for tlb_fill has changed very recently.
Move the function into cpu.c so that it may be static
while assigning to the CPUClass methods.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-12-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/cpu.c       | 14 ++++++++++++++
 target/rx/op_helper.c | 11 -----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c370f65faa..3eef1329a1 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -154,6 +154,19 @@ static void rx_cpu_disas_set_info(CPUState *cpu, dis=
assemble_info *info)
     info->print_insn =3D print_insn_rx;
 }
=20
+static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                            MMUAccessType access_type, int mmu_idx,
+                            bool probe, uintptr_t retaddr)
+{
+    uint32_t address, physical, prot;
+
+    /* Linear mapping */
+    address =3D physical =3D addr & TARGET_PAGE_MASK;
+    prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE)=
;
+    return true;
+}
+
 static void rx_cpu_init(Object *obj)
 {
     CPUState *cs =3D CPU(obj);
@@ -188,6 +201,7 @@ static void rx_cpu_class_init(ObjectClass *klass, voi=
d *data)
     cc->get_phys_page_debug =3D rx_cpu_get_phys_page_debug;
     cc->disas_set_info =3D rx_cpu_disas_set_info;
     cc->tcg_initialize =3D rx_translate_init;
+    cc->tlb_fill =3D rx_cpu_tlb_fill;
=20
     cc->gdb_num_core_regs =3D 26;
 }
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 9a460070e9..fb7ae3c3ec 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -468,14 +468,3 @@ void QEMU_NORETURN helper_rxbrk(CPURXState *env)
 {
     raise_exception(env, 0x100, 0);
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    uint32_t address, physical, prot;
-
-    /* Linear mapping */
-    address =3D physical =3D addr & TARGET_PAGE_MASK;
-    prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE)=
;
-}
--=20
2.20.1


