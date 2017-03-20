Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R1-00024B-Nl
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qs-0005Bl-BN
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45349
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qr-0005Aj-Sd
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8p07008141
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29afu7a8aa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:45 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:44 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:27 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-64-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 63/81] sd: sdhci: check data length during
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
Cc: qemu-stable@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit 42922105beb14c2fc58185ea022b9f72fb5465e9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
