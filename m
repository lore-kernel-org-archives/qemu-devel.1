Received: from eggs.gnu.org ([209.51.188.92]:35053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogPG-0005Uo-Sz
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogPG-0006qh-6W
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:19:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gogPG-0006qR-15
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:19:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 30 Jan 2019 11:18:16 +0800
Message-Id: <20190130031817.27780-6-stefanha@redhat.com>
In-Reply-To: <20190130031817.27780-1-stefanha@redhat.com>
References: <20190130031817.27780-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/6] trace: improve runstate tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Trace previous state, move tracepoint to runstate_set start (to cover
all cases for debugging), add string representations of traced states.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190124125154.474650-1-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 vl.c         | 7 +++++--
 trace-events | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index bc9fbec654..9cf0fbe0b8 100644
--- a/vl.c
+++ b/vl.c
@@ -731,6 +731,9 @@ void runstate_set(RunState new_state)
 {
     assert(new_state < RUN_STATE__MAX);
=20
+    trace_runstate_set(current_run_state, RunState_str(current_run_state=
),
+                       new_state, RunState_str(current_run_state));
+
     if (current_run_state =3D=3D new_state) {
         return;
     }
@@ -741,7 +744,7 @@ void runstate_set(RunState new_state)
                      RunState_str(new_state));
         abort();
     }
-    trace_runstate_set(new_state);
+
     current_run_state =3D new_state;
 }
=20
@@ -1554,7 +1557,7 @@ void vm_state_notify(int running, RunState state)
 {
     VMChangeStateEntry *e, *next;
=20
-    trace_vm_state_notify(running, state);
+    trace_vm_state_notify(running, state, RunState_str(state));
=20
     QLIST_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
         e->cb(e->opaque, running, state);
diff --git a/trace-events b/trace-events
index 4fd2cb4b97..e66afc59e9 100644
--- a/trace-events
+++ b/trace-events
@@ -34,9 +34,9 @@ cpu_out(unsigned int addr, char size, unsigned int val)=
 "addr 0x%x(%c) value %u"
 balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
=20
 # vl.c
-vm_state_notify(int running, int reason) "running %d reason %d"
+vm_state_notify(int running, int reason, const char *reason_str) "runnin=
g %d reason %d (%s)"
 load_file(const char *name, const char *path) "name %s location %s"
-runstate_set(int new_state) "new state %d"
+runstate_set(int current_state, const char *current_state_str, int new_s=
tate, const char *new_state_str) "current_run_state %d (%s) new_state %d =
(%s)"
 system_wakeup_request(int reason) "reason=3D%d"
 qemu_system_shutdown_request(int reason) "reason=3D%d"
 qemu_system_powerdown_request(void) ""
--=20
2.20.1
