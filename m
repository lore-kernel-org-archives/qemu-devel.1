Received: from eggs.gnu.org ([2001:4830:134:3::10]:37217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnhPk-00045c-Lt
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnhPj-0006km-Or
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:40 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2017 16:02:28 +0800
Message-Id: <1489478550-19431-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489478550-19431-1-git-send-email-jasowang@redhat.com>
References: <1489478550-19431-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] e1000e: correctly tear down MSI-X memory
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

MSI-X has been disabled by the time the e1000e device is unrealized, hence
msix_uninit is never called.  This causes the object to be leaked, which
shows up as a RAMBlock with empty name when attempting migration.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index b0f429b..6e23493 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -306,7 +306,7 @@ e1000e_init_msix(E1000EState *s)
 static void
 e1000e_cleanup_msix(E1000EState *s)
 {
-    if (msix_enabled(PCI_DEVICE(s))) {
+    if (msix_present(PCI_DEVICE(s))) {
         e1000e_unuse_msix_vectors(s, E1000E_MSIX_VEC_NUM);
         msix_uninit(PCI_DEVICE(s), &s->msix, &s->msix);
     }
-- 
2.7.4
