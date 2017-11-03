Received: from eggs.gnu.org ([2001:4830:134:3::10]:38191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdyh-000854-Kw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdye-0001Ee-Hm
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAdye-0001E2-BK
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:48 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Nov 2017 15:33:32 +0000
Message-Id: <20171103153333.6416-5-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-1-berrange@redhat.com>
References: <20171103153333.6416-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/5] build: don't fail if given a git
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
Cc: Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

If going back in time in git history, across a commit that introduces a new
submodule, the 'git-submodule.sh' script will fail, causing rebuild to fail.

This is because config-host.mak contains a GIT_SUBMODULES variable that lists
a submodule that only exists in the later commit. config-host.mak won't get
repopulated until config.status is invoked, but make won't get this far due to
the submodule error.

This change makes 'git-submodule.sh' check whether each module is known to git
and drops any which are not present. A warning message will be printed when any
submodule is dropped in this manner.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/git-submodule.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 63ace6fc55..2857fc57c4 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -7,7 +7,7 @@ substat=".git-submodule-status"
 
 command=$1
 shift
-modules="$@"
+maybe_modules="$@"
 
 test -z "$GIT" && GIT=git
 
@@ -33,12 +33,24 @@ error() {
     exit 1
 }
 
-if test -z "$modules"
+if test -z "$maybe_modules"
 then
     test -e $substat || touch $substat
     exit 0
 fi
 
+modules=""
+for m in $maybe_modules
+do
+    $GIT submodule status $m 1> /dev/null 2>&1
+    if test $? = 0
+    then
+        modules="$modules $m"
+    else
+        echo "warn: ignoring non-existant submodule $m"
+    fi
+done
+
 if ! test -e ".git"
 then
     echo "$0: unexpectedly called with submodules but no git checkout exists"
-- 
2.13.6
