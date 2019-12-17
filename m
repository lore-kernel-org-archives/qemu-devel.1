Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045CFC2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67A22072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CWQ7tT3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67A22072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5AW-0006mL-Jw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jJ-0001aM-NL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jI-000700-Ef
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:05 -0500
Received: from ozlabs.org ([203.11.71.1]:35339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jI-0006Rh-3B; Mon, 16 Dec 2019 23:45:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWb0n0Xz9sT7; Tue, 17 Dec 2019 15:43:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557819;
 bh=PYsIZv4wWScv1e8Bh3X6QiwpEh8GrxqKPfNCFUsPPKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CWQ7tT3r7/HRDZog0D6DFUou8YeTL7QI5w0oeK3PnNjFCgWNwheJ+Enz97s3M4C1l
 MBEtP2v5PPpBMlSk4MTNzhMFViRl9BjPXzD6XSkELwV2+n/B8Khjus58tUBZ4Et7PP
 cUVY0Plt++1PpVm2UR0TWSnulJqxC8hPCoSD1aNg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 58/88] ppc: Don't use CPUPPCState::irq_input_state with modern
 Book3s CPU models
Date: Tue, 17 Dec 2019 15:42:52 +1100
Message-Id: <20191217044322.351838-59-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The power7_set_irq() and power9_set_irq() functions set this but it is
never used actually. Modern Book3s compatible CPUs are only supported
by the pnv and spapr machines. They have an interrupt controller, XICS
for POWER7/8 and XIVE for POWER9, whose models don't require to track
IRQ input states at the CPU level.

Drop these lines to avoid confusion.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157548862861.3650476.16622818876928044450.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c     | 16 ++--------------
 target/ppc/cpu.h |  4 +++-
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fab73f1b1f..45834f98d1 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -275,10 +275,9 @@ void ppc970_irq_init(PowerPCCPU *cpu)
 static void power7_set_irq(void *opaque, int pin, int level)
 {
     PowerPCCPU *cpu =3D opaque;
-    CPUPPCState *env =3D &cpu->env;
=20
     LOG_IRQ("%s: env %p pin %d level %d\n", __func__,
-                env, pin, level);
+            &cpu->env, pin, level);
=20
     switch (pin) {
     case POWER7_INPUT_INT:
@@ -292,11 +291,6 @@ static void power7_set_irq(void *opaque, int pin, in=
t level)
         LOG_IRQ("%s: unknown IRQ pin %d\n", __func__, pin);
         return;
     }
-    if (level) {
-        env->irq_input_state |=3D 1 << pin;
-    } else {
-        env->irq_input_state &=3D ~(1 << pin);
-    }
 }
=20
 void ppcPOWER7_irq_init(PowerPCCPU *cpu)
@@ -311,10 +305,9 @@ void ppcPOWER7_irq_init(PowerPCCPU *cpu)
 static void power9_set_irq(void *opaque, int pin, int level)
 {
     PowerPCCPU *cpu =3D opaque;
-    CPUPPCState *env =3D &cpu->env;
=20
     LOG_IRQ("%s: env %p pin %d level %d\n", __func__,
-                env, pin, level);
+            &cpu->env, pin, level);
=20
     switch (pin) {
     case POWER9_INPUT_INT:
@@ -334,11 +327,6 @@ static void power9_set_irq(void *opaque, int pin, in=
t level)
         LOG_IRQ("%s: unknown IRQ pin %d\n", __func__, pin);
         return;
     }
-    if (level) {
-        env->irq_input_state |=3D 1 << pin;
-    } else {
-        env->irq_input_state &=3D ~(1 << pin);
-    }
 }
=20
 void ppcPOWER9_irq_init(PowerPCCPU *cpu)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e3e82327b7..f9528fc29d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1090,7 +1090,9 @@ struct CPUPPCState {
 #if !defined(CONFIG_USER_ONLY)
     /*
      * This is the IRQ controller, which is implementation dependent
-     * and only relevant when emulating a complete machine.
+     * and only relevant when emulating a complete machine. Note that
+     * this isn't used by recent Book3s compatible CPUs (POWER7 and
+     * newer).
      */
     uint32_t irq_input_state;
     void **irq_inputs;
--=20
2.23.0


