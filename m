Received: from eggs.gnu.org ([209.51.188.92]:38840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3W1-0005gp-OF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3W0-00044f-Mm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3W0-00037a-Br
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:40 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9i6uW074239
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9vhk7b0a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:04 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:47:02 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:25 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-20-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/19] target/ppc: Add support for LPCR:HEIC on
 POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This controls whether the External Interrupt (0x500) can be
delivered to the hypervisor or not.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/excp_helper.c        | 5 ++++-
 target/ppc/translate_init.inc.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index d171a5eb6236..39bedbb11db0 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -827,7 +827,10 @@ static void ppc_hw_interrupt(CPUPPCState *env)
     /* External interrupt can ignore MSR:EE under some circumstances */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_EXT)) {
         bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        if (async_deliver || (env->has_hv_mode && msr_hv =3D=3D 0 && !lp=
es0)) {
+        bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+        /* HEIC blocks delivery to the hypervisor */
+        if ((async_deliver && !(heic && msr_hv && !msr_pr)) ||
+            (env->has_hv_mode && msr_hv =3D=3D 0 && !lpes0)) {
             powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_EXTERNAL);
             return;
         }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 7f25215f0192..63ded33ea7ea 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8823,7 +8823,10 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         /* External Exception */
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
             (env->spr[SPR_LPCR] & LPCR_EEE)) {
-            return true;
+            bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+            if (heic =3D=3D 0 || !msr_hv || msr_pr) {
+                return true;
+            }
         }
         /* Decrementer Exception */
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
--=20
2.20.1
