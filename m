Received: from eggs.gnu.org ([2001:4830:134:3::10]:52494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj569-0005C1-R6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj565-0004Ak-VF
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj565-0004A8-PM
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31182402346C
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 15:56:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-135.ams2.redhat.com
	[10.36.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DEF9B2156897
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 15:56:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:56:02 +0200
Message-Id: <20180727155602.10148-4-armbru@redhat.com>
In-Reply-To: <20180727155602.10148-1-armbru@redhat.com>
References: <20180727155602.10148-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] qstring: Move qstring_from_substr()'s @end
 one to the right
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qstring_from_substr() takes the index of the substring's first and
last character.  qstring_from_substr(s, 0, SIZE_MAX) denotes an empty
substring.  Awkward.

Shift the end index one to the right.  This simplifies both
qstring_from_substr() and its callers.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180727062204.10401-3-armbru@redhat.com>
---
 block/blkdebug.c      | 2 +-
 block/blkverify.c     | 2 +-
 block/nbd.c           | 2 +-
 qobject/qstring.c     | 6 +++---
 tests/check-qobject.c | 2 +-
 tests/check-qstring.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 0457bf5b66..0759452925 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -305,7 +305,7 @@ static void blkdebug_parse_filename(const char *filename, QDict *options,
 
     if (c != filename) {
         QString *config_path;
-        config_path = qstring_from_substr(filename, 0, c - filename - 1);
+        config_path = qstring_from_substr(filename, 0, c - filename);
         qdict_put(options, "config", config_path);
     }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index da97ee5927..89bf4386e3 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -80,7 +80,7 @@ static void blkverify_parse_filename(const char *filename, QDict *options,
     }
 
     /* TODO Implement option pass-through and set raw.filename here */
-    raw_path = qstring_from_substr(filename, 0, c - filename - 1);
+    raw_path = qstring_from_substr(filename, 0, c - filename);
     qdict_put(options, "x-raw", raw_path);
 
     /* TODO Allow multi-level nesting and set file.filename here */
diff --git a/block/nbd.c b/block/nbd.c
index b198ad775f..e87699fb73 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -109,7 +109,7 @@ static int nbd_parse_uri(const char *filename, QDict *options)
         /* strip braces from literal IPv6 address */
         if (uri->server[0] == '[') {
             host = qstring_from_substr(uri->server, 1,
-                                       strlen(uri->server) - 2);
+                                       strlen(uri->server) - 1);
         } else {
             host = qstring_from_str(uri->server);
         }
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 1bb7784a88..0f1510e792 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -41,12 +41,12 @@ QString *qstring_from_substr(const char *str, size_t start, size_t end)
 {
     QString *qstring;
 
-    assert(start <= end + 1);
+    assert(start <= end);
 
     qstring = g_malloc(sizeof(*qstring));
     qobject_init(QOBJECT(qstring), QTYPE_QSTRING);
 
-    qstring->length = end - start + 1;
+    qstring->length = end - start;
     qstring->capacity = qstring->length;
 
     assert(qstring->capacity < SIZE_MAX);
@@ -64,7 +64,7 @@ QString *qstring_from_substr(const char *str, size_t start, size_t end)
  */
 QString *qstring_from_str(const char *str)
 {
-    return qstring_from_substr(str, 0, strlen(str) - 1);
+    return qstring_from_substr(str, 0, strlen(str));
 }
 
 static void capacity_increase(QString *qstring, size_t len)
diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 16ccbde82c..593c3a0618 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -154,7 +154,7 @@ static void qobject_is_equal_string_test(void)
     str_case = qstring_from_str("Foo");
 
     /* Should yield "foo" */
-    str_built = qstring_from_substr("form", 0, 1);
+    str_built = qstring_from_substr("form", 0, 2);
     qstring_append_chr(str_built, 'o');
 
     check_unequal(str_base, str_whitespace_0, str_whitespace_1,
diff --git a/tests/check-qstring.c b/tests/check-qstring.c
index f11a7a8605..2d079921e3 100644
--- a/tests/check-qstring.c
+++ b/tests/check-qstring.c
@@ -66,7 +66,7 @@ static void qstring_from_substr_test(void)
 {
     QString *qs;
 
-    qs = qstring_from_substr("virtualization", 3, 9);
+    qs = qstring_from_substr("virtualization", 3, 10);
     g_assert(qs != NULL);
     g_assert(strcmp(qstring_get_str(qs), "tualiza") == 0);
 
-- 
2.17.1
