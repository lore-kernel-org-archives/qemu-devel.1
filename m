Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2250FC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF8421897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CIrxmQDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF8421897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWBM-0004Mh-JH
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3T-0006Hu-Gk; Tue, 08 Sep 2020 01:20:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58895 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3R-0005zU-PT; Tue, 08 Sep 2020 01:20:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkq4rc0z9sVg; Tue,  8 Sep 2020 15:20:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542403;
 bh=Ed8eNmI6TeOF00ug4vwXg3Ihw5WGZ2MpoWZJgwfPLvg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CIrxmQDDwyU3wMzmvLD85H6VVZN7/VfAvb9h1awuk25OGBNAP6EYAw1AfAWfONfZ/
 2pu9//t33h8RgUG/s2e+dqX/KDDZzQFXFj46Ptgw/B4gD+wmwWyTNl2oQOM4jH2I8n
 PPriuP/xlRUzid0liMOPYG+2lmpQqOlXtX8cabUs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/33] ppc/e500: Use start-powered-off CPUState property
Date: Tue,  8 Sep 2020 15:19:38 +1000
Message-Id: <20200908051953.1616885-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:19:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
the start-powered-off property which makes cpu_common_reset() initialize it
to 1 in common code.

Also change creation of CPU object from cpu_create() to object_new() and
qdev_realize_and_unref() because cpu_create() realizes the CPU and it's not
possible to set a property after the object is realized.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Message-Id: <20200826055535.951207-5-bauerman@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index ab9884e315..ae39b9358e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
 
     cpu_reset(cs);
 
-    /* Secondary CPU starts in halted state for now. Needs to change when
-       implementing non-kernel boot. */
-    cs->halted = 1;
     cs->exception_index = EXCP_HLT;
 }
 
@@ -865,7 +862,7 @@ void ppce500_init(MachineState *machine)
         CPUState *cs;
         qemu_irq *input;
 
-        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+        cpu = POWERPC_CPU(object_new(machine->cpu_type));
         env = &cpu->env;
         cs = CPU(cpu);
 
@@ -875,6 +872,14 @@ void ppce500_init(MachineState *machine)
             exit(1);
         }
 
+        /*
+         * Secondary CPU starts in halted state for now. Needs to change
+         * when implementing non-kernel boot.
+         */
+        object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
+                                 &error_fatal);
+        qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
+
         if (!firstenv) {
             firstenv = env;
         }
-- 
2.26.2


