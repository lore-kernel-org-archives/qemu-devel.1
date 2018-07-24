Received: from eggs.gnu.org ([2001:4830:134:3::10]:60179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuf-00011k-0C
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuc-0006YU-4a
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuub-0006YK-Tk
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id e7-v6so3655459wrs.9
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:07 +0100
Message-Id: <20180724105109.8392-16-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/17] docker: ignore distro versioning of
 debootstrap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We do a minimum version check for the debootstrap but if the distro
has added their own minor version tick it would fail and fall-back to
the SCM version. This is sub-optimal as the latest/greatest version
may be broken at any one particular time. We fix that with a little
sed magic on the version string before passing to our ugly shell
versioning check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index ea324d6e4a..3b0ef95374 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -56,10 +56,13 @@ if [ -z $DEBOOTSTRAP_DIR ]; then
     if [ -z $DEBOOTSTRAP ]; then
         echo "No debootstrap installed, attempting to install from SCM"
         NEED_DEBOOTSTRAP=true
-    elif ! (echo "${MIN_DEBOOTSTRAP_VERSION}" ; "${DEBOOTSTRAP}" --version \
-            | cut -d ' ' -f 2) | sort -t . -n -k 1,1 -k 2,2 -k 3,3 -c &>/dev/null; then
-        echo "debootstrap too old, attempting to install from SCM"
-        NEED_DEBOOTSTRAP=true
+    else
+        INSTALLED_VERSION=$(${DEBOOTSTRAP} --version | sed 's/debootstrap \([0-9\.]*\)[^0-9\.]*.*/\1/')
+        if ! (echo "${MIN_DEBOOTSTRAP_VERSION}" ; echo "${INSTALLED_VERSION}") \
+                | sort -t . -n -k 1,1 -k 2,2 -k 3,3 -C ; then
+            echo "debootstrap too old, attempting to install from SCM"
+            NEED_DEBOOTSTRAP=true
+        fi
     fi
     if $NEED_DEBOOTSTRAP; then
         DEBOOTSTRAP_SOURCE=https://salsa.debian.org/installer-team/debootstrap.git
-- 
2.17.1
