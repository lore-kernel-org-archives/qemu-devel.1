Received: from eggs.gnu.org ([2001:4830:134:3::10]:44268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cnk8G-0000qS-O8
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cnk8C-0000gM-PB
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:56:48 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cnk8C-0000g4-Jd
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:56:44 -0400
Received: by mail-pg0-x242.google.com with SMTP id 77so23698623pgc.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:56:44 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 14 Mar 2017 03:56:20 -0700
Message-Id: <1489488980-130668-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH] scsi: mptsas: fix the wrong reading size in
 fetch request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

When fetching request, it should read sizeof(*hdr), not the
pointer hdr.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/scsi/mptsas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 2e091c0..765ab53 100644
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
