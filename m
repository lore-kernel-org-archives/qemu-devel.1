Received: from eggs.gnu.org ([2001:4830:134:3::10]:41978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R9-0002Bs-Fq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qy-0005Kb-AP
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47344
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qx-0005JU-VY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WwV084339
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:51 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2abd3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:51 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:50 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:42 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-79-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 78/81] scsi: mptsas: fix the wrong reading size
 in fetch request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>, Paolo Bonzini <pbonzini@redhat.com>

From: Li Qiang <liq3ea@gmail.com>

When fetching request, it should read sizeof(*hdr), not the
pointer hdr.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-Id: <1489488980-130668-1-git-send-email-liqiang6-s@360.cn>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b01a2d07c963e96dbd151f0db1eaa06f273acf34)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/mptsas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index ad87e78..421955b 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -756,7 +756,7 @@ static void mptsas_fetch_request(MPTSASState *s)
 
     /* Read the message header from the guest first. */
     addr = s->host_mfa_high_addr | MPTSAS_FIFO_GET(s, request_post);
-    pci_dma_read(pci, addr, req, sizeof(hdr));
+    pci_dma_read(pci, addr, req, sizeof(*hdr));
 
     if (hdr->Function < ARRAY_SIZE(mpi_request_sizes) &&
         mpi_request_sizes[hdr->Function]) {
@@ -766,8 +766,8 @@ static void mptsas_fetch_request(MPTSASState *s)
          */
         size = mpi_request_sizes[hdr->Function];
         assert(size <= MPTSAS_MAX_REQUEST_SIZE);
-        pci_dma_read(pci, addr + sizeof(hdr), &req[sizeof(hdr)],
-                     size - sizeof(hdr));
+        pci_dma_read(pci, addr + sizeof(*hdr), &req[sizeof(*hdr)],
+                     size - sizeof(*hdr));
     }
 
     if (hdr->Function == MPI_FUNCTION_SCSI_IO_REQUEST) {
-- 
2.7.4
