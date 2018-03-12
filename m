Received: from eggs.gnu.org ([2001:4830:134:3::10]:55823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVcB-0006BJ-1e
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVc9-00013X-Ny
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1evVc9-00012s-FS
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2CM4k2C117932
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gnxck082h-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:16 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Mon, 12 Mar 2018 18:08:15 -0400
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 19:07:51 -0300
In-Reply-To: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
References: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180312220753.20096-4-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/5] block/throttle: Remove protocol-related
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
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
