Received: from eggs.gnu.org ([2001:4830:134:3::10]:49373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJL-0007iD-VJ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ6-000494-31
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:16 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:59 +0200
Message-Id: <1502117160-24655-56-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 55/56] block: Make MapEntry offsets and
 size unsigned in QAPI
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

File offsets and sizes use QAPI type 'size' (uint64_t).  MapEntry
members @start, @length and @offset are 'int' (int64_t).
get_block_status() sets @start and @length to unsigned long long
values, and @offset to a non-negative int64_t value.

Change these MapEntry members to 'size'.

"qemu-img map" now reports them correctly above 2^63-1 instead of
their (negative) two's complement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 4 ++--
 qemu-img.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3482f8c..6f62723 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -236,8 +236,8 @@
 #
 ##
 { 'struct': 'MapEntry',
-  'data': {'start': 'int', 'length': 'int', 'data': 'bool',
-           'zero': 'bool', 'depth': 'int', '*offset': 'int',
+  'data': {'start': 'size', 'length': 'size', 'data': 'bool',
+           'zero': 'bool', 'depth': 'int', '*offset': 'size',
            '*filename': 'str' } }
 
 ##
diff --git a/qemu-img.c b/qemu-img.c
index cf3ef3e..1c783c7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2655,14 +2655,14 @@ static void dump_map_entry(OutputFormat output_format, MapEntry *e,
         }
         break;
     case OFORMAT_JSON:
-        printf("%s{ \"start\": %"PRId64", \"length\": %"PRId64","
+        printf("%s{ \"start\": %" PRIu64 ", \"length\": %" PRIu64 ","
                " \"depth\": %"PRId64", \"zero\": %s, \"data\": %s",
                (e->start == 0 ? "[" : ",\n"),
                e->start, e->length, e->depth,
                e->zero ? "true" : "false",
                e->data ? "true" : "false");
         if (e->has_offset) {
-            printf(", \"offset\": %"PRId64"", e->offset);
+            printf(", \"offset\": %" PRIu64, e->offset);
         }
         putchar('}');
 
-- 
2.7.5
