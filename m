Received: from eggs.gnu.org ([209.51.188.92]:44336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTM-00084V-90
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTL-0000lN-6L
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:36 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 13:56:12 +0100
Message-Id: <20190218125615.18970-8-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-1-armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] mips_malta: Clean up definition of flash
 memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

pflash_cfi01_register() takes a size in bytes, a block size in bytes
and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
locally as 0x400000).  Confusing all the same.

Pass FLASH_SIZE instead of BIOS_SIZE.

There are more uses of BIOS_SIZE, but I don't sufficiently understand
them to attempt cleanup.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/mips/mips_malta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index fff5ed19bd..65cdda4881 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
     if (dinfo) {
         printf("Register parallel flash %d size " TARGET_FMT_lx " at "
                "addr %08llx '%s' %x\n",
-               fl_idx, bios_size, FLASH_ADDRESS,
+               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
                blk_name(dinfo->bdrv), fl_sectors);
     }
 #endif
     fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
-                               BIOS_SIZE,
+                               FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                65536, fl_sectors,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
-- 
2.17.2
