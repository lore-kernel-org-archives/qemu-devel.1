Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqmJ-0001hG-7S
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqmF-0003U8-9P
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:58 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqmD-0003S7-Gg
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:53 -0500
Received: by mail-oi1-x243.google.com with SMTP id x202so11327537oif.13
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:08:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 10:08:40 -0600
Message-Id: <20181203160840.15115-6-richard.henderson@linaro.org>
In-Reply-To: <20181203160840.15115-1-richard.henderson@linaro.org>
References: <20181203160840.15115-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 5/5] tcg/i386: Add setup_guest_base_seg
 for FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index b8d2dd5ba3..3a39b51685 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1873,6 +1873,15 @@ static inline int setup_guest_base_seg(void)
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
