Received: from eggs.gnu.org ([2001:4830:134:3::10]:58335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cETtC-0005Ln-Er
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cETt8-0006as-GF
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:31:30 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Dec 2016 20:30:19 -0800
Message-Id: <1481085020-2614-2-git-send-email-rth@twiddle.net>
In-Reply-To: <1481085020-2614-1-git-send-email-rth@twiddle.net>
References: <1481085020-2614-1-git-send-email-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/2] target-arm: Fix aarch64 vec_reg_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Since CPUARMState.vfp.regs is not 16 byte aligned, the ^ 8 fixup used
for a big-endian host doesn't do what's intended.  Fix this by adding
in the vfp.regs offset after computing the inter-register offset.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target-arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target-arm/translate-a64.c b/target-arm/translate-a64.c
index 6dc27a6..ef7601b 100644
--- a/target-arm/translate-a64.c
+++ b/target-arm/translate-a64.c
@@ -527,7 +527,7 @@ static inline void assert_fp_access_checked(DisasContext *s)
 static inline int vec_reg_offset(DisasContext *s, int regno,
                                  int element, TCGMemOp size)
 {
-    int offs = offsetof(CPUARMState, vfp.regs[regno * 2]);
+    int offs = 0;
 #ifdef HOST_WORDS_BIGENDIAN
     /* This is complicated slightly because vfp.regs[2n] is
      * still the low half and  vfp.regs[2n+1] the high half
@@ -540,6 +540,7 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
 #else
     offs += element * (1 << size);
 #endif
+    offs += offsetof(CPUARMState, vfp.regs[regno * 2]);
     assert_fp_access_checked(s);
     return offs;
 }
-- 
2.7.4
