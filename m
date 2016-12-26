Received: from eggs.gnu.org ([2001:4830:134:3::10]:41895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbyx-00025c-2L
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbyt-0002py-RX
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:34:55 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:50869 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbyt-0002om-F7
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:34:51 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 21:34:49 +0100
Message-Id: <148278448889.8988.10079870021256093398.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/6] hypertrace: Add tracing event
 "guest_hypertrace"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Generates the "guest_hypertrace" event with a user-configurable number
of arguments.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile.objs       |    2 ++
 configure           |   34 ++++++++++++++++++++++++++++++++++
 trace-events        |   11 +++++++++++
 trace/Makefile.objs |    2 +-
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index 06f74b8b99..5f0be2c3fb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -163,3 +163,5 @@ trace-events-y +=3D target-ppc/trace-events
 trace-events-y +=3D qom/trace-events
 trace-events-y +=3D linux-user/trace-events
 trace-events-y +=3D qapi/trace-events
+
+trace-events-gen-y =3D hypertrace/trace-events
diff --git a/configure b/configure
index 3770d7c263..afc7071e77 100755
--- a/configure
+++ b/configure
@@ -274,6 +274,7 @@ pie=3D""
 qom_cast_debug=3D"yes"
 trace_backends=3D"log"
 trace_file=3D"trace"
+hypertrace=3D"1"
 spice=3D""
 rbd=3D""
 smartcard=3D""
@@ -789,6 +790,8 @@ for opt do
   ;;
   --with-trace-file=3D*) trace_file=3D"$optarg"
   ;;
+  --with-hypertrace-args=3D*) hypertrace=3D"$optarg"
+  ;;
   --enable-gprof) gprof=3D"yes"
   ;;
   --enable-gcov) gcov=3D"yes"
@@ -1322,6 +1325,8 @@ Advanced options (experts only):
                            Available backends: $($python $source_path/sc=
ripts/tracetool.py --list-backends)
   --with-trace-file=3DNAME   Full PATH,NAME of file to store traces
                            Default:trace-<pid>
+  --with-hypertrace-args=3DNUMBER
+                           number of hypertrace arguments (default: $hyp=
ertrace)
   --disable-slirp          disable SLIRP userspace network connectivity
   --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
   --oss-lib                path to OSS library
@@ -4299,6 +4304,16 @@ if test "$?" -ne 0 ; then
 fi
=20
 ##########################################
+# check hypertrace arguments
+case "$hypertrace" in
+    ''|*[!0-9]*) error_exit "invalid number of hypertrace arguments" ;;
+    *) ;;
+esac
+if test $hypertrace =3D 0; then
+    error_exit "hypertrace arguments must be greater than zero"
+fi
+
+##########################################
 # For 'ust' backend, test if ust headers are present
 if have_backend "ust"; then
   cat > $TMPC << EOF
@@ -5066,6 +5081,7 @@ echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
 fi
+echo "Hypertrace arguments  $hypertrace"
 echo "spice support     $spice $(echo_version $spice $spice_protocol_ver=
sion/$spice_server_version)"
 echo "rbd support       $rbd"
 echo "xfsctl support    $xfs"
@@ -5731,6 +5747,24 @@ else
 fi
 QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg $QEMU_INCLUDES"
=20
+# hypertrace
+echo "CONFIG_HYPERTRACE_ARGS=3D$hypertrace" >> $config_host_mak
+hypertrace_events=3Dhypertrace/trace-events
+mkdir -p $(dirname $hypertrace_events)
+echo "# See docs/trace-events.txt for syntax documentation." >$hypertrac=
e_events
+echo -n 'vcpu guest_hypertrace(' >>$hypertrace_events
+for i in `seq $hypertrace`; do
+    if test $i !=3D 1; then
+        echo -n ", " >>$hypertrace_events
+    fi
+    echo -n "uint64_t arg$i" >>$hypertrace_events
+done
+echo -n ') ' >>$hypertrace_events
+for i in `seq $hypertrace`; do
+    echo -n "\" arg$i=3D0x%016\"PRIx64" >>$hypertrace_events
+done
+echo >>$hypertrace_events
+
 echo "TOOLS=3D$tools" >> $config_host_mak
 echo "ROMS=3D$roms" >> $config_host_mak
 echo "MAKE=3D$make" >> $config_host_mak
diff --git a/trace-events b/trace-events
index f74e1d3d22..fe6e5af880 100644
--- a/trace-events
+++ b/trace-events
@@ -141,6 +141,17 @@ vcpu guest_cpu_enter(void)
 # Targets: all
 vcpu guest_cpu_reset(void)
=20
+# @argX: Hypertrace arguments.
+#
+# Event explicitly triggered by guest code. The event definition is
+# auto-generated from the "--with-hypertrace-args" configuration argumen=
t (see
+# "docs/hypertrace.txt"):
+#
+#   vcpu guest_hypertrace(uint64_t arg0, ..., uint64_t argN-1)
+#
+# Mode: all
+# Targets: all
+
 # @vaddr: Access' virtual address.
 # @info : Access' information (see below).
 #
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 1e1ce7479d..7ae6c9fdc7 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -8,7 +8,7 @@
 tracetool-y =3D $(SRC_PATH)/scripts/tracetool.py
 tracetool-y +=3D $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py"=
)
=20
-$(BUILD_DIR)/trace-events-all: $(trace-events-y:%=3D$(SRC_PATH)/%)
+$(BUILD_DIR)/trace-events-all: $(trace-events-y:%=3D$(SRC_PATH)/%) $(tra=
ce-events-gen-y:%=3D$(BUILD_DIR)/%)
 	$(call quiet-command,cat $^ > $@)
=20
 ######################################################################
