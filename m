Received: from eggs.gnu.org ([209.51.188.92]:57580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkh-0004ss-MW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkd-000247-ER
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:57 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:21 +1100
Message-Id: <20190226045304.25618-8-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/50] target/ppc: Detect erroneous condition in
 interrupt delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

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
Message-Id: <20190215161648.9600-8-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 37546bb0f0..1a2f469a5f 100644
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
