Received: from eggs.gnu.org ([2001:4830:134:3::10]:37482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gEyht-0007NI-M3
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gEyWl-0001P9-WB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gEyWi-0001LN-CC
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:23:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 23 Oct 2018 17:23:00 +0200
Message-Id: <20181023152306.3123-2-david@redhat.com>
In-Reply-To: <20181023152306.3123-1-david@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

The qemu api claims to be easier to use, and the resulting code seems to
agree.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi/string-input-visitor.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index b3fdd0827d..c1454f999f 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -20,6 +20,7 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/range.h"
+#include "qemu/cutils.h"
 
 
 struct StringInputVisitor
@@ -46,10 +47,10 @@ static void free_range(void *range, void *dummy)
 
 static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
 {
-    char *str = (char *) siv->string;
-    long long start, end;
+    const char *str = (char *) siv->string;
+    const char *endptr;
+    int64_t start, end;
     Range *cur;
-    char *endptr;
 
     if (siv->ranges) {
         return 0;
@@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
     }
 
     do {
-        errno = 0;
-        start = strtoll(str, &endptr, 0);
-        if (errno == 0 && endptr > str) {
+        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
             if (*endptr == '\0') {
                 cur = g_malloc0(sizeof(*cur));
                 range_set_bounds(cur, start, start);
@@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
                 str = NULL;
             } else if (*endptr == '-') {
                 str = endptr + 1;
-                errno = 0;
-                end = strtoll(str, &endptr, 0);
-                if (errno == 0 && endptr > str && start <= end &&
-                    (start > INT64_MAX - 65536 ||
-                     end < start + 65536)) {
+                if (!qemu_strtoi64(str, &endptr, 0, &end) && start < end) {
                     if (*endptr == '\0') {
                         cur = g_malloc0(sizeof(*cur));
                         range_set_bounds(cur, start, end);
-- 
2.17.1
