Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D2FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D3A22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EVtykKP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D3A22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ldi-0004VM-6W
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1F-0005dp-8W
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1D-0000Hc-PS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:57 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42595)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L1D-0008V7-3N; Wed, 21 Aug 2019 03:26:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjG5mS9z9sR1; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372354;
 bh=+KW+voBQ7BzgDYq6pRx5WSron5t+f80yIV8x/ugXkfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EVtykKP3nmY0feElibJsnp7F+C8GkPl/VJJtATZGjDdkTJ8ueJLKQQrSQ0kjVOlXz
 b9bEJ0nh77A9nLWI4ZdwrbK9zyXnRSr7OnmFvQOuSRuzEXN+V2B93uAhZg9EUGgT/1
 8AJhYimqDsmMFrrzJxrZqjBjfp+XYD6O60cmRdW4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:31 +1000
Message-Id: <20190821072542.23090-32-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 31/42] spapr: Implement ibm,suspend-me
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
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

This has been useful to modify and test the Linux pseries suspend
code but it requires modification to the guest to call it (due to
being gated by other unimplemented features). It is not otherwise
used by Linux yet, but work is slowly progressing there.

This allows a (lightly modified) guest kernel to suspend with
`echo mem > /sys/power/state` and be resumed with system_wakeup
monitor command.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20190722061752.22114-2-npiggin@gmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  7 +++++++
 hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 56b33571c5..51e1cb0d46 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3083,6 +3083,13 @@ static void spapr_machine_init(MachineState *machi=
ne)
=20
     qemu_register_boot_set(spapr_boot_set, spapr);
=20
+    /*
+     * Nothing needs to be done to resume a suspended guest because
+     * suspending does not change the machine state, so no need for
+     * a ->wakeup method.
+     */
+    qemu_register_wakeup_support();
+
     if (kvm_enabled()) {
         /* to stop and start vmclock */
         qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d3f9a69a51..526b489297 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -217,6 +217,36 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
     qemu_cpu_kick(cs);
 }
=20
+static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
+                           uint32_t token, uint32_t nargs,
+                           target_ulong args,
+                           uint32_t nret, target_ulong rets)
+{
+    CPUState *cs;
+
+    if (nargs !=3D 0 || nret !=3D 1) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *c =3D POWERPC_CPU(cs);
+        CPUPPCState *e =3D &c->env;
+        if (c =3D=3D cpu) {
+            continue;
+        }
+
+        /* See h_join */
+        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+            rtas_st(rets, 0, H_MULTI_THREADS_ACTIVE);
+            return;
+        }
+    }
+
+    qemu_system_suspend_request();
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static inline int sysparm_st(target_ulong addr, target_ulong len,
                              const void *val, uint16_t vallen)
 {
@@ -484,6 +514,8 @@ static void core_rtas_register_types(void)
                         rtas_query_cpu_stopped_state);
     spapr_rtas_register(RTAS_START_CPU, "start-cpu", rtas_start_cpu);
     spapr_rtas_register(RTAS_STOP_SELF, "stop-self", rtas_stop_self);
+    spapr_rtas_register(RTAS_IBM_SUSPEND_ME, "ibm,suspend-me",
+                        rtas_ibm_suspend_me);
     spapr_rtas_register(RTAS_IBM_GET_SYSTEM_PARAMETER,
                         "ibm,get-system-parameter",
                         rtas_ibm_get_system_parameter);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c79bc6a123..fa7c380edb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -642,8 +642,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_=
ulong opcode,
 #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
+#define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
=20
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
=20
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
--=20
2.21.0


