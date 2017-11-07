Received: from eggs.gnu.org ([2001:4830:134:3::10]:53144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wT-0001sk-6g
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wJ-0000HH-3d
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC0wI-0000Gp-Ta
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:03 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  7 Nov 2017 10:16:40 +0000
Message-Id: <20171107101642.28016-5-berrange@redhat.com>
In-Reply-To: <20171107101642.28016-1-berrange@redhat.com>
References: <20171107101642.28016-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 4/6] build: don't fail if given a git
 submodule which does not exist
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

If going back in time in git history, across a commit that introduces a n=
ew
submodule, the 'git-submodule.sh' script will fail, causing rebuild to fa=
il.

This is because config-host.mak contains a GIT_SUBMODULES variable that l=
ists
a submodule that only exists in the later commit. config-host.mak won't g=
et
repopulated until config.status is invoked, but make won't get this far d=
ue to
the submodule error.

This change makes 'git-submodule.sh' check whether each module is known t=
o git
and drops any which are not present. A warning message will be printed wh=
en any
submodule is dropped in this manner.

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/git-submodule.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 63ace6fc55..3683bc9a04 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -7,7 +7,7 @@ substat=3D".git-submodule-status"
=20
 command=3D$1
 shift
-modules=3D"$@"
+maybe_modules=3D"$@"
=20
 test -z "$GIT" && GIT=3Dgit
=20
@@ -33,12 +33,24 @@ error() {
     exit 1
 }
=20
-if test -z "$modules"
+if test -z "$maybe_modules"
 then
     test -e $substat || touch $substat
     exit 0
 fi
=20
+modules=3D""
+for m in $maybe_modules
+do
+    $GIT submodule status $m 1> /dev/null 2>&1
+    if test $? =3D 0
+    then
+        modules=3D"$modules $m"
+    else
+        echo "warn: ignoring non-existent submodule $m"
+    fi
+done
+
 if ! test -e ".git"
 then
     echo "$0: unexpectedly called with submodules but no git checkout ex=
ists"
--=20
2.13.6
