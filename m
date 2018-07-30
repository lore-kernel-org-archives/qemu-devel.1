Received: from eggs.gnu.org ([2001:4830:134:3::10]:56115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fk8rl-0003jx-Js
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fk8rg-00040z-0e
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:09:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fk8rf-0003yK-N2
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:09:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6UE7L2P027836
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:09:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kj1b0g1wd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:09:33 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Jul 2018 15:09:31 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Jul 2018 16:09:26 +0200
Message-Id: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 1/1] s390x/sclp: fix maxram calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, imbrenda@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>

We clamp down ram_size to match the sclp increment size. We do
not do the same for maxram_size, which means for large guests
with some sizes (e.g. -m 50000) maxram_size differs from ram_size.
This can break other code (e.g. CMMA migration) which uses maxram_size
to calculate the number of pages and then throws some errors.

Fixes: 82fab5c5b90e468f3e9d54c ("s390x/sclp: remove memory hotplug support")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: qemu-stable@nongnu.org
CC: David Hildenbrand <david@redhat.com>
---
 hw/s390x/sclp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index bd2a024..4510a80 100644
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
1.8.3.1
