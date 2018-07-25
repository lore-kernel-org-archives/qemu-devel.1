Received: from eggs.gnu.org ([2001:4830:134:3::10]:55582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiHze-0008Ap-Qf
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiHzb-0000TL-RA
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:30:10 -0400
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14]:58038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1fiHzb-0000Ji-L8
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:30:07 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 25 Jul 2018 13:30:00 +0200
Message-Id: <20180725113000.11014-1-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH] hw/arm/sysbus-fdt: Fix assertion in
 copy_properties_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When copy_properties_from_host() ignores the error for an optional
property, it frees the error, but fails to reset it.

Hence if two or more optional properties are missing, an assertion is
triggered:

    util/error.c:57: error_setv: Assertion `*errp == NULL' failed.

Fis this by resetting err to NULL after ignoring the error.

Fixes: 9481cf2e5f2f2bb6 ("hw/arm/sysbus-fdt: helpers for clock node generation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 hw/arm/sysbus-fdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 0d4c75702c3ddfae..43d6a7bb48ddc351 100644
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
