Received: from eggs.gnu.org ([2001:4830:134:3::10]:34546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqiPd-0004vc-5k
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqiPc-0005Hg-DO
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:19:49 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 19:19:31 +0200
Message-Id: <20180817171932.31976-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180817171932.31976-1-marcandre.lureau@redhat.com>
References: <20180817171932.31976-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qdict: add qdict_steal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Add a new function qdict_steal(), that deletes a key from a dict, and
returns the associated value, if any. Simplify related code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qdict.h |  1 +
 monitor.c                |  3 +--
 qobject/block-qdict.c    |  7 ++-----
 qobject/qdict.c          | 22 ++++++++++++++++++++++
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 7f3ec10a10..84644bfba6 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -37,6 +37,7 @@ QObject *qdict_entry_value(const QDictEntry *entry);
 size_t qdict_size(const QDict *qdict);
 void qdict_put_obj(QDict *qdict, const char *key, QObject *value);
 void qdict_del(QDict *qdict, const char *key);
+QObject *qdict_steal(QDict *qdict, const char *key);
 int qdict_haskey(const QDict *qdict, const char *key);
 QObject *qdict_get(const QDict *qdict, const char *key);
 bool qdict_is_equal(const QObject *x, const QObject *y);
diff --git a/monitor.c b/monitor.c
index a1999e396c..eab2dc7b7b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4262,8 +4262,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
=20
     qdict =3D qobject_to(QDict, req);
     if (qdict) {
-        id =3D qobject_ref(qdict_get(qdict, "id"));
-        qdict_del(qdict, "id");
+        id =3D qdict_steal(qdict, "id");
     } /* else will fail qmp_dispatch() */
=20
     if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND))=
 {
diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 42054cc274..a07664ee6a 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -692,8 +692,6 @@ void qdict_join(QDict *dest, QDict *src, bool overwri=
te)
  */
 bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error =
**errp)
 {
-    QObject *qobj;
-
     while (renames->from) {
         if (qdict_haskey(qdict, renames->from)) {
             if (qdict_haskey(qdict, renames->to)) {
@@ -702,9 +700,8 @@ bool qdict_rename_keys(QDict *qdict, const QDictRenam=
es *renames, Error **errp)
                 return false;
             }
=20
-            qobj =3D qdict_get(qdict, renames->from);
-            qdict_put_obj(qdict, renames->to, qobject_ref(qobj));
-            qdict_del(qdict, renames->from);
+            qdict_put_obj(qdict, renames->to,
+                          qdict_steal(qdict, renames->from));
         }
=20
         renames++;
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 3d8c2f7bbc..322f23f094 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -406,6 +406,28 @@ void qdict_del(QDict *qdict, const char *key)
     }
 }
=20
+/**
+ * qdict_steal(): Steal a 'key:value' pair from the dictionary
+ *
+ * Return the associated entry value and remove it, or NULL.
+ */
+QObject *qdict_steal(QDict *qdict, const char *key)
+{
+    QDictEntry *entry;
+    QObject *val =3D NULL;
+
+    entry =3D qdict_find(qdict, key, tdb_hash(key) % QDICT_BUCKET_MAX);
+    if (entry) {
+        QLIST_REMOVE(entry, next);
+        val =3D qobject_ref(entry->value);
+        qentry_destroy(entry);
+        qdict->size--;
+    }
+
+    return val;
+}
+
+
 /**
  * qdict_is_equal(): Test whether the two QDicts are equal
  *
--=20
2.18.0.547.g1d89318c48
