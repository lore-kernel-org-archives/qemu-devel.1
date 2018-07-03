Received: from eggs.gnu.org ([2001:4830:134:3::10]:43549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKq-0006ry-4J
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKo-0008Ug-VV
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:15:00 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faIKo-0008UC-Q2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:58 -0400
Received: by mail-wm0-x244.google.com with SMTP id w16-v6so1696814wmc.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:14:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:41 +0100
Message-Id: <20180703101444.23778-18-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/20] docker: debian-bootstrap.pre allow
 customising of variant/url
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We default to the buildd variant as most of our images are for
building. However lets give the user the ability to specify "minbase"
if they want to create a simple base image for experimentation.

Allowing the tweaking of DEB_URL means we can also bootstrap other
Debian based OS's. For example:

  make docker-binfmt-image-debian-ubuntu-bionic-arm64 \
       DEB_ARCH=arm64 DEB_TYPE=bionic \
       DEB_VARIANT=minbase DEB_URL=http://ports.ubuntu.com/ \
       EXECUTABLE=./aarch64-linux-user/qemu-aarch64

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index 7c76dce663..56e1aa7a21 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -32,6 +32,15 @@ if [ -z "${DEB_TYPE}" ]; then
 
 fi
 
+# The following allow finer grain control over the defaults
+if [ -z "${DEB_VARIANT}" ]; then
+    DEB_VARIANT=buildd
+fi
+
+if [ -z "${DEB_URL}" ]; then
+    DEB_URL="http://httpredir.debian.org/debian"
+fi
+
 # We check in order for
 #
 #  - DEBOOTSTRAP_DIR pointing at a development checkout
@@ -107,5 +116,5 @@ fi
 
 echo "Building a rootfs using ${FAKEROOT} and ${DEBOOTSTRAP} ${DEB_ARCH}/${DEB_TYPE}"
 
-${FAKEROOT} ${DEBOOTSTRAP} --variant=buildd --foreign --arch=$DEB_ARCH $DEB_TYPE . http://httpredir.debian.org/debian || exit 1
+${FAKEROOT} ${DEBOOTSTRAP} --variant=$DEB_VARIANT --foreign --arch=$DEB_ARCH $DEB_TYPE . $DEB_URL || exit 1
 exit 0
-- 
2.17.1
