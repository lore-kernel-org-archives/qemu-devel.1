Received: from eggs.gnu.org ([2001:4830:134:3::10]:58131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh0M-00079k-QF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh0H-0005z9-RI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:18:50 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:41356 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh0H-0005yO-AX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:18:45 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:18:34 +0300
Message-Id: <150091671441.30739.10101532119130561053.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/13] instrument: Allow adding the
 "instrument" property without modifying event files
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

Adds a configure argument to allow users to add the instrument property
to events without having to modify any trace event files.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 configure                     |   17 +++++++++++++++++
 rules.mak                     |    3 +++
 scripts/tracetool.py          |   11 +++++++++--
 scripts/tracetool/__init__.py |   20 +++++++++++++++++++-
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 13191052cb..8ab2a36130 100755
--- a/configure
+++ b/configure
@@ -353,6 +353,7 @@ trace_backends=3D"log"
 trace_file=3D"trace"
 trace_instrument=3D"no"
 trace_instrument_backend=3D"none"
+instrument_events=3D""
 spice=3D""
 rbd=3D""
 smartcard=3D""
@@ -901,6 +902,13 @@ for opt do
       trace_instrument=3D"yes"
       trace_instrument_backend=3D"dynamic"
   ;;
+  --with-instrument-events=3D*)
+      if test ! -f "$optarg"; then
+          echo "ERROR: no such file: $optarg"
+          exit 1
+      fi
+      instrument_events=3D"`realpath $optarg`"
+  ;;
   --enable-gprof) gprof=3D"yes"
   ;;
   --enable-gcov) gcov=3D"yes"
@@ -1433,6 +1441,9 @@ Advanced options (experts only):
                            Default:trace-<pid>
   --enable-trace-instrument
                            Enable trace instrumentation
+  --with-instrument-events=3DFILE
+                           File with a list of events to enable instrume=
ntation
+                           on (one per line)
   --disable-slirp          disable SLIRP userspace network connectivity
   --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
   --oss-lib                path to OSS library
@@ -5291,6 +5302,9 @@ if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
 fi
 echo "Trace instrumentation $trace_instrument"
+if test -n "$instrument_events"; then
+echo "Instrument events $instrument_events"
+fi
 echo "spice support     $spice $(echo_version $spice $spice_protocol_ver=
sion/$spice_server_version)"
 echo "rbd support       $rbd"
 echo "xfsctl support    $xfs"
@@ -6004,6 +6018,9 @@ echo "TRACE_INSTRUMENT_BACKEND=3Dinstr-$trace_instr=
ument_backend" >> $config_host_
 if test "$trace_instrument" =3D "yes"; then
     echo "CONFIG_INSTRUMENT=3Dy" >> $config_host_mak
 fi
+if test -n "$instrument_events"; then
+    echo "CONFIG_INSTRUMENT_EVENTS=3D$instrument_events" >> $config_host=
_mak
+fi
 ##########################################
=20
 echo "TOOLS=3D$tools" >> $config_host_mak
diff --git a/rules.mak b/rules.mak
index 6e943335f3..fbeda68022 100644
--- a/rules.mak
+++ b/rules.mak
@@ -188,6 +188,9 @@ notempty =3D $(if $1,y,n)
=20
 # Generate files with tracetool
 TRACETOOL=3D$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
+ifdef CONFIG_INSTRUMENT_EVENTS
+TRACETOOL +=3D --instrument=3D$(CONFIG_INSTRUMENT_EVENTS)
+endif
=20
 # Generate timestamp files for .h include files
=20
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index c55a21518b..d5d212e98f 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -6,7 +6,7 @@ Command-line wrapper for the tracetool machinery.
 """
=20
 __author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
-__copyright__  =3D "Copyright 2012-2014, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
 __license__    =3D "GPL version 2 or (at your option) any later version"
=20
 __maintainer__ =3D "Stefan Hajnoczi"
@@ -70,6 +70,7 @@ def main(args):
     long_opts =3D ["backends=3D", "format=3D", "help", "list-backends",
                  "check-backends", "group=3D"]
     long_opts +=3D ["binary=3D", "target-type=3D", "target-name=3D", "pr=
obe-prefix=3D"]
+    long_opts +=3D ["instrument=3D"]
=20
     try:
         opts, args =3D getopt.getopt(args[1:], "", long_opts)
@@ -84,6 +85,7 @@ def main(args):
     target_type =3D None
     target_name =3D None
     probe_prefix =3D None
+    instrument =3D None
     for opt, arg in opts:
         if opt =3D=3D "--help":
             error_opt()
@@ -111,6 +113,9 @@ def main(args):
         elif opt =3D=3D '--probe-prefix':
             probe_prefix =3D arg
=20
+        elif opt =3D=3D "--instrument":
+            instrument =3D arg
+
         else:
             error_opt("unhandled option: %s" % opt)
=20
@@ -137,12 +142,14 @@ def main(args):
         if probe_prefix is None:
             probe_prefix =3D ".".join(["qemu", target_type, target_name]=
)
=20
+    instrument_cre =3D tracetool.read_instrument(instrument)
+
     if len(args) < 1:
         error_opt("missing trace-events filepath")
     events =3D []
     for arg in args:
         with open(arg, "r") as fh:
-            events.extend(tracetool.read_events(fh))
+            events.extend(tracetool.read_events(fh, instrument_cre))
=20
     try:
         tracetool.generate(events, arg_group, arg_format, arg_backends,
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index e65349bc33..b9ddf8fbf9 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -292,13 +292,26 @@ class Event(object):
                      self)
=20
=20
-def read_events(fobj):
+def read_instrument(path):
+    if path is None:
+        return None
+
+    with open(path) as f:
+        patterns =3D f.readlines()
+        patterns =3D [p.replace("\n", "") for p in patterns]
+        patterns =3D [p.replace("*", ".*") for p in patterns]
+        pattern =3D "|".join(patterns)
+        return re.compile(pattern)
+
+def read_events(fobj, instrument):
     """Generate the output for the given (format, backends) pair.
=20
     Parameters
     ----------
     fobj : file
         Event description file.
+    instrument : cre or None
+        Event patterns to instrument.
=20
     Returns a list of Event objects
     """
@@ -312,6 +325,11 @@ def read_events(fobj):
=20
         event =3D Event.build(line)
=20
+        if instrument is not None and instrument.match(event.name):
+            event.properties =3D [p for p in event.properties
+                                if p !=3D "disable"]
+            event.properties.append("instrument")
+
         # transform TCG-enabled events
         if "tcg" not in event.properties:
             events.append(event)
