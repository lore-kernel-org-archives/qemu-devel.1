Received: from eggs.gnu.org ([2001:4830:134:3::10]:49664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP5PR-0004Dr-92
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 07:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP5PN-000604-7G
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 07:08:53 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:48805 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP5PM-0005zP-Rp
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 07:08:49 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 14:08:38 +0300
Message-Id: <149838891852.10366.11525912227070211356.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace: Fix early setting of events with the
 "vcpu" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Events with the "vcpu" property need to be set globally (i.e., as if they=
 didn't
have that property) while we have not yet created any vCPU.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 trace/control-target.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 6266e6380d..99a8ed5157 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -1,7 +1,7 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2014-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2014-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -38,12 +38,16 @@ void trace_event_set_state_dynamic(TraceEvent *ev, bo=
ol state)
 {
     CPUState *vcpu;
     assert(trace_event_get_state_static(ev));
-    if (trace_event_is_vcpu(ev)) {
+    if (trace_event_is_vcpu(ev) && likely(first_cpu !=3D NULL)) {
         CPU_FOREACH(vcpu) {
             trace_event_set_vcpu_state_dynamic(vcpu, ev, state);
         }
     } else {
-        /* Without the "vcpu" property, dstate can only be 1 or 0 */
+        /*
+         * Without the "vcpu" property, dstate can only be 1 or 0. With =
it, we
+         * haven't instantiated any vCPU yet, so we will set a global st=
ate
+         * instead, and trace_init_vcpu will reconcile it afterwards.
+         */
         bool state_pre =3D *ev->dstate;
         if (state_pre !=3D state) {
             if (state) {
