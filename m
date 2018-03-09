Received: from eggs.gnu.org ([2001:4830:134:3::10]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfJ-0005ZV-GM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfF-0001le-Eu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1euMfF-0001l8-7C
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:45 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29IKq23145734
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 13:22:44 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gkyfd02dy-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:22:43 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 13:22:42 -0500
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Fri,  9 Mar 2018 15:21:59 -0300
In-Reply-To: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180309182202.31206-4-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/5] block/throttle: Remove protocol-related
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

The throttle driver is not a protocol so it should implement bdrv_open
instead of bdrv_file_open and not provide a protocol_name.

Attempts to invoke this driver using protocol syntax
(i.e. throttle:<filename:options:...>) will now fail gracefully:

  $ qemu-img info throttle:foo
  qemu-img: Could not open 'throttle:foo': Unknown protocol 'throttle'

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
---
 block/throttle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/throttle.c b/block/throttle.c
index 5f4d43d0fc..95ed06acd8 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -215,10 +215,9 @@ static void coroutine_fn throttle_co_drain_end(BlockDriverState *bs)
 
 static BlockDriver bdrv_throttle = {
     .format_name                        =   "throttle",
-    .protocol_name                      =   "throttle",
     .instance_size                      =   sizeof(ThrottleGroupMember),
 
-    .bdrv_file_open                     =   throttle_open,
+    .bdrv_open                          =   throttle_open,
     .bdrv_close                         =   throttle_close,
     .bdrv_co_flush                      =   throttle_co_flush,
 
-- 
2.13.6
