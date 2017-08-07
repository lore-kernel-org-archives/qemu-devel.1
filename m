Received: from eggs.gnu.org ([2001:4830:134:3::10]:49071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ8-0007RR-WF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIs-0003xG-SM
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:33 +0200
Message-Id: <1502117160-24655-30-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 29/56] block: Make BlockDirtyInfo byte
 count unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Byte counts should use QAPI type 'size' (uint64_t).  BlockDirtyInfo
member @count is 'int' (int64_t).  bdrv_query_dirty_bitmaps() computes
@count from bdrv_get_dirty_count() in uint64_t, then implicitly
converts to int64_t.  Before the commit before previous, the
conversion was in bdrv_get_dirty_count() instead.

Change member @count to 'size'.

query-block now reports @count values above 2^63-1 correctly instead
of their (negative) two's complement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1c4a08d..60e1b6f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -418,7 +418,7 @@
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
-  'data': {'*name': 'str', 'count': 'int', 'granularity': 'size',
+  'data': {'*name': 'str', 'count': 'size', 'granularity': 'size',
            'status': 'DirtyBitmapStatus'} }
 
 ##
-- 
2.7.5
