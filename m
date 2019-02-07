Received: from eggs.gnu.org ([209.51.188.92]:40859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYe-0000Bg-17
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYa-0007Kj-AL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1groYY-0007Gb-7O
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:50 -0500
Received: by mail-wr1-x42c.google.com with SMTP id q15so899954wro.12
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:37:49 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  7 Feb 2019 18:37:32 +0000
Message-Id: <20190207183744.5054-5-alex.bennee@linaro.org>
In-Reply-To: <20190207183744.5054-1-alex.bennee@linaro.org>
References: <20190207183744.5054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/16] .travis.yml: fold --disable-tcg into
 alternate coroutine builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The alternate coroutine builds are really only of interest to people
running KVM (although I think you could use them for TCG if you really
tried). As they tend to run long lets kill two birds with one stone
and fold the --disable-tcg build into them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 652be702ac..baa06b976a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -97,12 +97,16 @@ matrix:
         - CONFIG="--enable-modules --disable-linux-user"
 
 
+    # Alternate coroutines implementations are only really of interest to KVM users
+    # However we can't test against KVM on Travis so we can only run unit tests
     - env:
-        - CONFIG="--with-coroutine=ucontext --disable-linux-user"
+        - CONFIG="--with-coroutine=ucontext --disable-tcg"
+        - TEST_CMD="make check-unit -j3 V=1"
 
 
     - env:
-        - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
+        - CONFIG="--with-coroutine=sigaltstack --disable-tcg"
+        - TEST_CMD="make check-unit -j3 V=1"
 
 
     # Check we can build docs and tools
@@ -162,11 +166,6 @@ matrix:
         - TEST_CMD=""
 
 
-    - env:
-        - CONFIG="--disable-tcg"
-        - TEST_CMD=""
-
-
     # MacOSX builds
     - env:
         - CONFIG="--target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
-- 
2.20.1
