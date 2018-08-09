Received: from eggs.gnu.org ([2001:4830:134:3::10]:47360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZX-00063J-KO
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZW-0003WH-Im
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  9 Aug 2018 14:01:13 +0100
Message-Id: <20180809130115.28951-15-peter.maydell@linaro.org>
In-Reply-To: <20180809130115.28951-1-peter.maydell@linaro.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 14/16] hw/dma/pl080: Correct bug in register
 address decode logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

A bug in the handling of the register address decode logic
for the PL08x meant that we were incorrectly treating
accesses to the DMA channel registers (DMACCxSrcAddr,
DMACCxDestaddr, DMACCxLLI, DMACCxControl, DMACCxConfiguration)
as bad offsets. Fix this long-standing bug.

Fixes: https://bugs.launchpad.net/qemu/+bug/1637974
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This has been around for a long time, identified by code
inspection several years ago in the LP bug. Now I have
some guest code that actually tries to use the PL08x I
can test the fix...
---
 hw/dma/pl080.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index a7aacad74f0..8f92550392b 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -229,7 +229,7 @@ static uint64_t pl080_read(void *opaque, hwaddr offset,
         i = (offset & 0xe0) >> 5;
         if (i >= s->nchannels)
             goto bad_offset;
-        switch (offset >> 2) {
+        switch ((offset >> 2) & 7) {
         case 0: /* SrcAddr */
             return s->chan[i].src;
         case 1: /* DestAddr */
@@ -290,7 +290,7 @@ static void pl080_write(void *opaque, hwaddr offset,
         i = (offset & 0xe0) >> 5;
         if (i >= s->nchannels)
             goto bad_offset;
-        switch (offset >> 2) {
+        switch ((offset >> 2) & 7) {
         case 0: /* SrcAddr */
             s->chan[i].src = value;
             break;
@@ -308,6 +308,7 @@ static void pl080_write(void *opaque, hwaddr offset,
             pl080_run(s);
             break;
         }
+        return;
     }
     switch (offset >> 2) {
     case 2: /* IntTCClear */
-- 
2.17.1
