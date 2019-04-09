Received: from eggs.gnu.org ([209.51.188.92]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg7G-0003Qc-Ee
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg7C-0006pJ-Er
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:04:00 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:38912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDg78-0006nA-FW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:56 -0400
Received: by mail-it1-x141.google.com with SMTP id 139so2437678ita.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:03:53 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  8 Apr 2019 22:01:34 -0400
Message-Id: <8f3c98364902035431d788f058b342b286cc924c.1554774454.git.stephen.checkoway@oberlin.edu>
In-Reply-To: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
References: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/10] block/pflash_cfi02: Use the chip
 erase time specified in the CFI table
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
index d9087cafff..76c8af4365 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -633,9 +633,9 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
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
