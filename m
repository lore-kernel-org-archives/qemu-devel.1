Received: from eggs.gnu.org ([209.51.188.92]:46308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RRX-000568-Nt
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RRW-0000r8-C7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:22:39 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:42567 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3RRV-0000nG-TL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:22:38 -0400
Date: Mon, 11 Mar 2019 20:22:38 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311202238.GG9@59ca1d9b7985>
References: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311201532.GA6@59ca1d9b7985>
Subject: [Qemu-devel] [PATCH v5 7/9] qemu-binfmt-conf.sh: generalize <CPU>
 to positional TARGETS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com

This breaks brackward compatibility.

Option '--systemd CPU' allows to register binfmt interpreters for a
single target architecture or for 'ALL' (of them). This patch
generalizes the approach to support it in any mode (default, '--debian'
or '--systemd'). To do so, option 'systemd' is changed to be boolean
(no args). Then, all the positional arguments are considered to be a
list of target architectures.

If no positional arguments are provided, all of the architectures in
qemu_target_list are registered. Conversely, argument value 'NONE'
allows to make a 'dry run' of the script. I.e., checks are executed
according to the mode, but no interpreter is registered.

Support QEMU_TARGETS environment variable, consistently with 'path',
'suffix', 'persistent' and 'credential', The supported formats are
the same as for positional arguments, which have priority. If both
the variable and the list of positional arguments are empty, defaults
to qemu_target_list.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 80 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 5616ac60ce..2be9867727 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -6,6 +6,28 @@ mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"

+# check if given TARGETS is/are in the supported target list
+qemu_check_target_list() {
+    if [ $# -eq 0 ] ; then
+      checked_target_list="$qemu_target_list"
+      return
+    fi
+    unset checked_target_list
+    for target ; do
+        for cpu in $qemu_target_list ; do
+            if [ "x$cpu" = "x$target" ] ; then
+                checked_target_list="$checked_target_list $target"
+                break
+            fi
+        done
+        if [ "x$cpu" != "x$target" ] ; then
+            echo "ERROR: unknown CPU \"$target\"" 1>&2
+            usage
+            exit 1
+        fi
+    done
+}
+
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
 i386_family=i386
@@ -167,14 +189,16 @@ qemu_get_family() {

 usage() {
     cat <<EOF
+Usage: qemu-binfmt-conf.sh [options] [TARGETS]

-Usage: qemu-binfmt-conf.sh [options]
-
-Configure binfmt_misc to use qemu interpreter
+Configure binfmt_misc to use qemu interpreter for the given TARGETS.

 Options and associated environment variables:

 Argument             Env-variable     Description
+TARGETS              QEMU_TARGETS     A single arch name or a list of them (see all names below);
+                                      if empty, configure all known targets;
+                                      if 'NONE', no interpreter is configured.
 -h|--help                             display this usage
 -Q|--path PATH       QEMU_PATH        set path to qemu interpreter(s)
 -F|--suffix SUFFIX   QEMU_SUFFIX      add a suffix to the default interpreter name
@@ -184,12 +208,12 @@ Argument             Env-variable     Description
                                       to the binary to interpret
 -e|--exportdir PATH  DEBIANDIR        define where to write configuration files
                      SYSTEMDDIR
--s|--systemd CPU                      don't write into /proc, generate file for
-                                      systemd-binfmt.service for the given CPU; if CPU is "ALL",
-                                      generate a file for all known cpus.
+-s|--systemd                          don't write into /proc, generate file(s) for
+                                      systemd-binfmt.service;
 -d|--debian                           don't write into /proc, generate update-binfmts templates

 Defaults:
+QEMU_TARGETS=$QEMU_TARGETS
 QEMU_PATH=$QEMU_PATH
 QEMU_SUFFIX=$QEMU_SUFFIX
 QEMU_PERSISTENT=$QEMU_PERSISTENT
@@ -203,14 +227,10 @@ To remove interpreter, use :

     sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH

-With systemd, binfmt files are loaded by systemd-binfmt.service
+The environment variable HOST_ARCH allows to override 'uname' to generate configuration files for
+a different architecture than the current one.

-The environment variable HOST_ARCH allows to override 'uname' to generate configuration files for a
-different architecture than the current one.
-
-where CPU is one of:
-
-    $qemu_target_list
+QEMU target list: $qemu_target_list

 EOF
 }
@@ -294,9 +314,15 @@ qemu_set_binfmts() {
     # probe cpu type
     host_family=$(qemu_get_family)

-    # register the interpreter for each cpu except for the native one
+    # reduce the list of target interpreters to those given in the CLI
+    [ $# -eq 0 ] && targets="${QEMU_TARGETS:-}" || targets="$@"
+    if [ "x$targets" = "xNONE" ] ; then
+      return
+    fi
+    qemu_check_target_list $targets

-    for cpu in ${qemu_target_list} ; do
+    # register the interpreter for each target except for the native one
+    for cpu in $checked_target_list ; do
         magic=$(eval echo \$${cpu}_magic)
         mask=$(eval echo \$${cpu}_mask)
         family=$(eval echo \$${cpu}_family)
@@ -324,12 +350,13 @@ BINFMT_SET=qemu_register_interpreter
 SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"

+QEMU_TARGETS="${QEMU_TARGETS:-}"
 QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
 QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"

-options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o dsQ:S:e:hcp -l debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
@@ -343,23 +370,6 @@ while true ; do
         CHECK=qemu_check_systemd
         BINFMT_SET=qemu_generate_systemd
         EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
-        shift
-        # check given cpu is in the supported CPU list
-        if [ "$1" != "ALL" ] ; then
-            for cpu in ${qemu_target_list} ; do
-                if [ "$cpu" = "$1" ] ; then
-                    break
-                fi
-            done
-
-            if [ "$cpu" = "$1" ] ; then
-                qemu_target_list="$1"
-            else
-                echo "ERROR: unknown CPU \"$1\"" 1>&2
-                usage
-                exit 1
-            fi
-        fi
         ;;
     -Q|--path)
         shift
@@ -390,5 +400,7 @@ while true ; do
     shift
 done

+shift
+
 $CHECK
-qemu_set_binfmts
+qemu_set_binfmts "$@"
--
2.21.0
