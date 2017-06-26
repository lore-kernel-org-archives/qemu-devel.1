Received: from eggs.gnu.org ([2001:4830:134:3::10]:57022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7k-0007hC-HV
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7h-0005Nn-Qt
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44947)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPc7h-0005Mq-KN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 26 Jun 2017 18:04:39 -0400
Message-Id: <1498514681-3059-6-git-send-email-cota@braap.org>
In-Reply-To: <1498514681-3059-1-git-send-email-cota@braap.org>
References: <1498514681-3059-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/7] trace: [tcg] Do not generate TCG code to
 trace dinamically-disabled events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Desnogues <laurent.desnogues@gmail.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

If an event is dynamically disabled, the TCG code that calls the
execution-time tracer is not generated.

Removes the overheads of execution-time tracers for dynamically disabled
events. As a bonus, also avoids checking the event state when the
execution-time tracer is called from TCG-generated code (since otherwise
TCG would simply not call it).

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 scripts/tracetool/__init__.py            |  3 ++-
 scripts/tracetool/format/h.py            | 26 +++++++++++++++++++-------
 scripts/tracetool/format/tcg_h.py        | 21 +++++++++++++++++----
 scripts/tracetool/format/tcg_helper_c.py |  5 +++--
 4 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 1ffbc1d..d4c204a 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -6,7 +6,7 @@ Machinery for generating tracing-related intermediate files.
 """
 
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
-__copyright__  = "Copyright 2012-2016, Lluís Vilanova <vilanova@ac.upc.edu>"
+__copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
@@ -268,6 +268,7 @@ class Event(object):
         return self._FMT.findall(self.fmt)
 
     QEMU_TRACE               = "trace_%(name)s"
+    QEMU_TRACE_NOCHECK       = "_nocheck__" + QEMU_TRACE
     QEMU_TRACE_TCG           = QEMU_TRACE + "_tcg"
     QEMU_DSTATE              = "_TRACE_%(NAME)s_DSTATE"
     QEMU_EVENT               = "_TRACE_%(NAME)s_EVENT"
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 3682f4e..aecf249 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -6,7 +6,7 @@ trace/generated-tracers.h
 """
 
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
-__copyright__  = "Copyright 2012-2016, Lluís Vilanova <vilanova@ac.upc.edu>"
+__copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
@@ -49,6 +49,19 @@ def generate(events, backend, group):
     backend.generate_begin(events, group)
 
     for e in events:
+        # tracer without checks
+        out('',
+            'static inline void %(api)s(%(args)s)',
+            '{',
+            api=e.api(e.QEMU_TRACE_NOCHECK),
+            args=e.args)
+
+        if "disable" not in e.properties:
+            backend.generate(e, group)
+
+        out('}')
+
+        # tracer wrapper with checks (per-vCPU tracing)
         if "vcpu" in e.properties:
             trace_cpu = next(iter(e.args))[1]
             cond = "trace_event_get_vcpu_state(%(cpu)s,"\
@@ -63,16 +76,15 @@ def generate(events, backend, group):
             'static inline void %(api)s(%(args)s)',
             '{',
             '    if (%(cond)s) {',
+            '        %(api_nocheck)s(%(names)s);',
+            '    }',
+            '}',
             api=e.api(),
+            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
             args=e.args,
+            names=", ".join(e.args.names()),
             cond=cond)
 
-        if "disable" not in e.properties:
-            backend.generate(e, group)
-
-        out('    }',
-            '}')
-
     backend.generate_end(events, group)
 
     out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
index db55f52..1651cc3 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -6,7 +6,7 @@ Generate .h file for TCG code generation.
 """
 
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
-__copyright__  = "Copyright 2012-2016, Lluís Vilanova <vilanova@ac.upc.edu>"
+__copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
@@ -46,7 +46,7 @@ def generate(events, backend, group):
 
     for e in events:
         # just keep one of them
-        if "tcg-trans" not in e.properties:
+        if "tcg-exec" not in e.properties:
             continue
 
         out('static inline void %(name_tcg)s(%(args)s)',
@@ -58,12 +58,25 @@ def generate(events, backend, group):
             args_trans = e.original.event_trans.args
             args_exec = tracetool.vcpu.transform_args(
                 "tcg_helper_c", e.original.event_exec, "wrapper")
+            if "vcpu" in e.properties:
+                trace_cpu = e.args.names()[0]
+                cond = "trace_event_get_vcpu_state(%(cpu)s,"\
+                       " TRACE_%(id)s)"\
+                       % dict(
+                           cpu=trace_cpu,
+                           id=e.original.event_exec.name.upper())
+            else:
+                cond = "true"
+
             out('    %(name_trans)s(%(argnames_trans)s);',
-                '    gen_helper_%(name_exec)s(%(argnames_exec)s);',
+                '    if (%(cond)s) {',
+                '        gen_helper_%(name_exec)s(%(argnames_exec)s);',
+                '    }',
                 name_trans=e.original.event_trans.api(e.QEMU_TRACE),
                 name_exec=e.original.event_exec.api(e.QEMU_TRACE),
                 argnames_trans=", ".join(args_trans.names()),
-                argnames_exec=", ".join(args_exec.names()))
+                argnames_exec=", ".join(args_exec.names()),
+                cond=cond)
 
         out('}')
 
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index ec7acbe..bbbd6ad 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -6,7 +6,7 @@ Generate trace/generated-helpers.c.
 """
 
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
-__copyright__  = "Copyright 2012-2016, Lluís Vilanova <vilanova@ac.upc.edu>"
+__copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
@@ -71,10 +71,11 @@ def generate(events, backend, group):
 
         out('void %(name_tcg)s(%(args_api)s)',
             '{',
+            # NOTE: the check was already performed at TCG-generation time
             '    %(name)s(%(args_call)s);',
             '}',
             name_tcg="helper_%s_proxy" % e.api(),
-            name=e.api(),
+            name=e.api(e.QEMU_TRACE_NOCHECK),
             args_api=e_args_api,
             args_call=", ".join(e_args_call.casted()),
             )
-- 
2.7.4
