Received: from eggs.gnu.org ([2001:4830:134:3::10]:55922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpcEf-0000h8-VB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpcEb-0000FY-64
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:27:25 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:49193)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpcEa-00009E-Qw
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:27:21 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 18:27:10 +0300
Message-Id: <150471163020.18882.9386672218918089445.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace: Immediately apply per-vCPU state
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
Cc: stefanha@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>

Right now, function trace_event_set_vcpu_state_dynamic() asynchronously e=
nables
events in the case a vCPU is executing TCG code. If the vCPU is being cre=
ated
this makes some events like "guest_cpu_enter" to not be traced.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 trace/control-target.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 4e36101997..0056da6a46 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -88,13 +88,18 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcp=
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
+            run_on_cpu_data ignored;
+            trace_event_synchronize_vcpu_state_dynamic(vcpu, ignored);
+        }
     }
 }
=20
