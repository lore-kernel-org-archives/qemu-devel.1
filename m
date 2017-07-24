Received: from eggs.gnu.org ([2001:4830:134:3::10]:56431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgsV-0002Bs-Dw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgsS-0002hk-4R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:10:43 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:32890)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgsR-0002hZ-FB
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:10:40 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:10:28 +0300
Message-Id: <150091622863.30739.6614221568254084366.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/13] instrument: [none] Add null
 instrumentation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

Renames existing tracing routines into "_backend__trace_*", and instead a=
dds an
instrumentation-aware "trace_*".

Since we're in a "null" instrumentation mode for tracing events, the new
routines simply call the original tracing code.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 .gitignore                                       |    3 +
 Makefile                                         |   26 ++++++++++
 Makefile.objs                                    |    4 ++
 configure                                        |    8 +++
 include/trace-tcg.h                              |    1=20
 instrument/Makefile.objs                         |   14 ++++++
 scripts/tracetool/__init__.py                    |    6 ++
 scripts/tracetool/backend/instr_none.py          |   34 +++++++++++++
 scripts/tracetool/format/h.py                    |    8 +++
 scripts/tracetool/format/instr_h.py              |   48 ++++++++++++++++=
+++
 scripts/tracetool/format/instr_tcg_h.py          |   56 ++++++++++++++++=
++++++
 scripts/tracetool/format/tcg_h.py                |    6 +-
 scripts/tracetool/format/tcg_helper_c.py         |    2 -
 scripts/tracetool/format/tcg_helper_h.py         |    2 -
 scripts/tracetool/format/tcg_helper_wrapper_h.py |    2 -
 15 files changed, 210 insertions(+), 10 deletions(-)
 create mode 100644 instrument/Makefile.objs
 create mode 100644 scripts/tracetool/backend/instr_none.py
 create mode 100644 scripts/tracetool/format/instr_h.py
 create mode 100644 scripts/tracetool/format/instr_tcg_h.py

diff --git a/.gitignore b/.gitignore
index 09c2363acf..068dc1c1ae 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,6 +5,8 @@
 /config-target.*
 /config.status
 /config-temp
+/instrument-root.h
+/instrument/generated-tcg-tracers.h
 /trace-events-all
 /trace/generated-events.h
 /trace/generated-events.c
@@ -116,6 +118,7 @@ tags
 TAGS
 docker-src.*
 *~
+instrument.h
 trace.h
 trace.c
 trace-ust.h
diff --git a/Makefile b/Makefile
index 38814f9a61..375bd313d7 100644
--- a/Makefile
+++ b/Makefile
@@ -191,6 +191,29 @@ trace-dtrace-root.h: trace-dtrace-root.dtrace
=20
 trace-dtrace-root.o: trace-dtrace-root.dtrace
=20
+INSTRUMENT_HEADERS =3D instrument-root.h $(trace-events-subdirs:%=3D%/in=
strument.h)
+INSTRUMENT_HEADERS +=3D instrument/generated-tcg-tracers.h
+
+GENERATED_FILES +=3D $(INSTRUMENT_HEADERS)
+
+%/instrument.h: %/instrument.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+%/instrument.h-timestamp: $(SRC_PATH)/%/trace-events $(BUILD_DIR)/config=
-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3D$(call trace-group-name,$@) \
+		--format=3Dinstr-h \
+		--backends=3D$(TRACE_INSTRUMENT_BACKEND) \
+		$< > $@,"GEN","$(@:%-timestamp=3D%)")
+
+instrument-root.h: instrument-root.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+instrument-root.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/confi=
g-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3Droot \
+		--format=3Dinstr-h \
+		--backends=3D$(TRACE_INSTRUMENT_BACKEND) \
+		$< > $@,"GEN","$(@:%-timestamp=3D%)")
+
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -806,7 +829,8 @@ endif
=20
 .SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=3D%-timestamp) \
 	$(TRACE_SOURCES) $(TRACE_SOURCES:%=3D%-timestamp) \
-	$(TRACE_DTRACE) $(TRACE_DTRACE:%=3D%-timestamp)
+	$(TRACE_DTRACE) $(TRACE_DTRACE:%=3D%-timestamp) \
+	$(INSTRUMENT_HEADERS) $(INSTRUMENT_HEADERS:%=3D%-timestamp)
=20
 # Include automatically generated dependency files
 # Dependencies in Makefile.objs files come from our recursive subdir rul=
es
diff --git a/Makefile.objs b/Makefile.objs
index bfd5a6ceb1..8e2b3770c4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -98,6 +98,10 @@ util-obj-y +=3D  trace/
 target-obj-y +=3D trace/
=20
 ######################################################################
+# instrumentation
+util-obj-y +=3D instrument/
+
+######################################################################
 # guest agent
=20
 # FIXME: a few definitions from qapi-types.o/qapi-visit.o are needed
diff --git a/configure b/configure
index a3f0522e8f..75d899b40c 100755
--- a/configure
+++ b/configure
@@ -351,6 +351,8 @@ pie=3D""
 qom_cast_debug=3D"yes"
 trace_backends=3D"log"
 trace_file=3D"trace"
+trace_instrument=3D"no"
+trace_instrument_backend=3D"none"
 spice=3D""
 rbd=3D""
 smartcard=3D""
@@ -5282,6 +5284,7 @@ echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
 fi
+echo "Trace instrumentation $trace_instrument"
 echo "spice support     $spice $(echo_version $spice $spice_protocol_ver=
sion/$spice_server_version)"
 echo "rbd support       $rbd"
 echo "xfsctl support    $xfs"
@@ -5989,6 +5992,11 @@ else
 fi
 QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg $QEMU_INCLUDES"
=20
+##########################################
+# trace instrumentation
+echo "TRACE_INSTRUMENT_BACKEND=3Dinstr-$trace_instrument_backend" >> $co=
nfig_host_mak
+##########################################
+
 echo "TOOLS=3D$tools" >> $config_host_mak
 echo "ROMS=3D$roms" >> $config_host_mak
 echo "MAKE=3D$make" >> $config_host_mak
diff --git a/include/trace-tcg.h b/include/trace-tcg.h
index da68608c85..a626c5020c 100644
--- a/include/trace-tcg.h
+++ b/include/trace-tcg.h
@@ -2,5 +2,6 @@
 #define TRACE_TCG_H
=20
 #include "trace/generated-tcg-tracers.h"
+#include "instrument/generated-tcg-tracers.h"
=20
 #endif /* TRACE_TCG_H */
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
new file mode 100644
index 0000000000..d1edd1696e
--- /dev/null
+++ b/instrument/Makefile.objs
@@ -0,0 +1,14 @@
+# -*- mode: makefile -*-
+
+######################################################################
+# QEMU trace->instrument interface
+
+$(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+$(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUI=
LD_DIR)/config-host.mak $(tracetool-y)
+	@mkdir -p $(dir $@)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3Droot \
+		--format=3Dinstr-tcg-h \
+		--backend=3D$(TRACE_INSTRUMENT_BACKEND) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index d4c204a472..6d382157c0 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -161,7 +161,7 @@ class Event(object):
                       "(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
                       "\s*")
=20
-    _VALID_PROPS =3D set(["disable", "tcg", "tcg-trans", "tcg-exec", "vc=
pu"])
+    _VALID_PROPS =3D set(["disable", "tcg", "tcg-trans", "tcg-exec", "vc=
pu", "instrument"])
=20
     def __init__(self, name, props, fmt, args, orig=3DNone,
                  event_trans=3DNone, event_exec=3DNone):
@@ -269,13 +269,15 @@ class Event(object):
=20
     QEMU_TRACE               =3D "trace_%(name)s"
     QEMU_TRACE_NOCHECK       =3D "_nocheck__" + QEMU_TRACE
+    QEMU_TRACE_BACKEND       =3D "_backend__" + QEMU_TRACE
     QEMU_TRACE_TCG           =3D QEMU_TRACE + "_tcg"
+    QEMU_TRACE_TCG_BACKEND   =3D "_backend__" + QEMU_TRACE_TCG
     QEMU_DSTATE              =3D "_TRACE_%(NAME)s_DSTATE"
     QEMU_EVENT               =3D "_TRACE_%(NAME)s_EVENT"
=20
     def api(self, fmt=3DNone):
         if fmt is None:
-            fmt =3D Event.QEMU_TRACE
+            fmt =3D Event.QEMU_TRACE_BACKEND
         return fmt % {"name": self.name, "NAME": self.name.upper()}
=20
     def transform(self, *trans):
diff --git a/scripts/tracetool/backend/instr_none.py b/scripts/tracetool/=
backend/instr_none.py
new file mode 100644
index 0000000000..56508cfcbe
--- /dev/null
+++ b/scripts/tracetool/backend/instr_none.py
@@ -0,0 +1,34 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+No-instrumentation proxy.
+"""
+
+__author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__license__    =3D "GPL version 2 or (at your option) any later version"
+
+__maintainer__ =3D "Stefan Hajnoczi"
+__email__      =3D "stefanha@linux.vnet.ibm.com"
+
+
+from tracetool import out
+
+
+##################################################
+# instr-tcg-h
+
+def generate_instr_tcg_h(event, group):
+    out('    %(backend)s(%(argnames)s);',
+        backend=3Devent.api(event.QEMU_TRACE_TCG_BACKEND),
+        argnames=3D", ".join(event.args.names()))
+
+
+##################################################
+# instr-h
+
+def generate_instr_h(event, group):
+    out('    %(backend)s(%(argnames)s);',
+        backend=3Devent.api(event.QEMU_TRACE_BACKEND),
+        argnames=3D", ".join(event.args.names()))
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.p=
y
index aecf249d66..2e423079db 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -87,4 +87,10 @@ def generate(events, backend, group):
=20
     backend.generate_end(events, group)
=20
-    out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
+    out('')
+    if group =3D=3D "root":
+        out('#include "instrument-root.h"')
+    else:
+        out('#include "instrument.h"')
+    out('',
+        '#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
diff --git a/scripts/tracetool/format/instr_h.py b/scripts/tracetool/form=
at/instr_h.py
new file mode 100644
index 0000000000..2b80b3d038
--- /dev/null
+++ b/scripts/tracetool/format/instr_h.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+/instrument-root.h
+.../instrument.h
+
+"""
+
+__author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__license__    =3D "GPL version 2 or (at your option) any later version"
+
+__maintainer__ =3D "Stefan Hajnoczi"
+__email__      =3D "stefanha@linux.vnet.ibm.com"
+
+
+from tracetool import out
+from tracetool.transform import *
+
+
+def generate(events, backend, group):
+    out('/* This file is autogenerated by tracetool, do not edit. */',
+        '',
+        '#ifndef INSTRUMENT_%s_GENERATED_TRACERS_H' % group.upper(),
+        '#define INSTRUMENT_%s_GENERATED_TRACERS_H' % group.upper(),
+        '')
+    backend.generate_begin(events, group)
+
+    for e in events:
+        out('static inline void %(qemu)s(%(args)s)',
+            '{',
+            qemu=3De.api(e.QEMU_TRACE),
+            args=3De.args)
+
+        if "tcg-trans" in e.properties or "instrument" not in e.properti=
es:
+            # "*_trans" never called directly (and never instrumented)
+            out('    %(backend)s(%(argnames)s);',
+                backend=3De.api(e.QEMU_TRACE_BACKEND),
+                argnames=3D", ".join(e.args.names()))
+        else:
+            backend.generate(e, group)
+
+        out('}')
+
+    backend.generate_end(events, group)
+    out('',
+        '#endif  /* INSTRUMENT_%s_GENERATED_TRACERS_H */' % group.upper(=
))
diff --git a/scripts/tracetool/format/instr_tcg_h.py b/scripts/tracetool/=
format/instr_tcg_h.py
new file mode 100644
index 0000000000..6abf97d368
--- /dev/null
+++ b/scripts/tracetool/format/instr_tcg_h.py
@@ -0,0 +1,56 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+instrument/generated-tcg-tracers.h
+
+"""
+
+__author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__license__    =3D "GPL version 2 or (at your option) any later version"
+
+__maintainer__ =3D "Stefan Hajnoczi"
+__email__      =3D "stefanha@linux.vnet.ibm.com"
+
+
+from tracetool import out, Arguments
+import tracetool.vcpu
+
+
+API =3D True
+
+
+def generate(events, backend, group):
+    events =3D [e.original for e in events
+              if "tcg-trans" in e.properties]
+
+    out('/* This file is autogenerated by tracetool, do not edit. */',
+        '',
+        '#ifndef INSTRUMENT_%s_GENERATED_TCG_TRACERS_H' % group.upper(),
+        '#define INSTRUMENT_%s_GENERATED_TCG_TRACERS_H' % group.upper(),
+        '')
+    backend.generate_begin(events, group)
+
+    for e in events:
+        args_api =3D tracetool.vcpu.transform_args("tcg_h", e)
+
+        out('static inline void %(qemu)s(%(args)s)',
+            '{',
+            qemu=3De.api(e.QEMU_TRACE_TCG),
+            args=3Dargs_api)
+
+        if "instrument" in e.properties:
+            e =3D e.copy()
+            e.args =3D args_api
+            backend.generate(e, group)
+        else:
+            out('    %(backend)s(%(argnames)s);',
+                backend=3De.api(e.QEMU_TRACE_TCG_BACKEND),
+                argnames=3D", ".join(args_api.names()))
+
+        out('}')
+
+    backend.generate_end(events, group)
+    out('',
+        '#endif  /* INSTRUMENT_%s_GENERATED_TCG_TRACERS_H */' % group.up=
per())
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format=
/tcg_h.py
index 1651cc3f71..3363502ffc 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -51,7 +51,7 @@ def generate(events, backend, group):
=20
         out('static inline void %(name_tcg)s(%(args)s)',
             '{',
-            name_tcg=3De.original.api(e.QEMU_TRACE_TCG),
+            name_tcg=3De.original.api(e.QEMU_TRACE_TCG_BACKEND),
             args=3Dtracetool.vcpu.transform_args("tcg_h", e.original))
=20
         if "disable" not in e.properties:
@@ -72,8 +72,8 @@ def generate(events, backend, group):
                 '    if (%(cond)s) {',
                 '        gen_helper_%(name_exec)s(%(argnames_exec)s);',
                 '    }',
-                name_trans=3De.original.event_trans.api(e.QEMU_TRACE),
-                name_exec=3De.original.event_exec.api(e.QEMU_TRACE),
+                name_trans=3De.original.event_trans.api(e.QEMU_TRACE_BAC=
KEND),
+                name_exec=3De.original.event_exec.api(e.QEMU_TRACE_BACKE=
ND),
                 argnames_trans=3D", ".join(args_trans.names()),
                 argnames_exec=3D", ".join(args_exec.names()),
                 cond=3Dcond)
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool=
/format/tcg_helper_c.py
index bbbd6ad0f4..e9ba62a136 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -74,7 +74,7 @@ def generate(events, backend, group):
             # NOTE: the check was already performed at TCG-generation ti=
me
             '    %(name)s(%(args_call)s);',
             '}',
-            name_tcg=3D"helper_%s_proxy" % e.api(),
+            name_tcg=3D"helper_%s_proxy" % e.api(e.QEMU_TRACE_BACKEND),
             name=3De.api(e.QEMU_TRACE_NOCHECK),
             args_api=3De_args_api,
             args_call=3D", ".join(e_args_call.casted()),
diff --git a/scripts/tracetool/format/tcg_helper_h.py b/scripts/tracetool=
/format/tcg_helper_h.py
index 6b184b641b..17ef0021eb 100644
--- a/scripts/tracetool/format/tcg_helper_h.py
+++ b/scripts/tracetool/format/tcg_helper_h.py
@@ -44,6 +44,6 @@ def generate(events, backend, group):
         out(fmt,
             flags=3Dflags,
             argc=3Dlen(args),
-            name=3De.api() + "_proxy",
+            name=3De.api(e.QEMU_TRACE_BACKEND) + "_proxy",
             types=3Dtypes,
             )
diff --git a/scripts/tracetool/format/tcg_helper_wrapper_h.py b/scripts/t=
racetool/format/tcg_helper_wrapper_h.py
index ff53447512..377af4615b 100644
--- a/scripts/tracetool/format/tcg_helper_wrapper_h.py
+++ b/scripts/tracetool/format/tcg_helper_wrapper_h.py
@@ -54,7 +54,7 @@ def generate(events, backend, group):
             for (type_, name) in args_tcg_compat
         ]
=20
-        gen_name =3D "gen_helper_" + e.api()
+        gen_name =3D "gen_helper_" + e.api(e.QEMU_TRACE_BACKEND)
=20
         out('static inline void %(name)s(%(args)s)',
             '{',
