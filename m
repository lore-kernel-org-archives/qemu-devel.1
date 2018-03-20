Received: from eggs.gnu.org ([2001:4830:134:3::10]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyGa7-00028n-7y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyGa3-0006Rn-Gh
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyGa3-0006RX-BQ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:31 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 20 Mar 2018 12:41:16 +0000
Message-Id: <20180320124117.40573-2-dgilbert@redhat.com>
In-Reply-To: <20180320124117.40573-1-dgilbert@redhat.com>
References: <20180320124117.40573-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] HMP: Initialize err before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, jixiang_zhang@h3c.com

From: zhangjixiang <jixiang_zhang@h3c.com>

When bdrv_snapshot_delete return fail, the errp will not be
assigned a valid value in error_propagate as errp didn't be
initialized in hmp_delvm, then error_reportf_err will use an
uninitialized value(call by hmp_delvm), and qemu crash.

Signed-off-by: zhangjixiang <jixiang_zhang@h3c.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index ba9e299ee2..fd13d5b56a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1321,7 +1321,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 void hmp_delvm(Monitor *mon, const QDict *qdict)
 {
     BlockDriverState *bs;
-    Error *err;
+    Error *err = NULL;
     const char *name = qdict_get_str(qdict, "name");
 
     if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
-- 
2.14.3
