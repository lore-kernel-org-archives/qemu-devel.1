Received: from eggs.gnu.org ([2001:4830:134:3::10]:40354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSo-0008G9-0t
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSk-0001df-WD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmSk-0001cO-Mq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5rdfB038809
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:08 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sn43a25x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:08 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:05 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 16:59:57 +1100
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Message-Id: <983a6cd6c33f273c0bcb7cb6632a8c23626d9fda.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 04/12] Move virtio_mmio.h to fix
 update-linux-headers.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com

Currently, running update-linux-headers.sh will produce a patch that
deletes virtio_mmio.h, which is still needed. This happens because
virtio_mmio.h is in the directory used to store headers from the linux
kernel that are copied by the kernel's "make headers_install" target
(used by the update script) but it is not one of the files in that
set.

Fix this by moving that file into a new directory.

In the future if that file is added to the "headers_install" target
then this change should be reverted.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:
* FWIW, here's one way of fixing it.

 hw/virtio/virtio-mmio.c                                          | 2 +-
 include/{standard-headers => kernel-headers}/linux/virtio_mmio.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/{standard-headers => kernel-headers}/linux/virtio_mmio.h (100%)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..cc6afa9da1 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "standard-headers/linux/virtio_mmio.h"
+#include "kernel-headers/linux/virtio_mmio.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/host-utils.h"
diff --git a/include/standard-headers/linux/virtio_mmio.h b/include/kernel-headers/linux/virtio_mmio.h
similarity index 100%
rename from include/standard-headers/linux/virtio_mmio.h
rename to include/kernel-headers/linux/virtio_mmio.h
-- 
2.11.0
