Received: from eggs.gnu.org ([2001:4830:134:3::10]:56319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7hsH-0006Mn-VD
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7hsD-0000UE-Nm
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7hsD-0000T3-IV
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:07:01 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Oct 2017 14:06:56 +0100
Message-Id: <20171026130656.31067-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] build: don't create temporary files in source
 dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

There are cases where users do VPATH builds with the source directory being on
a read-only volume. In such a case they have to manually run the command
'git-submodule.sh ...modules...'  manually ahead of time. When checking for
status we should not then write into the source dir.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/git-submodule.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index c66567d409..586ff32293 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -31,10 +31,10 @@ fi
 case "$command" in
 status)
     test -f "$substat" || exit 1
-    trap "rm -f ${substat}.tmp" EXIT
-    $GIT submodule status $modules > "${substat}.tmp"
-    test $? -ne 0 && error "failed to query git submodule status"
-    diff "${substat}" "${substat}.tmp" >/dev/null
+    substat_tmp=$(mktemp)
+    trap "rm -f ${substat_tmp}" EXIT
+    $GIT submodule status $modules > "${substat_tmp}"
+    diff "${substat}" "${substat_tmp}" >/dev/null
     exit $?
     ;;
 update)
-- 
2.13.6
