Received: from eggs.gnu.org ([2001:4830:134:3::10]:36530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gNIkQ-0005Wx-0w
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gNIkP-0005zY-9R
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:35:57 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 14:35:34 +0000
Message-Id: <20181115143535.5885-2-peter.maydell@linaro.org>
In-Reply-To: <20181115143535.5885-1-peter.maydell@linaro.org>
References: <20181115143535.5885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 1/2] hw/block/onenand: Fix off-by-one
 error allowing out-of-bounds read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

An off-by-one error in a switch case in onenand_read() allowed
a misbehaving guest to read off the end of a block of memory.

NB: the onenand device is used only by the "n800" and "n810"
machines, which are usable only with TCG, not KVM, so this is
not a security issue.

Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I tweaked RTH's suggested fix to use an 0xbffe offset so
we don't overrun on an access to 0xbfff either.

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
