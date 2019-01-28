Received: from eggs.gnu.org ([209.51.188.92]:38551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vc-0005Nb-CV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VU-0003Al-IS
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3VO-00030c-Pf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:04 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9i5Tu074217
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9vhk7aud-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:58 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:56 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:21 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-16-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/19] target/ppc: Detect erroneous condition
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
