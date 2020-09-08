Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD06C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BFF2137B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hAYt+RG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BFF2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWEp-0003sZ-55
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3V-0006Kq-Eb; Tue, 08 Sep 2020 01:20:36 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3T-00062t-2J; Tue, 08 Sep 2020 01:20:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltks570Tz9sVn; Tue,  8 Sep 2020 15:20:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542405;
 bh=+wRMb4x4M1I0zN16EWCl1WpIOSHPqee5UeeBLhwlsQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hAYt+RG2GsDHJoPB9kdbLSL1x67bIcLEaxQwPMiKF9h/e8sebQ5BBoD2FppWzS1hX
 JLsw68vUgmfX2QuhiKlbSvmGsLMP2d8mFGhx6UEgKFWImXf6Gqkk4nQdVCF0BokvTe
 3dWga0ELmgDziq3mPZowazUN3+0VcO4dNRjdgf7k=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 21/33] sparc/sun4m: Use start-powered-off CPUState property
Date: Tue,  8 Sep 2020 15:19:41 +1000
Message-Id: <20200908051953.1616885-22-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 bauerman@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Instead of setting CPUState::halted to 1 in secondary_cpu_reset(), use the
start-powered-off property which makes cpu_common_reset() initialize it
to 1 in common code.

Now secondary_cpu_reset() becomes equivalent to main_cpu_reset() so rename
the function to sun4m_cpu_reset().

Also remove setting of cs->halted from cpu_devinit(), which seems out of
place when compared to similar code in other architectures (e.g.,
ppce500_init() in hw/ppc/e500.c).

Finally, change creation of CPU object from cpu_create() to object_new()
and qdev_realize_and_unref() because cpu_create() realizes the CPU and it's
not possible to set a property after the object is realized.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Message-Id: <20200826055535.951207-8-bauerman@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/sparc/sun4m.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 7484aa4438..6bf9d27d8a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -218,7 +218,7 @@ static void dummy_cpu_set_irq(void *opaque, int irq, int level)
 {
 }
 
-static void main_cpu_reset(void *opaque)
+static void sun4m_cpu_reset(void *opaque)
 {
     SPARCCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
@@ -226,15 +226,6 @@ static void main_cpu_reset(void *opaque)
     cpu_reset(cs);
 }
 
-static void secondary_cpu_reset(void *opaque)
-{
-    SPARCCPU *cpu = opaque;
-    CPUState *cs = CPU(cpu);
-
-    cpu_reset(cs);
-    cs->halted = 1;
-}
-
 static void cpu_halt_signal(void *opaque, int irq, int level)
 {
     if (level && current_cpu) {
@@ -818,21 +809,17 @@ static const TypeInfo ram_info = {
 static void cpu_devinit(const char *cpu_type, unsigned int id,
                         uint64_t prom_addr, qemu_irq **cpu_irqs)
 {
-    CPUState *cs;
     SPARCCPU *cpu;
     CPUSPARCState *env;
 
-    cpu = SPARC_CPU(cpu_create(cpu_type));
+    cpu = SPARC_CPU(object_new(cpu_type));
     env = &cpu->env;
 
     cpu_sparc_set_id(env, id);
-    if (id == 0) {
-        qemu_register_reset(main_cpu_reset, cpu);
-    } else {
-        qemu_register_reset(secondary_cpu_reset, cpu);
-        cs = CPU(cpu);
-        cs->halted = 1;
-    }
+    qemu_register_reset(sun4m_cpu_reset, cpu);
+    object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
+                             &error_fatal);
+    qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
     *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
     env->prom_addr = prom_addr;
 }
-- 
2.26.2


