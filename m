Received: from eggs.gnu.org ([209.51.188.92]:42109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46E-0002rb-2K
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46C-0004Pu-Rs
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52606
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46C-0004Il-HY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L3sR5062192
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:57 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkskgsy1s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:51 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:29 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:25 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-52-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 51/97] block-backend: Set werror/rerror
 defaults in blk_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Currently, the default values for werror and rerror have to be set
explicitly with blk_set_on_error() by the callers of blk_new(). The only
caller actually doing this is blockdev_init(), which is called for
BlockBackends created using -drive.

In particular, anonymous BlockBackends created with
-device ...,drive=<node-name> didn't get the correct default set and
instead defaulted to the integer value 0 (= BLOCKDEV_ON_ERROR_REPORT).
This is the intended default for rerror anyway, but the default for
werror should be BLOCKDEV_ON_ERROR_ENOSPC.

Set the defaults in blk_new() instead so that they apply no matter what
way the BlockBackend was created.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
(cherry picked from commit cb53460b708db3617ab73248374d071d5552c263)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/block-backend.c      | 3 +++
 tests/qemu-iotests/067.out | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index f2f75a977d..1b27a68ae7 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -324,6 +324,9 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
+    blk->on_read_error = BLOCKDEV_ON_ERROR_REPORT;
+    blk->on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
+
     block_acct_init(&blk->stats);
 
     notifier_list_init(&blk->remove_bs_notifiers);
diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
index 2e71cff3ce..b10c71db03 100644
--- a/tests/qemu-iotests/067.out
+++ b/tests/qemu-iotests/067.out
@@ -385,6 +385,7 @@ Testing: -device virtio-scsi -device scsi-cd,id=cd0
 {
     "return": [
         {
+            "io-status": "ok",
             "device": "",
             "locked": false,
             "removable": true,
-- 
2.17.1
