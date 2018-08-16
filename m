Received: from eggs.gnu.org ([2001:4830:134:3::10]:56390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlS-0005tJ-Sl
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlA-00016L-N7
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44130 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJl3-0000jD-Qi
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:21 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:54 +0200
Message-Id: <1534431497-1385-62-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 61/84] mips_malta: Fix semihosting argument
 passing for nanoMIPS bare metal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Fix passing argument for nanoMIPS bare metal related to the
semihosting regime.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 hw/mips/mips_malta.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index f261dd6..40041d5 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -630,8 +630,14 @@ static void write_bootloader_nanomips(uint8_t *base,=
 int64_t run_addr,
                                 /* nop */
=20
     /* to_here: */
-    stw_p(p++, 0x0080); stw_p(p++, 0x0002);
+    if (semihosting_get_argc()) {
+        /* Preserve a0 content as arguments have been passed    */
+        stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop                          */
+    } else {
+        stw_p(p++, 0x0080); stw_p(p++, 0x0002);
                                 /* li a0,2                      */
+    }
=20
     stw_p(p++, 0xe3a0 | NM_HI1(ENVP_ADDR - 64));
=20
--=20
2.7.4
