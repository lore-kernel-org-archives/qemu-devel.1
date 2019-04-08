Received: from eggs.gnu.org ([209.51.188.92]:47666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKP-0003t3-Mi
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKO-0007sc-3u
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:17 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:39618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKN-0007s0-R8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:16 -0400
Received: by mail-io1-xd2b.google.com with SMTP id e13so12308996ioq.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:15 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  8 Apr 2019 16:55:50 -0400
Message-Id: <278aee36fb8106857717b7d567dedb167fa4ea4c.1554755001.git.stephen.checkoway@oberlin.edu>
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/10] block/pflash_cfi02: Fix reset command
 not ignored during erase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>

When the flash device is performing a chip erase, all commands are
ignored. When it is performing a sector erase, only the erase suspend
command is valid, which is currently not supported.

In particular, the reset command should not cause the device to reset to
read array mode while programming is on going.
---
 hw/block/pflash_cfi02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 32aba9a771..fa6929b9b6 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -325,7 +325,8 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                     pfl->bank_width * 2, value);
         }
 
-        if (cmd == 0xF0) {
+        /* Reset does nothing during chip erase and sector erase. */
+        if (cmd == 0xF0 && pfl->cmd != 0x10 && pfl->cmd != 0x30) {
 #if 0
             DPRINTF("%s: flash reset asked (%02x %02x)\n",
                     __func__, pfl->cmd, cmd);
-- 
2.20.1 (Apple Git-117)
