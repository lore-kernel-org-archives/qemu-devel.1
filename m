Received: from eggs.gnu.org ([209.51.188.92]:36841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3ID6-0000V0-UI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3ID5-0001ox-Pm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:31:08 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:4199 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3ID5-0001ng-Dr
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:31:07 -0400
Date: Mon, 11 Mar 2019 10:31:06 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311103106.GG16@765644dd90e5>
References: <20190311101428.GA11@765644dd90e5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311101428.GA11@765644dd90e5>
Subject: [Qemu-devel] [PATCH v4 8/10] qemu-binfmt-conf.sh: add option --clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com, alex.bennee@linaro.org

This is a partial implementation.

Allows to remove a single or a list of already registered binfmt
interpreters. Valid values are those in qemu_target_list.
If TARGETS is empty, all the existing 'qemu-*' interpreters are
removed.

This is partial because 'debian' and 'systemd' configurations are not
supported. The script will exit with error 'option clear not
implemented for this mode yet'.

Removal is done by printing '-1' as explained at:
https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 41 ++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index fde78517ff..07d1ee1f04 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -196,7 +196,7 @@ Options and associated environment variables:

 Argument             Env-variable     Description
 TARGETS              QEMU_TARGETS     A single arch name or a list of them (see all names below);
-                                      if empty, configure all known targets;
+                                      if empty, configure/clear all known targets;
                                       if 'NONE', no interpreter is configured.
 -h|--help                             display this usage
 -Q|--path PATH:      QEMU_PATH        set path to qemu interpreter(s)
@@ -206,9 +206,10 @@ TARGETS              QEMU_TARGETS     A single arch name or a list of them (see
                                       systemd-binfmt.service; environment variable HOST_ARCH
                                       allows to override 'uname' to generate configuration files
                                       for a different architecture than the current one.
-
 -e|--exportdir PATH: DEBIANDIR        define where to write configuration files
                      SYSTEMDDIR
+-c|--clear:          QEMU_CLEAR       (yes) remove registered interpreters for target TARGETS;
+                                      then exit.
 -c|--credential:     QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
                                       to the binary to interpret
 -p|--persistent:     QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
@@ -336,6 +337,25 @@ qemu_set_binfmts() {
     done
 }

+qemu_clear_notimplemented() {
+    echo "ERROR: option clear not implemented for this mode yet" 1>&2
+    usage
+    exit 1
+}
+
+qemu_clear_interpreter() {
+    names='qemu-*'
+    if [ $# -ne 0 ] ; then
+        qemu_check_target_list $1
+        unset names pre
+        for t in $checked_target_list ; do
+            names="${names}${pre}qemu-$t"
+            pre=' -o -name '
+        done
+    fi
+    find /proc/sys/fs/binfmt_misc/ -type f -name $names -exec sh -c 'printf %s -1 > {}' \;
+}
+
 CHECK=qemu_check_bintfmt_misc
 BINFMT_SET=qemu_register_interpreter

@@ -347,12 +367,16 @@ QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
 QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
+QEMU_CLEAR="${QEMU_CLEAR:-no}"

-options=$(getopt -o dsQ:S:e:hcp -l debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o cdsQ:S:e:hcp -l clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
     case "$1" in
+    -c|--clear)
+        QEMU_CLEAR="yes"
+        ;;
     -d|--debian)
         CHECK=qemu_check_debian
         BINFMT_SET=qemu_generate_debian
@@ -395,4 +419,15 @@ done
 shift

 $CHECK
+
+if [ "x$QEMU_CLEAR" = "xyes" ] ; then
+  case "$BINFMT_SET" in
+    *debian)  BINFMT_CLEAR=qemu_clear_notimplemented ;;
+    *systemd) BINFMT_CLEAR=qemu_clear_notimplemented ;;
+    *)        BINFMT_CLEAR=qemu_clear_interpreter
+  esac
+  $BINFMT_CLEAR "$@"
+  exit
+fi
+
 qemu_set_binfmts "$@"
--
2.21.0
