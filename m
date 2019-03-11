Received: from eggs.gnu.org ([209.51.188.92]:46738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RT9-0006P4-68
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RT8-0003n6-Bs
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:24:19 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:34367 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3RT8-0003ld-0K
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:24:18 -0400
Date: Mon, 11 Mar 2019 20:24:18 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311202418.GI9@59ca1d9b7985>
References: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311201532.GA6@59ca1d9b7985>
Subject: [Qemu-devel] [PATCH v5 9/9] qemu-binfmt-conf.sh: add --test
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

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 382bdaabfe..b750f60ef5 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -197,8 +197,7 @@ Options and associated environment variables:

 Argument             Env-variable     Description
 TARGETS              QEMU_TARGETS     A single arch name or a list of them (see all names below);
-                                      if empty, configure/clear all known targets;
-                                      if 'NONE', no interpreter is configured.
+                                      if empty, configure/clear all known targets.
 -h|--help                             display this usage
 -Q|--path PATH       QEMU_PATH        set path to qemu interpreter(s)
 -F|--suffix SUFFIX   QEMU_SUFFIX      add a suffix to the default interpreter name
@@ -208,6 +207,8 @@ TARGETS              QEMU_TARGETS     A single arch name or a list of them (see
                                       to the binary to interpret
 -r|--clear           QEMU_CLEAR       (yes) remove registered interpreters for target TARGETS;
                                       then exit.
+-t|--test            QEMU_TEST        (yes) test the setup with the provided arguments, but do not
+                                      configure any of the interpreters.
 -e|--exportdir PATH  DEBIANDIR        define where to write configuration files
                      SYSTEMDDIR
 -s|--systemd                          don't write into /proc, generate file(s) for
@@ -221,6 +222,7 @@ QEMU_SUFFIX=$QEMU_SUFFIX
 QEMU_PERSISTENT=$QEMU_PERSISTENT
 QEMU_CREDENTIAL=$QEMU_CREDENTIAL
 QEMU_CLEAR=$QEMU_CLEAR
+QEMU_TEST=$QEMU_TEST

 To import templates with update-binfmts, use :

@@ -319,9 +321,6 @@ qemu_set_binfmts() {

     # reduce the list of target interpreters to those given in the CLI
     [ $# -eq 0 ] && targets="${QEMU_TARGETS:-}" || targets="$@"
-    if [ "x$targets" = "xNONE" ] ; then
-      return
-    fi
     qemu_check_target_list $targets

     # register the interpreter for each target except for the native one
@@ -379,12 +378,16 @@ QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_CLEAR="${QEMU_CLEAR:-no}"
+QEMU_TEST="${QEMU_TEST:-no}"

-options=$(getopt -o rdsQ:S:e:hcp -l clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o trdsQ:S:e:hcp -l test,clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
     case "$1" in
+    -t|--test)
+        QEMU_TEST="yes"
+    ;;
     -r|--clear)
         QEMU_CLEAR="yes"
         ;;
@@ -438,4 +441,8 @@ if [ "x$QEMU_CLEAR" = "xyes" ] ; then
     exit
 fi

+if [ "x$QEMU_TEST" = "xyes" ] ; then
+    BINFMT_SET=:
+fi
+
 qemu_set_binfmts "$@"
--
2.21.0
