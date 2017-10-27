Received: from eggs.gnu.org ([2001:4830:134:3::10]:46070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84Sy-0003Uh-Ca
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84Sx-0006Xt-Hc
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e84Sx-0006Vx-CN
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:27 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 27 Oct 2017 14:14:10 +0100
Message-Id: <20171027131412.18830-3-berrange@redhat.com>
In-Reply-To: <20171027131412.18830-1-berrange@redhat.com>
References: <20171027131412.18830-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] build: don't create temporary files in
 source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

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
