Received: from eggs.gnu.org ([2001:4830:134:3::10]:47682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfH-0005Xj-HV
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfF-0001lK-4D
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1euMfE-0001ku-Sy
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:45 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29IKJVZ140273
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 13:22:43 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gku3aksjs-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:22:43 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 13:22:41 -0500
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Fri,  9 Mar 2018 15:21:58 -0300
In-Reply-To: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180309182202.31206-3-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/5] block/quorum: Remove protocol-related
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
