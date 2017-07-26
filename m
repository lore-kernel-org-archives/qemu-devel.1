Received: from eggs.gnu.org ([2001:4830:134:3::10]:60948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daPc6-0003vN-6J
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daPc1-0005jW-8m
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:56:46 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:50428 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daPc0-0005ik-Qz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:56:41 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 26 Jul 2017 19:56:30 +0300
Message-Id: <150108819035.11502.13406314529518835262.stgit@frigg.lan>
In-Reply-To: <150108770564.11502.9555409719195740021.stgit@frigg.lan>
References: <150108770564.11502.9555409719195740021.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/5] hypertrace: Add tracing event
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
 Makefile      |    7 ++++---
 Makefile.objs |    2 ++
 configure     |   34 ++++++++++++++++++++++++++++++++++
 trace-events  |   11 +++++++++++
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 38814f9a61..d45158cf29 100644
--- a/Makefile
+++ b/Makefile
@@ -83,7 +83,7 @@ endif
=20
 GENERATED_FILES +=3D $(TRACE_HEADERS)
 GENERATED_FILES +=3D $(TRACE_SOURCES)
-GENERATED_FILES +=3D $(BUILD_DIR)/trace-events-all
+GENERATED_FILES +=3D $(BUILD_DIR)/hypertrace/trace.h
=20
 trace-group-name =3D $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
=20
@@ -92,7 +92,7 @@ tracetool-y +=3D $(shell find $(SRC_PATH)/scripts/trace=
tool -name "*.py")
=20
 %/trace.h: %/trace.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
+%/trace.h-timestamp: %/trace-events $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=3D$(call trace-group-name,$@) \
 		--format=3Dh \
@@ -101,7 +101,7 @@ tracetool-y +=3D $(shell find $(SRC_PATH)/scripts/tra=
cetool -name "*.py")
=20
 %/trace.c: %/trace.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace.c-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
+%/trace.c-timestamp: %/trace-events $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=3D$(call trace-group-name,$@) \
 		--format=3Dc \
@@ -534,6 +534,7 @@ distclean: clean
 	rm -Rf .sdk
 	if test -f pixman/config.log; then $(MAKE) -C pixman distclean; fi
 	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
+	rm -f hypertrace/trace-events
=20
 KEYMAPS=3Dda     en-gb  et  fr     fr-ch  is  lt  modifiers  no  pt-br  =
sv \
 ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th=
 \
diff --git a/Makefile.objs b/Makefile.objs
index bfd5a6ceb1..ce9a60137b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -170,9 +170,11 @@ trace-events-subdirs +=3D accel/kvm
 trace-events-subdirs +=3D nbd
=20
 trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:%=
=3D$(SRC_PATH)/%/trace-events)
+trace-events-files +=3D $(BUILD_DIR)/hypertrace/trace-events
=20
 trace-obj-y =3D trace-root.o
 trace-obj-y +=3D $(trace-events-subdirs:%=3D%/trace.o)
 trace-obj-$(CONFIG_TRACE_UST) +=3D trace-ust-all.o
 trace-obj-$(CONFIG_TRACE_DTRACE) +=3D trace-dtrace-root.o
 trace-obj-$(CONFIG_TRACE_DTRACE) +=3D $(trace-events-subdirs:%=3D%/trace=
-dtrace.o)
+trace-obj-y +=3D $(BUILD_DIR)/hypertrace/trace.o
diff --git a/configure b/configure
index a3f0522e8f..e6f752c242 100755
--- a/configure
+++ b/configure
@@ -351,6 +351,7 @@ pie=3D""
 qom_cast_debug=3D"yes"
 trace_backends=3D"log"
 trace_file=3D"trace"
+hypertrace=3D"1"
 spice=3D""
 rbd=3D""
 smartcard=3D""
@@ -895,6 +896,8 @@ for opt do
   ;;
   --with-trace-file=3D*) trace_file=3D"$optarg"
   ;;
+  --with-hypertrace-args=3D*) hypertrace=3D"$optarg"
+  ;;
   --enable-gprof) gprof=3D"yes"
   ;;
   --enable-gcov) gcov=3D"yes"
@@ -1425,6 +1428,8 @@ Advanced options (experts only):
                            Available backends: $trace_backend_list
   --with-trace-file=3DNAME   Full PATH,NAME of file to store traces
                            Default:trace-<pid>
+  --with-hypertrace-args=3DNUMBER
+                           number of hypertrace arguments (default: $hyp=
ertrace)
   --disable-slirp          disable SLIRP userspace network connectivity
   --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
   --oss-lib                path to OSS library
@@ -4434,6 +4439,16 @@ if test "$?" -ne 0 ; then
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
@@ -5282,6 +5297,7 @@ echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
 fi
+echo "Hypertrace arguments  $hypertrace"
 echo "spice support     $spice $(echo_version $spice $spice_protocol_ver=
sion/$spice_server_version)"
 echo "rbd support       $rbd"
 echo "xfsctl support    $xfs"
@@ -5989,6 +6005,24 @@ else
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
index f9dbd7f509..aeb7b6807d 100644
--- a/trace-events
+++ b/trace-events
@@ -88,6 +88,17 @@ vcpu guest_cpu_exit(void)
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
