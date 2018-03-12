Received: from eggs.gnu.org ([2001:4830:134:3::10]:55786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVc9-00069c-5V
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVc4-000115-CR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53184
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1evVc4-00010Y-8E
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2CM57Pq109425
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:11 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gp1c1hbp6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:11 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Mon, 12 Mar 2018 18:08:10 -0400
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 19:07:50 -0300
In-Reply-To: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
References: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180312220753.20096-3-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/5] block/quorum: Remove protocol-related
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Alberto Garcia <berto@igalia.com>

The quorum driver is not a protocol so it should implement bdrv_open
instead of bdrv_file_open and not provide a protocol_name.

Attempts to invoke this driver using protocol syntax
(i.e. quorum:<filename:options:...>) will now fail gracefully:

  $ qemu-img info quorum:foo
  qemu-img: Could not open 'quorum:foo': Unknown protocol 'quorum'

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 14333c18aa..cfe484a945 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1098,11 +1098,10 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
 
 static BlockDriver bdrv_quorum = {
     .format_name                        = "quorum",
-    .protocol_name                      = "quorum",
 
     .instance_size                      = sizeof(BDRVQuorumState),
 
-    .bdrv_file_open                     = quorum_open,
+    .bdrv_open                          = quorum_open,
     .bdrv_close                         = quorum_close,
     .bdrv_refresh_filename              = quorum_refresh_filename,
 
-- 
2.13.6
