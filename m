Received: from eggs.gnu.org ([2001:4830:134:3::10]:55884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVcF-0006FM-1P
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVcA-000142-RG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39200
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1evVcA-00013q-M2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2CM4lEN059777
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:18 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gp003mgmx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:17 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Mon, 12 Mar 2018 18:08:17 -0400
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 19:07:52 -0300
In-Reply-To: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
References: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180312220753.20096-5-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/5] block/blkreplay: Remove
 protocol-related fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

The blkreplay driver is not a protocol so it should implement bdrv_open
instead of bdrv_file_open and not provide a protocol_name.

Attempts to invoke this driver using protocol syntax
(i.e. blkreplay:<filename:options:...>) will now fail gracefully:

  $ qemu-img info blkreplay:foo
  qemu-img: Could not open 'blkreplay:foo': Unknown protocol 'blkreplay'

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Reviewed-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/blkreplay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index 61e44a1949..fe5a9b4a98 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -129,10 +129,9 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
 
 static BlockDriver bdrv_blkreplay = {
     .format_name            = "blkreplay",
-    .protocol_name          = "blkreplay",
     .instance_size          = 0,
 
-    .bdrv_file_open         = blkreplay_open,
+    .bdrv_open              = blkreplay_open,
     .bdrv_close             = blkreplay_close,
     .bdrv_child_perm        = bdrv_filter_default_perms,
     .bdrv_getlength         = blkreplay_getlength,
-- 
2.13.6
