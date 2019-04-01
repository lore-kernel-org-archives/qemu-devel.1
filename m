Received: from eggs.gnu.org ([209.51.188.92]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB456-0001qn-V5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB455-0003ld-PU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB455-0003ep-Bh
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1oNH061926
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:48 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s2jh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:47 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:46 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:40 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-67-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 66/97] vfio-helpers: Fix qemu_vfio_open_pci()
 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Markus Armbruster <armbru@redhat.com>

qemu_vfio_open_common() initializes s->lock only after passing s to
qemu_vfio_dma_map() via qemu_vfio_init_ramblock().
qemu_vfio_dma_map() tries to lock the uninitialized lock and crashes.

Fix by initializing s->lock first.

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1645840
Fixes: 418026ca43bc2626db092d7558258f9594366f28
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20181127084143.1113-1-armbru@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 549b50a31d28f2687a47e827a1e17300784a2c44)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 util/vfio-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 1d9272efa4..cccc9cd42e 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -411,13 +411,13 @@ static int qemu_vfio_init_ramblock(const char *block_name, void *host_addr,
 
 static void qemu_vfio_open_common(QEMUVFIOState *s)
 {
+    qemu_mutex_init(&s->lock);
     s->ram_notifier.ram_block_added = qemu_vfio_ram_block_added;
     s->ram_notifier.ram_block_removed = qemu_vfio_ram_block_removed;
     ram_block_notifier_add(&s->ram_notifier);
     s->low_water_mark = QEMU_VFIO_IOVA_MIN;
     s->high_water_mark = QEMU_VFIO_IOVA_MAX;
     qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
-    qemu_mutex_init(&s->lock);
 }
 
 /**
-- 
2.17.1
