Received: from eggs.gnu.org ([209.51.188.92]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKW-00042B-47
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKT-0007xt-Tx
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:24 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:40277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKT-0007uh-Jk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:21 -0400
Received: by mail-it1-x144.google.com with SMTP id k64so1429011itb.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:18 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  8 Apr 2019 16:55:53 -0400
Message-Id: <ea23d53834372a9493d705ea603419f2c0845adf.1554755001.git.stephen.checkoway@oberlin.edu>
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/10] block/pflash_cfi02: Use the chip erase
 time specified in the CFI table
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

When erasing the chip, use the typical time specified in the CFI table
rather than arbitrarily selecting 5 seconds.

Since the currently unconfigurable value set in the table is 12, this
means a chip erase takes 4096 ms so this isn't a big change in behavior.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f8a7314dee..f256049375 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -637,9 +637,9 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 pflash_update(pfl, 0, pfl->total_len);
             }
             set_dq7(pfl, 0x00);
-            /* Let's wait 5 seconds before chip erase is done */
+            /* Wait the time specified at CFI address 0x22. */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (NANOSECONDS_PER_SECOND * 5));
+                      (1ULL << pfl->cfi_table[0x22]) * SCALE_MS);
             break;
         case 0x30:
             /* Sector erase */
-- 
2.20.1 (Apple Git-117)
