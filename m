Received: from eggs.gnu.org ([2001:4830:134:3::10]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGk-0002z3-Sj
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGg-0001bR-Cn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfGg-0001a6-73
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36C5B81DEF
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 18:41:41 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Sep 2017 19:41:26 +0100
Message-Id: <20170906184133.25524-2-dgilbert@redhat.com>
In-Reply-To: <20170906184133.25524-1-dgilbert@redhat.com>
References: <20170906184133.25524-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] migration: Report when bdrv_inactivate_all
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, armbru@redhat.com, kwolf@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

If the bdrv_inactivate_all fails near the end of the migration,
the migration will fail and often the only diagnostics in the log
are an I/O error which you can't distinguish from an error on
the socket connection.

Add an error so we know when it's actually a block problem.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170822170212.27347-1-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index fdd15fa0a7..7a55023d1a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1157,6 +1157,8 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
          * bdrv_invalidate_cache_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
         if (ret) {
+            error_report("%s: bdrv_inactivate_all() failed (%d)",
+                         __func__, ret);
             qemu_file_set_error(f, ret);
             return ret;
         }
-- 
2.13.5
