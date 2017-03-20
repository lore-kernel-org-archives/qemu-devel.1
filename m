Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qo-0001o9-S9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qi-00050u-IW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qi-00050C-9e
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8YDj025846
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:35 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak1xpmb8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:35 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:34 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:10 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-47-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 46/81] exec: Add missing rcu_read_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Roman Kapl <rka@sysgo.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Roman Kapl <rka@sysgo.com>

rcu_read_unlock was not called if the address_space_access_valid result is
negative.

This caused (at least) a problem when qemu on PPC/E500+TAP failed to terminate
properly and instead got stuck in a deadlock.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Message-Id: <20170109110921.4931-1-rka@sysgo.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5ad4a2b75f85dd854a781a6e03b90320cb3441d3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index 08c558e..6fda455 100644
--- a/exec.c
+++ b/exec.c
@@ -2927,6 +2927,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write)) {
+                rcu_read_unlock();
                 return false;
             }
         }
-- 
2.7.4
