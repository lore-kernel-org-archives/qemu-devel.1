Received: from eggs.gnu.org ([2001:4830:134:3::10]:55486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKi-0003Jt-GA
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKd-00018j-OE
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKd-00018G-Dv
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id c13-v6so4062785wrt.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:05:03 +0100
Message-Id: <20180718100505.7546-9-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 08/10] docker: disable additional non-x86
 images
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

 - travis - doesn't support non-x8
 - centos7 - only AltArch, next release should have support
 - debian-8 based - docker hub issue?
 - ubuntu - image a bit old, maybe update to 18.04

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e1eba21f06..2226abd092 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -148,9 +148,16 @@ DOCKER_PARTIAL_IMAGES += debian-powerpc-user-cross
 
 ifneq ($(ARCH),x86_64)
 
+# Don't include non-multiarch images
+DOCKER_PARTIAL_IMAGES += travis centos7
+
 ifeq ($(ARCH),aarch64)
 # no point having a cross compiler when it is the native one
 DOCKER_PARTIAL_IMAGES += debian-arm64-cross
+# hub.docker.com's older Debian images are not multiarch
+DOCKER_PARTIAL_IMAGES += debian-win32-cross debian-win64-cross
+# older Ubuntu's need fixing up as well
+DOCKER_PARTIAL_IMAGES += ubuntu
 endif
 
 # No MIPS cross-compilers in non-x86 Debian images, so use linux-user
-- 
2.17.1
