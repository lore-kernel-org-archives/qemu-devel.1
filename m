Received: from eggs.gnu.org ([2001:4830:134:3::10]:55141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cqfVl-0006Tp-MS
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cqfVg-0007hh-QP
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:37:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cqfVg-0007gv-Hl
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:37:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2MCY7pr140655
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:37:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vjt15j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:37:01 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 22 Mar 2017 12:36:58 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 22 Mar 2017 13:36:55 +0100
Message-Id: <20170322123655.32085-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] cryptodev: fix asserting single queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

We already check for queues == 1 in cryptodev_builtin_init and when that
is not true raise an error. But before that error is reported the
assertion in cryptodev_builtin_cleanup kicks in (because object is being
finalized and freed).

Let's remove assert(queues == 1) form cryptodev_builtin_cleanup as it
does only harm and no good.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 backends/cryptodev-builtin.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 82a068e..137c7a6 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -359,8 +359,6 @@ static void cryptodev_builtin_cleanup(
         }
     }
 
-    assert(queues == 1);
-
     for (i = 0; i < queues; i++) {
         cc = backend->conf.peers.ccs[i];
         if (cc) {
-- 
2.8.4
