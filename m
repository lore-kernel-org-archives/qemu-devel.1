Received: from eggs.gnu.org ([209.51.188.92]:37075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3IE4-0001EG-UK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3IE3-0002Uq-WE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:32:08 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:39728 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3IE3-0002U6-Jx
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:32:07 -0400
Date: Mon, 11 Mar 2019 10:32:07 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311103207.GI16@765644dd90e5>
References: <20190311101428.GA11@765644dd90e5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311101428.GA11@765644dd90e5>
Subject: [Qemu-devel] [PATCH v4 10/10] qemu-binfmt-conf.sh: add
 --test|--dry-run
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
 scripts/qemu-binfmt-conf.sh | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index a516181a3a..db85798e76 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -196,8 +196,7 @@ Options and associated environment variables:

 Argument             Env-variable     Description
 TARGETS              QEMU_TARGETS     A single arch name or a list of them (see all names below);
-                                      if empty, configure/clear all known targets;
-                                      if 'NONE', no interpreter is configured.
+                                      if empty, configure/clear all known targets.
 -h|--help                             display this usage
 -Q|--path PATH:      QEMU_PATH        set path to qemu interpreter(s)
 -F|--suffix SUFFIX:  QEMU_SUFFIX      add a suffix to the default interpreter name
@@ -209,6 +208,8 @@ TARGETS              QEMU_TARGETS     A single arch name or a list of them (see
                      SYSTEMDDIR
 -c|--clear:          QEMU_CLEAR       (yes) remove registered interpreters for target TARGETS;
                                       then exit.
+-t|--test|--dry-run: QEMU_TEST        (yes) test the setup with the provided arguments, but do not
+                                      configure any of the interpreters.
 -s|--systemd:                         don't write into /proc, generate file(s) for
                                       systemd-binfmt.service; environment variable HOST_ARCH
                                       allows to override 'uname' to generate configuration files
@@ -222,6 +223,7 @@ QEMU_SUFFIX=$QEMU_SUFFIX
 QEMU_PERSISTENT=$QEMU_PERSISTENT
 QEMU_CREDENTIAL=$QEMU_CREDENTIAL
 QEMU_CLEAR=$QEMU_CLEAR
+QEMU_TEST=$QEMU_TEST

 To import templates with update-binfmts, use :

@@ -317,9 +319,6 @@ qemu_set_binfmts() {

     # reduce the list of target interpreters to those given in the CLI
     [ $# -eq 0 ] && targets="${QEMU_TARGETS:-}" || targets="$@"
-    if [ "x$targets" = "xNONE" ] ; then
-      return
-    fi
     qemu_check_target_list $targets

     # register the interpreter for each target except for the native one
@@ -376,12 +375,16 @@ QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_CLEAR="${QEMU_CLEAR:-no}"
+QEMU_TEST="${QEMU_TEST:-no}"

-options=$(getopt -o cdsQ:S:e:hcp -l clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o tcdsQ:S:e:hcp -l test,dry-runclear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
     case "$1" in
+    -t|--test|--dry-run)
+      QEMU_TEST="yes"
+    ;;
     -c|--clear)
         QEMU_CLEAR="yes"
         ;;
@@ -438,4 +441,10 @@ if [ "x$QEMU_CLEAR" = "xyes" ] ; then
   exit
 fi

+if [ "x$QEMU_TEST" = "xyes" ] ; then
+    skip(){
+    :;}
+    BINFMT_SET=skip
+fi
+
 qemu_set_binfmts "$@"
--
2.21.0
