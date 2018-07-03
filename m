Received: from eggs.gnu.org ([2001:4830:134:3::10]:49419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG6-0007VK-W8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG3-0005Iw-2L
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:30 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1faOG2-0005IN-O0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Jul 2018 18:34:46 +0200
Message-Id: <20180703163451.16936-3-laurent@vivier.eu>
In-Reply-To: <20180703163451.16936-1-laurent@vivier.eu>
References: <20180703163451.16936-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 2/7] qemu-binfmt-conf.sh: add persistent (F)
 flags
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

Since kernel commit 948b701a607f
(binfmt_misc: add persistent opened binary handler for containers)
kernel allows to load the interpreter at the configuration time.

In case of chroot, it allows to have the interpreter in the host root
filesystem and not to copy it to the chroot filesystem.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180627205317.10343-3-laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 9900554608..00c9c3aa16 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -161,6 +161,7 @@ usage() {
     cat <<EOF
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                            [--help][--credential yes|no][--exportdir PATH]
+                           [--persistent yes|no]
 
        Configure binfmt_misc to use qemu interpreter
 
@@ -176,6 +177,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                      (default: $SYSTEMDDIR or $DEBIANDIR)
        --credential: if yes, credential and security tokens are
                      calculated according to the binary to interpret
+       --persistent: if yes, the interpreter is loaded when binfmt is
+                     configured and remains in memory. All future uses
+                     are cloned from the open file.
 
     To import templates with update-binfmts, use :
 
@@ -245,6 +249,9 @@ qemu_generate_register() {
     if [ "$CREDENTIAL" = "yes" ] ; then
         flags="OC"
     fi
+    if [ "$PERSISTENT" = "yes" ] ; then
+        flags="${flags}F"
+    fi
 
     echo ":qemu-$cpu:M::$magic:$mask:$qemu:$flags"
 }
@@ -304,8 +311,9 @@ DEBIANDIR="/usr/share/binfmts"
 
 QEMU_PATH=/usr/local/bin
 CREDENTIAL=no
+PERSISTENT=no
 
-options=$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdir:,help,credential: -- "$@")
+options=$(getopt -o ds:Q:e:hc:p: -l debian,systemd:,qemu-path:,exportdir:,help,credential:,persistent: -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -353,6 +361,10 @@ while true ; do
         shift
         CREDENTIAL="$1"
         ;;
+    -p|--persistent)
+        shift
+        PERSISTENT="$1"
+        ;;
     *)
         break
         ;;
-- 
2.17.1
