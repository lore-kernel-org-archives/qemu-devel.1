Received: from eggs.gnu.org ([2001:4830:134:3::10]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ett7Q-0001Cn-0q
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ett7M-00023E-4T
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:49:52 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:33293)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ett7L-00022T-Rr
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:49:48 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  8 Mar 2018 11:48:59 +0100
Message-Id: <20180308104859.3315-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: allows to use "--systemd ALL" with
 qemu-binfmt-conf.sh
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

qemu-binfmt-conf.sh when it is used with systemd
needs to know for which CPU the systemd-binfmt.service
file must be created (i.e. "--systemd ppc").

But sometime, for instance for test purpose, we need to
create an entry for all known architectures.
This patch entroduce the "ALL" parameter for this purpose.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index ea5a748745..7c86d857a1 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -143,7 +143,8 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                      instead generate update-binfmts templates
        --systemd:    don't write into /proc,
                      instead generate file for systemd-binfmt.service
-                     for the given CPU
+                     for the given CPU. If CPU is "ALL", generate a
+                     file for all known cpus
        --exportdir:  define where to write configuration files
                      (default: $SYSTEMDDIR or $DEBIANDIR)
        --credential: if yes, credential and security tokens are
@@ -290,18 +291,20 @@ while true ; do
         EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
         shift
         # check given cpu is in the supported CPU list
-        for cpu in ${qemu_target_list} ; do
+        if [ "$1" != "ALL" ] ; then
+            for cpu in ${qemu_target_list} ; do
+                if [ "$cpu" = "$1" ] ; then
+                    break
+                fi
+            done
+
             if [ "$cpu" = "$1" ] ; then
-                break
+                qemu_target_list="$1"
+            else
+                echo "ERROR: unknown CPU \"$1\"" 1>&2
+                usage
+                exit 1
             fi
-        done
-
-        if [ "$cpu" = "$1" ] ; then
-            qemu_target_list="$1"
-        else
-            echo "ERROR: unknown CPU \"$1\"" 1>&2
-            usage
-            exit 1
         fi
         ;;
     -Q|--qemu-path)
-- 
2.14.3
