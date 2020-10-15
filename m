Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03FC20759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03FC20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAi7-0007of-VD
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kTAgO-0006Yv-DC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:21:08 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:28323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kTAgM-0001V3-QE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:21:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-8AiGXCELNCqNDW6G6a9MSw-1; Thu, 15 Oct 2020 17:18:35 -0400
X-MC-Unique: 8AiGXCELNCqNDW6G6a9MSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B10F18A822B;
 Thu, 15 Oct 2020 21:18:34 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 538CF76663;
 Thu, 15 Oct 2020 21:18:33 +0000 (UTC)
Subject: [PATCH v2 2/5] spapr: Unrealize vCPUs with qdev_unrealize()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Oct 2020 23:18:32 +0200
Message-ID: <160279671236.1808373.14732005038172874990.stgit@bahia.lan>
In-Reply-To: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
References: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 17:18:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we introduced CPU hot-unplug in sPAPR, we don't unrealize the
vCPU objects explicitly. Instead, we let QOM handle that for us under
object_property_del_all() when the CPU core object is finalized. The
only thing we do is calling cpu_remove_sync() to tear the vCPU thread
down.

This happens to work but it is ugly because:
- we call qdev_realize() but the corresponding qdev_unrealize() is
  buried deep in the QOM code
- we call cpu_remove_sync() to undo qemu_init_vcpu() called by
  ppc_cpu_realize() in target/ppc/translate_init.c.inc
- the CPU init and teardown paths aren't really symmetrical

The latter didn't bite us so far but a future patch that greatly
simplifies the CPU core realize path needs it to avoid a crash
in QOM.

For all these reasons, have ppc_cpu_unrealize() to undo the changes
of ppc_cpu_realize() by calling cpu_remove_sync() at the right place,
and have the sPAPR CPU core code to call qdev_unrealize().

This requires to add a missing stub because translate_init.c.inc is
also compiled for user mode.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 accel/tcg/user-exec-stub.c      |    4 ++++
 hw/ppc/spapr_cpu_core.c         |    4 ++--
 target/ppc/translate_init.c.inc |    2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index f6d8c8fb6f2d..b876f5c1e45d 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -9,6 +9,10 @@ void cpu_resume(CPUState *cpu)
 {
 }
=20
+void cpu_remove_sync(CPUState *cpu)
+{
+}
+
 void qemu_init_vcpu(CPUState *cpu)
 {
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c55211214524..e4aeb93c0299 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -187,7 +187,7 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, Spapr=
CpuCore *sc)
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_da=
ta);
     }
     spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
-    cpu_remove_sync(CPU(cpu));
+    qdev_unrealize(DEVICE(cpu));
 }
=20
 /*
@@ -255,7 +255,7 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
     kvmppc_set_papr(cpu);
=20
     if (spapr_irq_cpu_intc_create(spapr, cpu, errp) < 0) {
-        cpu_remove_sync(CPU(cpu));
+        qdev_unrealize(DEVICE(cpu));
         return false;
     }
=20
diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.=
inc
index bb66526280ef..d2a8204d6011 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -10328,6 +10328,8 @@ static void ppc_cpu_unrealize(DeviceState *dev)
=20
     pcc->parent_unrealize(dev);
=20
+    cpu_remove_sync(CPU(cpu));
+
     for (i =3D 0; i < PPC_CPU_OPCODES_LEN; i++) {
         if (cpu->opcodes[i] =3D=3D &invalid_handler) {
             continue;



