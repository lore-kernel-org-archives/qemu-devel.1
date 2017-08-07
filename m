Received: from eggs.gnu.org ([2001:4830:134:3::10]:48747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIt-00079E-Tl
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIe-0003mD-DQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:47 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:20 +0200
Message-Id: <1502117160-24655-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 16/56] migration: Make XBZRLE transferred
 size unsigned in QAPI/QMP
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

Sizes should use QAPI type 'size' (uint64_t).  XBZRLECacheStats member
@bytes is 'int' (int64_t).  save_xbzrle_page() computes the byte count
increment in size_t, implicitly converts it to int, then adds that to
@bytes.

Change the XBZRLECacheStats member to 'size' and clean up
save_xbzrle_page().

query-migrate now reports transferred sizes above 2^63-1 correctly
instead of their (negative) two's complement.

HMP's "info migrate" already reported them correctly, because it
printed the signed integer with PRIu64.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/ram.c  | 3 ++-
 qapi-schema.json | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ce38be4..5c247f8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -461,7 +461,8 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
                             ram_addr_t current_addr, RAMBlock *block,
                             ram_addr_t offset, bool last_stage)
 {
-    int encoded_len = 0, bytes_xbzrle;
+    int encoded_len;
+    size_t bytes_xbzrle;
     uint8_t *prev_cached_page;
 
     if (!cache_is_cached(XBZRLE.cache, current_addr,
diff --git a/qapi-schema.json b/qapi-schema.json
index ecabff6..4a3d07e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -646,7 +646,7 @@
 # Since: 1.2
 ##
 { 'struct': 'XBZRLECacheStats',
-  'data': {'cache-size': 'size', 'bytes': 'int', 'pages': 'int',
+  'data': {'cache-size': 'size', 'bytes': 'size', 'pages': 'int',
            'cache-miss': 'int', 'cache-miss-rate': 'number',
            'overflow': 'int' } }
 
-- 
2.7.5
