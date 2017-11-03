Received: from eggs.gnu.org ([2001:4830:134:3::10]:38141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdyb-0007zH-Ed
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdya-00016w-Bv
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAdya-00015p-6j
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:44 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Nov 2017 15:33:30 +0000
Message-Id: <20171103153333.6416-3-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-1-berrange@redhat.com>
References: <20171103153333.6416-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/5] build: don't create temporary files in
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
Cc: Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

There are cases where users do VPATH builds with the source directory being on
a read-only volume. In such a case they have to manually run the command
'git-submodule.sh ...modules...' ahead of time. When checking for status we
should not then write into the source dir.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/git-submodule.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 039f782d81..21909ea413 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -39,10 +39,9 @@ fi
 case "$command" in
 status)
     test -f "$substat" || exit 1
-    trap "rm -f ${substat}.tmp" EXIT
-    $GIT submodule status $modules > "${substat}.tmp"
-    test $? -ne 0 && error "failed to query git submodule status"
-    diff "${substat}" "${substat}.tmp" >/dev/null
+    CURSTATUS=`$GIT submodule status $modules`
+    OLDSTATUS=`cat $substat`
+    test "$CURSTATUS" = "$OLDSTATUS"
     exit $?
     ;;
 update)
-- 
2.13.6
