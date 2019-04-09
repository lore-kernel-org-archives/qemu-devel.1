Received: from eggs.gnu.org ([209.51.188.92]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00084v-3u
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5s-0004gc-PN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5q-0004Zf-QM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id k11so21614638wro.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Apr 2019 17:55:14 +0200
Message-Id: <1554825316-33288-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] include/qemu/bswap.h: Use
 __builtin_memcpy() in accessor functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In the accessor functions ld*_he_p() and st*_he_p() we use memcpy()
to perform a load or store to a pointer which might not be aligned
for the size of the type. We rely on the compiler to optimize this
memcpy() into an efficient load or store instruction where possible.
This is required for good performance, but at the moment it is also
required for correct operation, because some users of these functions
require that the access is atomic if the pointer is aligned, which
will only be the case if the compiler has optimized out the memcpy().
(The particular example where we discovered this is the virtio
vring_avail_idx() which calls virtio_lduw_phys_cached() which
eventually ends up calling lduw_he_p().)

Unfortunately some compile environments, such as the fortify-source
setup used in Alpine Linux, define memcpy() to a wrapper function
in a way that inhibits this compiler optimization.

The correct long-term fix here is to add a set of functions for
doing atomic accesses into AddressSpaces (and to other relevant
families of accessor functions like the virtio_*_phys_cached()
ones), and make sure that callsites which want atomic behaviour
use the correct functions.

In the meantime, switch to using __builtin_memcpy() in the
bswap.h accessor functions. This will make us robust against things
like this fortify library in the short term. In the longer term
it will mean that we don't end up with these functions being really
badly-performing even if the semantics of the out-of-line memcpy()
are correct.

Reported-by: Fernando Casas Schössow <casasfernando@outlook.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190318112938.8298-1-peter.maydell@linaro.org>
---
 include/qemu/bswap.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 5a70f78..2a9f3fe 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -316,51 +316,57 @@ static inline void stb_p(void *ptr, uint8_t v)
     *(uint8_t *)ptr = v;
 }
 
-/* Any compiler worth its salt will turn these memcpy into native unaligned
-   operations.  Thus we don't need to play games with packed attributes, or
-   inline byte-by-byte stores.  */
+/*
+ * Any compiler worth its salt will turn these memcpy into native unaligned
+ * operations.  Thus we don't need to play games with packed attributes, or
+ * inline byte-by-byte stores.
+ * Some compilation environments (eg some fortify-source implementations)
+ * may intercept memcpy() in a way that defeats the compiler optimization,
+ * though, so we use __builtin_memcpy() to give ourselves the best chance
+ * of good performance.
+ */
 
 static inline int lduw_he_p(const void *ptr)
 {
     uint16_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline int ldsw_he_p(const void *ptr)
 {
     int16_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline void stw_he_p(void *ptr, uint16_t v)
 {
-    memcpy(ptr, &v, sizeof(v));
+    __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
 static inline int ldl_he_p(const void *ptr)
 {
     int32_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline void stl_he_p(void *ptr, uint32_t v)
 {
-    memcpy(ptr, &v, sizeof(v));
+    __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
 static inline uint64_t ldq_he_p(const void *ptr)
 {
     uint64_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline void stq_he_p(void *ptr, uint64_t v)
 {
-    memcpy(ptr, &v, sizeof(v));
+    __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
 static inline int lduw_le_p(const void *ptr)
-- 
1.8.3.1
