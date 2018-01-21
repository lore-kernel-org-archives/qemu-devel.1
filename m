Received: from eggs.gnu.org ([2001:4830:134:3::10]:36124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gh-0000Zk-7y
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Ge-0007Ll-U8
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 21 Jan 2018 16:33:51 +1100
Message-Id: <20180121053353.25970-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180121053353.25970-1-david@gibson.dropbear.id.au>
References: <20180121053353.25970-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/12] sii3112: Add explicit type casts to avoid
 unintended sign extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Noticed by Coverity

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ide/sii3112.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index e2f5562bb7..17aa930e39 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -79,13 +79,13 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
         val |= (d->regs[0].confstat & (1UL << 11) ? (1 << 4) : 0); /*SATAINT0*/
         val |= (d->regs[1].confstat & (1UL << 11) ? (1 << 6) : 0); /*SATAINT1*/
         val |= (d->i.bmdma[1].status & BM_STATUS_INT ? (1 << 14) : 0);
-        val |= d->i.bmdma[0].status << 16;
-        val |= d->i.bmdma[1].status << 24;
+        val |= (uint32_t)d->i.bmdma[0].status << 16;
+        val |= (uint32_t)d->i.bmdma[1].status << 24;
         break;
     case 0x18:
         val = d->i.bmdma[1].cmd;
         val |= (d->regs[1].confstat & (1UL << 11) ? (1 << 4) : 0);
-        val |= d->i.bmdma[1].status << 16;
+        val |= (uint32_t)d->i.bmdma[1].status << 16;
         break;
     case 0x80 ... 0x87:
         if (size == 1) {
@@ -128,7 +128,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
         val = (d->i.bus[0].ifs[0].blk) ? 0x113 : 0;
         break;
     case 0x148:
-        val = d->regs[0].sien << 16;
+        val = (uint32_t)d->regs[0].sien << 16;
         break;
     case 0x180:
         val = d->regs[1].scontrol;
@@ -137,7 +137,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
         val = (d->i.bus[1].ifs[0].blk) ? 0x113 : 0;
         break;
     case 0x1c8:
-        val = d->regs[1].sien << 16;
+        val = (uint32_t)d->regs[1].sien << 16;
         break;
     default:
         val = 0;
-- 
2.14.3
