Received: from eggs.gnu.org ([2001:4830:134:3::10]:57002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHRl-0004GD-Ca
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHRi-0003Zf-8j
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:53:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYHRh-0003XC-U0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:53:46 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 27 Jun 2018 22:53:15 +0200
Message-Id: <20180627205317.10343-2-laurent@vivier.eu>
In-Reply-To: <20180627205317.10343-1-laurent@vivier.eu>
References: <20180627205317.10343-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/3] qemu-binfmt-conf.sh: cleanup --credential
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

move credential value to its own variable to be able to manage
more flags

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index d7eefda0b8..9900554608 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -241,7 +241,12 @@ qemu_check_systemd() {
 }
 
 qemu_generate_register() {
-    echo ":qemu-$cpu:M::$magic:$mask:$qemu:$FLAGS"
+    flags=""
+    if [ "$CREDENTIAL" = "yes" ] ; then
+        flags="OC"
+    fi
+
+    echo ":qemu-$cpu:M::$magic:$mask:$qemu:$flags"
 }
 
 qemu_register_interpreter() {
@@ -260,10 +265,8 @@ package qemu-$cpu
 interpreter $qemu
 magic $magic
 mask $mask
+credential $CREDENTIAL
 EOF
-    if [ "$FLAGS" = "OC" ] ; then
-        echo "credentials yes" >> "$EXPORTDIR/qemu-$cpu"
-    fi
 }
 
 qemu_set_binfmts() {
@@ -300,7 +303,7 @@ SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"
 
 QEMU_PATH=/usr/local/bin
-FLAGS=""
+CREDENTIAL=no
 
 options=$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdir:,help,credential: -- "$@")
 eval set -- "$options"
@@ -348,11 +351,7 @@ while true ; do
         ;;
     -c|--credential)
         shift
-        if [ "$1" = "yes" ] ; then
-            FLAGS="OC"
-        else
-            FLAGS=""
-        fi
+        CREDENTIAL="$1"
         ;;
     *)
         break
-- 
2.14.4
