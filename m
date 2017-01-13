Received: from eggs.gnu.org ([2001:4830:134:3::10]:50583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8lw-0007Ix-Lp
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8lt-0005tS-Jo
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:28 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:49709)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8lt-0005t5-7h
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:25 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 13 Jan 2017 21:48:22 +0100
Message-Id: <148434050231.31446.10929552655201551997.stgit@frigg.lan>
In-Reply-To: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 2/7] trace: Make
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
Cc: Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Later patches will make use of it.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 trace/control-internal.h |    7 ++++++-
 trace/control.c          |   11 +++--------
 trace/control.h          |    4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/trace/control-internal.h b/trace/control-internal.h
index a9d395a587..a8beb44847 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -1,7 +1,7 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2011-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
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
index 1a7bee6ddc..8a52c7fc39 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -1,7 +1,7 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2011-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
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
index ccaeac8552..6dfbc53c8d 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -1,7 +1,7 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2011-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -237,7 +237,7 @@ char *trace_opt_parse(const char *optarg);
  *
  * Return the number of known vcpu-specific events
  */
-uint32_t trace_get_vcpu_event_count(void);
+static uint32_t trace_get_vcpu_event_count(void);
=20
=20
 #include "trace/control-internal.h"
