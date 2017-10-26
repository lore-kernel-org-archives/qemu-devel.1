Received: from eggs.gnu.org ([2001:4830:134:3::10]:49612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7X4N-0003bE-HO
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7X4K-0006xg-FD
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:34:51 -0400
Received: from ozlabs.ru ([107.173.13.209]:57096)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7X4K-0006xW-90
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:34:48 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 26 Oct 2017 12:34:45 +1100
Message-Id: <20171026013445.45605-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2] git-submodule.sh: Do not try writing
 to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Daniel P. Berrange" <berrange@redhat.com>

The new git-submodule.sh script writes .git-submodule-status to
the source directory every time no matter what. This makes it conditional.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* fixed "status" branch too
---
 scripts/git-submodule.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index d8fbc7e47e..ae038d2e58 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -23,16 +23,21 @@ then
     exit 1
 fi
 
+substat_tmp=$(mktemp)
+
 case "$command" in
 status)
     test -f "$substat" || exit 1
-    trap "rm -f ${substat}.tmp" EXIT
-    git submodule status $modules > "${substat}.tmp"
-    diff "${substat}" "${substat}.tmp" >/dev/null
-    exit $?
+    git submodule status $modules > "$substat_tmp"
+    diff "${substat_tmp}" "${substat}" > /dev/null
     ;;
 update)
     git submodule update --init $modules 1>/dev/null 2>&1
-    git submodule status $modules > "${substat}"
+    git submodule status $modules > "$substat_tmp"
+    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
     ;;
 esac
+
+myret=$?
+rm "${substat_tmp}" 2>/dev/null
+exit $myret
-- 
2.11.0
