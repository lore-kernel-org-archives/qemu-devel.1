Received: from eggs.gnu.org ([209.51.188.92]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas.roth@leveldown.de>) id 1glEDJ-0003Xg-FO
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas.roth@leveldown.de>) id 1glEDI-0003ME-Gc
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:36:41 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thomas.roth@leveldown.de>)
	id 1glEDI-0003EF-0E
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:36:40 -0500
Received: by mail-oi1-x243.google.com with SMTP id j21so12599226oii.8
	for <qemu-devel@nongnu.org>; Sun, 20 Jan 2019 06:36:29 -0800 (PST)
MIME-Version: 1.0
From: Thomas Roth <code@stacksmashing.net>
Date: Sun, 20 Jan 2019 15:36:16 +0100
Message-ID: <CAGGekkuc+-tvp5RJP7CM+Jy_hJF7eiRHZ96132sb=hPPCappKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] target/arm: v8m: Ensure IDAU is respected if
 SAU is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

The current behavior of v8m_security_lookup in helper.c only checks whether the
IDAU specifies a higher security if the SAU is enabled. If SAU.ALLNS is set to
1, this will lead to addresses being treated as non-secure, even though the
IDAU indicates that they must be secure.

This patch changes the behavior to also check the IDAU if the SAU is currently
disabled.

Signed-off-by: Thomas Roth <code@stacksmashing.net>
---
 target/arm/helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f00c141ef9..34fe7f21bf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10479,17 +10479,17 @@ static void v8m_security_lookup(CPUARMState
*env, uint32_t address,
                 }
             }
         }
+        break;
+    }

-        /* The IDAU will override the SAU lookup results if it specifies
-         * higher security than the SAU does.
-         */
-        if (!idau_ns) {
-            if (sattrs->ns || (!idau_nsc && sattrs->nsc)) {
-                sattrs->ns = false;
-                sattrs->nsc = idau_nsc;
-            }
+    /* The IDAU will override the SAU lookup results if it specifies
+     * higher security than the SAU does.
+     */
+    if (!idau_ns) {
+        if (sattrs->ns || (!idau_nsc && sattrs->nsc)) {
+            sattrs->ns = false;
+            sattrs->nsc = idau_nsc;
         }
-        break;
     }
 }

-- 
2.17.2
