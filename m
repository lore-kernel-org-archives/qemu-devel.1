Received: from eggs.gnu.org ([2001:4830:134:3::10]:43845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTorV-0001lj-53
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTorE-0001uR-Hv
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gTorE-0001nX-7g
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:05:56 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  3 Dec 2018 15:05:37 +0100
Message-Id: <1543845937-300-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1543845937-300-1-git-send-email-thuth@redhat.com>
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 7/7] includes: Replace QEMU_GNUC_PREREQ
 with "__has_builtin || !defined(__clang__)"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

Since we require GCC version 4.8 or newer now, we can be sure that
the builtin functions are always available on GCC. And for Clang,
we can check the availablility with __has_builtin instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/compiler.h   | 2 +-
 include/qemu/host-utils.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 8337361..261842b 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -121,7 +121,7 @@
 #define __has_builtin(x) 0 /* compatibility with non-clang compilers */
 #endif
 
-#if __has_builtin(__builtin_assume_aligned) || QEMU_GNUC_PREREQ(4, 7)
+#if __has_builtin(__builtin_assume_aligned) || !defined(__clang__)
 #define HAS_ASSUME_ALIGNED
 #endif
 
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 25ba3e8..0b3b79e 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -177,7 +177,7 @@ static inline int cto64(uint64_t val)
  */
 static inline int clrsb32(uint32_t val)
 {
-#if QEMU_GNUC_PREREQ(4, 7)
+#if __has_builtin(__builtin_clrsb) || !defined(__clang__)
     return __builtin_clrsb(val);
 #else
     return clz32(val ^ ((int32_t)val >> 1)) - 1;
@@ -193,7 +193,7 @@ static inline int clrsb32(uint32_t val)
  */
 static inline int clrsb64(uint64_t val)
 {
-#if QEMU_GNUC_PREREQ(4, 7)
+#if __has_builtin(__builtin_clrsbll) || !defined(__clang__)
     return __builtin_clrsbll(val);
 #else
     return clz64(val ^ ((int64_t)val >> 1)) - 1;
-- 
1.8.3.1
