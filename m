Received: from eggs.gnu.org ([2001:4830:134:3::10]:44332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj9-0000LQ-CR
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj5-0003nL-O8
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj5-0003ly-HF
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:35 -0500
Received: by mail-wr1-x444.google.com with SMTP id t3so12596704wrr.3
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:56 +0100
Message-Id: <20181123144558.5048-36-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 35/37] tcg/i386: Add
 setup_guest_base_seg for FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 79de8d0cd2..55c5a8516c 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1818,6 +1818,16 @@ static inline void setup_guest_base_seg(void)
         guest_base_flags = P_GS;
     }
 }
+#elif defined (__FreeBSD__) || defined (__FreeBSD_kernel__)
+# include <machine/sysarch.h>
+
+static int guest_base_flags;
+static inline void setup_guest_base_seg(void)
+{
+    if (sysarch(AMD64_SET_GSBASE, &guest_base) == 0) {
+        guest_base_flags = P_GS;
+    }
+}
 #else
 # define guest_base_flags 0
 static inline void setup_guest_base_seg(void) { }
-- 
2.17.2
