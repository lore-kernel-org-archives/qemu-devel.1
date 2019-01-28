Received: from eggs.gnu.org ([209.51.188.92]:40848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN7-0002cf-3g
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN5-0008Ha-3a
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:00 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBN1-00089I-O7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so19087392wrt.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:10:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:10:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:23 +0000
Message-Id: <20190128181047.20781-3-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/26] target/arm: v8m: Ensure IDAU is respected
 if SAU is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Roth <code@stacksmashing.net>

The current behavior of v8m_security_lookup in helper.c only checks whether the
IDAU specifies a higher security if the SAU is enabled. If SAU.ALLNS is set to
1, this will lead to addresses being treated as non-secure, even though the
IDAU indicates that they must be secure.

This patch changes the behavior to also check the IDAU if the SAU is currently
disabled.

(This brings the behaviour here into line with the v8M Arm ARM
SecurityCheck() pseudocode.)

Signed-off-by: Thomas Roth <code@stacksmashing.net>
Message-id: CAGGekkuc+-tvp5RJP7CM+Jy_hJF7eiRHZ96132sb=hPPCappKg@mail.gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added pseudocode ref to the commit message, fixed comment style]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e24689f7677..676059cb386 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11078,18 +11078,19 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
                 }
             }
         }
-
-        /* The IDAU will override the SAU lookup results if it specifies
-         * higher security than the SAU does.
-         */
-        if (!idau_ns) {
-            if (sattrs->ns || (!idau_nsc && sattrs->nsc)) {
-                sattrs->ns = false;
-                sattrs->nsc = idau_nsc;
-            }
-        }
         break;
     }
+
+    /*
+     * The IDAU will override the SAU lookup results if it specifies
+     * higher security than the SAU does.
+     */
+    if (!idau_ns) {
+        if (sattrs->ns || (!idau_nsc && sattrs->nsc)) {
+            sattrs->ns = false;
+            sattrs->nsc = idau_nsc;
+        }
+    }
 }
 
 static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-- 
2.20.1
