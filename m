Received: from eggs.gnu.org ([209.51.188.92]:44392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTN-00085s-F5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTM-0000mi-8r
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:37 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 13:56:11 +0100
Message-Id: <20190218125615.18970-7-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-1-armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is confused
 about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, Magnus Damm <magnus.damm@gmail.com>

pflash_cfi02_register() takes a size in bytes, a block size in bytes
and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
number of blocks.  The latter happens to win.  I tried to find
documentation on the physcial hardware, no luck.

For now, adjust the byte size passed to match the actual size created,
and add a FIXME comment.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/sh4/r2d.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index dcdb3728cb..ed18d1f351 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -290,7 +290,14 @@ static void r2d_init(MachineState *machine)
 
     /* onboard flash memory */
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
+    /*
+     * FIXME The code is confused about the size of the flash.  It
+     * used to pass FLASH_SIZE bytes, in FLASH_SIZE >> 16 blocks of
+     * 16KiB each, which does not compute, but creates one of
+     * FLASH_SIZE / 4 bytes anyway.  The current code does so too, but
+     * whether it's the right size is anybody's guess.
+     */
+    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE / 4,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           16 * KiB, FLASH_SIZE >> 16,
                           1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
-- 
2.17.2
