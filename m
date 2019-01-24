Received: from eggs.gnu.org ([209.51.188.92]:36134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTbt-0003Ad-2J
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTNo-0000Rg-Jq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmTNn-0000He-MV
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:00:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Jan 2019 02:00:23 +0100
Message-Id: <20190124010023.24397-3-philmd@redhat.com>
In-Reply-To: <20190124010023.24397-1-philmd@redhat.com>
References: <20190124010023.24397-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] archive-source.sh: Clone the submodules
 locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We cloned the QEMU repository from the local storage. Since the
submodules are also available there, clone them too. This is
quicker and reduce network use.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/archive-source.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 62bd22578b..e80c47caa3 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -38,6 +38,10 @@ else
 fi
 git clone --shared . "$vroot_dir"
 test $? -ne 0 && error "failed to clone into '$vroot_dir'"
+for sm in $submodules; do
+    git clone --shared "$sm" "$vroot_dir/$sm"
+    test $? -ne 0 && error "failed to clone submodule $sm"
+done
=20
 cd "$vroot_dir"
 test $? -ne 0 && error "failed to change into '$vroot_dir'"
@@ -45,11 +49,6 @@ test $? -ne 0 && error "failed to change into '$vroot_=
dir'"
 git checkout $HEAD
 test $? -ne 0 && error "failed to checkout $HEAD revision"
=20
-for sm in $submodules; do
-    git submodule update --init $sm
-    test $? -ne 0 && error "failed to init submodule $sm"
-done
-
 if test -n "$submodules"; then
     {
         git ls-files || error "git ls-files failed"
--=20
2.20.1
