Received: from eggs.gnu.org ([2001:4830:134:3::10]:47738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkOUs-000748-Ak
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkOUq-0003p4-RO
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:51:06 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 31 Jul 2018 08:50:57 +0200
Message-Id: <20180731065057.23710-2-cohuck@redhat.com>
In-Reply-To: <20180731065057.23710-1-cohuck@redhat.com>
References: <20180731065057.23710-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 1/1] s390x/sclp: fix maxram calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We clamp down ram_size to match the sclp increment size. We do
not do the same for maxram_size, which means for large guests
with some sizes (e.g. -m 50000) maxram_size differs from ram_size.
This can break other code (e.g. CMMA migration) which uses maxram_size
to calculate the number of pages and then throws some errors.

Fixes: 82fab5c5b90e468f3e9d54c ("s390x/sclp: remove memory hotplug support")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: qemu-stable@nongnu.org
CC: David Hildenbrand <david@redhat.com>
Message-Id: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index bd2a024efd..4510a800cb 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -320,6 +320,7 @@ static void sclp_memory_init(SCLPDevice *sclp)
     initial_mem = initial_mem >> increment_size << increment_size;
 
     machine->ram_size = initial_mem;
+    machine->maxram_size = initial_mem;
     /* let's propagate the changed ram size into the global variable. */
     ram_size = initial_mem;
 }
-- 
2.14.4
