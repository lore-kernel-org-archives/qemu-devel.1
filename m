Received: from eggs.gnu.org ([2001:4830:134:3::10]:45076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4sN-0002V4-8a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4sL-00073E-W2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX4sL-00072r-N4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 17 Jul 2017 13:11:24 +0100
Message-Id: <20170717121127.25154-5-stefanha@redhat.com>
In-Reply-To: <20170717121127.25154-1-stefanha@redhat.com>
References: <20170717121127.25154-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] trace: [tcg] Do not generate TCG code to
 trace dynamically-disabled events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

If an event is dynamically disabled, the TCG code that calls the
execution-time tracer is not generated.

Removes the overheads of execution-time tracers for dynamically disabled
events. As a bonus, also avoids checking the event state when the
execution-time tracer is called from TCG-generated code (since otherwise
TCG would simply not call it).

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-id: 149915799921.6295.13067154430923434035.stgit@frigg.lan
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py            |  3 ++-
 scripts/tracetool/format/h.py            | 26 +++++++++++++++++++-------
 scripts/tracetool/format/tcg_h.py        | 21 +++++++++++++++++----
 scripts/tracetool/format/tcg_helper_c.py |  5 +++--
 4 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 1ffbc1d..d4c204a 100644
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
index 3682f4e..aecf249 100644
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
index db55f52..1651cc3 100644
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
index ec7acbe..bbbd6ad 100644
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
--=20
2.9.4
