Received: from eggs.gnu.org ([209.51.188.92]:36335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1ORv-0007eG-Sz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1ORs-0001rs-96
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:46:33 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:31997 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1ORj-0001gh-Bu
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:46:26 -0500
Date: Wed, 6 Mar 2019 04:46:20 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190306044620.GC75@03612eec87fc>
References: <20190306031221.GA53@03612eec87fc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306031221.GA53@03612eec87fc>
Subject: [Qemu-devel] [PATCH v3 3/10] qemu-binfmt-conf.sh: add
 QEMU_CREDENTIAL and QEMU_PERSISTENT
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

Allow to set options '--persistent' and/or '--credential' through
environment variables. If not defined, defaults are used ('no').
Anyway, command-line arguments have priority over environment variables.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index ca15ff8092..e7a714e22c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -186,9 +186,11 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                       (default: $SYSTEMDDIR or $DEBIANDIR)
        --credential:  if present, credential and security tokens are
                       calculated according to the binary to interpret
+                      ($QEMU_CREDENTIAL=yes)
        --persistent:  if present, the interpreter is loaded when binfmt is
                       configured and remains in memory. All future uses
                       are cloned from the open file.
+                      ($QEMU_PERSISTENT=yes)

     To import templates with update-binfmts, use :

@@ -255,10 +257,10 @@ qemu_check_systemd() {

 qemu_generate_register() {
     flags=""
-    if [ "x$CREDENTIAL" = "xyes" ] ; then
+    if [ "x$QEMU_CREDENTIAL" = "xyes" ] ; then
         flags="OC"
     fi
-    if [ "x$PERSISTENT" = "xyes" ] ; then
+    if [ "x$QEMU_PERSISTENT" = "xyes" ] ; then
         flags="${flags}F"
     fi

@@ -281,7 +283,7 @@ package qemu-$cpu
 interpreter $qemu
 magic $magic
 mask $mask
-credential $CREDENTIAL
+credential $QEMU_CREDENTIAL
 EOF
 }

@@ -320,8 +322,10 @@ SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"

 QEMU_PATH=/usr/local/bin
-CREDENTIAL=no
-PERSISTENT=no
+
+QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
+QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
+
 QEMU_SUFFIX=""

 options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
@@ -373,10 +377,10 @@ while true ; do
         exit 1
         ;;
     -c|--credential)
-        CREDENTIAL="yes"
+        QEMU_CREDENTIAL="yes"
         ;;
     -p|--persistent)
-        PERSISTENT="yes"
+        QEMU_PERSISTENT="yes"
         ;;
     *)
         break
--
2.20.1
