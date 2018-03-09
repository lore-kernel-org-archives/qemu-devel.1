Received: from eggs.gnu.org ([2001:4830:134:3::10]:47760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfN-0005fE-Ll
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfK-0001oA-Ej
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40776
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1euMfK-0001nr-9v
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29IKJSO069746
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 13:22:49 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gkuqx9w10-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:22:49 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 13:22:48 -0500
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Fri,  9 Mar 2018 15:22:00 -0300
In-Reply-To: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180309182202.31206-5-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/5] block/blkreplay: Remove protocol-related
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

The blkreplay driver is not a protocol so it should implement bdrv_open
instead of bdrv_file_open and not provide a protocol_name.

Attempts to invoke this driver using protocol syntax
(i.e. blkreplay:<filename:options:...>) will now fail gracefully:

  $ qemu-img info blkreplay:foo
  qemu-img: Could not open 'blkreplay:foo': Unknown protocol 'blkreplay'

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
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
