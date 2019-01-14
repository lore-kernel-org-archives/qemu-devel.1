Received: from eggs.gnu.org ([209.51.188.92]:51000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj16f-0006vf-Kh
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj16e-0007Im-VE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:12:41 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 13:12:35 +0100
Message-Id: <1547467955-17245-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation with
 Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

Clang v7.0.1 does not like the __int128 variable type for inline
assembly on s390x:

In file included from fpu/softfloat.c:97:
include/fpu/softfloat-macros.h:647:9: error: inline asm error:
 This value type register class is not natively supported!
    asm("dlgr %0, %1" : "+r"(n) : "r"(d));
        ^

Disable this code part there now when compiling with Clang, so that
the generic code gets used instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/fpu/softfloat-macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index b1d772e..bd5b641 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -641,7 +641,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
     uint64_t q;
     asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
     return q;
-#elif defined(__s390x__)
+#elif defined(__s390x__) && !defined(__clang__)
     /* Need to use a TImode type to get an even register pair for DLGR.  */
     unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
-- 
1.8.3.1
