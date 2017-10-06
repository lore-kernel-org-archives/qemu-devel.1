Received: from eggs.gnu.org ([2001:4830:134:3::10]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPp-0008JC-2e
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPo-0005r9-1n
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:27 -0300
Message-Id: <20171006235023.11952-33-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 32/88] QObject: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added qbool.c, qdict.c, qlist.c, qstring.c and tests/]
---
 qobject/json-parser.c               | 2 +-
 qobject/qbool.c                     | 2 +-
 qobject/qdict.c                     | 4 ++--
 qobject/qlist.c                     | 4 ++--
 qobject/qstring.c                   | 2 +-
 tests/test-qobject-output-visitor.c | 4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 724ca240e4..37dda9bc3f 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -247,7 +247,7 @@ static JSONParserContext *parser_context_new(GQueue *tokens)
         return NULL;
     }
 
-    ctxt = g_malloc0(sizeof(JSONParserContext));
+    ctxt = g_new0(JSONParserContext, 1);
     ctxt->buf = tokens;
 
     return ctxt;
diff --git a/qobject/qbool.c b/qobject/qbool.c
index 0606bbd2a3..5ad7f6d98f 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -25,7 +25,7 @@ QBool *qbool_from_bool(bool value)
 {
     QBool *qb;
 
-    qb = g_malloc(sizeof(*qb));
+    qb = g_new(QBool, 1);
     qobject_init(QOBJECT(qb), QTYPE_QBOOL);
     qb->value = value;
 
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 576018e531..857e71c7a1 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -30,7 +30,7 @@ QDict *qdict_new(void)
 {
     QDict *qdict;
 
-    qdict = g_malloc0(sizeof(*qdict));
+    qdict = g_new0(QDict, 1);
     qobject_init(QOBJECT(qdict), QTYPE_QDICT);
 
     return qdict;
@@ -70,7 +70,7 @@ static QDictEntry *alloc_entry(const char *key, QObject *value)
 {
     QDictEntry *entry;
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(QDictEntry, 1);
     entry->key = g_strdup(key);
     entry->value = value;
 
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 86b60cb88c..8afc594d0d 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -25,7 +25,7 @@ QList *qlist_new(void)
 {
     QList *qlist;
 
-    qlist = g_malloc(sizeof(*qlist));
+    qlist = g_new(QList, 1);
     qobject_init(QOBJECT(qlist), QTYPE_QLIST);
     QTAILQ_INIT(&qlist->head);
 
@@ -58,7 +58,7 @@ void qlist_append_obj(QList *qlist, QObject *value)
 {
     QListEntry *entry;
 
-    entry = g_malloc(sizeof(*entry));
+    entry = g_new(QListEntry, 1);
     entry->value = value;
 
     QTAILQ_INSERT_TAIL(&qlist->head, entry, next);
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 5da7b5f37c..806c0306a2 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -42,7 +42,7 @@ QString *qstring_from_substr(const char *str, int start, int end)
 {
     QString *qstring;
 
-    qstring = g_malloc(sizeof(*qstring));
+    qstring = g_new(QString, 1);
     qobject_init(QOBJECT(qstring), QTYPE_QSTRING);
 
     qstring->length = end - start + 1;
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index d375100a52..d0a66a5dca 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -182,7 +182,7 @@ static void test_visitor_out_struct_nested(TestOutputVisitorData *data,
     const char *strings[] = { "forty two", "forty three", "forty four",
                               "forty five" };
 
-    ud2 = g_malloc0(sizeof(*ud2));
+    ud2 = g_new0(UserDefTwo, 1);
     ud2->string0 = g_strdup(strings[0]);
 
     ud2->dict1 = g_malloc0(sizeof(*ud2->dict1));
@@ -372,7 +372,7 @@ static void test_visitor_out_union_flat(TestOutputVisitorData *data,
 {
     QDict *qdict;
 
-    UserDefFlatUnion *tmp = g_malloc0(sizeof(UserDefFlatUnion));
+    UserDefFlatUnion *tmp = g_new0(UserDefFlatUnion, 1);
     tmp->enum1 = ENUM_ONE_VALUE1;
     tmp->string = g_strdup("str");
     tmp->integer = 41;
-- 
2.14.2
