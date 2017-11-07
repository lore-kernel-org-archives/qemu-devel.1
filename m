Received: from eggs.gnu.org ([2001:4830:134:3::10]:52977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wJ-0001kD-HZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wG-0000FK-DR
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC0wG-0000En-7I
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:00 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  7 Nov 2017 10:16:38 +0000
Message-Id: <20171107101642.28016-3-berrange@redhat.com>
In-Reply-To: <20171107101642.28016-1-berrange@redhat.com>
References: <20171107101642.28016-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 2/6] build: don't create temporary files in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

There are cases where users do VPATH builds with the source directory bei=
ng on
a read-only volume. In such a case they have to manually run the command
'git-submodule.sh ...modules...' ahead of time. When checking for status =
we
should not then write into the source dir.

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
+    CURSTATUS=3D`$GIT submodule status $modules`
+    OLDSTATUS=3D`cat $substat`
+    test "$CURSTATUS" =3D "$OLDSTATUS"
     exit $?
     ;;
 update)
--=20
2.13.6
