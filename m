Received: from eggs.gnu.org ([2001:4830:134:3::10]:43714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMJ9v-0004QJ-Mw
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMJ9u-0001GU-Sp
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:41:07 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:48437 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMJ9u-0001GM-GH
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:41:06 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Dec 2016 19:41:05 +0100
Message-Id: <148295046527.19871.6610919709371885230.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 2/7] trace: Make
 trace_get_vcpu_event_count() inlinable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Later patches will make use of it.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 trace/control-internal.h |    5 +++++
 trace/control.c          |    9 ++-------
 trace/control.h          |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/trace/control-internal.h b/trace/control-internal.h
index a9d395a587..beb98a0d2c 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -16,6 +16,7 @@
=20
=20
 extern int trace_events_enabled_count;
+extern uint32_t trace_next_vcpu_id;
=20
=20
 static inline bool trace_event_is_pattern(const char *str)
@@ -82,6 +83,10 @@ static inline bool trace_event_get_vcpu_state_dynamic(=
CPUState *vcpu,
     return trace_event_get_vcpu_state_dynamic_by_vcpu_id(vcpu, vcpu_id);
 }
=20
+static inline uint32_t trace_get_vcpu_event_count(void)
+{
+    return trace_next_vcpu_id;
+}
=20
 void trace_event_register_group(TraceEvent **events);
=20
diff --git a/trace/control.c b/trace/control.c
index 1a7bee6ddc..52d0e343fa 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -36,7 +36,7 @@ typedef struct TraceEventGroup {
 static TraceEventGroup *event_groups;
 static size_t nevent_groups;
 static uint32_t next_id;
-static uint32_t next_vcpu_id;
+uint32_t trace_next_vcpu_id;
=20
 QemuOptsList qemu_trace_opts =3D {
     .name =3D "trace",
@@ -65,7 +65,7 @@ void trace_event_register_group(TraceEvent **events)
     for (i =3D 0; events[i] !=3D NULL; i++) {
         events[i]->id =3D next_id++;
         if (events[i]->vcpu_id !=3D TRACE_VCPU_EVENT_NONE) {
-            events[i]->vcpu_id =3D next_vcpu_id++;
+            events[i]->vcpu_id =3D trace_next_vcpu_id++;
         }
     }
     event_groups =3D g_renew(TraceEventGroup, event_groups, nevent_group=
s + 1);
@@ -299,8 +299,3 @@ char *trace_opt_parse(const char *optarg)
=20
     return trace_file;
 }
-
-uint32_t trace_get_vcpu_event_count(void)
-{
-    return next_vcpu_id;
-}
diff --git a/trace/control.h b/trace/control.h
index ccaeac8552..80d326c4d1 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -237,7 +237,7 @@ char *trace_opt_parse(const char *optarg);
  *
  * Return the number of known vcpu-specific events
  */
-uint32_t trace_get_vcpu_event_count(void);
+static uint32_t trace_get_vcpu_event_count(void);
=20
=20
 #include "trace/control-internal.h"
