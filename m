Received: from eggs.gnu.org ([209.51.188.92]:52195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn22A-0003c5-6p
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn221-0000gc-VI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn21x-0000Xy-U9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so6892049wmj.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:23 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:07 +0000
Message-Id: <20190125140017.6092-5-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 04/14] archive-source.sh: Clone the
 submodules locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We cloned the QEMU repository from the local storage. Since the
submodules are also available there, clone them too. This is
quicker and reduce network use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/archive-source.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 6eed2a29bd..ce31be67b0 100755
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
 
 cd "$vroot_dir"
 test $? -ne 0 && error "failed to change into '$vroot_dir'"
@@ -45,11 +49,6 @@ test $? -ne 0 && error "failed to change into '$vroot_dir'"
 git checkout $HEAD
 test $? -ne 0 && error "failed to checkout $HEAD revision"
 
-for sm in $submodules; do
-    git submodule update --init $sm
-    test $? -ne 0 && error "failed to init submodule $sm"
-done
-
 if test -n "$submodules"; then
     {
         git ls-files || error "git ls-files failed"
-- 
2.17.1
