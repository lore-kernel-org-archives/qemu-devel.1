Received: from eggs.gnu.org ([209.51.188.92]:60925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wQ-0007SU-99
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wP-0008FN-AO
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gm3wP-0007qg-3e
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id t6so46281wrr.12
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:50:23 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 22 Jan 2019 21:50:13 +0000
Message-Id: <20190122215016.18697-9-alex.bennee@linaro.org>
In-Reply-To: <20190122215016.18697-1-alex.bennee@linaro.org>
References: <20190122215016.18697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/11] include/fpu/softfloat: Fix
 compilation with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

From: Thomas Huth <thuth@redhat.com>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat-macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index b1d772e6d4..bd5b6418e3 100644
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
2.17.1
