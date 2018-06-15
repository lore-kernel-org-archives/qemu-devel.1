Received: from eggs.gnu.org ([2001:4830:134:3::10]:32909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfk-0001x8-VJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfk-0006Re-0c
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfj-0006Qc-PZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:51 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfi-0003rC-GH
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:16 +0100
Message-Id: <20180615142521.19143-39-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/43] m25p80: add support for two bytes WRSR
 for Macronix chips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

On Macronix chips, two bytes can written to the WRSR. First byte will
configure the status register and the second the configuration
register. It is important to save the configuration value as it
contains the dummy cycle setting when using dual or quad IO mode.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a5ccffb4aae..b0ed8fa4188 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -698,6 +698,7 @@ static void complete_collecting_data(Flash *s)
         case MAN_MACRONIX:
             s->quad_enable = extract32(s->data[0], 6, 1);
             if (s->len > 1) {
+                s->volatile_cfg = s->data[1];
                 s->four_bytes_address_mode = extract32(s->data[1], 5, 1);
             }
             break;
-- 
2.17.1
