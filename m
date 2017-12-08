Received: from eggs.gnu.org ([2001:4830:134:3::10]:45845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNCC5-0008V1-66
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNCC1-0002Yn-BI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eNCC1-0002XX-4w
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:31:29 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  8 Dec 2017 07:31:13 +0100
Message-Id: <20171208063113.20383-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2] msix: don't mask already masked vectors on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, geoff@hostfission.com, mst@redhat.com, alex.williamson@redhat.com

msix_mask_all() is supposed to invoke the release vector notifier if the state of the
respective vector changed from unmasked to masked. The way it's currently called from
msix_reset(), though, may result in calling the release notifier even if the vector
is already masked.

1) msix_reset() clears out the msix_cap field and the msix_table.
2) msix_mask_all() runs with was_masked=false for all vectors because of 1), which
   results in calling the release notifier on all vectors.
3) if msix_reset() is subsequently called again, it goes through the same steps and
   calls the release notifier on all vectors again.

This commit moves msix_mask_all() up so it runs before the device state is lost. And
it adds an assignment to msix_function_masked so that the device remembers that
MSI-X is masked.

This is likely a low impact issue, found while debugging an already broken device. It
is however easy to fix and the expectation that the use and release notifier invocations
are always balanced is very natural.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---

v1->v2:
* fixed typo in commit message "or" -> "to" (Marcel)
* directly set msix_function_masked to true instead of calling
  msix_update_function_masked() (Marcel)


 hw/pci/msix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index c944c02135..d6a4dbdb6b 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -500,11 +500,12 @@ void msix_reset(PCIDevice *dev)
         return;
     }
     msix_clear_all_vectors(dev);
+    msix_mask_all(dev, dev->msix_entries_nr);
     dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET] &=
 	    ~dev->wmask[dev->msix_cap + MSIX_CONTROL_OFFSET];
     memset(dev->msix_table, 0, dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE);
     memset(dev->msix_pba, 0, QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8);
-    msix_mask_all(dev, dev->msix_entries_nr);
+    dev->msix_function_masked = true;
 }
 
 /* PCI spec suggests that devices make it possible for software to configure
-- 
2.13.6
