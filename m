Received: from eggs.gnu.org ([2001:4830:134:3::10]:58918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1B-0006FP-1e
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe18-0007Xn-2q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:59 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:45953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe16-0007Ha-6R
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:56 -0500
Received: by mail-oi1-x22a.google.com with SMTP id y1so3443316oie.12
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:13 -0600
Message-Id: <20181214031923.29527-24-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 22/32] tcg/i386: Add setup_guest_base_seg for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3fb2f4b971..c21c3272f2 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1876,6 +1876,15 @@ static inline int setup_guest_base_seg(void)
     }
     return 0;
 }
+# elif defined (__FreeBSD__) || defined (__FreeBSD_kernel__)
+#  include <machine/sysarch.h>
+static inline int setup_guest_base_seg(void)
+{
+    if (sysarch(AMD64_SET_GSBASE, &guest_base) == 0) {
+        return P_GS;
+    }
+    return 0;
+}
 # else
 static inline int setup_guest_base_seg(void)
 {
-- 
2.17.2
