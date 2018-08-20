Received: from eggs.gnu.org ([2001:4830:134:3::10]:37267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUR-00045o-LL
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUQ-0005h9-RJ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUQ-0005go-KW
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUP-0003Fg-Ol
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:11 +0100
Message-Id: <20180820103212.2810-25-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/25] hw/dma/pl080: Correct bug in register
 address decode logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A bug in the handling of the register address decode logic
for the PL08x meant that we were incorrectly treating
accesses to the DMA channel registers (DMACCxSrcAddr,
DMACCxDestaddr, DMACCxLLI, DMACCxControl, DMACCxConfiguration)
as bad offsets. Fix this long-standing bug.

Fixes: https://bugs.launchpad.net/qemu/+bug/1637974
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.18.0
