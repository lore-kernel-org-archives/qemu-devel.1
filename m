Received: from eggs.gnu.org ([2001:4830:134:3::10]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRr-0004EZ-Ma
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRq-0000ip-Mx
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRq-0000iU-II
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:34 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:12 +0100
Message-Id: <20180615151518.83637-5-dgilbert@redhat.com>
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 04/10] migration/block-dirty-bitmap: fix
 dirty_bitmap_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

dirty_bitmap_load_header return code is obtained but not handled. Fix
this.

Bug was introduced in b35ebdf076d697bc
"migration: add postcopy migration of dirty bitmaps" with the whole
function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180530112424.204835-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/block-dirty-bitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index eeccaff34b..3bafbbdc4c 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -672,6 +672,9 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 
     do {
         ret = dirty_bitmap_load_header(f, &s);
+        if (ret < 0) {
+            return ret;
+        }
 
         if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
             ret = dirty_bitmap_load_start(f, &s);
-- 
2.17.1
