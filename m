Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5TS-0006HZ-F2
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5TP-0008Cz-DI
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:52:46 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:55798 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5TP-0008BN-1g
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:52:43 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:52:34 +0300
Message-Id: <150506235457.23603.4968569384233027274.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] trace: Immediately apply per-vCPU state
 changes if a vCPU is being created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Right now, function trace_event_set_vcpu_state_dynamic() asynchronously e=
nables
events in the case a vCPU is executing TCG code. If the vCPU is being cre=
ated
this makes some events like "guest_cpu_enter" to not be traced.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Emilio G. Cora <cota@braap.org>
---

Changes in v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Use RUN_ON_CPU_NULL [Emilio G. Cota].
* Rebase on fcea73709b.
---
 trace/control-target.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 4e36101997..706b2cee9d 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -88,13 +88,17 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcp=
u,
             clear_bit(vcpu_id, vcpu->trace_dstate_delayed);
             (*ev->dstate)--;
         }
-        /*
-         * Delay changes until next TB; we want all TBs to be built from=
 a
-         * single set of dstate values to ensure consistency of generate=
d
-         * tracing code.
-         */
-        async_run_on_cpu(vcpu, trace_event_synchronize_vcpu_state_dynami=
c,
-                         RUN_ON_CPU_NULL);
+        if (vcpu->created) {
+            /*
+             * Delay changes until next TB; we want all TBs to be built =
from a
+             * single set of dstate values to ensure consistency of gene=
rated
+             * tracing code.
+             */
+            async_run_on_cpu(vcpu, trace_event_synchronize_vcpu_state_dy=
namic,
+                             RUN_ON_CPU_NULL);
+        } else {
+            trace_event_synchronize_vcpu_state_dynamic(vcpu, RUN_ON_CPU_=
NULL);
+        }
     }
 }
=20
