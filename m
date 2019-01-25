Received: from eggs.gnu.org ([209.51.188.92]:54486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bl-0004KP-9w
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bi-0002f4-PB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6Bi-0002Rz-GP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:46 -0500
Received: by mail-wm1-x341.google.com with SMTP id n190so7708323wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:26:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:26:20 +0000
Message-Id: <20190125182626.9221-2-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-1-peter.maydell@linaro.org>
References: <20190125182626.9221-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/7] target/arm/translate-a64: Don't
 underdecode system instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Desnogues <laurent.desnogues@gmail.com>

The "system instructions" and "system register move" subcategories
of "branches, exception generating and system instructions" for A64
only apply if bits [23:22] are zero; other values are currently
unallocated. Correctly UNDEF these unallocated encodings.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4d28a27c3bd..e6df303e321 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2144,7 +2144,11 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
         break;
     case 0x6a: /* Exception generation / System */
         if (insn & (1 << 24)) {
-            disas_system(s, insn);
+            if (extract32(insn, 22, 2) == 0) {
+                disas_system(s, insn);
+            } else {
+                unallocated_encoding(s);
+            }
         } else {
             disas_exc(s, insn);
         }
-- 
2.20.1
