Received: from eggs.gnu.org ([2001:4830:134:3::10]:48906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCA-0000Cd-83
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC7-0000H7-35
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC6-0000Fe-Qj
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFWWH046742
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:19 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epky0qqnq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:19 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:18 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:10 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-18-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 17/55] memory: Move
 address_space_update_ioeventfds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

So it is called (twice) from the same function. This is to make the next
patches a bit simpler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-12-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 02218487649558ed66c3689d4cc55250a42601d8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 8034520148..1f58d29755 100644
--- a/memory.c
+++ b/memory.c
@@ -951,8 +951,6 @@ static void address_space_update_topology(AddressSpace *as)
      * counting is necessary.
      */
     flatview_unref(old_view);
-
-    address_space_update_ioeventfds(as);
 }
 
 void memory_region_transaction_begin(void)
@@ -975,6 +973,7 @@ void memory_region_transaction_commit(void)
 
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_topology(as);
+                address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
-- 
2.11.0
