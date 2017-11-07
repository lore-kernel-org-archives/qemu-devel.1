Received: from eggs.gnu.org ([2001:4830:134:3::10]:53026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wL-0001lh-SX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wK-0000J3-GD
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC0wK-0000IH-AC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:04 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  7 Nov 2017 10:16:41 +0000
Message-Id: <20171107101642.28016-6-berrange@redhat.com>
In-Reply-To: <20171107101642.28016-1-berrange@redhat.com>
References: <20171107101642.28016-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 5/6] build: delay check for empty git
 submodule list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

We short circuit the git submodule update when passed an empty module lis=
t.
This accidentally causes the 'status' command to write to the status file=
. The
test needs to be delayed into the individual commands to avoid this prema=
ture
writing of the status file.

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/git-submodule.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 3683bc9a04..030617b4ac 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -33,12 +33,6 @@ error() {
     exit 1
 }
=20
-if test -z "$maybe_modules"
-then
-    test -e $substat || touch $substat
-    exit 0
-fi
-
 modules=3D""
 for m in $maybe_modules
 do
@@ -51,7 +45,7 @@ do
     fi
 done
=20
-if ! test -e ".git"
+if test -n "$maybe_modules" && ! test -e ".git"
 then
     echo "$0: unexpectedly called with submodules but no git checkout ex=
ists"
     exit 1
@@ -59,6 +53,11 @@ fi
=20
 case "$command" in
 status)
+    if test -z "$maybe_modules"
+    then
+         test -s ${substat} && exit 1 || exit 0
+    fi
+
     test -f "$substat" || exit 1
     CURSTATUS=3D`$GIT submodule status $modules`
     OLDSTATUS=3D`cat $substat`
@@ -66,6 +65,12 @@ status)
     exit $?
     ;;
 update)
+    if test -z "$maybe_modules"
+    then
+        test -e $substat || touch $substat
+        exit 0
+    fi
+
     $GIT submodule update --init $modules 1>/dev/null
     test $? -ne 0 && error "failed to update modules"
=20
--=20
2.13.6
