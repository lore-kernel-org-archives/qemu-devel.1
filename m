Received: from eggs.gnu.org ([2001:4830:134:3::10]:58188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zu-000152-GU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zq-0002Rh-La
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fk8zq-00029y-El
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zf-0004FV-Ft
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:17:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 15:17:44 +0100
Message-Id: <20180730141748.430-3-peter.maydell@linaro.org>
In-Reply-To: <20180730141748.430-1-peter.maydell@linaro.org>
References: <20180730141748.430-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 2/6] hw/arm/sysbus-fdt: Fix assertion in
 copy_properties_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

When copy_properties_from_host() ignores the error for an optional
property, it frees the error, but fails to reset it.

Hence if two or more optional properties are missing, an assertion is
triggered:

    util/error.c:57: error_setv: Assertion `*errp == NULL' failed.

Fis this by resetting err to NULL after ignoring the error.

Fixes: 9481cf2e5f2f2bb6 ("hw/arm/sysbus-fdt: helpers for clock node generation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Message-id: 20180725113000.11014-1-geert+renesas@glider.be
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sysbus-fdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 0d4c75702c3..43d6a7bb48d 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -107,6 +107,7 @@ static void copy_properties_from_host(HostProperty *props, int nb_props,
                 /* mandatory property not found: bail out */
                 exit(1);
             }
+            err = NULL;
         }
     }
 }
-- 
2.17.1
