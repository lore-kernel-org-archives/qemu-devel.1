Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RB-0004GE-6C
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R7-00028C-6H
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R5-00021E-33
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1EB42DF94
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:53:06 +0200
Message-Id: <20181015115309.17089-33-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 32/35] vl: Assert drive_new() does not fail
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
