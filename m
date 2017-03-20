Received: from eggs.gnu.org ([2001:4830:134:3::10]:42011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6RA-0002Ci-3x
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qy-0005LD-Uj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qy-0005Jc-I8
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8YBR020629
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:51 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 299yqc6yy0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:51 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:50 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:41 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-78-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 77/81] e1000e: correctly tear down MSI-X memory
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

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
(cherry picked from commit 7ec7ae4b973d1471f6f39fc2b6481f69c2b39593)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/e1000e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 4994e1c..509f2a0 100644
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
