Received: from eggs.gnu.org ([2001:4830:134:3::10]:60687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsuaz-0003qv-KK
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsuay-0005LM-IV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:40:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dsuay-0005LE-CS
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:40:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 15 Sep 2017 18:39:50 +0100
Message-Id: <20170915173950.21404-2-stefanha@redhat.com>
In-Reply-To: <20170915173950.21404-1-stefanha@redhat.com>
References: <20170915173950.21404-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] trace: Immediately apply per-vCPU state
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

Right now, function trace_event_set_vcpu_state_dynamic() asynchronously e=
nables
events in the case a vCPU is executing TCG code. If the vCPU is being cre=
ated
this makes some events like "guest_cpu_enter" to not be traced.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Message-id: 150525662577.19850.13767570977540117247.stgit@frigg.lan
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control-target.c | 18 +++++++++++-------
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
--=20
2.13.5
