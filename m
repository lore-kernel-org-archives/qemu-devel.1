Received: from eggs.gnu.org ([2001:4830:134:3::10]:36732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9i-0003XX-Rf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9f-0006e0-L1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:38 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:12 +0100
Message-Id: <1489508300-48184-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/18] scsi: mptsas: fix the wrong reading size
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
Cc: Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>, qemu-stable@nongnu.org

From: Li Qiang <liq3ea@gmail.com>

When fetching request, it should read sizeof(*hdr), not the
pointer hdr.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-Id: <1489488980-130668-1-git-send-email-liqiang6-s@360.cn>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
