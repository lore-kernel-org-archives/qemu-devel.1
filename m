Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC0C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F3322DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M1bKnGDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F3322DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LOJ-00080u-4j
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0T-0004dq-N1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0Q-00086w-U4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:09 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59369)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0Q-00081Q-78; Wed, 21 Aug 2019 03:26:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjC20zmz9sPf; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372351;
 bh=QfB+kr+J9gga2TVJShNfEu3si0XX4vHShF0UZf74fkI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M1bKnGDyMcdPGPCOrCGedYhR44GeY33QT8IaqBPm345KfB7zhbv45tmfy8aYtj0ei
 nuoUiUt3nRU+snPjcKTbGTGkcpjPw8S5CgQhwxPdZ8qbfzlNElb7Mw1jWUeHuhB8D+
 llCJyQ6fFcpycsUef9UZ21RW9m4V52tXraWPiDkI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:17 +1000
Message-Id: <20190821072542.23090-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 17/42] spapr: Implement H_CONFER
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

This does not do directed yielding and is not quite as strict as PAPR
specifies in terms of precise dispatch behaviour. This generally will
mean suboptimal performance, rather than guest misbehaviour. Linux
does not rely on exact dispatch behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20190718034214.14948-4-npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index dd584da1ce..eb54b96097 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1070,6 +1070,72 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
     return H_SUCCESS;
 }
=20
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target =3D args[0];
+    uint32_t dispatch =3D args[1];
+    CPUState *cs =3D CPU(cpu);
+    SpaprCpuState *spapr_cpu;
+
+    /*
+     * -1 means confer to all other CPUs without dispatch counter check,
+     *  otherwise it's a targeted confer.
+     */
+    if (target !=3D -1) {
+        PowerPCCPU *target_cpu =3D spapr_find_cpu(target);
+        uint32_t target_dispatch;
+
+        if (!target_cpu) {
+            return H_PARAMETER;
+        }
+
+        spapr_cpu =3D spapr_cpu_state(target_cpu);
+
+        /*
+         * target =3D=3D self is a special case, we wait until prodded, =
without
+         * dispatch counter check.
+         */
+        if (cpu =3D=3D target_cpu) {
+            if (spapr_cpu->prod) {
+                spapr_cpu->prod =3D false;
+
+                return H_SUCCESS;
+            }
+
+            cs->halted =3D 1;
+            cs->exception_index =3D EXCP_HALTED;
+            cs->exit_request =3D 1;
+
+            return H_SUCCESS;
+        }
+
+        if (!spapr_cpu->vpa_addr || ((dispatch & 1) =3D=3D 0)) {
+            return H_SUCCESS;
+        }
+
+        target_dispatch =3D ldl_be_phys(cs->as,
+                                  spapr_cpu->vpa_addr + VPA_DISPATCH_COU=
NTER);
+        if (target_dispatch !=3D dispatch) {
+            return H_SUCCESS;
+        }
+
+        /*
+         * The targeted confer does not do anything special beyond yield=
ing
+         * the current vCPU, but even this should be better than nothing=
.
+         * At least for single-threaded tcg, it gives the target a chanc=
e to
+         * run before we run again. Multi-threaded tcg does not really d=
o
+         * anything with EXCP_YIELD yet.
+         */
+    }
+
+    cs->exception_index =3D EXCP_YIELD;
+    cs->exit_request =3D 1;
+    cpu_loop_exit(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1915,6 +1981,7 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
=20
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
--=20
2.21.0


