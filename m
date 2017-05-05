Received: from eggs.gnu.org ([2001:4830:134:3::10]:54121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <julien@gns3.net>) id 1d6cnU-0001CZ-G2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <julien@gns3.net>) id 1d6cnR-0006c9-EM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:57:24 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <julien@gns3.net>) id 1d6cnR-0006ak-5R
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:57:21 -0400
Received: by mail-wm0-x230.google.com with SMTP id m123so5522472wma.0
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 05:57:19 -0700 (PDT)
From: Julien Duponchelle <julien@gns3.net>
Date: Fri,  5 May 2017 14:57:18 +0200
Message-Id: <20170505125718.18337-1-julien@gns3.net>
Subject: [Qemu-devel] [PATCH] Disable the not fully implemented warning for
 e1000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Julien Duponchelle <julien@gns3.net>

Otherwise for image like CISCO IOSv you got a lot
of warning on the console preventing you to use
the VM because it's slow down the machine.

This fix:
https://bugs.launchpad.net/qemu/+bug/1673722

Signed-off-by: Julien Duponchelle <julien@gns3.net>
---
 hw/net/e1000.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index f2e5072d27..095fd0133f 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -35,6 +35,7 @@
 #include "sysemu/dma.h"
 #include "qemu/iov.h"
 #include "qemu/range.h"
+#include "qemu/log.h"
 
 #include "e1000x_common.h"
 
@@ -1264,8 +1265,9 @@ e1000_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
             || (s->compat_flags & (mac_reg_access[index] >> 2))) {
             if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
-                DBGOUT(GENERAL, "Writing to register at offset: 0x%08x. "
-                       "It is not fully implemented.\n", index<<2);
+                qemu_log_mask(LOG_UNIMP, "e1000: "
+                        "Writing to register at offset: 0x%08x. "
+                        "It is not fully implemented.\n", index << 2);
             }
             macreg_writeops[index](s, index, val);
         } else {    /* "flag needed" bit is set, but the flag is not active */
@@ -1291,8 +1293,9 @@ e1000_mmio_read(void *opaque, hwaddr addr, unsigned size)
         if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
             || (s->compat_flags & (mac_reg_access[index] >> 2))) {
             if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
-                DBGOUT(GENERAL, "Reading register at offset: 0x%08x. "
-                       "It is not fully implemented.\n", index<<2);
+                qemu_log_mask(LOG_UNIMP, "e1000: "
+                        "Reading register at offset: 0x%08x. "
+                        "It is not fully implemented.\n", index << 2);
             }
             return macreg_readops[index](s, index);
         } else {    /* "flag needed" bit is set, but the flag is not active */
-- 
2.11.0 (Apple Git-81)
