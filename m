Received: from eggs.gnu.org ([2001:4830:134:3::10]:56774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTMA-00065o-8A
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM8-0000Bo-2N
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM7-00008U-L2
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A732B3082DCF
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:52 +0200
Message-Id: <20181016174158.15229-33-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 32/38] vl: Assert drive_new() does not fail
 in default_drive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

If creating (empty) default drives fails, it's a bug.  Therefore,
assert() is more appropriate than exit(1).

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 vl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 2a8ef05aef..65366b961e 100644
--- a/vl.c
+++ b/vl.c
@@ -1156,9 +1156,7 @@ static void default_drive(int enable, int snapshot, BlockInterfaceType type,
     }
 
     dinfo = drive_new(opts, type);
-    if (!dinfo) {
-        exit(1);
-    }
+    assert(dinfo);
     dinfo->is_default = true;
 
 }
-- 
2.17.1
