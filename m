Received: from eggs.gnu.org ([2001:4830:134:3::10]:45275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvi-00020U-P3
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvi-0006tr-5B
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOlvh-0006rE-UP
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvh-00065p-1d
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:57:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:57:28 +0000
Message-Id: <20181119155730.11758-9-peter.maydell@linaro.org>
In-Reply-To: <20181119155730.11758-1-peter.maydell@linaro.org>
References: <20181119155730.11758-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/10] hw/block/onenand: Fix off-by-one error
 allowing out-of-bounds read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

An off-by-one error in a switch case in onenand_read() allowed
a misbehaving guest to read off the end of a block of memory.

NB: the onenand device is used only by the "n800" and "n810"
machines, which are usable only with TCG, not KVM, so this is
not a security issue.

Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20181115143535.5885-2-peter.maydell@linaro.org
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/onenand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 0cb8d7fa135..49ef68c9b14 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -608,7 +608,7 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
     int offset = addr >> s->shift;
 
     switch (offset) {
-    case 0x0000 ... 0xc000:
+    case 0x0000 ... 0xbffe:
         return lduw_le_p(s->boot[0] + addr);
 
     case 0xf000:	/* Manufacturer ID */
-- 
2.19.1
