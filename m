Received: from eggs.gnu.org ([209.51.188.92]:58926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0008EX-Mr
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM9-0003hF-NX
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:55 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM9-0003QW-Ek
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id b11so6677152wmj.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:31 +0000
Message-Id: <20190201160653.13829-26-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/47] target/arm/translate-a64: Don't
 underdecode system instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The "system instructions" and "system register move" subcategories
of "branches, exception generating and system instructions" for A64
only apply if bits [23:22] are zero; other values are currently
unallocated. Correctly UNDEF these unallocated encodings.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190125182626.9221-2-peter.maydell@linaro.org
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
