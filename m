Received: from eggs.gnu.org ([2001:4830:134:3::10]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70U-0001ac-FS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70S-0004CT-VC
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:12 +1000
Message-Id: <20170927074316.4454-23-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/26] mac_dbdma: remove unused IO fields from
 DBDMAState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These fields were used to manually handle IO requests that weren't aligned
to a sector boundary before this feature was supported by the block API.

Once the block API changed to support byte-aligned IO requests, the macio
controller was switched over to use it in commit be1e343 but these fields
were accidentally left behind. Remove them, including the initialisation
in DBDMA_init().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/mac_dbdma.c  | 2 --
 include/hw/ppc/mac_dbdma.h | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 3fe507393f..979517263f 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -893,9 +893,7 @@ void* DBDMA_init (MemoryRegion **dbdma_mem)
     s = g_malloc0(sizeof(DBDMAState));
 
     for (i = 0; i < DBDMA_CHANNELS; i++) {
-        DBDMA_io *io = &s->channels[i].io;
         DBDMA_channel *ch = &s->channels[i];
-        qemu_iovec_init(&io->iov, 1);
 
         ch->rw = dbdma_unassigned_rw;
         ch->flush = dbdma_unassigned_flush;
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index a8603877d7..21bd66f3c9 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -42,10 +42,6 @@ struct DBDMA_io {
     DBDMA_end dma_end;
     /* DMA is in progress, don't start another one */
     bool processing;
-    /* unaligned last sector of a request */
-    uint8_t head_remainder[0x200];
-    uint8_t tail_remainder[0x200];
-    QEMUIOVector iov;
     /* DMA request */
     void *dma_mem;
     dma_addr_t dma_len;
-- 
2.13.5
