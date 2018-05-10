Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd9-0004zV-Sg
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd9-0000qW-0y
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd8-0000nR-Oi
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd7-0003Vu-Gh
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:05 +0100
Message-Id: <20180510174519.11264-8-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/21] atomic.h: Work around gcc spurious
 "unused value" warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some versions of gcc produce a spurious warning if the result of
__atomic_compare_echange_n() is not used and the type involved
is a signed 8 bit value:
  error: value computed is not used [-Werror=unused-value]
This has been seen on at least
 gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609

Work around this by using an explicit cast to void to indicate
that we don't care about the return value.

We don't currently use our atomic_cmpxchg() macro on any signed
8 bit types, but the upcoming support for the Arm v8.1-Atomics
will require it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index d73c9e14d7..9ed39effd3 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -187,7 +187,7 @@
 /* Returns the eventual value, failed or not */
 #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    \
     typeof_strip_qual(*ptr) _old = (old);                               \
-    __atomic_compare_exchange_n(ptr, &_old, new, false,                 \
+    (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \
                               __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \
     _old;                                                               \
 })
-- 
2.17.0
