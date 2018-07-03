Received: from eggs.gnu.org ([2001:4830:134:3::10]:49605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOGY-0007r8-9u
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOGU-0005aH-BY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:58 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1faOGU-0005Zn-0X
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:54 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Jul 2018 18:34:47 +0200
Message-Id: <20180703163451.16936-4-laurent@vivier.eu>
In-Reply-To: <20180703163451.16936-1-laurent@vivier.eu>
References: <20180703163451.16936-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/7] qemu-binfmt-conf.sh: allow to provide a
 suffix to the interpreter name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

some distros provide a qemu-CPU-static binary beside the qemu-CPU one.
This change allows to use it by providing "--qemu-suffix -static" to the
script.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180627205317.10343-4-laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 41 ++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 00c9c3aa16..23df00ae30 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -161,25 +161,26 @@ usage() {
     cat <<EOF
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                            [--help][--credential yes|no][--exportdir PATH]
-                           [--persistent yes|no]
+                           [--persistent yes|no][--qemu-suffix SUFFIX]
 
        Configure binfmt_misc to use qemu interpreter
 
-       --help:       display this usage
-       --qemu-path:  set path to qemu interpreter ($QEMU_PATH)
-       --debian:     don't write into /proc,
-                     instead generate update-binfmts templates
-       --systemd:    don't write into /proc,
-                     instead generate file for systemd-binfmt.service
-                     for the given CPU. If CPU is "ALL", generate a
-                     file for all known cpus
-       --exportdir:  define where to write configuration files
-                     (default: $SYSTEMDDIR or $DEBIANDIR)
-       --credential: if yes, credential and security tokens are
-                     calculated according to the binary to interpret
-       --persistent: if yes, the interpreter is loaded when binfmt is
-                     configured and remains in memory. All future uses
-                     are cloned from the open file.
+       --help:        display this usage
+       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
+       --qemu-suffix: add a suffix to the default interpreter name
+       --debian:      don't write into /proc,
+                      instead generate update-binfmts templates
+       --systemd:     don't write into /proc,
+                      instead generate file for systemd-binfmt.service
+                      for the given CPU. If CPU is "ALL", generate a
+                      file for all known cpus
+       --exportdir:   define where to write configuration files
+                      (default: $SYSTEMDDIR or $DEBIANDIR)
+       --credential:  if yes, credential and security tokens are
+                      calculated according to the binary to interpret
+       --persistent:  if yes, the interpreter is loaded when binfmt is
+                      configured and remains in memory. All future uses
+                      are cloned from the open file.
 
     To import templates with update-binfmts, use :
 
@@ -297,6 +298,7 @@ qemu_set_binfmts() {
             qemu="$QEMU_PATH/qemu-i386"
         fi
 
+        qemu="$qemu$QEMU_SUFFIX"
         if [ "$host_family" != "$family" ] ; then
             $BINFMT_SET
         fi
@@ -312,8 +314,9 @@ DEBIANDIR="/usr/share/binfmts"
 QEMU_PATH=/usr/local/bin
 CREDENTIAL=no
 PERSISTENT=no
+QEMU_SUFFIX=""
 
-options=$(getopt -o ds:Q:e:hc:p: -l debian,systemd:,qemu-path:,exportdir:,help,credential:,persistent: -- "$@")
+options=$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent: -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -349,6 +352,10 @@ while true ; do
         shift
         QEMU_PATH="$1"
         ;;
+    -F|--qemu-suffix)
+        shift
+        QEMU_SUFFIX="$1"
+        ;;
     -e|--exportdir)
         shift
         EXPORTDIR="$1"
-- 
2.17.1
