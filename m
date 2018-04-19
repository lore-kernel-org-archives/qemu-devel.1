Received: from eggs.gnu.org ([2001:4830:134:3::10]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f9B4Y-0006kP-Mz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f9B4W-0002DK-Ko
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:02:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f9B4W-0002CB-AW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67FFB81A88A1
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:02:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Apr 2018 17:01:45 +0200
Message-Id: <20180419150145.24795-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180419150145.24795-1-marcandre.lureau@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 5/5] qobject: modify qobject_ref() to assert
 on NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

While it may be convenient to accept NULL value in
qobject_unref() (for similar reasons as free() accepts NULL), it is
not such a good idea for qobject_ref(): now assert() on NULL.

Some places relied on that behaviour (the monitor request id for
example), and it's best to be explicit that NULL is accepted there.
We have to rely on testing, and manual inspection of qobject_ref()
usage:

* block.c:
 - bdrv_refresh_filename(): guarded
 - append_open_options(): it depends if qdict values could be NULL,
   handled for extra safety, might be unnecessary

* block/blkdebug.c:
 - blkdebug_refresh_filename(): depends if qdict values could be NULL,
   full_open_options could be NULL apparently, handled

* block/blkverify.c: guarded

* block/{null,nvme}.c: guarded, previous qdict_del() (actually
  qdict_find()) guarantee non-NULL)

* block/quorum.c: full_open_options could be NULL, handled for extra
  safety, might be unnecessary

* monitor: optional "id" case must be handled, in 2 places
  - monitor_json_emitter(): only called with data !=3D NULL
  - monitor_qapi_event_queue(): called from func_emit, by qapi events,
  assert earlier during construction in qobject_output_complete()

* qapi/qmp-dispatch.c: if "arguments" exists, it can't be NULL during
  json parsing

* qapi/qobject-input-visitor.c: guarded by assert in visit_type_any()

* qapi/qobject-output-visitor.c: guarded by assert() in visit_type_any()
  qobject_output_complete(): guarded by pre-condition assert()

* qmp.c: guarded, error out before if NULL

* qobject/q{list,dict}.c: can accept NULL values apparently, what's
  the reason? how are you supposed to handle that? no test?

  Some code, such as qdict_flatten_qdict(), assume the value is always
  non-NULL for example.

- tests/*: considered to be covered by make check, not critical

- util/keyval.c: guarded, if (!elt[i]) before

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qobject.h | 7 ++++---
 block.c                    | 9 +++++----
 block/blkdebug.c           | 3 ++-
 block/quorum.c             | 3 ++-
 monitor.c                  | 2 +-
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 25a83aa619..fe8643634c 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -74,9 +74,8 @@ static inline void qobject_init(QObject *obj, QType typ=
e)
=20
 static inline void *qobject_ref_impl(QObject *obj)
 {
-    if (obj) {
-        obj->base.refcnt++;
-    }
+    assert(obj);
+    obj->base.refcnt++;
     return obj;
 }
=20
@@ -104,6 +103,7 @@ static inline void qobject_unref_impl(QObject *obj)
=20
 /**
  * qobject_ref(): Increment QObject's reference count
+ * @obj: a #QObject or child type instance (must not be NULL)
  *
  * Returns: the same @obj. The type of @obj will be propagated to the
  * return type.
@@ -117,6 +117,7 @@ static inline void qobject_unref_impl(QObject *obj)
 /**
  * qobject_unref(): Decrement QObject's reference count, deallocate
  * when it reaches zero
+ * @obj: a #QObject or children type instance (can be NULL)
  */
 #define qobject_unref(obj) qobject_unref_impl(QOBJECT(obj))
=20
diff --git a/block.c b/block.c
index 676e57f562..9f4d7c79af 100644
--- a/block.c
+++ b/block.c
@@ -5110,8 +5110,9 @@ static bool append_open_options(QDict *d, BlockDriv=
erState *bs)
     const char *p;
=20
     for (entry =3D qdict_first(bs->options); entry;
-         entry =3D qdict_next(bs->options, entry))
-    {
+         entry =3D qdict_next(bs->options, entry)) {
+        QObject *val;
+
         /* Exclude options for children */
         QLIST_FOREACH(child, &bs->children, next) {
             if (strstart(qdict_entry_key(entry), child->name, &p)
@@ -5134,8 +5135,8 @@ static bool append_open_options(QDict *d, BlockDriv=
erState *bs)
             continue;
         }
=20
-        qdict_put_obj(d, qdict_entry_key(entry),
-                      qobject_ref(qdict_entry_value(entry)));
+        val =3D qdict_entry_value(entry);
+        qdict_put_obj(d, qdict_entry_key(entry), val ? qobject_ref(val) =
: NULL);
         found_any =3D true;
     }
=20
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 053372c22e..1876a42c0e 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -845,7 +845,8 @@ static void blkdebug_refresh_filename(BlockDriverStat=
e *bs, QDict *options)
     opts =3D qdict_new();
     qdict_put_str(opts, "driver", "blkdebug");
=20
-    qdict_put(opts, "image", qobject_ref(bs->file->bs->full_open_options=
));
+    qdict_put(opts, "image", bs->file->bs->full_open_options ?
+              qobject_ref(bs->file->bs->full_open_options) : NULL);
=20
     for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)) {
         if (strcmp(qdict_entry_key(e), "x-image")) {
diff --git a/block/quorum.c b/block/quorum.c
index a5051da56e..0304f248ed 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1083,7 +1083,8 @@ static void quorum_refresh_filename(BlockDriverStat=
e *bs, QDict *options)
     children =3D qlist_new();
     for (i =3D 0; i < s->num_children; i++) {
         qlist_append(children,
-                     qobject_ref(s->children[i]->bs->full_open_options))=
;
+                     s->children[i]->bs->full_open_options ?
+                     qobject_ref(s->children[i]->bs->full_open_options) =
: NULL);
     }
=20
     opts =3D qdict_new();
diff --git a/monitor.c b/monitor.c
index 46814af533..5dc0c34799 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4187,7 +4187,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
=20
     req_obj =3D g_new0(QMPRequest, 1);
     req_obj->mon =3D mon;
-    req_obj->id =3D qobject_ref(id);
+    req_obj->id =3D id ? qobject_ref(id) : NULL;
     req_obj->req =3D req;
     req_obj->need_resume =3D false;
=20
--=20
2.17.0.253.g3dd125b46d
