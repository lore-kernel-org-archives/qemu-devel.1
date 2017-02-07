Received: from eggs.gnu.org ([2001:4830:134:3::10]:32877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe8-0007eb-Bx
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe7-0002o1-5B
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe6-0002gg-Vq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAds-0005St-7S
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:16 +0000
Message-Id: <1486492645-27803-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/13] sd: sdhci: check data length during
 dma_memory_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Prasad J Pandit <pjp@fedoraproject.org>

While doing multi block SDMA transfer in routine
'sdhci_sdma_transfer_multi_blocks', the 's->fifo_buffer' starting
index 'begin' and data length 's->data_count' could end up to be same.
This could lead to an OOB access issue. Correct transfer data length
to avoid it.

Cc: qemu-stable@nongnu.org
Reported-by: Jiang Xin <jiangxin1@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20170130064736.9236-1-ppandit@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
