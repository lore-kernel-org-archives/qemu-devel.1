Received: from eggs.gnu.org ([2001:4830:134:3::10]:37288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cY5ki-00029q-OT
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 01:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cY5kf-0005J2-LL
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 01:47:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cY5kf-0005HC-Es
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 01:47:45 -0500
From: P J P <ppandit@redhat.com>
Date: Mon, 30 Jan 2017 12:17:36 +0530
Message-Id: <20170130064736.9236-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] sd: sdhci: check data length during
 dma_memory_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While doing multi block SDMA transfer in routine
'sdhci_sdma_transfer_multi_blocks', the 's->fifo_buffer' starting
index 'begin' and data length 's->data_count' could end up to be same.
This could lead to an OOB access issue. Correct transfer data length
to avoid it.

Reported-by: Jiang Xin <jiangxin1@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 01fbf22..5bd5ab6 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -536,7 +536,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 boundary_count -= block_size - begin;
             }
             dma_memory_read(&address_space_memory, s->sdmasysad,
-                            &s->fifo_buffer[begin], s->data_count);
+                            &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
                 for (n = 0; n < block_size; n++) {
-- 
2.9.3
