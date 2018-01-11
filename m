Received: from eggs.gnu.org ([2001:4830:134:3::10]:52406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd4A-0007ae-Uf
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd4A-0000IY-3u
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd49-0000Fq-Ss
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd48-0005ma-J8
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:44 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:22 +0000
Message-Id: <1515677902-23436-27-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/26] hw/intc/arm_gic: reserved register
 addresses are RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The GICv2 specification says that reserved register addresses
must RAZ/WI; now that we implement external abort handling
for Arm CPUs this means we must return MEMTX_OK rather than
MEMTX_ERROR, to avoid generating a spurious guest data abort.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1513183941-24300-3-git-send-email-peter.maydell@linaro.org
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/intc/arm_gic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 5a0e2a3..d701e49 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1261,7 +1261,8 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gic_cpu_read: Bad offset %x\n", (int)offset);
-        return MEMTX_ERROR;
+        *data = 0;
+        break;
     }
     return MEMTX_OK;
 }
@@ -1329,7 +1330,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gic_cpu_write: Bad offset %x\n", (int)offset);
-        return MEMTX_ERROR;
+        return MEMTX_OK;
     }
     gic_update(s);
     return MEMTX_OK;
-- 
2.7.4
