Received: from eggs.gnu.org ([2001:4830:134:3::10]:38192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPo-0002PR-S5
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPm-0003C3-BN
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEZPl-0002xI-TK
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BF02300206F
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 Oct 2018 14:34:07 +0200
Message-Id: <20181022123413.28044-35-armbru@redhat.com>
In-Reply-To: <20181022123413.28044-1-armbru@redhat.com>
References: <20181022123413.28044-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 34/40] vl: Assert drive_new() does not fail in
 default_drive()
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
Message-Id: <20181017082702.5581-33-armbru@redhat.com>
---
 vl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 7cd35d2c37..fbbae766d5 100644
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
2.17.2
