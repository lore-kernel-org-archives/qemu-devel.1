Received: from eggs.gnu.org ([2001:4830:134:3::10]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1ZnJ-0005AK-OJ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1ZnH-0006as-KZ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:48:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f1ZnH-0006aN-GA
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:48:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D1944068024
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 15:48:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Mar 2018 17:48:33 +0200
Message-Id: <20180329154833.566-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180329154833.566-1-marcandre.lureau@redhat.com>
References: <20180329154833.566-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/4] qobject: modify qobject_ref() to assert
 on NULL and return obj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Following a discussion on the mailing list: while it may be convenient
to accept NULL value in qobject_unref() (for similar reasons as free()
accepts NULL), it is a probably a bad idea to accept NULL argument in
qobject_ref().

Furthermore, it is convenient and more clear to call qobject_ref() at
the time when the reference is associated with a variable, or
argument. For this reason, make qobject_ref() return the same pointer
as given.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qobject.h    | 15 ++++++++++-----
 block.c                       |  8 ++++----
 block/blkdebug.c              |  7 +++----
 block/blkverify.c             |  8 ++++----
 block/null.c                  |  3 +--
 block/nvme.c                  |  3 +--
 block/quorum.c                |  4 ++--
 monitor.c                     | 19 +++++++------------
 qapi/qobject-input-visitor.c  |  6 ++----
 qapi/qobject-output-visitor.c |  7 +++----
 qobject/qdict.c               | 33 +++++++++++----------------------
 11 files changed, 48 insertions(+), 65 deletions(-)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 4183d81f00..bd3a618a73 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -70,11 +70,11 @@ static inline void qobject_init(QObject *obj, QType t=
ype)
     obj->base.type =3D type;
 }
=20
-static inline void qobject_ref(QObject *obj)
+static inline void *qobject_ref(QObject *obj)
 {
-    if (obj) {
-        obj->base.refcnt++;
-    }
+    assert(obj);
+    obj->base.refcnt++;
+    return obj;
 }
=20
 /**
@@ -101,13 +101,18 @@ static inline void qobject_unref(QObject *obj)
=20
 /**
  * qobject_ref(): Increment QObject's reference count
+ * @obj: a #QObject or children type instance (must not be NULL)
+ *
+ * Returns: the same @obj. The type of @obj will be propagated to the
+ * return type.
  */
 #define qobject_ref(obj)                        \
-    qobject_ref(QOBJECT(obj))
+    (typeof(obj)) qobject_ref(QOBJECT(obj))
=20
 /**
  * qobject_unref(): Decrement QObject's reference count, deallocate
  * when it reaches zero
+ * @obj: a #QObject or children type instance (can be NULL)
  */
 #define qobject_unref(obj)                      \
     qobject_unref(QOBJECT(obj))
diff --git a/block.c b/block.c
index 55a79845be..676e57f562 100644
--- a/block.c
+++ b/block.c
@@ -5134,8 +5134,8 @@ static bool append_open_options(QDict *d, BlockDriv=
erState *bs)
             continue;
         }
=20
-        qobject_ref(qdict_entry_value(entry));
-        qdict_put_obj(d, qdict_entry_key(entry), qdict_entry_value(entry=
));
+        qdict_put_obj(d, qdict_entry_key(entry),
+                      qobject_ref(qdict_entry_value(entry)));
         found_any =3D true;
     }
=20
@@ -5207,8 +5207,8 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * suffices without querying the (exact_)filename of this BDS. *=
/
         if (bs->file->bs->full_open_options) {
             qdict_put_str(opts, "driver", drv->format_name);
-            qobject_ref(bs->file->bs->full_open_options);
-            qdict_put(opts, "file", bs->file->bs->full_open_options);
+            qdict_put(opts, "file",
+                      qobject_ref(bs->file->bs->full_open_options));
=20
             bs->full_open_options =3D opts;
         } else {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 689703d386..053372c22e 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -845,13 +845,12 @@ static void blkdebug_refresh_filename(BlockDriverSt=
ate *bs, QDict *options)
     opts =3D qdict_new();
     qdict_put_str(opts, "driver", "blkdebug");
=20
-    qobject_ref(bs->file->bs->full_open_options);
-    qdict_put(opts, "image", bs->file->bs->full_open_options);
+    qdict_put(opts, "image", qobject_ref(bs->file->bs->full_open_options=
));
=20
     for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)) {
         if (strcmp(qdict_entry_key(e), "x-image")) {
-            qobject_ref(qdict_entry_value(e));
-            qdict_put_obj(opts, qdict_entry_key(e), qdict_entry_value(e)=
);
+            qdict_put_obj(opts, qdict_entry_key(e),
+                          qobject_ref(qdict_entry_value(e)));
         }
     }
=20
diff --git a/block/blkverify.c b/block/blkverify.c
index 3cffcb1ca6..754cc9e857 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -291,10 +291,10 @@ static void blkverify_refresh_filename(BlockDriverS=
tate *bs, QDict *options)
         QDict *opts =3D qdict_new();
         qdict_put_str(opts, "driver", "blkverify");
=20
-        qobject_ref(bs->file->bs->full_open_options);
-        qdict_put(opts, "raw", bs->file->bs->full_open_options);
-        qobject_ref(s->test_file->bs->full_open_options);
-        qdict_put(opts, "test", s->test_file->bs->full_open_options);
+        qdict_put(opts, "raw",
+                  qobject_ref(bs->file->bs->full_open_options));
+        qdict_put(opts, "test",
+                  qobject_ref(s->test_file->bs->full_open_options));
=20
         bs->full_open_options =3D opts;
     }
diff --git a/block/null.c b/block/null.c
index 700a2d0857..3944550f67 100644
--- a/block/null.c
+++ b/block/null.c
@@ -244,7 +244,6 @@ static int coroutine_fn null_co_block_status(BlockDri=
verState *bs,
=20
 static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    qobject_ref(opts);
     qdict_del(opts, "filename");
=20
     if (!qdict_size(opts)) {
@@ -253,7 +252,7 @@ static void null_refresh_filename(BlockDriverState *b=
s, QDict *opts)
     }
=20
     qdict_put_str(opts, "driver", bs->drv->format_name);
-    bs->full_open_options =3D opts;
+    bs->full_open_options =3D qobject_ref(opts);
 }
=20
 static BlockDriver bdrv_null_co =3D {
diff --git a/block/nvme.c b/block/nvme.c
index e192da9ee1..6f71122bf5 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1073,7 +1073,6 @@ static int nvme_reopen_prepare(BDRVReopenState *reo=
pen_state,
=20
 static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    qobject_ref(opts);
     qdict_del(opts, "filename");
=20
     if (!qdict_size(opts)) {
@@ -1082,7 +1081,7 @@ static void nvme_refresh_filename(BlockDriverState =
*bs, QDict *opts)
     }
=20
     qdict_put_str(opts, "driver", bs->drv->format_name);
-    bs->full_open_options =3D opts;
+    bs->full_open_options =3D qobject_ref(opts);
 }
=20
 static void nvme_refresh_limits(BlockDriverState *bs, Error **errp)
diff --git a/block/quorum.c b/block/quorum.c
index 862cea366d..a5051da56e 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1082,8 +1082,8 @@ static void quorum_refresh_filename(BlockDriverStat=
e *bs, QDict *options)
=20
     children =3D qlist_new();
     for (i =3D 0; i < s->num_children; i++) {
-        qobject_ref(s->children[i]->bs->full_open_options);
-        qlist_append(children, s->children[i]->bs->full_open_options);
+        qlist_append(children,
+                     qobject_ref(s->children[i]->bs->full_open_options))=
;
     }
=20
     opts =3D qdict_new();
diff --git a/monitor.c b/monitor.c
index 9d2b89431e..c149cf9e96 100644
--- a/monitor.c
+++ b/monitor.c
@@ -494,9 +494,8 @@ static void monitor_json_emitter(Monitor *mon, QObjec=
t *data)
          * caller won't free the data (which will be finally freed in
          * responder thread).
          */
-        qobject_ref(data);
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        g_queue_push_tail(mon->qmp.qmp_responses, data);
+        g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(data));
         qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
         qemu_bh_schedule(mon_global.qmp_respond_bh);
     } else {
@@ -614,8 +613,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdic=
t, Error **errp)
              * replacing a prior stored event if any.
              */
             qobject_unref(evstate->qdict);
-            evstate->qdict =3D qdict;
-            qobject_ref(evstate->qdict);
+            evstate->qdict =3D qobject_ref(qdict);
         } else {
             /*
              * Last send was (at least) evconf->rate ns ago.
@@ -629,8 +627,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdic=
t, Error **errp)
=20
             evstate =3D g_new(MonitorQAPIEventState, 1);
             evstate->event =3D event;
-            evstate->data =3D data;
-            qobject_ref(evstate->data);
+            evstate->data =3D qobject_ref(data);
             evstate->qdict =3D NULL;
             evstate->timer =3D timer_new_ns(event_clock_type,
                                           monitor_qapi_event_handler,
@@ -4049,8 +4046,7 @@ static void monitor_qmp_respond(Monitor *mon, QObje=
ct *rsp,
     if (rsp) {
         if (id) {
             /* This is for the qdict below. */
-            qobject_ref(id);
-            qdict_put_obj(qobject_to(QDict, rsp), "id", id);
+            qdict_put_obj(qobject_to(QDict, rsp), "id", qobject_ref(id))=
;
         }
=20
         monitor_json_emitter(mon, rsp);
@@ -4190,15 +4186,14 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
         goto err;
     }
=20
-    qobject_ref(id);
-    qdict_del(qdict, "id");
-
     req_obj =3D g_new0(QMPRequest, 1);
     req_obj->mon =3D mon;
-    req_obj->id =3D id;
+    req_obj->id =3D id ? qobject_ref(id) : NULL;
     req_obj->req =3D req;
     req_obj->need_resume =3D false;
=20
+    qdict_del(qdict, "id");
+
     if (qmp_is_oob(qdict)) {
         /* Out-Of-Band (OOB) requests are executed directly in parser. *=
/
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->i=
d)
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 7a290c4a3f..da57f4cc24 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -588,8 +588,7 @@ static void qobject_input_type_any(Visitor *v, const =
char *name, QObject **obj,
         return;
     }
=20
-    qobject_ref(qobj);
-    *obj =3D qobj;
+    *obj =3D qobject_ref(qobj);
 }
=20
 static void qobject_input_type_null(Visitor *v, const char *name,
@@ -677,8 +676,7 @@ static QObjectInputVisitor *qobject_input_visitor_bas=
e_new(QObject *obj)
     v->visitor.optional =3D qobject_input_optional;
     v->visitor.free =3D qobject_input_free;
=20
-    v->root =3D obj;
-    qobject_ref(obj);
+    v->root =3D qobject_ref(obj);
=20
     return v;
 }
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 3a933b489b..89ffd8a7bf 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -188,8 +188,8 @@ static void qobject_output_type_any(Visitor *v, const=
 char *name,
                                     QObject **obj, Error **errp)
 {
     QObjectOutputVisitor *qov =3D to_qov(v);
-    qobject_ref(*obj);
-    qobject_output_add_obj(qov, name, *obj);
+
+    qobject_output_add_obj(qov, name, qobject_ref(*obj));
 }
=20
 static void qobject_output_type_null(Visitor *v, const char *name,
@@ -210,8 +210,7 @@ static void qobject_output_complete(Visitor *v, void =
*opaque)
     assert(qov->root && QSLIST_EMPTY(&qov->stack));
     assert(opaque =3D=3D qov->result);
=20
-    qobject_ref(qov->root);
-    *qov->result =3D qov->root;
+    *qov->result =3D qobject_ref(qov->root);
     qov->result =3D NULL;
 }
=20
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 2e9bd53e22..22800eeceb 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -373,8 +373,7 @@ QDict *qdict_clone_shallow(const QDict *src)
=20
     for (i =3D 0; i < QDICT_BUCKET_MAX; i++) {
         QLIST_FOREACH(entry, &src->table[i], next) {
-            qobject_ref(entry->value);
-            qdict_put_obj(dest, entry->key, entry->value);
+            qdict_put_obj(dest, entry->key, qobject_ref(entry->value));
         }
     }
=20
@@ -480,8 +479,7 @@ void qdict_copy_default(QDict *dst, QDict *src, const=
 char *key)
=20
     val =3D qdict_get(src, key);
     if (val) {
-        qobject_ref(val);
-        qdict_put_obj(dst, key, val);
+        qdict_put_obj(dst, key, qobject_ref(val));
     }
 }
=20
@@ -526,8 +524,7 @@ static void qdict_flatten_qlist(QList *qlist, QDict *=
target, const char *prefix)
             qdict_flatten_qlist(qobject_to(QList, value), target, new_ke=
y);
         } else {
             /* All other types are moved to the target unchanged. */
-            qobject_ref(value);
-            qdict_put_obj(target, new_key, value);
+            qdict_put_obj(target, new_key, qobject_ref(value));
         }
=20
         g_free(new_key);
@@ -566,8 +563,7 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *=
target, const char *prefix)
             delete =3D true;
         } else if (prefix) {
             /* All other objects are moved to the target unchanged. */
-            qobject_ref(value);
-            qdict_put_obj(target, new_key, value);
+            qdict_put_obj(target, new_key, qobject_ref(value));
             delete =3D true;
         }
=20
@@ -610,8 +606,7 @@ void qdict_extract_subqdict(QDict *src, QDict **dst, =
const char *start)
     while (entry !=3D NULL) {
         next =3D qdict_next(src, entry);
         if (strstart(entry->key, start, &p)) {
-            qobject_ref(entry->value);
-            qdict_put_obj(*dst, p, entry->value);
+            qdict_put_obj(*dst, p, qobject_ref(entry->value));
             qdict_del(src, entry->key);
         }
         entry =3D next;
@@ -894,16 +889,14 @@ QObject *qdict_crumple(const QDict *src, Error **er=
rp)
                 qdict_put_obj(two_level, prefix, QOBJECT(child_dict));
             }
=20
-            qobject_ref(ent->value);
-            qdict_put_obj(child_dict, suffix, ent->value);
+            qdict_put_obj(child_dict, suffix, qobject_ref(ent->value));
         } else {
             if (child) {
                 error_setg(errp, "Key %s prefix is already set as a dict=
",
                            prefix);
                 goto error;
             }
-            qobject_ref(ent->value);
-            qdict_put_obj(two_level, prefix, ent->value);
+            qdict_put_obj(two_level, prefix, qobject_ref(ent->value));
         }
=20
         g_free(prefix);
@@ -924,8 +917,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp=
)
=20
             qdict_put_obj(multi_level, ent->key, child);
         } else {
-            qobject_ref(ent->value);
-            qdict_put_obj(multi_level, ent->key, ent->value);
+            qdict_put_obj(multi_level, ent->key, qobject_ref(ent->value)=
);
         }
     }
     qobject_unref(two_level);
@@ -951,8 +943,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp=
)
                 goto error;
             }
=20
-            qobject_ref(child);
-            qlist_append_obj(qobject_to(QList, dst), child);
+            qlist_append_obj(qobject_to(QList, dst), qobject_ref(child))=
;
         }
         qobject_unref(multi_level);
         multi_level =3D NULL;
@@ -1055,8 +1046,7 @@ void qdict_join(QDict *dest, QDict *src, bool overw=
rite)
         next =3D qdict_next(src, entry);
=20
         if (overwrite || !qdict_haskey(dest, entry->key)) {
-            qobject_ref(entry->value);
-            qdict_put_obj(dest, entry->key, entry->value);
+            qdict_put_obj(dest, entry->key, qobject_ref(entry->value));
             qdict_del(src, entry->key);
         }
=20
@@ -1088,8 +1078,7 @@ bool qdict_rename_keys(QDict *qdict, const QDictRen=
ames *renames, Error **errp)
             }
=20
             qobj =3D qdict_get(qdict, renames->from);
-            qobject_ref(qobj);
-            qdict_put_obj(qdict, renames->to, qobj);
+            qdict_put_obj(qdict, renames->to, qobject_ref(qobj));
             qdict_del(qdict, renames->from);
         }
=20
--=20
2.17.0.rc1.36.gcedb63ea2f
