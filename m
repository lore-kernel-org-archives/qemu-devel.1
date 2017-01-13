Received: from eggs.gnu.org ([2001:4830:134:3::10]:50683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8mD-0007Ra-De
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8mB-00063y-T2
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:45 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:49720)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8mB-00063O-GM
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:43 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 13 Jan 2017 21:48:41 +0100
Message-Id: <148434052149.31446.3343314758905711046.stgit@frigg.lan>
In-Reply-To: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 5/7] trace: [tcg] Do not generate TCG code
 to trace dinamically-disabled events
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

If an event is dynamically disabled, the TCG code that calls the
execution-time tracer is not generated.

Removes the overheads of execution-time tracers for dynamically disabled
events. As a bonus, also avoids checking the event state when the
execution-time tracer is called from TCG-generated code (since otherwise
TCG would simply not call it).

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 scripts/tracetool/__init__.py            |    3 ++-
 scripts/tracetool/format/h.py            |   26 +++++++++++++++++++-----=
--
 scripts/tracetool/format/tcg_h.py        |   21 +++++++++++++++++----
 scripts/tracetool/format/tcg_helper_c.py |    5 +++--
 4 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 365446fa53..5f1576539e 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -6,7 +6,7 @@ Machinery for generating tracing-related intermediate fil=
es.
 """
=20
 __author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
-__copyright__  =3D "Copyright 2012-2016, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
 __license__    =3D "GPL version 2 or (at your option) any later version"
=20
 __maintainer__ =3D "Stefan Hajnoczi"
@@ -264,6 +264,7 @@ class Event(object):
         return self._FMT.findall(self.fmt)
=20
     QEMU_TRACE               =3D "trace_%(name)s"
+    QEMU_TRACE_NOCHECK       =3D "_nocheck__" + QEMU_TRACE
     QEMU_TRACE_TCG           =3D QEMU_TRACE + "_tcg"
     QEMU_DSTATE              =3D "_TRACE_%(NAME)s_DSTATE"
     QEMU_EVENT               =3D "_TRACE_%(NAME)s_EVENT"
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.p=
y
index 3682f4e6a8..aecf249d66 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -6,7 +6,7 @@ trace/generated-tracers.h
 """
=20
 __author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
-__copyright__  =3D "Copyright 2012-2016, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
 __license__    =3D "GPL version 2 or (at your option) any later version"
=20
 __maintainer__ =3D "Stefan Hajnoczi"
@@ -49,6 +49,19 @@ def generate(events, backend, group):
     backend.generate_begin(events, group)
=20
     for e in events:
+        # tracer without checks
+        out('',
+            'static inline void %(api)s(%(args)s)',
+            '{',
+            api=3De.api(e.QEMU_TRACE_NOCHECK),
+            args=3De.args)
+
+        if "disable" not in e.properties:
+            backend.generate(e, group)
+
+        out('}')
+
+        # tracer wrapper with checks (per-vCPU tracing)
         if "vcpu" in e.properties:
             trace_cpu =3D next(iter(e.args))[1]
             cond =3D "trace_event_get_vcpu_state(%(cpu)s,"\
@@ -63,16 +76,15 @@ def generate(events, backend, group):
             'static inline void %(api)s(%(args)s)',
             '{',
             '    if (%(cond)s) {',
+            '        %(api_nocheck)s(%(names)s);',
+            '    }',
+            '}',
             api=3De.api(),
+            api_nocheck=3De.api(e.QEMU_TRACE_NOCHECK),
             args=3De.args,
+            names=3D", ".join(e.args.names()),
             cond=3Dcond)
=20
-        if "disable" not in e.properties:
-            backend.generate(e, group)
-
-        out('    }',
-            '}')
-
     backend.generate_end(events, group)
=20
     out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format=
/tcg_h.py
index 5f213f6cba..9a73b5b268 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -6,7 +6,7 @@ Generate .h file for TCG code generation.
 """
=20
 __author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
-__copyright__  =3D "Copyright 2012-2016, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
 __license__    =3D "GPL version 2 or (at your option) any later version"
=20
 __maintainer__ =3D "Stefan Hajnoczi"
@@ -41,7 +41,7 @@ def generate(events, backend, group):
=20
     for e in events:
         # just keep one of them
-        if "tcg-trans" not in e.properties:
+        if "tcg-exec" not in e.properties:
             continue
=20
         out('static inline void %(name_tcg)s(%(args)s)',
@@ -53,12 +53,25 @@ def generate(events, backend, group):
             args_trans =3D e.original.event_trans.args
             args_exec =3D tracetool.vcpu.transform_args(
                 "tcg_helper_c", e.original.event_exec, "wrapper")
+            if "vcpu" in e.properties:
+                trace_cpu =3D e.args.names()[0]
+                cond =3D "trace_event_get_vcpu_state(%(cpu)s,"\
+                       " TRACE_%(id)s)"\
+                       % dict(
+                           cpu=3Dtrace_cpu,
+                           id=3De.original.event_exec.name.upper())
+            else:
+                cond =3D "true"
+
             out('    %(name_trans)s(%(argnames_trans)s);',
-                '    gen_helper_%(name_exec)s(%(argnames_exec)s);',
+                '    if (%(cond)s) {',
+                '        gen_helper_%(name_exec)s(%(argnames_exec)s);',
+                '    }',
                 name_trans=3De.original.event_trans.api(e.QEMU_TRACE),
                 name_exec=3De.original.event_exec.api(e.QEMU_TRACE),
                 argnames_trans=3D", ".join(args_trans.names()),
-                argnames_exec=3D", ".join(args_exec.names()))
+                argnames_exec=3D", ".join(args_exec.names()),
+                cond=3Dcond)
=20
         out('}')
=20
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool=
/format/tcg_helper_c.py
index cc26e03008..aec6dbe891 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -6,7 +6,7 @@ Generate trace/generated-helpers.c.
 """
=20
 __author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
-__copyright__  =3D "Copyright 2012-2016, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
 __license__    =3D "GPL version 2 or (at your option) any later version"
=20
 __maintainer__ =3D "Stefan Hajnoczi"
@@ -66,10 +66,11 @@ def generate(events, backend, group):
=20
         out('void %(name_tcg)s(%(args_api)s)',
             '{',
+            # NOTE: the check was already performed at TCG-generation ti=
me
             '    %(name)s(%(args_call)s);',
             '}',
             name_tcg=3D"helper_%s_proxy" % e.api(),
-            name=3De.api(),
+            name=3De.api(e.QEMU_TRACE_NOCHECK),
             args_api=3De_args_api,
             args_call=3D", ".join(e_args_call.casted()),
             )
