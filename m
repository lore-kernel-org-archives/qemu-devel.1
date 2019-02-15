Received: from eggs.gnu.org ([209.51.188.92]:52624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugCW-0004HC-EF
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugCV-0007WZ-EZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:18:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49174
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugCV-0007SA-A8
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:18:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGBR6f097482
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:18:52 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qp0pp0r08-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:18:20 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 16:16:54 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 17:16:45 +0100
In-Reply-To: <20190215161648.9600-1-clg@kaod.org>
References: <20190215161648.9600-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215161648.9600-8-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/10] target/ppc: Detect erroneous condition
 in interrupt delivery
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

It's very easy for the CPU specific has_work() implementation
and the logic in ppc_hw_interrupt() to be subtly out of sync.

This can occasionally allow a CPU to wakeup from a PM state
and resume executing past the PM instruction when it should
resume at the 0x100 vector.

This detects if it happens and aborts, making it a lot easier
to catch such bugs when testing rather than chasing obscure
guest misbehaviour.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 37546bb0f0fe..1a2f469a5fa2 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -878,6 +878,22 @@ static void ppc_hw_interrupt(CPUPPCState *env)
             return;
         }
     }
+
+    if (env->resume_as_sreset) {
+        /*
+         * This is a bug ! It means that has_work took us out of halt wi=
thout
+         * anything to deliver while in a PM state that requires getting
+         * out via a 0x100
+         *
+         * This means we will incorrectly execute past the power managem=
ent
+         * instruction instead of triggering a reset.
+         *
+         * It generally means a discrepancy between the wakup conditions=
 in the
+         * processor has_work implementation and the logic in this funct=
ion.
+         */
+        cpu_abort(CPU(ppc_env_get_cpu(env)),
+                  "Wakeup from PM state but interrupt Undelivered");
+    }
 }
=20
 void ppc_cpu_do_system_reset(CPUState *cs)
--=20
2.20.1
