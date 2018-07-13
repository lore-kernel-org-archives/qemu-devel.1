Received: from eggs.gnu.org ([2001:4830:134:3::10]:59923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdxAS-0004Ic-B0
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdxAR-00026n-4G
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:27:24 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdxAQ-00025t-Tb
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:27:23 -0400
Received: by mail-wm0-x242.google.com with SMTP id n17-v6so9264634wmh.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:27:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 13:17:41 +0100
Message-Id: <20180713121741.19262-17-alex.bennee@linaro.org>
In-Reply-To: <20180713121741.19262-1-alex.bennee@linaro.org>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 16/16] docker: ignore distro
 versioning of debootstrap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We do a minimum version check for the debootstrap but if the distro
has added their own minor version tick it would fail and fall-back to
the SCM version. This is sub-optimal as the latest/greatest version
may be broken at any one particular time. We fix that with a little
sed magic on the version string before passing to our ugly shell
versioning check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-bootstrap.pre | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

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
