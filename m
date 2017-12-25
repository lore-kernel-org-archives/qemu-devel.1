Received: from eggs.gnu.org ([2001:4830:134:3::10]:59373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eTIoN-0006mD-Lw
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eTIoJ-0003IM-2C
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:48:19 -0500
Received: from [45.249.212.35] (port=52234 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1eTIoI-0003HH-Le
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:48:14 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 25 Dec 2017 10:47:04 +0800
Message-ID: <20171225024704.19540-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] irq: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, peterx@redhat.com, mst@redhat.com, pbonzini@redhat.com, linzhecheng <linzhecheng@huawei.com>

entry is moved from list but is not freed.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 351b64f77c..3c920db79a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3494,6 +3494,7 @@ int kvm_arch_release_virq_post(int virq)
         if (entry->virq == virq) {
             trace_kvm_x86_remove_msi_route(virq);
             QLIST_REMOVE(entry, list);
+            g_free(entry);
             break;
         }
     }
-- 
2.12.2.windows.2
