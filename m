Received: from eggs.gnu.org ([2001:4830:134:3::10]:57232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgwQ-0004wW-1D
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgwM-0003fW-PR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:14:46 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:45106)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgwM-0003fK-4m
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:14:42 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:14:31 +0300
Message-Id: <150091647131.30739.8668633366747555026.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/13] instrument: [dynamic] Add dynamic
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

This mode uses a function pointer in "trace_*" routines. By default, it p=
oints
to the original tracing function (now "_backend__trace_*").

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 .gitignore                                 |    3 +
 Makefile                                   |   26 ++++++++++-
 Makefile.objs                              |    4 ++
 configure                                  |    9 ++++
 instrument/Makefile.objs                   |   12 +++++
 scripts/tracetool/__init__.py              |    3 +
 scripts/tracetool/backend/instr_dynamic.py |   67 ++++++++++++++++++++++=
++++++
 scripts/tracetool/format/instr_c.py        |   44 ++++++++++++++++++
 scripts/tracetool/format/instr_tcg_c.py    |   40 +++++++++++++++++
 9 files changed, 206 insertions(+), 2 deletions(-)
 create mode 100644 scripts/tracetool/backend/instr_dynamic.py
 create mode 100644 scripts/tracetool/format/instr_c.py
 create mode 100644 scripts/tracetool/format/instr_tcg_c.py

diff --git a/.gitignore b/.gitignore
index 068dc1c1ae..ee2768cb05 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,7 +6,9 @@
 /config.status
 /config-temp
 /instrument-root.h
+/instrument-root.c
 /instrument/generated-tcg-tracers.h
+/instrument/generated-tcg-tracers.c
 /trace-events-all
 /trace/generated-events.h
 /trace/generated-events.c
@@ -119,6 +121,7 @@ TAGS
 docker-src.*
 *~
 instrument.h
+instrument.c
 trace.h
 trace.c
 trace-ust.h
diff --git a/Makefile b/Makefile
index 375bd313d7..fb226bf54b 100644
--- a/Makefile
+++ b/Makefile
@@ -193,8 +193,11 @@ trace-dtrace-root.o: trace-dtrace-root.dtrace
=20
 INSTRUMENT_HEADERS =3D instrument-root.h $(trace-events-subdirs:%=3D%/in=
strument.h)
 INSTRUMENT_HEADERS +=3D instrument/generated-tcg-tracers.h
+INSTRUMENT_SOURCES =3D instrument-root.c $(trace-events-subdirs:%=3D%/in=
strument.c)
+INSTRUMENT_SOURCES +=3D instrument/generated-tcg-tracers.c
=20
 GENERATED_FILES +=3D $(INSTRUMENT_HEADERS)
+GENERATED_FILES +=3D $(INSTRUMENT_SOURCES)
=20
 %/instrument.h: %/instrument.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
@@ -205,6 +208,15 @@ GENERATED_FILES +=3D $(INSTRUMENT_HEADERS)
 		--backends=3D$(TRACE_INSTRUMENT_BACKEND) \
 		$< > $@,"GEN","$(@:%-timestamp=3D%)")
=20
+%/instrument.c: %/instrument.c-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+%/instrument.c-timestamp: $(SRC_PATH)/%/trace-events $(BUILD_DIR)/config=
-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3D$(call trace-group-name,$@) \
+		--format=3Dinstr-c \
+		--backends=3D$(TRACE_INSTRUMENT_BACKEND) \
+		$< > $@,"GEN","$(@:%-timestamp=3D%)")
+
 instrument-root.h: instrument-root.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 instrument-root.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/confi=
g-host.mak $(tracetool-y)
@@ -214,6 +226,15 @@ instrument-root.h-timestamp: $(SRC_PATH)/trace-event=
s $(BUILD_DIR)/config-host.m
 		--backends=3D$(TRACE_INSTRUMENT_BACKEND) \
 		$< > $@,"GEN","$(@:%-timestamp=3D%)")
=20
+instrument-root.c: instrument-root.c-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+instrument-root.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/confi=
g-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3Droot \
+		--format=3Dinstr-c \
+		--backends=3D$(TRACE_INSTRUMENT_BACKEND) \
+		$< > $@,"GEN","$(@:%-timestamp=3D%)")
+
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -390,7 +411,7 @@ Makefile: $(version-obj-y)
 # Build libraries
=20
 libqemustub.a: $(stub-obj-y)
-libqemuutil.a: $(util-obj-y) $(trace-obj-y)
+libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(instr-obj-y)
=20
 ######################################################################
=20
@@ -830,7 +851,8 @@ endif
 .SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=3D%-timestamp) \
 	$(TRACE_SOURCES) $(TRACE_SOURCES:%=3D%-timestamp) \
 	$(TRACE_DTRACE) $(TRACE_DTRACE:%=3D%-timestamp) \
-	$(INSTRUMENT_HEADERS) $(INSTRUMENT_HEADERS:%=3D%-timestamp)
+	$(INSTRUMENT_HEADERS) $(INSTRUMENT_HEADERS:%=3D%-timestamp) \
+	$(INSTRUMENT_SOURCES) $(INSTRUMENT_SOURCES:%=3D%-timestamp)
=20
 # Include automatically generated dependency files
 # Dependencies in Makefile.objs files come from our recursive subdir rul=
es
diff --git a/Makefile.objs b/Makefile.objs
index 8e2b3770c4..e36a519952 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -100,6 +100,7 @@ target-obj-y +=3D trace/
 ######################################################################
 # instrumentation
 util-obj-y +=3D instrument/
+target-obj-y +=3D instrument/
=20
 ######################################################################
 # guest agent
@@ -180,3 +181,6 @@ trace-obj-y +=3D $(trace-events-subdirs:%=3D%/trace.o=
)
 trace-obj-$(CONFIG_TRACE_UST) +=3D trace-ust-all.o
 trace-obj-$(CONFIG_TRACE_DTRACE) +=3D trace-dtrace-root.o
 trace-obj-$(CONFIG_TRACE_DTRACE) +=3D $(trace-events-subdirs:%=3D%/trace=
-dtrace.o)
+
+instr-obj-$(CONFIG_INSTRUMENT) =3D instrument-root.o
+instr-obj-y +=3D $(trace-events-subdirs:%=3D%/instrument.o)
diff --git a/configure b/configure
index 75d899b40c..13191052cb 100755
--- a/configure
+++ b/configure
@@ -897,6 +897,10 @@ for opt do
   ;;
   --with-trace-file=3D*) trace_file=3D"$optarg"
   ;;
+  --enable-trace-instrument)
+      trace_instrument=3D"yes"
+      trace_instrument_backend=3D"dynamic"
+  ;;
   --enable-gprof) gprof=3D"yes"
   ;;
   --enable-gcov) gcov=3D"yes"
@@ -1427,6 +1431,8 @@ Advanced options (experts only):
                            Available backends: $trace_backend_list
   --with-trace-file=3DNAME   Full PATH,NAME of file to store traces
                            Default:trace-<pid>
+  --enable-trace-instrument
+                           Enable trace instrumentation
   --disable-slirp          disable SLIRP userspace network connectivity
   --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
   --oss-lib                path to OSS library
@@ -5995,6 +6001,9 @@ QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg $QEMU_INCLUDES"
 ##########################################
 # trace instrumentation
 echo "TRACE_INSTRUMENT_BACKEND=3Dinstr-$trace_instrument_backend" >> $co=
nfig_host_mak
+if test "$trace_instrument" =3D "yes"; then
+    echo "CONFIG_INSTRUMENT=3Dy" >> $config_host_mak
+fi
 ##########################################
=20
 echo "TOOLS=3D$tools" >> $config_host_mak
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index d1edd1696e..c548bbdd8a 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -12,3 +12,15 @@ $(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/=
trace-events $(BUILD_DIR)/
 		--format=3Dinstr-tcg-h \
 		--backend=3D$(TRACE_INSTRUMENT_BACKEND) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
+
+$(obj)/generated-tcg-tracers.c: $(obj)/generated-tcg-tracers.c-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+$(obj)/generated-tcg-tracers.c-timestamp: $(SRC_PATH)/trace-events $(BUI=
LD_DIR)/config-host.mak $(tracetool-y)
+	@mkdir -p $(dir $@)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3Droot \
+		--format=3Dinstr-tcg-c \
+		--backend=3D$(TRACE_INSTRUMENT_BACKEND) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
+
+target-obj-$(CONFIG_INSTRUMENT) +=3D generated-tcg-tracers.o
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 6d382157c0..e65349bc33 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -275,6 +275,9 @@ class Event(object):
     QEMU_DSTATE              =3D "_TRACE_%(NAME)s_DSTATE"
     QEMU_EVENT               =3D "_TRACE_%(NAME)s_EVENT"
=20
+    QI_TRACE_INSTRUMENT      =3D "qi_event_%(name)s"
+    QI_TRACE_INSTRUMENT_TCG  =3D QI_TRACE_INSTRUMENT + "_tcg"
+
     def api(self, fmt=3DNone):
         if fmt is None:
             fmt =3D Event.QEMU_TRACE_BACKEND
diff --git a/scripts/tracetool/backend/instr_dynamic.py b/scripts/traceto=
ol/backend/instr_dynamic.py
new file mode 100644
index 0000000000..f42d3afa8f
--- /dev/null
+++ b/scripts/tracetool/backend/instr_dynamic.py
@@ -0,0 +1,67 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+Dynamic instrumentation proxy.
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
+import tracetool.vcpu
+
+
+##################################################
+# instr-h
+
+def generate_instr_h_begin(events, group):
+    for event in events:
+        if "instrument" not in event.properties:
+            continue
+        out('extern void * %(qi)s_cb;',
+            qi=3Devent.api(event.QI_TRACE_INSTRUMENT))
+    out('')
+
+
+def generate_instr_h(event, group):
+    argtypes =3D ", ".join(event.args.types())
+    if argtypes =3D=3D "":
+        argtypes =3D "void"
+    out('    void (*func)(%(argtypes)s) =3D %(qi)s_cb;',
+        '    func(%(argnames)s);',
+        qi=3Devent.api(event.QI_TRACE_INSTRUMENT),
+        args=3Devent.args,
+        argnames=3D", ".join(event.args.names()),
+        argtypes=3Dargtypes)
+
+
+##################################################
+# instr-tcg-h
+
+def generate_instr_tcg_h_begin(events, group):
+    for event in events:
+        if "instrument" not in event.properties:
+            continue
+        out('extern void * %(qi)s_cb;',
+            qi=3Devent.api(event.QI_TRACE_INSTRUMENT_TCG))
+    out('')
+
+
+def generate_instr_tcg_h(event, group):
+    argtypes =3D ", ".join(event.args.types())
+    if argtypes =3D=3D "":
+        argtypes =3D "void"
+    out('    void (*func)(%(argtypes)s) =3D %(qi)s_cb;',
+        '    func(%(argnames)s);',
+        qi=3Devent.api(event.QI_TRACE_INSTRUMENT_TCG),
+        args=3Devent.args,
+        argnames=3D", ".join(event.args.names()),
+        argtypes=3Dargtypes)
diff --git a/scripts/tracetool/format/instr_c.py b/scripts/tracetool/form=
at/instr_c.py
new file mode 100644
index 0000000000..987ecbf5c2
--- /dev/null
+++ b/scripts/tracetool/format/instr_c.py
@@ -0,0 +1,44 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+/instrument-root.c
+.../instrument.c
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
+    events =3D [e for e in events
+              if "tcg-trans" not in e.properties and
+              "instrument" in e.properties]
+
+    if group =3D=3D "root":
+        header =3D "trace-root.h"
+    else:
+        header =3D "trace.h"
+
+    out('/* This file is autogenerated by tracetool, do not edit. */',
+        '',
+        '#include "qemu/osdep.h"',
+        '#include "%s"' % header,
+        '')
+    backend.generate_begin(events, group)
+
+    for e in events:
+        out('void *%(qi_cb)s_cb =3D %(qi_trace)s;',
+            qi_cb=3De.api(e.QI_TRACE_INSTRUMENT),
+            qi_trace=3De.api(e.QEMU_TRACE_BACKEND))
+
+    backend.generate_end(events, group)
diff --git a/scripts/tracetool/format/instr_tcg_c.py b/scripts/tracetool/=
format/instr_tcg_c.py
new file mode 100644
index 0000000000..382709d0bd
--- /dev/null
+++ b/scripts/tracetool/format/instr_tcg_c.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+instrument/generated-tcg-tracers.c
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
+    events =3D [e.original for e in events
+              if "tcg-trans" in e.properties and
+              "instrument" in e.properties]
+
+    out('/* This file is autogenerated by tracetool, do not edit. */',
+        '',
+        '#include "qemu/osdep.h"',
+        '#include "cpu.h"',
+        '#include "tcg-op.h"',
+        '#include "trace-tcg.h"',
+        '')
+    backend.generate_begin(events, group)
+
+    for e in events:
+        out('void *%(qi_cb)s_cb =3D %(qi_trace)s;',
+            qi_cb=3De.api(e.QI_TRACE_INSTRUMENT_TCG),
+            qi_trace=3De.api(e.QEMU_TRACE_TCG_BACKEND))
+
+    backend.generate_end(events, group)
