Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2BBC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6983A21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k7mq+bkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsnp-0003rB-Gs
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:15:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQR-0000Lc-FH
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQQ-0002qf-68
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:03 -0400
Received: from ozlabs.org ([203.11.71.1]:49441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQP-0002dQ-Kp; Wed, 29 May 2019 02:51:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv61d8bz9sPD; Wed, 29 May 2019 16:50:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112626;
	bh=/fFO7nS87jy6WRRFS3qGkfTO+v+bQ72fNfrwS6enePQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7mq+bkLOmMcg0g0TQNQlkQ/XNAXJ1dhKdUMV13SupyfefqPPyx4AFCErLTP6ma0I
	tH0/cjn3b2RZNCeVZ+UwF6+pZgeF0biKeQ0/vAezOuY2/O2nLkW7JjE6adf9FOrGcU
	GLhmp2GNX/5+fOVC1MghOBifZaAj77JEYJvzk30s=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:49:54 +1000
Message-Id: <20190529065017.15149-22-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 21/44] target/ppc: Set PSSCR_EC on cpu halt to
 prevent spurious wakeup
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The processor stop status and control register (PSSCR) is used to
control the power saving facilities of the thread. The exit criterion
bit (EC) is used to specify whether the thread should be woken by any
interrupt (EC =3D=3D 0) or only an interrupt enabled in the LPCR to wake =
the
thread (EC =3D=3D 1).

The rtas facilities start-cpu and self-stop are used to transition a
vcpu between the stopped and running states. When a vcpu is stopped it
may only be started again by the start-cpu rtas call.

Currently a vcpu in the stopped state will start again whenever an
interrupt comes along due to PSSCR_EC being cleared, and while this is
architecturally correct for a hardware thread, a vcpu is expected to
only be woken by calling start-cpu. This means when performing a reboot
on a tcg machine that the secondary threads will restart while the
primary is still in slof, this is unsupported and causes call traces
like:

SLOF ********************************************************************=
**
QEMU Starting
 Build Date =3D Jan 14 2019 18:00:39
 FW Version =3D git-a5b428e1c1eae703
 Press "s" to enter Open Firmware.

qemu: fatal: Trying to deliver HV exception (MSR) 70 with no HV support

NIP 6d61676963313230   LR 000000003dbe0308 CTR 6d61676963313233 XER 00000=
00000000000 CPU#1
MSR 0000000000000000 HID0 0000000000000000  HF 0000000000000000 iidx 3 di=
dx 3
TB 00000026 115746031956 DECR 18446744073326238463
GPR00 000000003dbe0308 000000003e669fe0 000000003dc10700 0000000000000003
GPR04 000000003dc62198 000000003dc62178 000000003dc0ea48 0000000000000030
GPR08 000000003dc621a8 0000000000000018 000000003e466008 000000003dc50700
GPR12 c00000000093a4e0 c00000003ffff300 c00000003e533f90 0000000000000000
GPR16 0000000000000000 0000000000000000 000000003e466010 000000003dc0b040
GPR20 0000000000008000 000000000000f003 0000000000000006 000000003e66a050
GPR24 000000003dc06400 000000003dc0ae70 0000000000000003 000000000000f001
GPR28 000000003e66a060 ffffffffffffffff 6d61676963313233 0000000000000028
CR 28000222  [ E  L  -  -  -  E  E  E  ]             RES ffffffffffffffff
FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR08 0000000000000000 0000000000000000 0000000000000000 00000000311825e0
FPR12 00000000311825e0 0000000000000000 0000000000000000 0000000000000000
FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPSCR 0000000000000000
 SRR0 000000003dbe06b0  SRR1 0000000000080000    PVR 00000000004e1200 VRS=
AVE 0000000000000000
SPRG0 000000003dbe0308 SPRG1 000000003e669fe0  SPRG2 00000000000000d8  SP=
RG3 000000003dbe0308
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SP=
RG7 0000000000000000
HSRR0 6d61676963313230 HSRR1 0000000000000000
 CFAR 000000003dbe3e64
 LPCR 0000000004020008
 PTCR 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000
Aborted (core dumped)

To fix this, set the PSSCR_EC bit when a vcpu is stopped to disable it
from coming back online until the start-cpu rtas call is made.

Fixes: 21c0d66a9c99 ("target/ppc: Fix support for "STOP light" states on =
POWER9")

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190516005744.24366-1-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 2 ++
 hw/ppc/spapr_rtas.c     | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index f04e06cdf6..5621fb9a3d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -58,9 +58,11 @@ static void spapr_cpu_reset(void *opaque)
      *
      * Disable Power-saving mode Exit Cause exceptions for the CPU, so
      * we don't get spurious wakups before an RTAS start-cpu call.
+     * For the same reason, set PSSCR_EC.
      */
     lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_=
pm);
     lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
+    env->spr[SPR_PSSCR] |=3D PSSCR_EC;
=20
     /* Set RMLS to the max (ie, 16G) */
     lpcr &=3D ~LPCR_RMLS;
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index ee24212765..5bc1a93271 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -177,6 +177,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, Spapr=
MachineState *spapr,
         } else {
             lpcr &=3D ~(LPCR_UPRT | LPCR_GTSE | LPCR_HR);
         }
+        env->spr[SPR_PSSCR] &=3D ~PSSCR_EC;
     }
     ppc_store_lpcr(newcpu, lpcr);
=20
@@ -205,8 +206,11 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
=20
     /* Disable Power-saving mode Exit Cause exceptions for the CPU.
      * This could deliver an interrupt on a dying CPU and crash the
-     * guest */
+     * guest.
+     * For the same reason, set PSSCR_EC.
+     */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
+    env->spr[SPR_PSSCR] |=3D PSSCR_EC;
     cs->halted =3D 1;
     kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
--=20
2.21.0


