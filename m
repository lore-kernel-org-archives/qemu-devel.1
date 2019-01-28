Received: from eggs.gnu.org ([209.51.188.92]:38622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vi-0005Qu-5F
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vg-0003LB-8n
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58488
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3Ve-0002wA-V5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:19 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9htTR054911
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9xb4jv6x-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:55 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:53 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:17 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-12-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/19] target/ppc: Move "wakeup reset" code to
 a separate function
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

This moves the code to handle waking up from the 0x100 vector
from powerpc_excp() to a separate function, as the former is
already way too big as it is.

No functional change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/excp_helper.c | 75 ++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 97503193ef43..489a54f51b90 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -65,6 +65,46 @@ static inline void dump_syscall(CPUPPCState *env)
                   ppc_dump_gpr(env, 6), env->nip);
 }
=20
+static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp=
,
+                                target_ulong *msr)
+{
+    /* We no longer are in a PM state */
+    env->in_pm_state =3D false;
+
+    /* Pretend to be returning from doze always as we don't lose state *=
/
+    *msr |=3D (0x1ull << (63 - 47));
+
+    /* Machine checks are sent normally */
+    if (excp =3D=3D POWERPC_EXCP_MCHECK) {
+        return excp;
+    }
+    switch (excp) {
+    case POWERPC_EXCP_RESET:
+        *msr |=3D 0x4ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_EXTERNAL:
+        *msr |=3D 0x8ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_DECR:
+        *msr |=3D 0x6ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_SDOOR:
+        *msr |=3D 0x5ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_SDOOR_HV:
+        *msr |=3D 0x3ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_HV_MAINT:
+        *msr |=3D 0xaull << (63 - 45);
+        break;
+    default:
+        cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
+                  excp);
+    }
+    return POWERPC_EXCP_RESET;
+}
+
+
 /* Note that this function should be greatly optimized
  * when called with a constant excp, from ppc_hw_interrupt
  */
@@ -102,40 +142,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
      * P7/P8/P9
      */
     if (env->in_pm_state) {
-        env->in_pm_state =3D false;
-
-        /* Pretend to be returning from doze always as we don't lose sta=
te */
-        msr |=3D (0x1ull << (63 - 47));
-
-        /* Non-machine check are routed to 0x100 with a wakeup cause
-         * encoded in SRR1
-         */
-        if (excp !=3D POWERPC_EXCP_MCHECK) {
-            switch (excp) {
-            case POWERPC_EXCP_RESET:
-                msr |=3D 0x4ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_EXTERNAL:
-                msr |=3D 0x8ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_DECR:
-                msr |=3D 0x6ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_SDOOR:
-                msr |=3D 0x5ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_SDOOR_HV:
-                msr |=3D 0x3ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_HV_MAINT:
-                msr |=3D 0xaull << (63 - 45);
-                break;
-            default:
-                cpu_abort(cs, "Unsupported exception %d in Power Save mo=
de\n",
-                          excp);
-            }
-            excp =3D POWERPC_EXCP_RESET;
-        }
+        excp =3D powerpc_reset_wakeup(cs, env, excp, &msr);
     }
=20
     /* Exception targetting modifiers
--=20
2.20.1
