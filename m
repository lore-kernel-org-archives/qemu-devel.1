Received: from eggs.gnu.org ([2001:4830:134:3::10]:49257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dNKOu-0002aZ-Hq
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dNKOo-0002Fo-O6
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:45:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dNKOo-0002C4-Gd
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:44:58 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:44:45 +0100
Message-Id: <1497969886-17773-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497969886-17773-1-git-send-email-peter.maydell@linaro.org>
References: <1497969886-17773-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] risu_reginfo_arm.c: Fix handling of size
 values in sigframe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, patches@linaro.org

The code in reginfo_init_vfp() to parse the signal frame
was mishandling the size counts:
 * the size includes the bytes for the magic and size fields,
   so the code to skip forward over unknown or undersize blocks
   was adding 4 more than it should
 * the size is in bytes but the "is this block too small"
   test was checking against an expected size in words

This didn't cause any problems because the kernel happens
to generate signal frames with the VFP section first.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 risu_reginfo_arm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 0cb9087..b0d5da7 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -36,7 +36,12 @@ static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
     unsigned long *rs = uc->uc_regspace;
 
     for (;;) {
-        switch (*rs++) {
+        unsigned long magic = *rs++;
+        unsigned long size = *rs++;
+
+        size -= 8; /* Account for the magic/size fields */
+
+        switch (magic) {
         case 0:
         {
             /* We didn't find any VFP at all (probably a no-VFP
@@ -57,11 +62,11 @@ static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
              */
             int i;
             /* Skip if it's smaller than we expected (should never happen!) */
-            if (*rs < ((32 * 2) + 1)) {
-                rs += (*rs / 4);
+            if (size < ((32 * 2) + 1) * 4) {
+                rs += size / 4;
                 break;
             }
-            rs++;
+
             for (i = 0; i < 32; i++) {
                 ri->fpregs[i] = *rs++;
                 ri->fpregs[i] |= (uint64_t) (*rs++) << 32;
@@ -86,7 +91,7 @@ static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
         }
         default:
             /* Some other kind of block, ignore it */
-            rs += (*rs / 4);
+            rs += size / 4;
             break;
         }
     }
-- 
2.7.4
