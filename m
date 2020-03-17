Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C8C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB92205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NPM2mOm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB92205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Mo-00009J-Td
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96s-0002xi-2K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96q-0002Ew-If
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:06:05 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47543 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96m-00081J-O7; Tue, 17 Mar 2020 06:06:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL33lsSz9sTb; Tue, 17 Mar 2020 21:04:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439483;
 bh=dmNCSb023joqbBJUG6s88uCYWWL25UKE/pXw6CARv/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NPM2mOm7TU5dhhDBlyBBVYpqLwYZCVfIUJUbHkWSbHQD0oma0prTaFD7BBe4WGIAM
 JDJBern2G5acy3pKAnlzqKLUAf0+BExXZpe/ognqjt+xTYVUdhjdRc39O2wOboe0Vm
 l76FdTA9dIydDm7AeTlazdxxXV42MGLPlVX3rXGo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 42/45] target/ppc: allow ppc_cpu_do_system_reset to take an
 alternate vector
Date: Tue, 17 Mar 2020 21:04:20 +1100
Message-Id: <20200317100423.622643-43-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

Provide for an alternate delivery location, -1 defaults to the
architected address.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200316142613.121089-7-npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c           | 2 +-
 target/ppc/cpu.h         | 2 +-
 target/ppc/excp_helper.c | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d22bf54baf..6d65c0797b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3385,7 +3385,7 @@ static void spapr_machine_finalizefn(Object *obj)
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     cpu_synchronize_state(cs);
-    ppc_cpu_do_system_reset(cs);
+    ppc_cpu_do_system_reset(cs, -1);
 }
=20
 static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3953680534..f8c7d6f19c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunctio=
n f, CPUState *cs,
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
-void ppc_cpu_do_system_reset(CPUState *cs);
+void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7f2b5899d3..08bc885ca6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -961,12 +961,15 @@ static void ppc_hw_interrupt(CPUPPCState *env)
     }
 }
=20
-void ppc_cpu_do_system_reset(CPUState *cs)
+void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     CPUPPCState *env =3D &cpu->env;
=20
     powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
+    if (vector !=3D -1) {
+        env->nip =3D vector;
+    }
 }
=20
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
--=20
2.24.1


