Received: from eggs.gnu.org ([2001:4830:134:3::10]:52638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mv-0001Ev-FI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mm-0000VX-CK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6Mi-0000SW-I0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id m1so5558969wml.2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:59 +0100
Message-Id: <1544628195-37728-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 38/54] includes: Replace QEMU_GNUC_PREREQ with
 "__has_builtin || !defined(__clang__)"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Since we require GCC version 4.8 or newer now, we can be sure that
the builtin functions are always available on GCC. And for Clang,
we can check the availablility with __has_builtin instead.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543937577-28256-7-git-send-email-thuth@redhat.com>
---
 include/qemu/compiler.h   | 2 +-
 include/qemu/host-utils.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 6f32ec2..a1e50ed 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -135,7 +135,7 @@
 #define __has_builtin(x) 0 /* compatibility with non-clang compilers */
 #endif
 
-#if __has_builtin(__builtin_assume_aligned) || QEMU_GNUC_PREREQ(4, 7)
+#if __has_builtin(__builtin_assume_aligned) || !defined(__clang__)
 #define HAS_ASSUME_ALIGNED
 #endif
 
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 38da849..4cd170e 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -207,7 +207,7 @@ static inline int cto64(uint64_t val)
  */
 static inline int clrsb32(uint32_t val)
 {
-#if QEMU_GNUC_PREREQ(4, 7)
+#if __has_builtin(__builtin_clrsb) || !defined(__clang__)
     return __builtin_clrsb(val);
 #else
     return clz32(val ^ ((int32_t)val >> 1)) - 1;
@@ -223,7 +223,7 @@ static inline int clrsb32(uint32_t val)
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
