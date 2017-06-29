Received: from eggs.gnu.org ([2001:4830:134:3::10]:60411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYdv-0001nM-EA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYdq-0002Ku-FW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:33:55 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:38571 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYdq-0002KK-1u
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:33:50 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 29 Jun 2017 15:33:40 +0300
Message-Id: <149873962051.9180.2860311876908940895.stgit@frigg.lan>
In-Reply-To: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 5/7] trace: [tcg] Do not generate TCG code
 to trace dynamically-disabled events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
index 1ffbc1dc40..d4c204a472 100644
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
@@ -268,6 +268,7 @@ class Event(object):
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
index db55f52eb5..1651cc3f71 100644
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
@@ -46,7 +46,7 @@ def generate(events, backend, group):
=20
     for e in events:
         # just keep one of them
-        if "tcg-trans" not in e.properties:
+        if "tcg-exec" not in e.properties:
             continue
=20
         out('static inline void %(name_tcg)s(%(args)s)',
@@ -58,12 +58,25 @@ def generate(events, backend, group):
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
index ec7acbe347..bbbd6ad0f4 100644
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
@@ -71,10 +71,11 @@ def generate(events, backend, group):
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
