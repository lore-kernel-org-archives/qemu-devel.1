Received: from eggs.gnu.org ([2001:4830:134:3::10]:32993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db1SC-00077Z-BS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db1SB-00075e-B6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1db1SB-00074e-21
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:21:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 28 Jul 2017 10:20:52 +0100
Message-Id: <20170728092053.10122-2-stefanha@redhat.com>
In-Reply-To: <20170728092053.10122-1-stefanha@redhat.com>
References: <20170728092053.10122-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] trace: add TRACE_<event>_BACKEND_DSTATE()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

QEMU keeps track of trace event enabled/disabled state and provides
monitor commands to inspect and modify the "dstate".  SystemTap and
LTTng UST maintain independent enabled/disabled states for each trace
event.

Introduce a new per-event macro that combines backend-specific dstate
like this:

  #define TRACE_MY_EVENT_BACKEND_DSTATE() ( \
      QEMU_MY_EVENT_ENABLED() || /* SystemTap */ \
      tracepoint_enabled(qemu, my_event) /* LTTng UST */ || \
      false)

This will be used to extend trace_event_get_state() in the next patch.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py         |  1 +
 scripts/tracetool/backend/__init__.py |  3 +++
 scripts/tracetool/backend/dtrace.py   | 12 ++++++++++++
 scripts/tracetool/backend/ust.py      |  5 +++++
 scripts/tracetool/format/h.py         | 10 ++++++++++
 5 files changed, 31 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index d4c204a472..0670ec17d5 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -271,6 +271,7 @@ class Event(object):
     QEMU_TRACE_NOCHECK       = "_nocheck__" + QEMU_TRACE
     QEMU_TRACE_TCG           = QEMU_TRACE + "_tcg"
     QEMU_DSTATE              = "_TRACE_%(NAME)s_DSTATE"
+    QEMU_BACKEND_DSTATE      = "TRACE_%(NAME)s_BACKEND_DSTATE"
     QEMU_EVENT               = "_TRACE_%(NAME)s_EVENT"
 
     def api(self, fmt=None):
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index f735a259c0..259c6a6531 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -119,5 +119,8 @@ class Wrapper:
     def generate(self, event, group):
         self._run_function("generate_%s", event, group)
 
+    def generate_backend_dstate(self, event, group):
+        self._run_function("generate_%s_backend_dstate", event, group)
+
     def generate_end(self, events, group):
         self._run_function("generate_%s_end", events, group)
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index c6812b70a2..17f902cc62 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -44,8 +44,20 @@ def generate_h_begin(events, group):
     out('#include "%s"' % header,
         '')
 
+    # SystemTap defines <provider>_<name>_ENABLED() but other DTrace
+    # implementations might not.
+    for e in events:
+        out('#ifndef QEMU_%(uppername)s_ENABLED',
+            '#define QEMU_%(uppername)s_ENABLED() false',
+            '#endif',
+            uppername=e.name.upper())
 
 def generate_h(event, group):
     out('    QEMU_%(uppername)s(%(argnames)s);',
         uppername=event.name.upper(),
         argnames=", ".join(event.args.names()))
+
+
+def generate_h_backend_dstate(event, group):
+    out('    QEMU_%(uppername)s_ENABLED() || \\',
+        uppername=event.name.upper())
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 2adaf548d5..412592b8e0 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -38,3 +38,8 @@ def generate_h(event, group):
     out('    tracepoint(qemu, %(name)s%(tp_args)s);',
         name=event.name,
         tp_args=argnames)
+
+
+def generate_h_backend_dstate(event, group):
+    out('    tracepoint_enabled(qemu, %(name)s) || \\',
+        name=event.name)
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index aecf249d66..e06f0f27c5 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -49,6 +49,16 @@ def generate(events, backend, group):
     backend.generate_begin(events, group)
 
     for e in events:
+        # tracer-specific dstate
+        out('',
+            '#define %(api)s() ( \\',
+            api=e.api(e.QEMU_BACKEND_DSTATE))
+
+        if "disable" not in e.properties:
+            backend.generate_backend_dstate(e, group)
+
+        out('    false)')
+
         # tracer without checks
         out('',
             'static inline void %(api)s(%(args)s)',
-- 
2.13.3
