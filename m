Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUqeJ-0007kJ-P4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUqeI-0008Ek-T7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUqeI-0008EW-NU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 11 Jul 2017 09:35:51 +0100
Message-Id: <20170711083552.17433-2-stefanha@redhat.com>
In-Reply-To: <20170711083552.17433-1-stefanha@redhat.com>
References: <20170711083552.17433-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] trace: Fix early setting of events with the
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

Events with the "vcpu" property need to be set globally (i.e., as if they=
 didn't
have that property) while we have not yet created any vCPU.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Message-id: 149838891852.10366.11525912227070211356.stgit@frigg.lan
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control-target.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 6266e63..99a8ed5 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -1,7 +1,7 @@
 /*
  * Interface for configuring and controlling the state of tracing events=
.
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
--=20
2.9.4
