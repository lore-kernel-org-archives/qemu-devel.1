Received: from eggs.gnu.org ([2001:4830:134:3::10]:49570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7M-0005iV-UV
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7J-0000ok-Uu
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:25 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 13:57:58 +0800
Message-Id: <20180509055802.28423-2-famz@redhat.com>
In-Reply-To: <20180509055802.28423-1-famz@redhat.com>
References: <20180509055802.28423-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] qapi: Add qapi_enum_parse_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This variant of qapi_enum_parse can do case insensitive compare.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qapi/util.h |  2 ++
 qapi/qapi-util.c    | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index a7c3c64148..2cec231919 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -19,6 +19,8 @@ typedef struct QEnumLookup {
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
 int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
                     int def, Error **errp);
+int qapi_enum_parse_full(const QEnumLookup *lookup, const char *buf,
+                         int def, bool ignore_case, Error **errp);
 
 int parse_qapi_name(const char *name, bool complete);
 
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index e9b266bb70..6180957edb 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -21,8 +21,8 @@ const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
     return lookup->array[val];
 }
 
-int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
-                    int def, Error **errp)
+int qapi_enum_parse_full(const QEnumLookup *lookup, const char *buf,
+                         int def, bool ignore_case, Error **errp)
 {
     int i;
 
@@ -31,8 +31,14 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
     }
 
     for (i = 0; i < lookup->size; i++) {
-        if (!strcmp(buf, lookup->array[i])) {
-            return i;
+        if (ignore_case) {
+            if (!strcasecmp(buf, lookup->array[i])) {
+                return i;
+            }
+        } else {
+            if (!strcmp(buf, lookup->array[i])) {
+                return i;
+            }
         }
     }
 
@@ -40,6 +46,12 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
     return def;
 }
 
+int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
+                    int def, Error **errp)
+{
+    return qapi_enum_parse_full(lookup, buf, def, false, errp);
+}
+
 /*
  * Parse a valid QAPI name from @str.
  * A valid name consists of letters, digits, hyphen and underscore.
-- 
2.14.3
