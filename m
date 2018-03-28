Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1Ao5-0006GR-8Q
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1Ank-0003kJ-GZ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:08:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f1Ank-0003k8-3Q
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB8A9406804F
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:07:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Mar 2018 15:07:23 +0200
Message-Id: <20180328130723.20831-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180328130723.20831-1-marcandre.lureau@redhat.com>
References: <20180328130723.20831-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] qobject: replace qobject_incref/QINCREF
 qobject_decref/QDECREF
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

Now that we can safely call QOBJECT() on QObject * and children types,
we can have a single macro to ref/unref the object.

Change the incref/decref prefix name for the more common ref/unref.

Note that before the patch, "QDECREF(obj)" was problematic because it
would expand to "obj ? obj : ...", which could evaluate "obj" multiple
times.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/events.py              |   2 +-
 include/qapi/qmp/qnull.h            |   2 +-
 include/qapi/qmp/qobject.h          |  34 +++++-----
 block.c                             |  78 +++++++++++-----------
 block/blkdebug.c                    |   4 +-
 block/blkverify.c                   |   4 +-
 block/crypto.c                      |   4 +-
 block/gluster.c                     |   4 +-
 block/iscsi.c                       |   2 +-
 block/nbd.c                         |   4 +-
 block/nfs.c                         |   4 +-
 block/null.c                        |   2 +-
 block/nvme.c                        |   2 +-
 block/parallels.c                   |   4 +-
 block/qapi.c                        |   2 +-
 block/qcow.c                        |   8 +--
 block/qcow2.c                       |   8 +--
 block/qed.c                         |   4 +-
 block/quorum.c                      |   2 +-
 block/rbd.c                         |  14 ++--
 block/sheepdog.c                    |  12 ++--
 block/snapshot.c                    |   4 +-
 block/ssh.c                         |   4 +-
 block/vdi.c                         |   2 +-
 block/vhdx.c                        |   4 +-
 block/vpc.c                         |   4 +-
 block/vvfat.c                       |   2 +-
 block/vxhs.c                        |   2 +-
 blockdev.c                          |  16 ++---
 hw/i386/acpi-build.c                |  12 ++--
 hw/ppc/spapr_drc.c                  |   2 +-
 hw/usb/xen-usb.c                    |   4 +-
 migration/migration.c               |   4 +-
 migration/qjson.c                   |   2 +-
 monitor.c                           |  50 +++++++-------
 qapi/qapi-dealloc-visitor.c         |   4 +-
 qapi/qmp-dispatch.c                 |   6 +-
 qapi/qobject-input-visitor.c        |   8 +--
 qapi/qobject-output-visitor.c       |   8 +--
 qemu-img.c                          |  18 ++---
 qemu-io.c                           |   6 +-
 qga/main.c                          |  12 ++--
 qmp.c                               |   4 +-
 qobject/json-parser.c               |  10 +--
 qobject/qdict.c                     |  38 +++++------
 qobject/qjson.c                     |   2 +-
 qobject/qlist.c                     |   4 +-
 qom/object.c                        |  16 ++---
 qom/object_interfaces.c             |   2 +-
 target/ppc/translate_init.c         |   2 +-
 target/s390x/cpu_models.c           |   2 +-
 tests/ahci-test.c                   |   6 +-
 tests/check-qdict.c                 | 100 ++++++++++++++--------------
 tests/check-qjson.c                 |  84 +++++++++++------------
 tests/check-qlist.c                 |   8 +--
 tests/check-qlit.c                  |  10 +--
 tests/check-qnull.c                 |  10 +--
 tests/check-qnum.c                  |  28 ++++----
 tests/check-qobject.c               |   2 +-
 tests/check-qstring.c               |  10 +--
 tests/cpu-plug-test.c               |   4 +-
 tests/device-introspect-test.c      |  24 +++----
 tests/drive_del-test.c              |   4 +-
 tests/libqos/libqos.c               |   8 +--
 tests/libqos/pci-pc.c               |   2 +-
 tests/libqtest.c                    |  24 +++----
 tests/machine-none-test.c           |   2 +-
 tests/migration-test.c              |  24 +++----
 tests/numa-test.c                   |  16 ++---
 tests/pvpanic-test.c                |   2 +-
 tests/q35-test.c                    |   2 +-
 tests/qmp-test.c                    |  38 +++++------
 tests/qom-test.c                    |   8 +--
 tests/tco-test.c                    |  12 ++--
 tests/test-char.c                   |   2 +-
 tests/test-keyval.c                 |  82 +++++++++++------------
 tests/test-netfilter.c              |  26 ++++----
 tests/test-qemu-opts.c              |  14 ++--
 tests/test-qga.c                    |  76 ++++++++++-----------
 tests/test-qmp-cmds.c               |  24 +++----
 tests/test-qmp-event.c              |   2 +-
 tests/test-qobject-input-visitor.c  |  10 +--
 tests/test-qobject-output-visitor.c |  18 ++---
 tests/test-visitor-serialization.c  |   6 +-
 tests/test-x86-cpuid-compat.c       |  14 ++--
 tests/tmp105-test.c                 |   4 +-
 tests/vhost-user-test.c             |   6 +-
 tests/virtio-net-test.c             |   6 +-
 tests/vmgenid-test.c                |   2 +-
 tests/wdt_ib700-test.c              |  14 ++--
 util/keyval.c                       |  12 ++--
 util/qemu-config.c                  |   4 +-
 docs/devel/qapi-code-gen.txt        |   2 +-
 scripts/coccinelle/qobject.cocci    |   8 +--
 94 files changed, 606 insertions(+), 608 deletions(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 3dc523cf39..4426861ff1 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -142,7 +142,7 @@ out:
 ''')
     ret +=3D mcgen('''
     error_propagate(errp, err);
-    QDECREF(qmp);
+    qobject_unref(qmp);
 }
 ''')
     return ret
diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
index 32d4ce98af..348b8181d3 100644
--- a/include/qapi/qmp/qnull.h
+++ b/include/qapi/qmp/qnull.h
@@ -23,7 +23,7 @@ extern QNull qnull_;
=20
 static inline QNull *qnull(void)
 {
-    QINCREF(&qnull_);
+    qobject_ref(&qnull_);
     return &qnull_;
 }
=20
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 4fc59b54d3..67279f54b1 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -16,16 +16,16 @@
  *
  *  - Returning references: A function that returns an object may
  *  return it as either a weak or a strong reference.  If the reference
- *  is strong, you are responsible for calling QDECREF() on the referenc=
e
+ *  is strong, you are responsible for calling qobject_unref() on the re=
ference
  *  when you are done.
  *
  *  If the reference is weak, the owner of the reference may free it at
  *  any time in the future.  Before storing the reference anywhere, you
- *  should call QINCREF() to make the reference strong.
+ *  should call qobject_ref() to make the reference strong.
  *
  *  - Transferring ownership: when you transfer ownership of a reference
  *  by calling a function, you are no longer responsible for calling
- *  QDECREF() when the reference is no longer needed.  In other words,
+ *  qobject_unref() when the reference is no longer needed.  In other wo=
rds,
  *  when the function returns you must behave as if the reference to the
  *  passed object was weak.
  */
@@ -46,13 +46,18 @@ struct QObject {
 #define QOBJECT(x) \
    container_of(&(x)->base, QObject, base)
=20
-/* High-level interface for qobject_incref() */
-#define QINCREF(obj)      \
-    qobject_incref(QOBJECT(obj))
+/**
+ * qobject_ref(): Increment QObject's reference count
+ */
+#define qobject_ref(obj)      \
+    qobject_ref_impl(QOBJECT(obj))
=20
-/* High-level interface for qobject_decref() */
-#define QDECREF(obj)              \
-    qobject_decref(obj ? QOBJECT(obj) : NULL)
+/**
+ * qobject_unref(): Decrement QObject's reference count, deallocate
+ * when it reaches zero
+ */
+#define qobject_unref(obj)              \
+    qobject_unref_impl(QOBJECT(obj))
=20
 /* Required for qobject_to() */
 #define QTYPE_CAST_TO_QNull     QTYPE_QNULL
@@ -76,10 +81,7 @@ static inline void qobject_init(QObject *obj, QType ty=
pe)
     obj->base.type =3D type;
 }
=20
-/**
- * qobject_incref(): Increment QObject's reference count
- */
-static inline void qobject_incref(QObject *obj)
+static inline void qobject_ref_impl(QObject *obj)
 {
     if (obj) {
         obj->base.refcnt++;
@@ -100,11 +102,7 @@ bool qobject_is_equal(const QObject *x, const QObjec=
t *y);
  */
 void qobject_destroy(QObject *obj);
=20
-/**
- * qobject_decref(): Decrement QObject's reference count, deallocate
- * when it reaches zero
- */
-static inline void qobject_decref(QObject *obj)
+static inline void qobject_unref_impl(QObject *obj)
 {
     assert(!obj || obj->base.refcnt);
     if (obj && --obj->base.refcnt =3D=3D 0) {
diff --git a/block.c b/block.c
index a2caadf0a0..55a79845be 100644
--- a/block.c
+++ b/block.c
@@ -1227,9 +1227,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver =
*drv, const char *node_name,
=20
     ret =3D bdrv_open_driver(bs, drv, node_name, bs->options, flags, err=
p);
     if (ret < 0) {
-        QDECREF(bs->explicit_options);
+        qobject_unref(bs->explicit_options);
         bs->explicit_options =3D NULL;
-        QDECREF(bs->options);
+        qobject_unref(bs->options);
         bs->options =3D NULL;
         bdrv_unref(bs);
         return NULL;
@@ -1460,7 +1460,7 @@ static QDict *parse_json_filename(const char *filen=
ame, Error **errp)
=20
     options =3D qobject_to(QDict, options_obj);
     if (!options) {
-        qobject_decref(options_obj);
+        qobject_unref(options_obj);
         error_setg(errp, "Invalid JSON object given");
         return NULL;
     }
@@ -1490,7 +1490,7 @@ static void parse_json_protocol(QDict *options, con=
st char **pfilename,
     /* Options given in the filename have lower priority than options
      * specified directly */
     qdict_join(options, json_options, false);
-    QDECREF(json_options);
+    qobject_unref(json_options);
     *pfilename =3D NULL;
 }
=20
@@ -2273,7 +2273,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
     if (reference || qdict_haskey(options, "file.filename")) {
         backing_filename[0] =3D '\0';
     } else if (bs->backing_file[0] =3D=3D '\0' && qdict_size(options) =3D=
=3D 0) {
-        QDECREF(options);
+        qobject_unref(options);
         goto free_exit;
     } else {
         bdrv_get_full_backing_filename(bs, backing_filename, PATH_MAX,
@@ -2281,7 +2281,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
         if (local_err) {
             ret =3D -EINVAL;
             error_propagate(errp, local_err);
-            QDECREF(options);
+            qobject_unref(options);
             goto free_exit;
         }
     }
@@ -2289,7 +2289,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
     if (!bs->drv || !bs->drv->supports_backing) {
         ret =3D -EINVAL;
         error_setg(errp, "Driver doesn't support backing files");
-        QDECREF(options);
+        qobject_unref(options);
         goto free_exit;
     }
=20
@@ -2323,7 +2323,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
=20
 free_exit:
     g_free(backing_filename);
-    QDECREF(tmp_parent_options);
+    qobject_unref(tmp_parent_options);
     return ret;
 }
=20
@@ -2356,7 +2356,7 @@ bdrv_open_child_bs(const char *filename, QDict *opt=
ions, const char *bdref_key,
             error_setg(errp, "A block device must be specified for \"%s\=
"",
                        bdref_key);
         }
-        QDECREF(image_options);
+        qobject_unref(image_options);
         goto done;
     }
=20
@@ -2449,7 +2449,7 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRe=
f *ref, Error **errp)
     obj =3D NULL;
=20
 fail:
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_free(v);
     return bs;
 }
@@ -2519,7 +2519,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(=
BlockDriverState *bs,
     }
=20
 out:
-    QDECREF(snapshot_options);
+    qobject_unref(snapshot_options);
     g_free(tmp_filename);
     return bs_snapshot;
 }
@@ -2530,7 +2530,7 @@ out:
  * options is a QDict of options to pass to the block drivers, or NULL f=
or an
  * empty set of options. The reference to the QDict belongs to the block=
 layer
  * after the call (even on failure), so if the caller intends to reuse t=
he
- * dictionary, it needs to use QINCREF() before calling bdrv_open.
+ * dictionary, it needs to use qobject_ref() before calling bdrv_open.
  *
  * If *pbs is NULL, a new BDS will be created with a pointer to it store=
d there.
  * If it is not NULL, the referenced BDS will be reused.
@@ -2561,7 +2561,7 @@ static BlockDriverState *bdrv_open_inherit(const ch=
ar *filename,
=20
     if (reference) {
         bool options_non_empty =3D options ? qdict_size(options) : false=
;
-        QDECREF(options);
+        qobject_unref(options);
=20
         if (filename || options_non_empty) {
             error_setg(errp, "Cannot reference an existing block device =
with "
@@ -2752,7 +2752,7 @@ static BlockDriverState *bdrv_open_inherit(const ch=
ar *filename,
=20
     bdrv_parent_cb_change_media(bs, true);
=20
-    QDECREF(options);
+    qobject_unref(options);
=20
     /* For snapshot=3Don, create a temporary qcow2 overlay. bs points to=
 the
      * temporary snapshot afterwards. */
@@ -2776,10 +2776,10 @@ static BlockDriverState *bdrv_open_inherit(const =
char *filename,
=20
 fail:
     blk_unref(file);
-    QDECREF(snapshot_options);
-    QDECREF(bs->explicit_options);
-    QDECREF(bs->options);
-    QDECREF(options);
+    qobject_unref(snapshot_options);
+    qobject_unref(bs->explicit_options);
+    qobject_unref(bs->options);
+    qobject_unref(options);
     bs->options =3D NULL;
     bs->explicit_options =3D NULL;
     bdrv_unref(bs);
@@ -2788,8 +2788,8 @@ fail:
=20
 close_and_fail:
     bdrv_unref(bs);
-    QDECREF(snapshot_options);
-    QDECREF(options);
+    qobject_unref(snapshot_options);
+    qobject_unref(options);
     error_propagate(errp, local_err);
     return NULL;
 }
@@ -2884,7 +2884,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
         old_options =3D qdict_clone_shallow(bs->explicit_options);
     }
     bdrv_join_options(bs, options, old_options);
-    QDECREF(old_options);
+    qobject_unref(old_options);
=20
     explicit_options =3D qdict_clone_shallow(options);
=20
@@ -2899,13 +2899,13 @@ static BlockReopenQueue *bdrv_reopen_queue_child(=
BlockReopenQueue *bs_queue,
         qemu_opts_absorb_qdict(opts, options_copy, NULL);
         update_flags_from_options(&flags, opts);
         qemu_opts_del(opts);
-        QDECREF(options_copy);
+        qobject_unref(options_copy);
     }
=20
     /* Old values are used for options that aren't set yet */
     old_options =3D qdict_clone_shallow(bs->options);
     bdrv_join_options(bs, options, old_options);
-    QDECREF(old_options);
+    qobject_unref(old_options);
=20
     /* bdrv_open_inherit() sets and clears some additional flags interna=
lly */
     flags &=3D ~BDRV_O_PROTOCOL;
@@ -2917,8 +2917,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
         bs_entry =3D g_new0(BlockReopenQueueEntry, 1);
         QSIMPLEQ_INSERT_TAIL(bs_queue, bs_entry, entry);
     } else {
-        QDECREF(bs_entry->state.options);
-        QDECREF(bs_entry->state.explicit_options);
+        qobject_unref(bs_entry->state.options);
+        qobject_unref(bs_entry->state.explicit_options);
     }
=20
     bs_entry->state.bs =3D bs;
@@ -3008,9 +3008,9 @@ cleanup:
         if (ret && bs_entry->prepared) {
             bdrv_reopen_abort(&bs_entry->state);
         } else if (ret) {
-            QDECREF(bs_entry->state.explicit_options);
+            qobject_unref(bs_entry->state.explicit_options);
         }
-        QDECREF(bs_entry->state.options);
+        qobject_unref(bs_entry->state.options);
         g_free(bs_entry);
     }
     g_free(bs_queue);
@@ -3253,7 +3253,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_sta=
te)
     }
=20
     /* set BDS specific flags now */
-    QDECREF(bs->explicit_options);
+    qobject_unref(bs->explicit_options);
=20
     bs->explicit_options   =3D reopen_state->explicit_options;
     bs->open_flags         =3D reopen_state->flags;
@@ -3296,7 +3296,7 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_stat=
e)
         drv->bdrv_reopen_abort(reopen_state);
     }
=20
-    QDECREF(reopen_state->explicit_options);
+    qobject_unref(reopen_state->explicit_options);
=20
     bdrv_abort_perm_update(reopen_state->bs);
 }
@@ -3343,11 +3343,11 @@ static void bdrv_close(BlockDriverState *bs)
     bs->total_sectors =3D 0;
     bs->encrypted =3D false;
     bs->sg =3D false;
-    QDECREF(bs->options);
-    QDECREF(bs->explicit_options);
+    qobject_unref(bs->options);
+    qobject_unref(bs->explicit_options);
     bs->options =3D NULL;
     bs->explicit_options =3D NULL;
-    QDECREF(bs->full_open_options);
+    qobject_unref(bs->full_open_options);
     bs->full_open_options =3D NULL;
=20
     bdrv_release_named_dirty_bitmaps(bs);
@@ -5134,7 +5134,7 @@ static bool append_open_options(QDict *d, BlockDriv=
erState *bs)
             continue;
         }
=20
-        qobject_incref(qdict_entry_value(entry));
+        qobject_ref(qdict_entry_value(entry));
         qdict_put_obj(d, qdict_entry_key(entry), qdict_entry_value(entry=
));
         found_any =3D true;
     }
@@ -5174,21 +5174,21 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * information before refreshing it */
         bs->exact_filename[0] =3D '\0';
         if (bs->full_open_options) {
-            QDECREF(bs->full_open_options);
+            qobject_unref(bs->full_open_options);
             bs->full_open_options =3D NULL;
         }
=20
         opts =3D qdict_new();
         append_open_options(opts, bs);
         drv->bdrv_refresh_filename(bs, opts);
-        QDECREF(opts);
+        qobject_unref(opts);
     } else if (bs->file) {
         /* Try to reconstruct valid information from the underlying file=
 */
         bool has_open_options;
=20
         bs->exact_filename[0] =3D '\0';
         if (bs->full_open_options) {
-            QDECREF(bs->full_open_options);
+            qobject_unref(bs->full_open_options);
             bs->full_open_options =3D NULL;
         }
=20
@@ -5207,12 +5207,12 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * suffices without querying the (exact_)filename of this BDS. *=
/
         if (bs->file->bs->full_open_options) {
             qdict_put_str(opts, "driver", drv->format_name);
-            QINCREF(bs->file->bs->full_open_options);
+            qobject_ref(bs->file->bs->full_open_options);
             qdict_put(opts, "file", bs->file->bs->full_open_options);
=20
             bs->full_open_options =3D opts;
         } else {
-            QDECREF(opts);
+            qobject_unref(opts);
         }
     } else if (!bs->full_open_options && qdict_size(bs->options)) {
         /* There is no underlying file BDS (at least referenced by BDS.f=
ile),
@@ -5246,7 +5246,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         QString *json =3D qobject_to_json(QOBJECT(bs->full_open_options)=
);
         snprintf(bs->filename, sizeof(bs->filename), "json:%s",
                  qstring_get_str(json));
-        QDECREF(json);
+        qobject_unref(json);
     }
 }
=20
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 589712475a..689703d386 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -845,12 +845,12 @@ static void blkdebug_refresh_filename(BlockDriverSt=
ate *bs, QDict *options)
     opts =3D qdict_new();
     qdict_put_str(opts, "driver", "blkdebug");
=20
-    QINCREF(bs->file->bs->full_open_options);
+    qobject_ref(bs->file->bs->full_open_options);
     qdict_put(opts, "image", bs->file->bs->full_open_options);
=20
     for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)) {
         if (strcmp(qdict_entry_key(e), "x-image")) {
-            qobject_incref(qdict_entry_value(e));
+            qobject_ref(qdict_entry_value(e));
             qdict_put_obj(opts, qdict_entry_key(e), qdict_entry_value(e)=
);
         }
     }
diff --git a/block/blkverify.c b/block/blkverify.c
index 331365be33..3cffcb1ca6 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -291,9 +291,9 @@ static void blkverify_refresh_filename(BlockDriverSta=
te *bs, QDict *options)
         QDict *opts =3D qdict_new();
         qdict_put_str(opts, "driver", "blkverify");
=20
-        QINCREF(bs->file->bs->full_open_options);
+        qobject_ref(bs->file->bs->full_open_options);
         qdict_put(opts, "raw", bs->file->bs->full_open_options);
-        QINCREF(s->test_file->bs->full_open_options);
+        qobject_ref(s->test_file->bs->full_open_options);
         qdict_put(opts, "test", s->test_file->bs->full_open_options);
=20
         bs->full_open_options =3D opts;
diff --git a/block/crypto.c b/block/crypto.c
index bc6c7e3795..7e7ad2d2a6 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -305,7 +305,7 @@ static int block_crypto_open_generic(QCryptoBlockForm=
at format,
=20
     ret =3D 0;
  cleanup:
-    QDECREF(cryptoopts);
+    qobject_unref(cryptoopts);
     qapi_free_QCryptoBlockOpenOptions(open_opts);
     return ret;
 }
@@ -635,7 +635,7 @@ static int coroutine_fn block_crypto_co_create_opts_l=
uks(const char *filename,
 fail:
     bdrv_unref(bs);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
-    QDECREF(cryptoopts);
+    qobject_unref(cryptoopts);
     return ret;
 }
=20
diff --git a/block/gluster.c b/block/gluster.c
index 296e036b3d..7a2a3e9c21 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -637,7 +637,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
         }
         gsconf =3D NULL;
=20
-        QDECREF(backing_options);
+        qobject_unref(backing_options);
         backing_options =3D NULL;
         g_free(str);
         str =3D NULL;
@@ -650,7 +650,7 @@ out:
     qapi_free_SocketAddress(gsconf);
     qemu_opts_del(opts);
     g_free(str);
-    QDECREF(backing_options);
+    qobject_unref(backing_options);
     errno =3D EINVAL;
     return -errno;
 }
diff --git a/block/iscsi.c b/block/iscsi.c
index f5aecfc883..d19ae0e398 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2143,7 +2143,7 @@ static int coroutine_fn iscsi_co_create_opts(const =
char *filename, QemuOpts *opt
     } else {
         ret =3D iscsi_open(bs, bs_options, 0, NULL);
     }
-    QDECREF(bs_options);
+    qobject_unref(bs_options);
=20
     if (ret !=3D 0) {
         goto out;
diff --git a/block/nbd.c b/block/nbd.c
index 1e2b3ba2d3..3e1693cc55 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -293,8 +293,8 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDi=
ct *options,
     }
=20
 done:
-    QDECREF(addr);
-    qobject_decref(crumpled_addr);
+    qobject_unref(addr);
+    qobject_unref(crumpled_addr);
     visit_free(iv);
     return saddr;
 }
diff --git a/block/nfs.c b/block/nfs.c
index 2577df4b26..66fddf12d4 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -567,7 +567,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(=
QDict *options,
     v =3D qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevOptionsNfs(v, NULL, &opts, &local_err);
     visit_free(v);
-    qobject_decref(crumpled);
+    qobject_unref(crumpled);
=20
     if (local_err) {
         return NULL;
@@ -683,7 +683,7 @@ static int coroutine_fn nfs_file_co_create_opts(const=
 char *url, QemuOpts *opts,
=20
     ret =3D 0;
 out:
-    QDECREF(options);
+    qobject_unref(options);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
diff --git a/block/null.c b/block/null.c
index 806a8631e4..700a2d0857 100644
--- a/block/null.c
+++ b/block/null.c
@@ -244,7 +244,7 @@ static int coroutine_fn null_co_block_status(BlockDri=
verState *bs,
=20
 static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    QINCREF(opts);
+    qobject_ref(opts);
     qdict_del(opts, "filename");
=20
     if (!qdict_size(opts)) {
diff --git a/block/nvme.c b/block/nvme.c
index c4f3a7bc94..e192da9ee1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1073,7 +1073,7 @@ static int nvme_reopen_prepare(BDRVReopenState *reo=
pen_state,
=20
 static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    QINCREF(opts);
+    qobject_ref(opts);
     qdict_del(opts, "filename");
=20
     if (!qdict_size(opts)) {
diff --git a/block/parallels.c b/block/parallels.c
index 799215e079..045810d00f 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -651,7 +651,7 @@ static int coroutine_fn parallels_co_create_opts(cons=
t char *filename,
     qdict_put_str(qdict, "file", bs->node_name);
=20
     qobj =3D qdict_crumple(qdict, errp);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     qdict =3D qobject_to(QDict, qobj);
     if (qdict =3D=3D NULL) {
         ret =3D -EINVAL;
@@ -682,7 +682,7 @@ static int coroutine_fn parallels_co_create_opts(cons=
t char *filename,
     ret =3D 0;
=20
 done:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     bdrv_unref(bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
diff --git a/block/qapi.c b/block/qapi.c
index 04c6fc69b9..e12968fec8 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -773,7 +773,7 @@ void bdrv_image_info_specific_dump(fprintf_function f=
unc_fprintf, void *f,
     visit_complete(v, &obj);
     data =3D qdict_get(qobject_to(QDict, obj), "data");
     dump_qobject(func_fprintf, f, 1, data);
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_free(v);
 }
=20
diff --git a/block/qcow.c b/block/qcow.c
index f92891676c..4b2f7db74c 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -315,7 +315,7 @@ static int qcow_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
         goto fail;
     }
=20
-    QDECREF(encryptopts);
+    qobject_unref(encryptopts);
     qapi_free_QCryptoBlockOpenOptions(crypto_opts);
     qemu_co_mutex_init(&s->lock);
     return 0;
@@ -326,7 +326,7 @@ static int qcow_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     g_free(s->cluster_cache);
     g_free(s->cluster_data);
     qcrypto_block_free(s->crypto);
-    QDECREF(encryptopts);
+    qobject_unref(encryptopts);
     qapi_free_QCryptoBlockOpenOptions(crypto_opts);
     return ret;
 }
@@ -995,7 +995,7 @@ static int coroutine_fn qcow_co_create_opts(const cha=
r *filename,
     qdict_put_str(qdict, "file", bs->node_name);
=20
     qobj =3D qdict_crumple(qdict, errp);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     qdict =3D qobject_to(QDict, qobj);
     if (qdict =3D=3D NULL) {
         ret =3D -EINVAL;
@@ -1025,7 +1025,7 @@ static int coroutine_fn qcow_co_create_opts(const c=
har *filename,
=20
     ret =3D 0;
 fail:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     bdrv_unref(bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
diff --git a/block/qcow2.c b/block/qcow2.c
index 486f3e83b7..917519ce97 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1063,7 +1063,7 @@ static int qcow2_update_options_prepare(BlockDriver=
State *bs,
=20
     ret =3D 0;
 fail:
-    QDECREF(encryptopts);
+    qobject_unref(encryptopts);
     qemu_opts_del(opts);
     opts =3D NULL;
     return ret;
@@ -2183,7 +2183,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(=
BlockDriverState *bs,
     qemu_co_mutex_lock(&s->lock);
     ret =3D qcow2_do_open(bs, options, flags, &local_err);
     qemu_co_mutex_unlock(&s->lock);
-    QDECREF(options);
+    qobject_unref(options);
     if (local_err) {
         error_propagate(errp, local_err);
         error_prepend(errp, "Could not reopen qcow2 layer: ");
@@ -3139,7 +3139,7 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
=20
     /* Now get the QAPI type BlockdevCreateOptions */
     qobj =3D qdict_crumple(qdict, errp);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     qdict =3D qobject_to(QDict, qobj);
     if (qdict =3D=3D NULL) {
         ret =3D -EINVAL;
@@ -3168,7 +3168,7 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
=20
     ret =3D 0;
 finish:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     bdrv_unref(bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
diff --git a/block/qed.c b/block/qed.c
index 35ff505066..1db8eaf241 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -763,7 +763,7 @@ static int coroutine_fn bdrv_qed_co_create_opts(const=
 char *filename,
     qdict_put_str(qdict, "file", bs->node_name);
=20
     qobj =3D qdict_crumple(qdict, errp);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     qdict =3D qobject_to(QDict, qobj);
     if (qdict =3D=3D NULL) {
         ret =3D -EINVAL;
@@ -789,7 +789,7 @@ static int coroutine_fn bdrv_qed_co_create_opts(const=
 char *filename,
     ret =3D bdrv_qed_co_create(create_options, errp);
=20
 fail:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     bdrv_unref(bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
diff --git a/block/quorum.c b/block/quorum.c
index cfe484a945..862cea366d 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1082,7 +1082,7 @@ static void quorum_refresh_filename(BlockDriverStat=
e *bs, QDict *options)
=20
     children =3D qlist_new();
     for (i =3D 0; i < s->num_children; i++) {
-        QINCREF(s->children[i]->bs->full_open_options);
+        qobject_ref(s->children[i]->bs->full_open_options);
         qlist_append(children, s->children[i]->bs->full_open_options);
     }
=20
diff --git a/block/rbd.c b/block/rbd.c
index 5b64849dc6..77678a5c65 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -226,7 +226,7 @@ static void qemu_rbd_parse_filename(const char *filen=
ame, QDict *options,
=20
 done:
     g_free(buf);
-    QDECREF(keypairs);
+    qobject_unref(keypairs);
     return;
 }
=20
@@ -275,17 +275,17 @@ static int qemu_rbd_set_keypairs(rados_t cluster, c=
onst char *keypairs_json,
         key =3D qstring_get_str(name);
=20
         ret =3D rados_conf_set(cluster, key, qstring_get_str(value));
-        QDECREF(value);
+        qobject_unref(value);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "invalid conf option %s", key);
-            QDECREF(name);
+            qobject_unref(name);
             ret =3D -EINVAL;
             break;
         }
-        QDECREF(name);
+        qobject_unref(name);
     }
=20
-    QDECREF(keypairs);
+    qobject_unref(keypairs);
     return ret;
 }
=20
@@ -449,7 +449,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const=
 char *filename,
     }
=20
 exit:
-    QDECREF(options);
+    qobject_unref(options);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
@@ -663,7 +663,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict =
*options, int flags,
     v =3D qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevOptionsRbd(v, NULL, &opts, &local_err);
     visit_free(v);
-    qobject_decref(crumpled);
+    qobject_unref(crumpled);
=20
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 387f59c8aa..07529f4b1b 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -567,8 +567,8 @@ static SocketAddress *sd_server_config(QDict *options=
, Error **errp)
=20
 done:
     visit_free(iv);
-    qobject_decref(crumpled_server);
-    QDECREF(server);
+    qobject_unref(crumpled_server);
+    qobject_unref(server);
     return saddr;
 }
=20
@@ -1883,7 +1883,7 @@ static int sd_create_prealloc(BlockdevOptionsSheepd=
og *location, int64_t size,
=20
     if (local_err) {
         error_propagate(errp, local_err);
-        qobject_decref(obj);
+        qobject_unref(obj);
         return -EINVAL;
     }
=20
@@ -1901,7 +1901,7 @@ static int sd_create_prealloc(BlockdevOptionsSheepd=
og *location, int64_t size,
     ret =3D sd_prealloc(bs, 0, size, errp);
 fail:
     bdrv_unref(bs);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     return ret;
 }
=20
@@ -2226,7 +2226,7 @@ static int coroutine_fn sd_co_create_opts(const cha=
r *filename, QemuOpts *opts,
     v =3D qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_er=
r);
     visit_free(v);
-    qobject_decref(crumpled);
+    qobject_unref(crumpled);
=20
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2252,7 +2252,7 @@ static int coroutine_fn sd_co_create_opts(const cha=
r *filename, QemuOpts *opts,
     ret =3D sd_co_create(create_options, errp);
 fail:
     qapi_free_BlockdevCreateOptions(create_options);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     return ret;
 }
=20
diff --git a/block/snapshot.c b/block/snapshot.c
index eacc1f19a2..2953d96c06 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -214,7 +214,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         bdrv_ref(file);
=20
         qdict_extract_subqdict(options, &file_options, "file.");
-        QDECREF(file_options);
+        qobject_unref(file_options);
         qdict_put_str(options, "file", bdrv_get_node_name(file));
=20
         drv->bdrv_close(bs);
@@ -223,7 +223,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
=20
         ret =3D bdrv_snapshot_goto(file, snapshot_id, errp);
         open_ret =3D drv->bdrv_open(bs, options, bs->open_flags, &local_=
err);
-        QDECREF(options);
+        qobject_unref(options);
         if (open_ret < 0) {
             bdrv_unref(file);
             bs->drv =3D NULL;
diff --git a/block/ssh.c b/block/ssh.c
index ab3acf0c22..412a1bfc17 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -638,7 +638,7 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *o=
ptions, Error **errp)
     v =3D qobject_input_visitor_new(crumpled);
     visit_type_BlockdevOptionsSsh(v, NULL, &result, &local_err);
     visit_free(v);
-    qobject_decref(crumpled);
+    qobject_unref(crumpled);
=20
     if (local_err) {
         error_propagate(errp, local_err);
@@ -917,7 +917,7 @@ static int coroutine_fn ssh_co_create_opts(const char=
 *filename, QemuOpts *opts,
     ret =3D ssh_co_create(create_options, errp);
=20
  out:
-    QDECREF(uri_options);
+    qobject_unref(uri_options);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
diff --git a/block/vdi.c b/block/vdi.c
index 4a2d1ff88d..96a22b8e83 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -951,7 +951,7 @@ static int coroutine_fn vdi_co_create_opts(const char=
 *filename, QemuOpts *opts,
     /* Create the vdi image (format layer) */
     ret =3D vdi_co_do_create(create_options, block_size, errp);
 done:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     qapi_free_BlockdevCreateOptions(create_options);
     bdrv_unref(bs_file);
     return ret;
diff --git a/block/vhdx.c b/block/vhdx.c
index 6ac0424f61..c3a4220a35 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2003,7 +2003,7 @@ static int coroutine_fn vhdx_co_create_opts(const c=
har *filename,
     qdict_put_str(qdict, "file", bs->node_name);
=20
     qobj =3D qdict_crumple(qdict, errp);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     qdict =3D qobject_to(QDict, qobj);
     if (qdict =3D=3D NULL) {
         ret =3D -EINVAL;
@@ -2049,7 +2049,7 @@ static int coroutine_fn vhdx_co_create_opts(const c=
har *filename,
     ret =3D vhdx_co_create(create_options, errp);
=20
 fail:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     bdrv_unref(bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
diff --git a/block/vpc.c b/block/vpc.c
index 44f99a4d1b..0ebfcd3cc8 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1119,7 +1119,7 @@ static int coroutine_fn vpc_co_create_opts(const ch=
ar *filename,
     qdict_put_str(qdict, "file", bs->node_name);
=20
     qobj =3D qdict_crumple(qdict, errp);
-    QDECREF(qdict);
+    qobject_unref(qdict);
     qdict =3D qobject_to(QDict, qobj);
     if (qdict =3D=3D NULL) {
         ret =3D -EINVAL;
@@ -1157,7 +1157,7 @@ static int coroutine_fn vpc_co_create_opts(const ch=
ar *filename,
     ret =3D vpc_co_create(create_options, errp);
=20
 fail:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     bdrv_unref(bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
diff --git a/block/vvfat.c b/block/vvfat.c
index 1569783b0f..662dca0114 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3179,7 +3179,7 @@ static int enable_write_target(BlockDriverState *bs=
, Error **errp)
     qdict_put_str(options, "write-target.driver", "qcow");
     s->qcow =3D bdrv_open_child(s->qcow_filename, options, "write-target=
", bs,
                               &child_vvfat_qcow, false, errp);
-    QDECREF(options);
+    qobject_unref(options);
     if (!s->qcow) {
         ret =3D -EINVAL;
         goto err;
diff --git a/block/vxhs.c b/block/vxhs.c
index 75cc6c8672..55ae1a666e 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -396,7 +396,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *opt=
ions,
=20
 out:
     g_free(of_vsa_addr);
-    QDECREF(backing_options);
+    qobject_unref(backing_options);
     qemu_opts_del(tcp_opts);
     qemu_opts_del(opts);
     g_free(cacert);
diff --git a/blockdev.c b/blockdev.c
index c31bf3d98d..3808b1fc00 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -576,7 +576,7 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
         blk_rs->read_only     =3D read_only;
         blk_rs->detect_zeroes =3D detect_zeroes;
=20
-        QDECREF(bs_opts);
+        qobject_unref(bs_opts);
     } else {
         if (file && !*file) {
             file =3D NULL;
@@ -632,16 +632,16 @@ static BlockBackend *blockdev_init(const char *file=
, QDict *bs_opts,
=20
 err_no_bs_opts:
     qemu_opts_del(opts);
-    QDECREF(interval_dict);
-    QDECREF(interval_list);
+    qobject_unref(interval_dict);
+    qobject_unref(interval_list);
     return blk;
=20
 early_err:
     qemu_opts_del(opts);
-    QDECREF(interval_dict);
-    QDECREF(interval_list);
+    qobject_unref(interval_dict);
+    qobject_unref(interval_list);
 err_no_opts:
-    QDECREF(bs_opts);
+    qobject_unref(bs_opts);
     return NULL;
 }
=20
@@ -1130,7 +1130,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInter=
faceType block_default_type)
=20
 fail:
     qemu_opts_del(legacy_opts);
-    QDECREF(bs_opts);
+    qobject_unref(bs_opts);
     return dinfo;
 }
=20
@@ -4022,7 +4022,7 @@ void hmp_drive_add_node(Monitor *mon, const char *o=
ptstr)
     qdict =3D qemu_opts_to_qdict(opts, NULL);
=20
     if (!qdict_get_try_str(qdict, "node-name")) {
-        QDECREF(qdict);
+        qobject_unref(qdict);
         error_report("'node-name' needs to be specified");
         goto out;
     }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3cf2a1679c..c634dcad1d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -198,21 +198,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     } else {
         pm->s3_disabled =3D false;
     }
-    qobject_decref(o);
+    qobject_unref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
     if (o) {
         pm->s4_disabled =3D qnum_get_uint(qobject_to(QNum, o));
     } else {
         pm->s4_disabled =3D false;
     }
-    qobject_decref(o);
+    qobject_unref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
     if (o) {
         pm->s4_val =3D qnum_get_uint(qobject_to(QNum, o));
     } else {
         pm->s4_val =3D false;
     }
-    qobject_decref(o);
+    qobject_unref(o);
=20
     pm->pcihp_bridge_en =3D
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-supp=
ort",
@@ -570,7 +570,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
         }
     }
     aml_append(parent_scope, method);
-    qobject_decref(bsel);
+    qobject_unref(bsel);
 }
=20
 /**
@@ -2614,12 +2614,12 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
         return false;
     }
     mcfg->mcfg_base =3D qnum_get_uint(qobject_to(QNum, o));
-    qobject_decref(o);
+    qobject_unref(o);
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
     assert(o);
     mcfg->mcfg_size =3D qnum_get_uint(qobject_to(QNum, o));
-    qobject_decref(o);
+    qobject_unref(o);
     return true;
 }
=20
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index aa251133de..8a045d6b93 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -305,7 +305,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
=20
     if (!drc->fdt) {
         visit_type_null(v, NULL, &null, errp);
-        QDECREF(null);
+        qobject_unref(null);
         return;
     }
=20
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 3beeb0d170..b3a90c0e68 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -763,7 +763,7 @@ static void usbback_portid_add(struct usbback_info *u=
sbif, unsigned port,
     if (!usbif->ports[port - 1].dev) {
         goto err;
     }
-    QDECREF(qdict);
+    qobject_unref(qdict);
     speed =3D usbif->ports[port - 1].dev->speed;
     switch (speed) {
     case USB_SPEED_LOW:
@@ -796,7 +796,7 @@ static void usbback_portid_add(struct usbback_info *u=
sbif, unsigned port,
     return;
=20
 err:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     xen_pv_printf(&usbif->xendev, 0, "device %s could not be opened\n", =
busid);
 }
=20
diff --git a/migration/migration.c b/migration/migration.c
index 52a5092add..48ce4a6624 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1006,14 +1006,14 @@ void qmp_migrate_set_parameters(MigrateSetParamet=
ers *params, Error **errp)
     /* TODO Rewrite "" to null instead */
     if (params->has_tls_creds
         && params->tls_creds->type =3D=3D QTYPE_QNULL) {
-        QDECREF(params->tls_creds->u.n);
+        qobject_unref(params->tls_creds->u.n);
         params->tls_creds->type =3D QTYPE_QSTRING;
         params->tls_creds->u.s =3D strdup("");
     }
     /* TODO Rewrite "" to null instead */
     if (params->has_tls_hostname
         && params->tls_hostname->type =3D=3D QTYPE_QNULL) {
-        QDECREF(params->tls_hostname->u.n);
+        qobject_unref(params->tls_hostname->u.n);
         params->tls_hostname->type =3D QTYPE_QSTRING;
         params->tls_hostname->u.s =3D strdup("");
     }
diff --git a/migration/qjson.c b/migration/qjson.c
index 9d7f6eb9eb..e9889bdcb0 100644
--- a/migration/qjson.c
+++ b/migration/qjson.c
@@ -109,6 +109,6 @@ void qjson_finish(QJSON *json)
=20
 void qjson_destroy(QJSON *json)
 {
-    QDECREF(json->str);
+    qobject_unref(json->str);
     g_free(json);
 }
diff --git a/monitor.c b/monitor.c
index 51f4cf480f..9d2b89431e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -329,8 +329,8 @@ int monitor_read_password(Monitor *mon, ReadLineFunc =
*readline_func,
=20
 static void qmp_request_free(QMPRequest *req)
 {
-    qobject_decref(req->id);
-    qobject_decref(req->req);
+    qobject_unref(req->id);
+    qobject_unref(req->req);
     g_free(req);
 }
=20
@@ -346,7 +346,7 @@ static void monitor_qmp_cleanup_req_queue_locked(Moni=
tor *mon)
 static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
 {
     while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
-        qobject_decref(g_queue_pop_head(mon->qmp.qmp_responses));
+        qobject_unref((QObject *)g_queue_pop_head(mon->qmp.qmp_responses=
));
     }
 }
=20
@@ -391,14 +391,14 @@ static void monitor_flush_locked(Monitor *mon)
         rc =3D qemu_chr_fe_write(&mon->chr, (const uint8_t *) buf, len);
         if ((rc < 0 && errno !=3D EAGAIN) || (rc =3D=3D len)) {
             /* all flushed or error */
-            QDECREF(mon->outbuf);
+            qobject_unref(mon->outbuf);
             mon->outbuf =3D qstring_new();
             return;
         }
         if (rc > 0) {
             /* partial write */
             QString *tmp =3D qstring_from_str(buf + rc);
-            QDECREF(mon->outbuf);
+            qobject_unref(mon->outbuf);
             mon->outbuf =3D tmp;
         }
         if (mon->out_watch =3D=3D 0) {
@@ -482,7 +482,7 @@ static void monitor_json_emitter_raw(Monitor *mon,
     qstring_append_chr(json, '\n');
     monitor_puts(mon, qstring_get_str(json));
=20
-    QDECREF(json);
+    qobject_unref(json);
 }
=20
 static void monitor_json_emitter(Monitor *mon, QObject *data)
@@ -494,9 +494,9 @@ static void monitor_json_emitter(Monitor *mon, QObjec=
t *data)
          * caller won't free the data (which will be finally freed in
          * responder thread).
          */
-        qobject_incref(data);
+        qobject_ref(data);
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        g_queue_push_tail(mon->qmp.qmp_responses, (void *)data);
+        g_queue_push_tail(mon->qmp.qmp_responses, data);
         qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
         qemu_bh_schedule(mon_global.qmp_respond_bh);
     } else {
@@ -546,7 +546,7 @@ static void monitor_qmp_bh_responder(void *opaque)
             break;
         }
         monitor_json_emitter_raw(response.mon, response.data);
-        qobject_decref(response.data);
+        qobject_unref(response.data);
     }
 }
=20
@@ -613,9 +613,9 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdic=
t, Error **errp)
              * last send.  Store event for sending when timer fires,
              * replacing a prior stored event if any.
              */
-            QDECREF(evstate->qdict);
+            qobject_unref(evstate->qdict);
             evstate->qdict =3D qdict;
-            QINCREF(evstate->qdict);
+            qobject_ref(evstate->qdict);
         } else {
             /*
              * Last send was (at least) evconf->rate ns ago.
@@ -630,7 +630,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdic=
t, Error **errp)
             evstate =3D g_new(MonitorQAPIEventState, 1);
             evstate->event =3D event;
             evstate->data =3D data;
-            QINCREF(evstate->data);
+            qobject_ref(evstate->data);
             evstate->qdict =3D NULL;
             evstate->timer =3D timer_new_ns(event_clock_type,
                                           monitor_qapi_event_handler,
@@ -660,12 +660,12 @@ static void monitor_qapi_event_handler(void *opaque=
)
         int64_t now =3D qemu_clock_get_ns(event_clock_type);
=20
         monitor_qapi_event_emit(evstate->event, evstate->qdict);
-        QDECREF(evstate->qdict);
+        qobject_unref(evstate->qdict);
         evstate->qdict =3D NULL;
         timer_mod_ns(evstate->timer, now + evconf->rate);
     } else {
         g_hash_table_remove(monitor_qapi_event_state, evstate);
-        QDECREF(evstate->data);
+        qobject_unref(evstate->data);
         timer_free(evstate->timer);
         g_free(evstate);
     }
@@ -747,7 +747,7 @@ static void monitor_data_destroy(Monitor *mon)
         json_message_parser_destroy(&mon->qmp.parser);
     }
     readline_free(mon->rs);
-    QDECREF(mon->outbuf);
+    qobject_unref(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
@@ -3362,7 +3362,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
     return qdict;
=20
 fail:
-    QDECREF(qdict);
+    qobject_unref(qdict);
     g_free(key);
     return NULL;
 }
@@ -3387,7 +3387,7 @@ static void handle_hmp_command(Monitor *mon, const =
char *cmdline)
     }
=20
     cmd->cmd(mon, qdict);
-    QDECREF(qdict);
+    qobject_unref(qdict);
 }
=20
 static void cmd_completion(Monitor *mon, const char *name, const char *l=
ist)
@@ -4049,15 +4049,15 @@ static void monitor_qmp_respond(Monitor *mon, QOb=
ject *rsp,
     if (rsp) {
         if (id) {
             /* This is for the qdict below. */
-            qobject_incref(id);
+            qobject_ref(id);
             qdict_put_obj(qobject_to(QDict, rsp), "id", id);
         }
=20
         monitor_json_emitter(mon, rsp);
     }
=20
-    qobject_decref(id);
-    qobject_decref(rsp);
+    qobject_unref(id);
+    qobject_unref(rsp);
 }
=20
 /*
@@ -4080,7 +4080,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
     if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
         QString *req_json =3D qobject_to_json(req);
         trace_handle_qmp_command(mon, qstring_get_str(req_json));
-        QDECREF(req_json);
+        qobject_unref(req_json);
     }
=20
     old_mon =3D cur_mon;
@@ -4098,7 +4098,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
         monitor_resume(mon);
     }
=20
-    qobject_decref(req);
+    qobject_unref(req);
 }
=20
 /*
@@ -4190,7 +4190,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         goto err;
     }
=20
-    qobject_incref(id);
+    qobject_ref(id);
     qdict_del(qdict, "id");
=20
     req_obj =3D g_new0(QMPRequest, 1);
@@ -4245,7 +4245,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
=20
 err:
     monitor_qmp_respond(mon, NULL, err, NULL);
-    qobject_decref(req);
+    qobject_unref(req);
 }
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
@@ -4364,7 +4364,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
         monitor_qmp_caps_reset(mon);
         data =3D get_qmp_greeting(mon);
         monitor_json_emitter(mon, data);
-        qobject_decref(data);
+        qobject_unref(data);
         mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index fd23803166..6b24afd367 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -99,7 +99,7 @@ static void qapi_dealloc_type_anything(Visitor *v, cons=
t char *name,
                                        QObject **obj, Error **errp)
 {
     if (obj) {
-        qobject_decref(*obj);
+        qobject_unref(*obj);
     }
 }
=20
@@ -107,7 +107,7 @@ static void qapi_dealloc_type_null(Visitor *v, const =
char *name,
                                    QNull **obj, Error **errp)
 {
     if (obj) {
-        QDECREF(*obj);
+        qobject_unref(*obj);
     }
 }
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index dd05907265..f9377b27fd 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -105,7 +105,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
         args =3D qdict_new();
     } else {
         args =3D qdict_get_qdict(dict, "arguments");
-        QINCREF(args);
+        qobject_ref(args);
     }
=20
     cmd->fn(args, &ret, &local_err);
@@ -117,7 +117,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
         ret =3D QOBJECT(qdict_new());
     }
=20
-    QDECREF(args);
+    qobject_unref(args);
=20
     return ret;
 }
@@ -166,7 +166,7 @@ QObject *qmp_dispatch(QmpCommandList *cmds, QObject *=
request)
     } else if (ret) {
         qdict_put_obj(rsp, "return", ret);
     } else {
-        QDECREF(rsp);
+        qobject_unref(rsp);
         return NULL;
     }
=20
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index a7569d5dce..7a290c4a3f 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -588,7 +588,7 @@ static void qobject_input_type_any(Visitor *v, const =
char *name, QObject **obj,
         return;
     }
=20
-    qobject_incref(qobj);
+    qobject_ref(qobj);
     *obj =3D qobj;
 }
=20
@@ -652,7 +652,7 @@ static void qobject_input_free(Visitor *v)
         qobject_input_stack_object_free(tos);
     }
=20
-    qobject_decref(qiv->root);
+    qobject_unref(qiv->root);
     if (qiv->errname) {
         g_string_free(qiv->errname, TRUE);
     }
@@ -678,7 +678,7 @@ static QObjectInputVisitor *qobject_input_visitor_bas=
e_new(QObject *obj)
     v->visitor.free =3D qobject_input_free;
=20
     v->root =3D obj;
-    qobject_incref(obj);
+    qobject_ref(obj);
=20
     return v;
 }
@@ -744,7 +744,7 @@ Visitor *qobject_input_visitor_new_str(const char *st=
r,
         }
         v =3D qobject_input_visitor_new_keyval(QOBJECT(args));
     }
-    QDECREF(args);
+    qobject_unref(args);
=20
     return v;
 }
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 877e37eeb8..3a933b489b 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -188,7 +188,7 @@ static void qobject_output_type_any(Visitor *v, const=
 char *name,
                                     QObject **obj, Error **errp)
 {
     QObjectOutputVisitor *qov =3D to_qov(v);
-    qobject_incref(*obj);
+    qobject_ref(*obj);
     qobject_output_add_obj(qov, name, *obj);
 }
=20
@@ -201,7 +201,7 @@ static void qobject_output_type_null(Visitor *v, cons=
t char *name,
=20
 /* Finish building, and return the root object.
  * The root object is never null. The caller becomes the object's
- * owner, and should use qobject_decref() when done with it.  */
+ * owner, and should use qobject_unref() when done with it.  */
 static void qobject_output_complete(Visitor *v, void *opaque)
 {
     QObjectOutputVisitor *qov =3D to_qov(v);
@@ -210,7 +210,7 @@ static void qobject_output_complete(Visitor *v, void =
*opaque)
     assert(qov->root && QSLIST_EMPTY(&qov->stack));
     assert(opaque =3D=3D qov->result);
=20
-    qobject_incref(qov->root);
+    qobject_ref(qov->root);
     *qov->result =3D qov->root;
     qov->result =3D NULL;
 }
@@ -226,7 +226,7 @@ static void qobject_output_free(Visitor *v)
         g_free(e);
     }
=20
-    qobject_decref(qov->root);
+    qobject_unref(qov->root);
     g_free(qov);
 }
=20
diff --git a/qemu-img.c b/qemu-img.c
index 855fa52514..ea62d2d61e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -279,7 +279,7 @@ static BlockBackend *img_open_opts(const char *optstr=
,
         if (qdict_haskey(options, BDRV_OPT_FORCE_SHARE)
             && !qdict_get_bool(options, BDRV_OPT_FORCE_SHARE)) {
             error_report("--force-share/-U conflicts with image options"=
);
-            QDECREF(options);
+            qobject_unref(options);
             return NULL;
         }
         qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
@@ -561,9 +561,9 @@ static void dump_json_image_check(ImageCheck *check, =
bool quiet)
     str =3D qobject_to_json_pretty(obj);
     assert(str !=3D NULL);
     qprintf(quiet, "%s\n", qstring_get_str(str));
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_free(v);
-    QDECREF(str);
+    qobject_unref(str);
 }
=20
 static void dump_human_image_check(ImageCheck *check, bool quiet)
@@ -2384,9 +2384,9 @@ static void dump_json_image_info_list(ImageInfoList=
 *list)
     str =3D qobject_to_json_pretty(obj);
     assert(str !=3D NULL);
     printf("%s\n", qstring_get_str(str));
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_free(v);
-    QDECREF(str);
+    qobject_unref(str);
 }
=20
 static void dump_json_image_info(ImageInfo *info)
@@ -2400,9 +2400,9 @@ static void dump_json_image_info(ImageInfo *info)
     str =3D qobject_to_json_pretty(obj);
     assert(str !=3D NULL);
     printf("%s\n", qstring_get_str(str));
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_free(v);
-    QDECREF(str);
+    qobject_unref(str);
 }
=20
 static void dump_human_image_info_list(ImageInfoList *list)
@@ -4457,9 +4457,9 @@ static void dump_json_block_measure_info(BlockMeasu=
reInfo *info)
     str =3D qobject_to_json_pretty(obj);
     assert(str !=3D NULL);
     printf("%s\n", qstring_get_str(str));
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_free(v);
-    QDECREF(str);
+    qobject_unref(str);
 }
=20
 static int img_measure(int argc, char **argv)
diff --git a/qemu-io.c b/qemu-io.c
index e692c555e0..72fee0d8b7 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -86,7 +86,7 @@ static int openfile(char *name, int flags, bool writeth=
rough, bool force_share,
=20
     if (qemuio_blk) {
         error_report("file open already, try 'help close'");
-        QDECREF(opts);
+        qobject_unref(opts);
         return 1;
     }
=20
@@ -97,7 +97,7 @@ static int openfile(char *name, int flags, bool writeth=
rough, bool force_share,
         if (qdict_haskey(opts, BDRV_OPT_FORCE_SHARE)
             && !qdict_get_bool(opts, BDRV_OPT_FORCE_SHARE)) {
             error_report("-U conflicts with image options");
-            QDECREF(opts);
+            qobject_unref(opts);
             return 1;
         }
         qdict_put_bool(opts, BDRV_OPT_FORCE_SHARE, true);
@@ -243,7 +243,7 @@ static int open_f(BlockBackend *blk, int argc, char *=
*argv)
     } else if (optind =3D=3D argc) {
         openfile(NULL, flags, writethrough, force_share, opts);
     } else {
-        QDECREF(opts);
+        qobject_unref(opts);
         qemuio_command_usage(&open_cmd);
     }
     return 0;
diff --git a/qga/main.c b/qga/main.c
index df1888edc1..1e1cec708f 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -563,7 +563,7 @@ static int send_response(GAState *s, QObject *payload=
)
         response_qstr =3D qstring_new();
         qstring_append_chr(response_qstr, QGA_SENTINEL_BYTE);
         qstring_append(response_qstr, qstring_get_str(payload_qstr));
-        QDECREF(payload_qstr);
+        qobject_unref(payload_qstr);
     } else {
         response_qstr =3D payload_qstr;
     }
@@ -571,7 +571,7 @@ static int send_response(GAState *s, QObject *payload=
)
     qstring_append_chr(response_qstr, '\n');
     buf =3D qstring_get_str(response_qstr);
     status =3D ga_channel_write_all(s->channel, buf, strlen(buf));
-    QDECREF(response_qstr);
+    qobject_unref(response_qstr);
     if (status !=3D G_IO_STATUS_NORMAL) {
         return -EIO;
     }
@@ -592,7 +592,7 @@ static void process_command(GAState *s, QDict *req)
         if (ret < 0) {
             g_warning("error sending response: %s", strerror(-ret));
         }
-        qobject_decref(rsp);
+        qobject_unref(rsp);
     }
 }
=20
@@ -609,7 +609,7 @@ static void process_event(JSONMessageParser *parser, =
GQueue *tokens)
     g_debug("process_event: called");
     qdict =3D qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err=
));
     if (err || !qdict) {
-        QDECREF(qdict);
+        qobject_unref(qdict);
         qdict =3D qdict_new();
         if (!err) {
             g_warning("failed to parse event: unknown error");
@@ -626,7 +626,7 @@ static void process_event(JSONMessageParser *parser, =
GQueue *tokens)
         process_command(s, qdict);
     } else {
         if (!qdict_haskey(qdict, "error")) {
-            QDECREF(qdict);
+            qobject_unref(qdict);
             qdict =3D qdict_new();
             g_warning("unrecognized payload format");
             error_setg(&err, QERR_UNSUPPORTED);
@@ -639,7 +639,7 @@ static void process_event(JSONMessageParser *parser, =
GQueue *tokens)
         }
     }
=20
-    QDECREF(qdict);
+    qobject_unref(qdict);
 }
=20
 /* false return signals GAChannel to close the current client connection=
 */
diff --git a/qmp.c b/qmp.c
index f72261667f..9e95b889ff 100644
--- a/qmp.c
+++ b/qmp.c
@@ -710,7 +710,7 @@ void qmp_object_add(const char *type, const char *id,
             error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict=
");
             return;
         }
-        QINCREF(pdict);
+        qobject_ref(pdict);
     } else {
         pdict =3D qdict_new();
     }
@@ -721,7 +721,7 @@ void qmp_object_add(const char *type, const char *id,
     if (obj) {
         object_unref(obj);
     }
-    QDECREF(pdict);
+    qobject_unref(pdict);
 }
=20
 void qmp_object_del(const char *id, Error **errp)
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 769b960c9f..a5aa790d62 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -222,7 +222,7 @@ static QString *qstring_from_escaped_str(JSONParserCo=
ntext *ctxt,
     return str;
=20
 out:
-    QDECREF(str);
+    qobject_unref(str);
     return NULL;
 }
=20
@@ -311,12 +311,12 @@ static int parse_pair(JSONParserContext *ctxt, QDic=
t *dict, va_list *ap)
=20
     qdict_put_obj(dict, qstring_get_str(key), value);
=20
-    QDECREF(key);
+    qobject_unref(key);
=20
     return 0;
=20
 out:
-    QDECREF(key);
+    qobject_unref(key);
=20
     return -1;
 }
@@ -371,7 +371,7 @@ static QObject *parse_object(JSONParserContext *ctxt,=
 va_list *ap)
     return QOBJECT(dict);
=20
 out:
-    QDECREF(dict);
+    qobject_unref(dict);
     return NULL;
 }
=20
@@ -435,7 +435,7 @@ static QObject *parse_array(JSONParserContext *ctxt, =
va_list *ap)
     return QOBJECT(list);
=20
 out:
-    QDECREF(list);
+    qobject_unref(list);
     return NULL;
 }
=20
diff --git a/qobject/qdict.c b/qobject/qdict.c
index d1997a0d8a..2e9bd53e22 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -123,7 +123,7 @@ void qdict_put_obj(QDict *qdict, const char *key, QOb=
ject *value)
     entry =3D qdict_find(qdict, key, bucket);
     if (entry) {
         /* replace key's value */
-        qobject_decref(entry->value);
+        qobject_unref(entry->value);
         entry->value =3D value;
     } else {
         /* allocate a new entry */
@@ -373,7 +373,7 @@ QDict *qdict_clone_shallow(const QDict *src)
=20
     for (i =3D 0; i < QDICT_BUCKET_MAX; i++) {
         QLIST_FOREACH(entry, &src->table[i], next) {
-            qobject_incref(entry->value);
+            qobject_ref(entry->value);
             qdict_put_obj(dest, entry->key, entry->value);
         }
     }
@@ -390,7 +390,7 @@ static void qentry_destroy(QDictEntry *e)
     assert(e->key !=3D NULL);
     assert(e->value !=3D NULL);
=20
-    qobject_decref(e->value);
+    qobject_unref(e->value);
     g_free(e->key);
     g_free(e);
 }
@@ -480,7 +480,7 @@ void qdict_copy_default(QDict *dst, QDict *src, const=
 char *key)
=20
     val =3D qdict_get(src, key);
     if (val) {
-        qobject_incref(val);
+        qobject_ref(val);
         qdict_put_obj(dst, key, val);
     }
 }
@@ -526,7 +526,7 @@ static void qdict_flatten_qlist(QList *qlist, QDict *=
target, const char *prefix)
             qdict_flatten_qlist(qobject_to(QList, value), target, new_ke=
y);
         } else {
             /* All other types are moved to the target unchanged. */
-            qobject_incref(value);
+            qobject_ref(value);
             qdict_put_obj(target, new_key, value);
         }
=20
@@ -566,7 +566,7 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *=
target, const char *prefix)
             delete =3D true;
         } else if (prefix) {
             /* All other objects are moved to the target unchanged. */
-            qobject_incref(value);
+            qobject_ref(value);
             qdict_put_obj(target, new_key, value);
             delete =3D true;
         }
@@ -610,7 +610,7 @@ void qdict_extract_subqdict(QDict *src, QDict **dst, =
const char *start)
     while (entry !=3D NULL) {
         next =3D qdict_next(src, entry);
         if (strstart(entry->key, start, &p)) {
-            qobject_incref(entry->value);
+            qobject_ref(entry->value);
             qdict_put_obj(*dst, p, entry->value);
             qdict_del(src, entry->key);
         }
@@ -684,7 +684,7 @@ void qdict_array_split(QDict *src, QList **dst)
             qdict_extract_subqdict(src, &subqdict, prefix);
             assert(qdict_size(subqdict) > 0);
         } else {
-            qobject_incref(subqobj);
+            qobject_ref(subqobj);
             qdict_del(src, indexstr);
         }
=20
@@ -894,7 +894,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp=
)
                 qdict_put_obj(two_level, prefix, QOBJECT(child_dict));
             }
=20
-            qobject_incref(ent->value);
+            qobject_ref(ent->value);
             qdict_put_obj(child_dict, suffix, ent->value);
         } else {
             if (child) {
@@ -902,7 +902,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp=
)
                            prefix);
                 goto error;
             }
-            qobject_incref(ent->value);
+            qobject_ref(ent->value);
             qdict_put_obj(two_level, prefix, ent->value);
         }
=20
@@ -924,11 +924,11 @@ QObject *qdict_crumple(const QDict *src, Error **er=
rp)
=20
             qdict_put_obj(multi_level, ent->key, child);
         } else {
-            qobject_incref(ent->value);
+            qobject_ref(ent->value);
             qdict_put_obj(multi_level, ent->key, ent->value);
         }
     }
-    QDECREF(two_level);
+    qobject_unref(two_level);
     two_level =3D NULL;
=20
     /* Step 3: detect if we need to turn our dict into list */
@@ -951,10 +951,10 @@ QObject *qdict_crumple(const QDict *src, Error **er=
rp)
                 goto error;
             }
=20
-            qobject_incref(child);
+            qobject_ref(child);
             qlist_append_obj(qobject_to(QList, dst), child);
         }
-        QDECREF(multi_level);
+        qobject_unref(multi_level);
         multi_level =3D NULL;
     } else {
         dst =3D QOBJECT(multi_level);
@@ -964,9 +964,9 @@ QObject *qdict_crumple(const QDict *src, Error **errp=
)
=20
  error:
     g_free(prefix);
-    QDECREF(multi_level);
-    QDECREF(two_level);
-    qobject_decref(dst);
+    qobject_unref(multi_level);
+    qobject_unref(two_level);
+    qobject_unref(dst);
     return NULL;
 }
=20
@@ -1055,7 +1055,7 @@ void qdict_join(QDict *dest, QDict *src, bool overw=
rite)
         next =3D qdict_next(src, entry);
=20
         if (overwrite || !qdict_haskey(dest, entry->key)) {
-            qobject_incref(entry->value);
+            qobject_ref(entry->value);
             qdict_put_obj(dest, entry->key, entry->value);
             qdict_del(src, entry->key);
         }
@@ -1088,7 +1088,7 @@ bool qdict_rename_keys(QDict *qdict, const QDictRen=
ames *renames, Error **errp)
             }
=20
             qobj =3D qdict_get(qdict, renames->from);
-            qobject_incref(qobj);
+            qobject_ref(qobj);
             qdict_put_obj(qdict, renames->to, qobj);
             qdict_del(qdict, renames->from);
         }
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 655d38adf1..9816a65c7d 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -104,7 +104,7 @@ static void to_json_dict_iter(const char *key, QObjec=
t *obj, void *opaque)
=20
     qkey =3D qstring_from_str(key);
     to_json(QOBJECT(qkey), s->str, s->pretty, s->indent);
-    QDECREF(qkey);
+    qobject_unref(qkey);
=20
     qstring_append(s->str, ": ");
     to_json(obj, s->str, s->pretty, s->indent);
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 954fe98375..37c1c167f1 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -39,7 +39,7 @@ static void qlist_copy_elem(QObject *obj, void *opaque)
 {
     QList *dst =3D opaque;
=20
-    qobject_incref(obj);
+    qobject_ref(obj);
     qlist_append_obj(dst, obj);
 }
=20
@@ -196,7 +196,7 @@ void qlist_destroy_obj(QObject *obj)
=20
     QTAILQ_FOREACH_SAFE(entry, &qlist->head, next, next_entry) {
         QTAILQ_REMOVE(&qlist->head, entry, next);
-        qobject_decref(entry->value);
+        qobject_unref(entry->value);
         g_free(entry);
     }
=20
diff --git a/qom/object.c b/qom/object.c
index 467795189c..76a89af99b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1129,7 +1129,7 @@ void object_property_set_str(Object *obj, const cha=
r *value,
     QString *qstr =3D qstring_from_str(value);
     object_property_set_qobject(obj, QOBJECT(qstr), name, errp);
=20
-    QDECREF(qstr);
+    qobject_unref(qstr);
 }
=20
 char *object_property_get_str(Object *obj, const char *name,
@@ -1147,7 +1147,7 @@ char *object_property_get_str(Object *obj, const ch=
ar *name,
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "string");
     }
=20
-    qobject_decref(ret);
+    qobject_unref(ret);
     return retval;
 }
=20
@@ -1187,7 +1187,7 @@ void object_property_set_bool(Object *obj, bool val=
ue,
     QBool *qbool =3D qbool_from_bool(value);
     object_property_set_qobject(obj, QOBJECT(qbool), name, errp);
=20
-    QDECREF(qbool);
+    qobject_unref(qbool);
 }
=20
 bool object_property_get_bool(Object *obj, const char *name,
@@ -1208,7 +1208,7 @@ bool object_property_get_bool(Object *obj, const ch=
ar *name,
         retval =3D qbool_get_bool(qbool);
     }
=20
-    qobject_decref(ret);
+    qobject_unref(ret);
     return retval;
 }
=20
@@ -1218,7 +1218,7 @@ void object_property_set_int(Object *obj, int64_t v=
alue,
     QNum *qnum =3D qnum_from_int(value);
     object_property_set_qobject(obj, QOBJECT(qnum), name, errp);
=20
-    QDECREF(qnum);
+    qobject_unref(qnum);
 }
=20
 int64_t object_property_get_int(Object *obj, const char *name,
@@ -1238,7 +1238,7 @@ int64_t object_property_get_int(Object *obj, const =
char *name,
         retval =3D -1;
     }
=20
-    qobject_decref(ret);
+    qobject_unref(ret);
     return retval;
 }
=20
@@ -1248,7 +1248,7 @@ void object_property_set_uint(Object *obj, uint64_t=
 value,
     QNum *qnum =3D qnum_from_uint(value);
=20
     object_property_set_qobject(obj, QOBJECT(qnum), name, errp);
-    QDECREF(qnum);
+    qobject_unref(qnum);
 }
=20
 uint64_t object_property_get_uint(Object *obj, const char *name,
@@ -1267,7 +1267,7 @@ uint64_t object_property_get_uint(Object *obj, cons=
t char *name,
         retval =3D 0;
     }
=20
-    qobject_decref(ret);
+    qobject_unref(ret);
     return retval;
 }
=20
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 2f76e1f36d..980ffc2ada 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -140,7 +140,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error=
 **errp)
     qemu_opts_set_id(opts, (char *) id);
     qemu_opt_set(opts, "qom-type", type, &error_abort);
     g_free(type);
-    QDECREF(pdict);
+    qobject_unref(pdict);
     return obj;
 }
=20
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 391b94b97d..17b06c75f3 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8351,7 +8351,7 @@ static void getset_compat_deprecated(Object *obj, V=
isitor *v, const char *name,
                      "use max-cpu-compat machine property instead");
     }
     visit_type_null(v, name, &null, NULL);
-    QDECREF(null);
+    qobject_unref(null);
 }
=20
 static const PropertyInfo ppc_compat_deprecated_propinfo =3D {
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2741b6803f..e10035aaa8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -551,7 +551,7 @@ static void cpu_info_from_model(CpuModelInfo *info, c=
onst S390CPUModel *model,
     }
=20
     if (!qdict_size(qdict)) {
-        QDECREF(qdict);
+        qobject_unref(qdict);
     } else {
         info->props =3D QOBJECT(qdict);
         info->has_props =3D true;
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index fb3cd84d07..1a7b761304 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1566,7 +1566,7 @@ static void atapi_wait_tray(bool open)
     } else {
         g_assert(!qdict_get_bool(data, "tray-open"));
     }
-    QDECREF(rsp);
+    qobject_unref(rsp);
 }
=20
 static void test_atapi_tray(void)
@@ -1596,7 +1596,7 @@ static void test_atapi_tray(void)
                "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(true);
     rsp =3D qmp_receive();
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     qmp_discard_response("{'execute': 'blockdev-remove-medium', "
                          "'arguments': {'id': 'cd0'}}");
@@ -1623,7 +1623,7 @@ static void test_atapi_tray(void)
                "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(false);
     rsp =3D qmp_receive();
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     /* Now, to convince ATAPI we understand the media has changed... */
     ahci_atapi_test_ready(ahci, port, false, SENSE_NOT_READY);
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 029b6b15b9..a0e0454684 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -34,7 +34,7 @@ static void qdict_new_test(void)
     g_assert(qdict->base.refcnt =3D=3D 1);
     g_assert(qobject_type(QOBJECT(qdict)) =3D=3D QTYPE_QDICT);
=20
-    QDECREF(qdict);
+    qobject_unref(qdict);
 }
=20
 static void qdict_put_obj_test(void)
@@ -54,7 +54,7 @@ static void qdict_put_obj_test(void)
     qn =3D qobject_to(QNum, ent->value);
     g_assert_cmpint(qnum_get_int(qn), =3D=3D, num);
=20
-    QDECREF(qdict);
+    qobject_unref(qdict);
 }
=20
 static void qdict_destroy_simple_test(void)
@@ -65,7 +65,7 @@ static void qdict_destroy_simple_test(void)
     qdict_put_int(qdict, "num", 0);
     qdict_put_str(qdict, "str", "foo");
=20
-    QDECREF(qdict);
+    qobject_unref(qdict);
 }
=20
 static void qdict_get_test(void)
@@ -84,7 +84,7 @@ static void qdict_get_test(void)
     qn =3D qobject_to(QNum, obj);
     g_assert_cmpint(qnum_get_int(qn), =3D=3D, value);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_get_int_test(void)
@@ -99,7 +99,7 @@ static void qdict_get_int_test(void)
     ret =3D qdict_get_int(tests_dict, key);
     g_assert(ret =3D=3D value);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_get_try_int_test(void)
@@ -121,7 +121,7 @@ static void qdict_get_try_int_test(void)
     ret =3D qdict_get_try_int(tests_dict, "string", -42);
     g_assert_cmpuint(ret, =3D=3D, -42);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_get_str_test(void)
@@ -137,7 +137,7 @@ static void qdict_get_str_test(void)
     g_assert(p !=3D NULL);
     g_assert(strcmp(p, str) =3D=3D 0);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_get_try_str_test(void)
@@ -153,7 +153,7 @@ static void qdict_get_try_str_test(void)
     g_assert(p !=3D NULL);
     g_assert(strcmp(p, str) =3D=3D 0);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_defaults_test(void)
@@ -174,8 +174,8 @@ static void qdict_defaults_test(void)
     qdict_copy_default(copy, dict, "bar");
     g_assert_cmpstr(qdict_get_str(copy, "bar"), =3D=3D, "xyz");
=20
-    QDECREF(copy);
-    QDECREF(dict);
+    qobject_unref(copy);
+    qobject_unref(dict);
 }
=20
 static void qdict_haskey_not_test(void)
@@ -183,7 +183,7 @@ static void qdict_haskey_not_test(void)
     QDict *tests_dict =3D qdict_new();
     g_assert(qdict_haskey(tests_dict, "test") =3D=3D 0);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_haskey_test(void)
@@ -194,7 +194,7 @@ static void qdict_haskey_test(void)
     qdict_put_int(tests_dict, key, 0);
     g_assert(qdict_haskey(tests_dict, key) =3D=3D 1);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_del_test(void)
@@ -210,7 +210,7 @@ static void qdict_del_test(void)
     g_assert(qdict_size(tests_dict) =3D=3D 0);
     g_assert(qdict_haskey(tests_dict, key) =3D=3D 0);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qobject_to_qdict_test(void)
@@ -218,7 +218,7 @@ static void qobject_to_qdict_test(void)
     QDict *tests_dict =3D qdict_new();
     g_assert(qobject_to(QDict, QOBJECT(tests_dict)) =3D=3D tests_dict);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_iterapi_test(void)
@@ -250,7 +250,7 @@ static void qdict_iterapi_test(void)
=20
     g_assert(count =3D=3D qdict_size(tests_dict));
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_flatten_test(void)
@@ -325,7 +325,7 @@ static void qdict_flatten_test(void)
=20
     g_assert(qdict_size(dict3) =3D=3D 8);
=20
-    QDECREF(dict3);
+    qobject_unref(dict3);
 }
=20
 static void qdict_array_split_test(void)
@@ -390,31 +390,31 @@ static void qdict_array_split_test(void)
     g_assert(int1);
     g_assert(qlist_empty(test_list));
=20
-    QDECREF(test_list);
+    qobject_unref(test_list);
=20
     g_assert(qdict_get_int(dict1, "a") =3D=3D 42);
     g_assert(qdict_get_int(dict1, "b") =3D=3D 23);
=20
     g_assert(qdict_size(dict1) =3D=3D 2);
=20
-    QDECREF(dict1);
+    qobject_unref(dict1);
=20
     g_assert(qdict_get_int(dict2, "x") =3D=3D 0);
=20
     g_assert(qdict_size(dict2) =3D=3D 1);
=20
-    QDECREF(dict2);
+    qobject_unref(dict2);
=20
     g_assert_cmpint(qnum_get_int(int1), =3D=3D, 66);
=20
-    QDECREF(int1);
+    qobject_unref(int1);
=20
     g_assert(qdict_get_int(test_dict, "4.y") =3D=3D 1);
     g_assert(qdict_get_int(test_dict, "o.o") =3D=3D 7);
=20
     g_assert(qdict_size(test_dict) =3D=3D 2);
=20
-    QDECREF(test_dict);
+    qobject_unref(test_dict);
=20
     /*
      * Test the split of
@@ -455,18 +455,18 @@ static void qdict_array_split_test(void)
     g_assert(int1);
     g_assert(qlist_empty(test_list));
=20
-    QDECREF(test_list);
+    qobject_unref(test_list);
=20
     g_assert_cmpint(qnum_get_int(int1), =3D=3D, 42);
=20
-    QDECREF(int1);
+    qobject_unref(int1);
=20
     g_assert(qdict_get_int(test_dict, "1") =3D=3D 23);
     g_assert(qdict_get_int(test_dict, "1.x") =3D=3D 84);
=20
     g_assert(qdict_size(test_dict) =3D=3D 2);
=20
-    QDECREF(test_dict);
+    qobject_unref(test_dict);
 }
=20
 static void qdict_array_entries_test(void)
@@ -493,7 +493,7 @@ static void qdict_array_entries_test(void)
     g_assert_cmpint(qdict_array_entries(dict, "foo."), =3D=3D, 3);
     g_assert_cmpint(qdict_array_entries(dict, ""), =3D=3D, -EINVAL);
=20
-    QDECREF(dict);
+    qobject_unref(dict);
=20
     dict =3D qdict_new();
     qdict_put_int(dict, "1", 0);
@@ -509,7 +509,7 @@ static void qdict_array_entries_test(void)
     qdict_put_int(dict, "2.c", 0);
     g_assert_cmpint(qdict_array_entries(dict, ""), =3D=3D, 3);
=20
-    QDECREF(dict);
+    qobject_unref(dict);
 }
=20
 static void qdict_join_test(void)
@@ -587,8 +587,8 @@ static void qdict_join_test(void)
     }
     while (overwrite ^=3D true);
=20
-    QDECREF(dict1);
-    QDECREF(dict2);
+    qobject_unref(dict1);
+    qobject_unref(dict2);
 }
=20
 static void qdict_crumple_test_recursive(void)
@@ -634,21 +634,21 @@ static void qdict_crumple_test_recursive(void)
     g_assert_cmpint(qdict_size(rule), =3D=3D, 2);
     g_assert_cmpstr("fred", =3D=3D, qdict_get_str(rule, "match"));
     g_assert_cmpstr("allow", =3D=3D, qdict_get_str(rule, "policy"));
-    QDECREF(rule);
+    qobject_unref(rule);
=20
     rule =3D qobject_to(QDict, qlist_pop(rules));
     g_assert(rule);
     g_assert_cmpint(qdict_size(rule), =3D=3D, 2);
     g_assert_cmpstr("bob", =3D=3D, qdict_get_str(rule, "match"));
     g_assert_cmpstr("deny", =3D=3D, qdict_get_str(rule, "policy"));
-    QDECREF(rule);
+    qobject_unref(rule);
=20
     /* With recursive crumpling, we should see all names unescaped */
     g_assert_cmpstr("acl0", =3D=3D, qdict_get_str(vnc, "acl.name"));
     g_assert_cmpstr("acl0", =3D=3D, qdict_get_str(acl, "rule.name"));
=20
-    QDECREF(src);
-    QDECREF(dst);
+    qobject_unref(src);
+    qobject_unref(dst);
 }
=20
 static void qdict_crumple_test_empty(void)
@@ -661,8 +661,8 @@ static void qdict_crumple_test_empty(void)
=20
     g_assert_cmpint(qdict_size(dst), =3D=3D, 0);
=20
-    QDECREF(src);
-    QDECREF(dst);
+    qobject_unref(src);
+    qobject_unref(dst);
 }
=20
 static int qdict_count_entries(QDict *dict)
@@ -704,7 +704,7 @@ static void qdict_rename_keys_test(void)
     g_assert(qobject_type(qdict_get(copy, "nothing")) =3D=3D QTYPE_QNULL=
);
     g_assert_cmpint(qdict_count_entries(copy), =3D=3D, 5);
=20
-    QDECREF(copy);
+    qobject_unref(copy);
=20
     /* Simple rename of all entries */
     renames =3D (QDictRenames[]) {
@@ -731,7 +731,7 @@ static void qdict_rename_keys_test(void)
     g_assert(qobject_type(qdict_get(copy, "null")) =3D=3D QTYPE_QNULL);
     g_assert_cmpint(qdict_count_entries(copy), =3D=3D, 5);
=20
-    QDECREF(copy);
+    qobject_unref(copy);
=20
     /* Renames are processed top to bottom */
     renames =3D (QDictRenames[]) {
@@ -754,7 +754,7 @@ static void qdict_rename_keys_test(void)
     g_assert(!qdict_haskey(copy, "tmp"));
     g_assert_cmpint(qdict_count_entries(copy), =3D=3D, 5);
=20
-    QDECREF(copy);
+    qobject_unref(copy);
=20
     /* Conflicting rename */
     renames =3D (QDictRenames[]) {
@@ -775,7 +775,7 @@ static void qdict_rename_keys_test(void)
     g_assert(qobject_type(qdict_get(copy, "nothing")) =3D=3D QTYPE_QNULL=
);
     g_assert_cmpint(qdict_count_entries(copy), =3D=3D, 5);
=20
-    QDECREF(copy);
+    qobject_unref(copy);
=20
     /* Renames in an empty dict */
     renames =3D (QDictRenames[]) {
@@ -783,13 +783,13 @@ static void qdict_rename_keys_test(void)
         { NULL , NULL }
     };
=20
-    QDECREF(dict);
+    qobject_unref(dict);
     dict =3D qdict_new();
=20
     qdict_rename_keys(dict, renames, &error_abort);
     g_assert(qdict_first(dict) =3D=3D NULL);
=20
-    QDECREF(dict);
+    qobject_unref(dict);
 }
=20
 static void qdict_crumple_test_bad_inputs(void)
@@ -806,7 +806,7 @@ static void qdict_crumple_test_bad_inputs(void)
     g_assert(error !=3D NULL);
     error_free(error);
     error =3D NULL;
-    QDECREF(src);
+    qobject_unref(src);
=20
     src =3D qdict_new();
     /* rule can't be both a list and a dict */
@@ -817,7 +817,7 @@ static void qdict_crumple_test_bad_inputs(void)
     g_assert(error !=3D NULL);
     error_free(error);
     error =3D NULL;
-    QDECREF(src);
+    qobject_unref(src);
=20
     src =3D qdict_new();
     /* The input should be flat, ie no dicts or lists */
@@ -828,7 +828,7 @@ static void qdict_crumple_test_bad_inputs(void)
     g_assert(error !=3D NULL);
     error_free(error);
     error =3D NULL;
-    QDECREF(src);
+    qobject_unref(src);
=20
     src =3D qdict_new();
     /* List indexes must not have gaps */
@@ -839,7 +839,7 @@ static void qdict_crumple_test_bad_inputs(void)
     g_assert(error !=3D NULL);
     error_free(error);
     error =3D NULL;
-    QDECREF(src);
+    qobject_unref(src);
=20
     src =3D qdict_new();
     /* List indexes must be in %zu format */
@@ -850,7 +850,7 @@ static void qdict_crumple_test_bad_inputs(void)
     g_assert(error !=3D NULL);
     error_free(error);
     error =3D NULL;
-    QDECREF(src);
+    qobject_unref(src);
 }
=20
 /*
@@ -871,7 +871,7 @@ static void qdict_put_exists_test(void)
=20
     g_assert(qdict_size(tests_dict) =3D=3D 1);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 static void qdict_get_not_exists_test(void)
@@ -879,7 +879,7 @@ static void qdict_get_not_exists_test(void)
     QDict *tests_dict =3D qdict_new();
     g_assert(qdict_get(tests_dict, "foo") =3D=3D NULL);
=20
-    QDECREF(tests_dict);
+    qobject_unref(tests_dict);
 }
=20
 /*
@@ -951,7 +951,7 @@ static void qdict_stress_test(void)
=20
         g_assert(strcmp(str1, str2) =3D=3D 0);
=20
-        QDECREF(value);
+        qobject_unref(value);
     }
=20
     // Delete everything
@@ -962,14 +962,14 @@ static void qdict_stress_test(void)
             break;
=20
         qdict_del(qdict, key);
-        QDECREF(value);
+        qobject_unref(value);
=20
         g_assert(qdict_haskey(qdict, key) =3D=3D 0);
     }
     fclose(test_file);
=20
     g_assert(qdict_size(qdict) =3D=3D 0);
-    QDECREF(qdict);
+    qobject_unref(qdict);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 997f4d3d2c..da582df3e9 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -67,10 +67,10 @@ static void escaped_string(void)
         if (test_cases[i].skip =3D=3D 0) {
             str =3D qobject_to_json(obj);
             g_assert_cmpstr(qstring_get_str(str), =3D=3D, test_cases[i].=
encoded);
-            qobject_decref(obj);
+            qobject_unref(obj);
         }
=20
-        QDECREF(str);
+        qobject_unref(str);
     }
 }
=20
@@ -99,9 +99,9 @@ static void simple_string(void)
         str =3D qobject_to_json(obj);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].encoded) =3D=
=3D 0);
=20
-        qobject_decref(obj);
+        qobject_unref(obj);
        =20
-        QDECREF(str);
+        qobject_unref(str);
     }
 }
=20
@@ -127,7 +127,7 @@ static void single_quote_string(void)
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) =3D=
=3D 0);
=20
-        QDECREF(str);
+        qobject_unref(str);
     }
 }
=20
@@ -823,7 +823,7 @@ static void utf8_string(void)
         } else {
             g_assert(!obj);
         }
-        qobject_decref(obj);
+        qobject_unref(obj);
=20
         obj =3D QOBJECT(qstring_from_str(utf8_in));
         str =3D qobject_to_json(obj);
@@ -833,8 +833,8 @@ static void utf8_string(void)
         } else {
             g_assert(!str);
         }
-        QDECREF(str);
-        qobject_decref(obj);
+        qobject_unref(str);
+        qobject_unref(obj);
=20
         /*
          * Disabled, because qobject_from_json() is buggy, and I can't
@@ -869,7 +869,7 @@ static void vararg_string(void)
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) =3D=
=3D 0);
=20
-        QDECREF(str);
+        qobject_unref(str);
     }
 }
=20
@@ -904,10 +904,10 @@ static void simple_number(void)
=20
             str =3D qobject_to_json(QOBJECT(qnum));
             g_assert(strcmp(qstring_get_str(str), test_cases[i].encoded)=
 =3D=3D 0);
-            QDECREF(str);
+            qobject_unref(str);
         }
=20
-        QDECREF(qnum);
+        qobject_unref(qnum);
     }
 }
=20
@@ -928,8 +928,8 @@ static void large_number(void)
=20
     str =3D qobject_to_json(QOBJECT(qnum));
     g_assert_cmpstr(qstring_get_str(str), =3D=3D, maxu64);
-    QDECREF(str);
-    QDECREF(qnum);
+    qobject_unref(str);
+    qobject_unref(qnum);
=20
     qnum =3D qobject_to(QNum, qobject_from_json(gtu64, &error_abort));
     g_assert(qnum);
@@ -939,8 +939,8 @@ static void large_number(void)
=20
     str =3D qobject_to_json(QOBJECT(qnum));
     g_assert_cmpstr(qstring_get_str(str), =3D=3D, gtu64);
-    QDECREF(str);
-    QDECREF(qnum);
+    qobject_unref(str);
+    qobject_unref(qnum);
=20
     qnum =3D qobject_to(QNum, qobject_from_json(lti64, &error_abort));
     g_assert(qnum);
@@ -950,8 +950,8 @@ static void large_number(void)
=20
     str =3D qobject_to_json(QOBJECT(qnum));
     g_assert_cmpstr(qstring_get_str(str), =3D=3D, "-9223372036854775808"=
);
-    QDECREF(str);
-    QDECREF(qnum);
+    qobject_unref(str);
+    qobject_unref(qnum);
 }
=20
 static void float_number(void)
@@ -983,10 +983,10 @@ static void float_number(void)
=20
             str =3D qobject_to_json(obj);
             g_assert(strcmp(qstring_get_str(str), test_cases[i].encoded)=
 =3D=3D 0);
-            QDECREF(str);
+            qobject_unref(str);
         }
=20
-        QDECREF(qnum);
+        qobject_unref(qnum);
     }
 }
=20
@@ -1001,16 +1001,16 @@ static void vararg_number(void)
     qnum =3D qobject_to(QNum, qobject_from_jsonf("%d", value));
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, =3D=3D, value);
-    QDECREF(qnum);
+    qobject_unref(qnum);
=20
     qnum =3D qobject_to(QNum, qobject_from_jsonf("%lld", value_ll));
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, =3D=3D, value_ll);
-    QDECREF(qnum);
+    qobject_unref(qnum);
=20
     qnum =3D qobject_to(QNum, qobject_from_jsonf("%f", valuef));
     g_assert(qnum_get_double(qnum) =3D=3D valuef);
-    QDECREF(qnum);
+    qobject_unref(qnum);
 }
=20
 static void keyword_literal(void)
@@ -1027,9 +1027,9 @@ static void keyword_literal(void)
=20
     str =3D qobject_to_json(obj);
     g_assert(strcmp(qstring_get_str(str), "true") =3D=3D 0);
-    QDECREF(str);
+    qobject_unref(str);
=20
-    QDECREF(qbool);
+    qobject_unref(qbool);
=20
     obj =3D qobject_from_json("false", &error_abort);
     qbool =3D qobject_to(QBool, obj);
@@ -1038,20 +1038,20 @@ static void keyword_literal(void)
=20
     str =3D qobject_to_json(obj);
     g_assert(strcmp(qstring_get_str(str), "false") =3D=3D 0);
-    QDECREF(str);
+    qobject_unref(str);
=20
-    QDECREF(qbool);
+    qobject_unref(qbool);
=20
     qbool =3D qobject_to(QBool, qobject_from_jsonf("%i", false));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) =3D=3D false);
-    QDECREF(qbool);
+    qobject_unref(qbool);
=20
     /* Test that non-zero values other than 1 get collapsed to true */
     qbool =3D qobject_to(QBool, qobject_from_jsonf("%i", 2));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) =3D=3D true);
-    QDECREF(qbool);
+    qobject_unref(qbool);
=20
     obj =3D qobject_from_json("null", &error_abort);
     g_assert(obj !=3D NULL);
@@ -1060,8 +1060,8 @@ static void keyword_literal(void)
     null =3D qnull();
     g_assert(QOBJECT(null) =3D=3D obj);
=20
-    qobject_decref(obj);
-    QDECREF(null);
+    qobject_unref(obj);
+    qobject_unref(null);
 }
=20
 static void simple_dict(void)
@@ -1101,12 +1101,12 @@ static void simple_dict(void)
         g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
-        qobject_decref(obj);
+        qobject_unref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
         g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
-        qobject_decref(obj);
-        QDECREF(str);
+        qobject_unref(obj);
+        qobject_unref(str);
     }
 }
=20
@@ -1158,7 +1158,7 @@ static void large_dict(void)
     obj =3D qobject_from_json(gstr->str, &error_abort);
     g_assert(obj !=3D NULL);
=20
-    qobject_decref(obj);
+    qobject_unref(obj);
     g_string_free(gstr, true);
 }
=20
@@ -1210,12 +1210,12 @@ static void simple_list(void)
         g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
-        qobject_decref(obj);
+        qobject_unref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
         g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
-        qobject_decref(obj);
-        QDECREF(str);
+        qobject_unref(obj);
+        qobject_unref(str);
     }
 }
=20
@@ -1272,13 +1272,13 @@ static void simple_whitespace(void)
         g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
-        qobject_decref(obj);
+        qobject_unref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
         g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
-        qobject_decref(obj);
-        QDECREF(str);
+        qobject_unref(obj);
+        qobject_unref(str);
     }
 }
=20
@@ -1301,7 +1301,7 @@ static void simple_varargs(void)
     obj =3D qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
     g_assert(qlit_equal_qobject(&decoded, obj));
=20
-    qobject_decref(obj);
+    qobject_unref(obj);
 }
=20
 static void empty_input(void)
@@ -1410,7 +1410,7 @@ static void limits_nesting(void)
=20
     obj =3D qobject_from_json(make_nest(buf, max_nesting), &error_abort)=
;
     g_assert(obj !=3D NULL);
-    qobject_decref(obj);
+    qobject_unref(obj);
=20
     obj =3D qobject_from_json(make_nest(buf, max_nesting + 1), &err);
     error_free_or_abort(&err);
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index a1c69ed648..ece83e293d 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -29,7 +29,7 @@ static void qlist_new_test(void)
     g_assert(qlist->base.refcnt =3D=3D 1);
     g_assert(qobject_type(QOBJECT(qlist)) =3D=3D QTYPE_QLIST);
=20
-    QDECREF(qlist);
+    qobject_unref(qlist);
 }
=20
 static void qlist_append_test(void)
@@ -47,7 +47,7 @@ static void qlist_append_test(void)
     g_assert(entry !=3D NULL);
     g_assert(entry->value =3D=3D QOBJECT(qi));
=20
-    QDECREF(qlist);
+    qobject_unref(qlist);
 }
=20
 static void qobject_to_qlist_test(void)
@@ -58,7 +58,7 @@ static void qobject_to_qlist_test(void)
=20
     g_assert(qobject_to(QList, QOBJECT(qlist)) =3D=3D qlist);
=20
-    QDECREF(qlist);
+    qobject_unref(qlist);
 }
=20
 static int iter_called;
@@ -96,7 +96,7 @@ static void qlist_iter_test(void)
=20
     g_assert(iter_called =3D=3D iter_max);
=20
-    QDECREF(qlist);
+    qobject_unref(qlist);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index 96bbb06f2c..bd6798d912 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -62,7 +62,7 @@ static void qlit_equal_qobject_test(void)
     qdict_put(qobject_to(QDict, qobj), "bee", qlist_new());
     g_assert(!qlit_equal_qobject(&qlit, qobj));
=20
-    qobject_decref(qobj);
+    qobject_unref(qobj);
 }
=20
 static void qobject_from_qlit_test(void)
@@ -79,15 +79,15 @@ static void qobject_from_qlit_test(void)
     bee =3D qdict_get_qlist(qdict, "bee");
     obj =3D qlist_pop(bee);
     g_assert_cmpint(qnum_get_int(qobject_to(QNum, obj)), =3D=3D, 43);
-    qobject_decref(obj);
+    qobject_unref(obj);
     obj =3D qlist_pop(bee);
     g_assert_cmpint(qnum_get_int(qobject_to(QNum, obj)), =3D=3D, 44);
-    qobject_decref(obj);
+    qobject_unref(obj);
     obj =3D qlist_pop(bee);
     g_assert(qbool_get_bool(qobject_to(QBool, obj)));
-    qobject_decref(obj);
+    qobject_unref(obj);
=20
-    qobject_decref(qobj);
+    qobject_unref(qobj);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/check-qnull.c b/tests/check-qnull.c
index afa4400da1..ebf21db83c 100644
--- a/tests/check-qnull.c
+++ b/tests/check-qnull.c
@@ -30,7 +30,7 @@ static void qnull_ref_test(void)
     g_assert(obj =3D=3D QOBJECT(&qnull_));
     g_assert(qnull_.base.refcnt =3D=3D 2);
     g_assert(qobject_type(obj) =3D=3D QTYPE_QNULL);
-    qobject_decref(obj);
+    qobject_unref(obj);
     g_assert(qnull_.base.refcnt =3D=3D 1);
 }
=20
@@ -49,10 +49,10 @@ static void qnull_visit_test(void)
     g_assert(qnull_.base.refcnt =3D=3D 1);
     obj =3D QOBJECT(qnull());
     v =3D qobject_input_visitor_new(obj);
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_type_null(v, NULL, &null, &error_abort);
     g_assert(obj =3D=3D QOBJECT(&qnull_));
-    QDECREF(null);
+    qobject_unref(null);
     visit_free(v);
=20
     null =3D NULL;
@@ -60,8 +60,8 @@ static void qnull_visit_test(void)
     visit_type_null(v, NULL, &null, &error_abort);
     visit_complete(v, &obj);
     g_assert(obj =3D=3D QOBJECT(&qnull_));
-    QDECREF(null);
-    qobject_decref(obj);
+    qobject_unref(null);
+    qobject_unref(obj);
     visit_free(v);
=20
     g_assert(qnull_.base.refcnt =3D=3D 1);
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index 9187da734b..4105015872 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -35,7 +35,7 @@ static void qnum_from_int_test(void)
     g_assert_cmpint(qn->base.refcnt, =3D=3D, 1);
     g_assert_cmpint(qobject_type(QOBJECT(qn)), =3D=3D, QTYPE_QNUM);
=20
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 static void qnum_from_uint_test(void)
@@ -50,7 +50,7 @@ static void qnum_from_uint_test(void)
     g_assert(qn->base.refcnt =3D=3D 1);
     g_assert(qobject_type(QOBJECT(qn)) =3D=3D QTYPE_QNUM);
=20
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 static void qnum_from_double_test(void)
@@ -65,7 +65,7 @@ static void qnum_from_double_test(void)
     g_assert_cmpint(qn->base.refcnt, =3D=3D, 1);
     g_assert_cmpint(qobject_type(QOBJECT(qn)), =3D=3D, QTYPE_QNUM);
=20
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 static void qnum_from_int64_test(void)
@@ -76,7 +76,7 @@ static void qnum_from_int64_test(void)
     qn =3D qnum_from_int(value);
     g_assert_cmpint((int64_t) qn->u.i64, =3D=3D, value);
=20
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 static void qnum_get_int_test(void)
@@ -87,7 +87,7 @@ static void qnum_get_int_test(void)
     qn =3D qnum_from_int(value);
     g_assert_cmpint(qnum_get_int(qn), =3D=3D, value);
=20
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 static void qnum_get_uint_test(void)
@@ -100,25 +100,25 @@ static void qnum_get_uint_test(void)
     qn =3D qnum_from_uint(value);
     g_assert(qnum_get_try_uint(qn, &val));
     g_assert_cmpuint(val, =3D=3D, value);
-    QDECREF(qn);
+    qobject_unref(qn);
=20
     qn =3D qnum_from_int(value);
     g_assert(qnum_get_try_uint(qn, &val));
     g_assert_cmpuint(val, =3D=3D, value);
-    QDECREF(qn);
+    qobject_unref(qn);
=20
     /* invalid cases */
     qn =3D qnum_from_int(-1);
     g_assert(!qnum_get_try_uint(qn, &val));
-    QDECREF(qn);
+    qobject_unref(qn);
=20
     qn =3D qnum_from_uint(-1ULL);
     g_assert(!qnum_get_try_int(qn, &ival));
-    QDECREF(qn);
+    qobject_unref(qn);
=20
     qn =3D qnum_from_double(0.42);
     g_assert(!qnum_get_try_uint(qn, &val));
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 static void qobject_to_qnum_test(void)
@@ -127,11 +127,11 @@ static void qobject_to_qnum_test(void)
=20
     qn =3D qnum_from_int(0);
     g_assert(qobject_to(QNum, QOBJECT(qn)) =3D=3D qn);
-    QDECREF(qn);
+    qobject_unref(qn);
=20
     qn =3D qnum_from_double(0);
     g_assert(qobject_to(QNum, QOBJECT(qn)) =3D=3D qn);
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 static void qnum_to_string_test(void)
@@ -143,13 +143,13 @@ static void qnum_to_string_test(void)
     tmp =3D qnum_to_string(qn);
     g_assert_cmpstr(tmp, =3D=3D, "123456");
     g_free(tmp);
-    QDECREF(qn);
+    qobject_unref(qn);
=20
     qn =3D qnum_from_double(0.42);
     tmp =3D qnum_to_string(qn);
     g_assert_cmpstr(tmp, =3D=3D, "0.42");
     g_free(tmp);
-    QDECREF(qn);
+    qobject_unref(qn);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 7629b8071b..5cb08fcb63 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -80,7 +80,7 @@ static void do_free_all(int _, ...)
=20
     va_start(ap, _);
     while ((obj =3D va_arg(ap, QObject *)) !=3D NULL) {
-        qobject_decref(obj);
+        qobject_unref(obj);
     }
     va_end(ap);
 }
diff --git a/tests/check-qstring.c b/tests/check-qstring.c
index 9c4dd3f94f..f11a7a8605 100644
--- a/tests/check-qstring.c
+++ b/tests/check-qstring.c
@@ -31,7 +31,7 @@ static void qstring_from_str_test(void)
     g_assert(strcmp(str, qstring->string) =3D=3D 0);
     g_assert(qobject_type(QOBJECT(qstring)) =3D=3D QTYPE_QSTRING);
=20
-    QDECREF(qstring);
+    qobject_unref(qstring);
 }
=20
 static void qstring_get_str_test(void)
@@ -44,7 +44,7 @@ static void qstring_get_str_test(void)
     ret_str =3D qstring_get_str(qstring);
     g_assert(strcmp(ret_str, str) =3D=3D 0);
=20
-    QDECREF(qstring);
+    qobject_unref(qstring);
 }
=20
 static void qstring_append_chr_test(void)
@@ -59,7 +59,7 @@ static void qstring_append_chr_test(void)
         qstring_append_chr(qstring, str[i]);
=20
     g_assert(strcmp(str, qstring_get_str(qstring)) =3D=3D 0);
-    QDECREF(qstring);
+    qobject_unref(qstring);
 }
=20
 static void qstring_from_substr_test(void)
@@ -70,7 +70,7 @@ static void qstring_from_substr_test(void)
     g_assert(qs !=3D NULL);
     g_assert(strcmp(qstring_get_str(qs), "tualiza") =3D=3D 0);
=20
-    QDECREF(qs);
+    qobject_unref(qs);
 }
=20
=20
@@ -81,7 +81,7 @@ static void qobject_to_qstring_test(void)
     qstring =3D qstring_from_str("foo");
     g_assert(qobject_to(QString, QOBJECT(qstring)) =3D=3D qstring);
=20
-    QDECREF(qstring);
+    qobject_unref(qstring);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 8b5ab1fd02..5f39ba0df3 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -42,7 +42,7 @@ static void test_plug_with_cpu_add(gconstpointer data)
                        "  'arguments': { 'id': %d } }", i);
         g_assert(response);
         g_assert(!qdict_haskey(response, "error"));
-        QDECREF(response);
+        qobject_unref(response);
     }
=20
     qtest_end();
@@ -66,7 +66,7 @@ static void test_plug_without_cpu_add(gconstpointer dat=
a)
                    s->sockets * s->cores * s->threads);
     g_assert(response);
     g_assert(qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     qtest_end();
     g_free(args);
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-tes=
t.c
index a01321aced..0b4f221c29 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -40,8 +40,8 @@ static QList *qom_list_types(const char *implements, bo=
ol abstract)
                " 'arguments': %p }", args);
     g_assert(qdict_haskey(resp, "return"));
     ret =3D qdict_get_qlist(resp, "return");
-    QINCREF(ret);
-    QDECREF(resp);
+    qobject_ref(ret);
+    qobject_unref(resp);
     return ret;
 }
=20
@@ -54,7 +54,7 @@ static QDict *qom_type_index(QList *types)
     QLIST_FOREACH_ENTRY(types, e) {
         QDict *d =3D qobject_to(QDict, qlist_entry_obj(e));
         const char *name =3D qdict_get_str(d, "name");
-        QINCREF(d);
+        qobject_ref(d);
         qdict_put(index, name, d);
     }
     return index;
@@ -108,7 +108,7 @@ static void test_one_device(const char *type)
     resp =3D qmp("{'execute': 'device-list-properties',"
                " 'arguments': {'typename': %s}}",
                type);
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     help =3D hmp("device_add \"%s,help\"", type);
     g_free(help);
@@ -129,7 +129,7 @@ static void test_device_intro_list(void)
     qtest_start(common_args);
=20
     types =3D device_type_list(true);
-    QDECREF(types);
+    qobject_unref(types);
=20
     help =3D hmp("device_add help");
     g_free(help);
@@ -157,8 +157,8 @@ static void test_qom_list_parents(const char *parent)
         g_assert(qom_has_parent(index, name, parent));
     }
=20
-    QDECREF(types);
-    QDECREF(index);
+    qobject_unref(types);
+    qobject_unref(index);
 }
=20
 static void test_qom_list_fields(void)
@@ -187,8 +187,8 @@ static void test_qom_list_fields(void)
     test_qom_list_parents("device");
     test_qom_list_parents("sys-bus-device");
=20
-    QDECREF(all_types);
-    QDECREF(non_abstract);
+    qobject_unref(all_types);
+    qobject_unref(non_abstract);
     qtest_end();
 }
=20
@@ -222,7 +222,7 @@ static void test_device_intro_concrete(void)
         test_one_device(type);
     }
=20
-    QDECREF(types);
+    qobject_unref(types);
     qtest_end();
 }
=20
@@ -255,8 +255,8 @@ static void test_abstract_interfaces(void)
         g_assert(qdict_haskey(d, "abstract") && qdict_get_bool(d, "abstr=
act"));
     }
=20
-    QDECREF(all_types);
-    QDECREF(index);
+    qobject_unref(all_types);
+    qobject_unref(index);
     qtest_end();
 }
=20
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 313030a14c..852fefc8f3 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -41,7 +41,7 @@ static void device_del(void)
     response =3D qmp_receive();
     g_assert(response);
     g_assert(qdict_haskey(response, "return"));
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 static void test_drive_without_dev(void)
@@ -78,7 +78,7 @@ static void test_after_failed_device_add(void)
     g_assert(response);
     error =3D qdict_get_qdict(response, "error");
     g_assert_cmpstr(qdict_get_try_str(error, "class"), =3D=3D, "GenericE=
rror");
-    QDECREF(response);
+    qobject_unref(response);
=20
     /* Delete the drive */
     drive_del();
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 5124e982c1..013ca68581 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -100,14 +100,14 @@ void migrate(QOSState *from, QOSState *to, const ch=
ar *uri)
     sub =3D qdict_get_qdict(rsp, "return");
     g_assert(qdict_haskey(sub, "running"));
     running =3D qdict_get_bool(sub, "running");
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     /* Issue the migrate command. */
     rsp =3D qtest_qmp(from->qts,
                     "{ 'execute': 'migrate', 'arguments': { 'uri': %s }}=
",
                     uri);
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     /* Wait for STOP event, but only if we were running: */
     if (running) {
@@ -132,12 +132,12 @@ void migrate(QOSState *from, QOSState *to, const ch=
ar *uri)
=20
         /* "setup", "active", "completed", "failed", "cancelled" */
         if (strcmp(st, "completed") =3D=3D 0) {
-            QDECREF(rsp);
+            qobject_unref(rsp);
             break;
         }
=20
         if ((strcmp(st, "setup") =3D=3D 0) || (strcmp(st, "active") =3D=3D=
 0)) {
-            QDECREF(rsp);
+            qobject_unref(rsp);
             g_usleep(5000);
             continue;
         }
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index a2daf6103d..a7803308b7 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -170,7 +170,7 @@ void qpci_unplug_acpi_device_test(const char *id, uin=
t8_t slot)
     g_free(cmd);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     outb(ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
=20
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 6f33a37667..43fb97e035 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -517,8 +517,8 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap=
)
         /* Send QMP request */
         socket_send(fd, str, qstring_get_length(qstr));
=20
-        QDECREF(qstr);
-        qobject_decref(qobj);
+        qobject_unref(qstr);
+        qobject_unref(qobj);
     }
 }
=20
@@ -585,7 +585,7 @@ void qtest_async_qmp(QTestState *s, const char *fmt, =
...)
 void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list=
 ap)
 {
     QDict *response =3D qtest_qmpv(s, fmt, ap);
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
@@ -596,7 +596,7 @@ void qtest_qmp_discard_response(QTestState *s, const =
char *fmt, ...)
     va_start(ap, fmt);
     response =3D qtest_qmpv(s, fmt, ap);
     va_end(ap);
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
@@ -609,7 +609,7 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const c=
har *event)
             (strcmp(qdict_get_str(response, "event"), event) =3D=3D 0)) =
{
             return response;
         }
-        QDECREF(response);
+        qobject_unref(response);
     }
 }
=20
@@ -618,7 +618,7 @@ void qtest_qmp_eventwait(QTestState *s, const char *e=
vent)
     QDict *response;
=20
     response =3D qtest_qmp_eventwait_ref(s, event);
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
@@ -634,12 +634,12 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va=
_list ap)
     ret =3D g_strdup(qdict_get_try_str(resp, "return"));
     while (ret =3D=3D NULL && qdict_get_try_str(resp, "event")) {
         /* Ignore asynchronous QMP events */
-        QDECREF(resp);
+        qobject_unref(resp);
         resp =3D qtest_qmp_receive(s);
         ret =3D g_strdup(qdict_get_try_str(resp, "return"));
     }
     g_assert(ret);
-    QDECREF(resp);
+    qobject_unref(resp);
     g_free(cmd);
     return ret;
 }
@@ -1021,7 +1021,7 @@ void qtest_cb_for_every_machine(void (*cb)(const ch=
ar *machine))
     }
=20
     qtest_end();
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 /*
@@ -1050,7 +1050,7 @@ void qtest_qmp_device_add(const char *driver, const=
 char *id, const char *fmt,
     g_assert(response);
     g_assert(!qdict_haskey(response, "event")); /* We don't expect any e=
vents */
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 /*
@@ -1095,6 +1095,6 @@ void qtest_qmp_device_del(const char *id)
     g_assert(event);
     g_assert_cmpstr(qdict_get_str(event, "event"), =3D=3D, "DEVICE_DELET=
ED");
=20
-    QDECREF(response1);
-    QDECREF(response2);
+    qobject_unref(response1);
+    qobject_unref(response2);
 }
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index efdd4be986..f286557b3e 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -88,7 +88,7 @@ static void test_machine_cpu_cli(void)
=20
     response =3D qmp("{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     qtest_quit(global_qtest);
 }
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 422bf1afdf..0acd715b14 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -193,7 +193,7 @@ static QDict *wait_command(QTestState *who, const cha=
r *command)
         if (!strcmp(event_string, "STOP")) {
             got_stop =3D true;
         }
-        QDECREF(response);
+        qobject_unref(response);
         response =3D qtest_qmp_receive(who);
     }
     return response;
@@ -219,7 +219,7 @@ static uint64_t get_migration_pass(QTestState *who)
         rsp_ram =3D qdict_get_qdict(rsp_return, "ram");
         result =3D qdict_get_try_int(rsp_ram, "dirty-sync-count", 0);
     }
-    QDECREF(rsp);
+    qobject_unref(rsp);
     return result;
 }
=20
@@ -235,7 +235,7 @@ static void wait_for_migration_complete(QTestState *w=
ho)
         status =3D qdict_get_str(rsp_return, "status");
         completed =3D strcmp(status, "completed") =3D=3D 0;
         g_assert_cmpstr(status, !=3D,  "failed");
-        QDECREF(rsp);
+        qobject_unref(rsp);
         if (completed) {
             return;
         }
@@ -322,7 +322,7 @@ static void migrate_check_parameter(QTestState *who, =
const char *parameter,
                              qdict_get_try_int(rsp_return,  parameter, -=
1));
     g_assert_cmpstr(result, =3D=3D, value);
     g_free(result);
-    QDECREF(rsp);
+    qobject_unref(rsp);
 }
=20
 static void migrate_set_parameter(QTestState *who, const char *parameter=
,
@@ -337,7 +337,7 @@ static void migrate_set_parameter(QTestState *who, co=
nst char *parameter,
     rsp =3D qtest_qmp(who, cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
     migrate_check_parameter(who, parameter, value);
 }
=20
@@ -355,7 +355,7 @@ static void migrate_set_capability(QTestState *who, c=
onst char *capability,
     rsp =3D qtest_qmp(who, cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
 }
=20
 static void migrate(QTestState *who, const char *uri)
@@ -369,7 +369,7 @@ static void migrate(QTestState *who, const char *uri)
     rsp =3D qtest_qmp(who, cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
 }
=20
 static void migrate_start_postcopy(QTestState *who)
@@ -378,7 +378,7 @@ static void migrate_start_postcopy(QTestState *who)
=20
     rsp =3D wait_command(who, "{ 'execute': 'migrate-start-postcopy' }")=
;
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
 }
=20
 static void test_migrate_start(QTestState **from, QTestState **to,
@@ -491,7 +491,7 @@ static void deprecated_set_downtime(QTestState *who, =
const double value)
     rsp =3D qtest_qmp(who, cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
     result_int =3D value * 1000L;
     expected =3D g_strdup_printf("%" PRId64, result_int);
     migrate_check_parameter(who, "downtime-limit", expected);
@@ -508,7 +508,7 @@ static void deprecated_set_speed(QTestState *who, con=
st char *value)
     rsp =3D qtest_qmp(who, cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
     migrate_check_parameter(who, "max-bandwidth", value);
 }
=20
@@ -581,7 +581,7 @@ static void test_baddest(void)
=20
         g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed"))=
);
         failed =3D !strcmp(status, "failed");
-        QDECREF(rsp);
+        qobject_unref(rsp);
     } while (!failed);
=20
     /* Is the machine currently running? */
@@ -590,7 +590,7 @@ static void test_baddest(void)
     rsp_return =3D qdict_get_qdict(rsp, "return");
     g_assert(qdict_haskey(rsp_return, "running"));
     g_assert(qdict_get_bool(rsp_return, "running"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     test_migrate_end(from, to, false);
 }
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 0f861d8176..169213fc1c 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -111,10 +111,10 @@ static void test_query_cpus(const void *data)
         } else {
             g_assert_cmpint(node, =3D=3D, 1);
         }
-        qobject_decref(e);
+        qobject_unref(e);
     }
=20
-    QDECREF(resp);
+    qobject_unref(resp);
     qtest_end();
     g_free(cli);
 }
@@ -164,10 +164,10 @@ static void pc_numa_cpu(const void *data)
         } else {
             g_assert(false);
         }
-        qobject_decref(e);
+        qobject_unref(e);
     }
=20
-    QDECREF(resp);
+    qobject_unref(resp);
     qtest_end();
     g_free(cli);
 }
@@ -209,10 +209,10 @@ static void spapr_numa_cpu(const void *data)
         } else {
             g_assert(false);
         }
-        qobject_decref(e);
+        qobject_unref(e);
     }
=20
-    QDECREF(resp);
+    qobject_unref(resp);
     qtest_end();
     g_free(cli);
 }
@@ -252,10 +252,10 @@ static void aarch64_numa_cpu(const void *data)
         } else {
             g_assert(false);
         }
-        qobject_decref(e);
+        qobject_unref(e);
     }
=20
-    QDECREF(resp);
+    qobject_unref(resp);
     qtest_end();
     g_free(cli);
 }
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index ebdf32c2e2..7461a7254f 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -28,7 +28,7 @@ static void test_panic(void)
     data =3D qdict_get_qdict(response, "data");
     g_assert(qdict_haskey(data, "action"));
     g_assert_cmpstr(qdict_get_str(data, "action"), =3D=3D, "pause");
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/q35-test.c b/tests/q35-test.c
index 3eaedf4b24..7ea7acc9d8 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -109,7 +109,7 @@ static void test_smram_lock(void)
     response =3D qmp("{'execute': 'system_reset', 'arguments': {} }");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     /* check open is settable again */
     smram_set_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN, false);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 772058fc4c..88f867f8c0 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -52,27 +52,27 @@ static void test_malformed(QTestState *qts)
     /* Not even a dictionary */
     resp =3D qtest_qmp(qts, "null");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* No "execute" key */
     resp =3D qtest_qmp(qts, "{}");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* "execute" isn't a string */
     resp =3D qtest_qmp(qts, "{ 'execute': true }");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* "arguments" isn't a dictionary */
     resp =3D qtest_qmp(qts, "{ 'execute': 'no-such-cmd', 'arguments': []=
 }");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* extra key */
     resp =3D qtest_qmp(qts, "{ 'execute': 'no-such-cmd', 'extra': true }=
");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    QDECREF(resp);
+    qobject_unref(resp);
 }
=20
 static void test_qmp_protocol(void)
@@ -90,12 +90,12 @@ static void test_qmp_protocol(void)
     test_version(qdict_get(q, "version"));
     capabilities =3D qdict_get_qlist(q, "capabilities");
     g_assert(capabilities && qlist_empty(capabilities));
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Test valid command before handshake */
     resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "CommandNotFound");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Test malformed commands before handshake */
     test_malformed(qts);
@@ -104,17 +104,17 @@ static void test_qmp_protocol(void)
     resp =3D qtest_qmp(qts, "{ 'execute': 'qmp_capabilities' }");
     ret =3D qdict_get_qdict(resp, "return");
     g_assert(ret && !qdict_size(ret));
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Test repeated handshake */
     resp =3D qtest_qmp(qts, "{ 'execute': 'qmp_capabilities' }");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "CommandNotFound");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Test valid command */
     resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
     test_version(qdict_get(resp, "return"));
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Test malformed commands */
     test_malformed(qts);
@@ -124,13 +124,13 @@ static void test_qmp_protocol(void)
     ret =3D qdict_get_qdict(resp, "return");
     g_assert(ret);
     g_assert_cmpstr(qdict_get_try_str(resp, "id"), =3D=3D, "cookie#1");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Test command failure with 'id' */
     resp =3D qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id':=
 2 }");
     g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
     g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 2);
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     qtest_quit(qts);
 }
@@ -159,21 +159,21 @@ static void test_qmp_oob(void)
     qstr =3D qobject_to(QString, entry->value);
     g_assert(qstr);
     g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "oob");
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Try a fake capability, it should fail. */
     resp =3D qtest_qmp(qts,
                      "{ 'execute': 'qmp_capabilities', "
                      "  'arguments': { 'enable': [ 'cap-does-not-exist' =
] } }");
     g_assert(qdict_haskey(resp, "error"));
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /* Now, enable OOB in current QMP session, it should succeed. */
     resp =3D qtest_qmp(qts,
                      "{ 'execute': 'qmp_capabilities', "
                      "  'arguments': { 'enable': [ 'oob' ] } }");
     g_assert(qdict_haskey(resp, "return"));
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /*
      * Try any command that does not support OOB but with OOB flag. We
@@ -183,7 +183,7 @@ static void test_qmp_oob(void)
                      "{ 'execute': 'query-cpus',"
                      "  'control': { 'run-oob': true } }");
     g_assert(qdict_haskey(resp, "error"));
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     /*
      * First send the "x-oob-test" command with lock=3Dtrue and
@@ -210,7 +210,7 @@ static void test_qmp_oob(void)
             !g_strcmp0(cmd_id, "unlock-cmd")) {
             acks++;
         }
-        QDECREF(resp);
+        qobject_unref(resp);
     }
=20
     qtest_quit(qts);
@@ -271,7 +271,7 @@ static void test_query(const void *data)
                                         -1, &error_abort),
                         =3D=3D, expected_error_class);
     }
-    QDECREF(resp);
+    qobject_unref(resp);
=20
     qtest_end();
 }
@@ -321,7 +321,7 @@ static void qmp_schema_init(QmpSchema *schema)
     visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);
     visit_free(qiv);
=20
-    QDECREF(resp);
+    qobject_unref(resp);
     qtest_end();
=20
     schema->hash =3D g_hash_table_new(g_str_hash, g_str_equal);
diff --git a/tests/qom-test.c b/tests/qom-test.c
index a34ff6ba53..e6f712cbd3 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -57,7 +57,7 @@ static void test_properties(const char *path, bool recu=
rse)
     g_assert(response);
=20
     if (!recurse) {
-        QDECREF(response);
+        qobject_unref(response);
         return;
     }
=20
@@ -82,10 +82,10 @@ static void test_properties(const char *path, bool re=
curse)
                       path, prop);
             /* qom-get may fail but should not, e.g., segfault. */
             g_assert(tmp);
-            QDECREF(tmp);
+            qobject_unref(tmp);
         }
     }
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 static void test_machine(gconstpointer data)
@@ -101,7 +101,7 @@ static void test_machine(gconstpointer data)
=20
     response =3D qmp("{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     qtest_end();
     g_free(args);
diff --git a/tests/tco-test.c b/tests/tco-test.c
index aee17af3c1..9945fb8469 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -241,8 +241,8 @@ static QDict *get_watchdog_action(void)
     QDict *data;
=20
     data =3D qdict_get_qdict(ev, "data");
-    QINCREF(data);
-    QDECREF(ev);
+    qobject_ref(data);
+    qobject_unref(ev);
     return data;
 }
=20
@@ -265,7 +265,7 @@ static void test_tco_second_timeout_pause(void)
     clock_step(ticks * TCO_TICK_NSEC * 2);
     ad =3D get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "pause"));
-    QDECREF(ad);
+    qobject_unref(ad);
=20
     stop_tco(&td);
     test_end(&td);
@@ -290,7 +290,7 @@ static void test_tco_second_timeout_reset(void)
     clock_step(ticks * TCO_TICK_NSEC * 2);
     ad =3D get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "reset"));
-    QDECREF(ad);
+    qobject_unref(ad);
=20
     stop_tco(&td);
     test_end(&td);
@@ -315,7 +315,7 @@ static void test_tco_second_timeout_shutdown(void)
     clock_step(ticks * TCO_TICK_NSEC * 2);
     ad =3D get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "shutdown"));
-    QDECREF(ad);
+    qobject_unref(ad);
=20
     stop_tco(&td);
     test_end(&td);
@@ -340,7 +340,7 @@ static void test_tco_second_timeout_none(void)
     clock_step(ticks * TCO_TICK_NSEC * 2);
     ad =3D get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "none"));
-    QDECREF(ad);
+    qobject_unref(ad);
=20
     stop_tco(&td);
     test_end(&td);
diff --git a/tests/test-char.c b/tests/test-char.c
index 306c728335..1880d36783 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -322,7 +322,7 @@ static void char_socket_test_common(Chardev *chr)
     qdict =3D qobject_to(QDict, addr);
     port =3D qdict_get_str(qdict, "port");
     tmp =3D g_strdup_printf("tcp:127.0.0.1:%s", port);
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     qemu_chr_fe_init(&be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&be, socket_can_read, socket_read,
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 029f05202a..63cb14629b 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -30,7 +30,7 @@ static void test_keyval_parse(void)
     /* Nothing */
     qdict =3D keyval_parse("", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), =3D=3D, 0);
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Empty key (qemu_opts_parse() accepts this) */
     qdict =3D keyval_parse("=3Dval", NULL, &err);
@@ -70,7 +70,7 @@ static void test_keyval_parse(void)
     qdict =3D keyval_parse(params + 2, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), =3D=3D, "v")=
;
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Long key fragment */
     qdict =3D keyval_parse(params, NULL, &error_abort);
@@ -79,7 +79,7 @@ static void test_keyval_parse(void)
     g_assert(sub_qdict);
     g_assert_cmpuint(qdict_size(sub_qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(sub_qdict, long_key + 1), =3D=3D, =
"v");
-    QDECREF(qdict);
+    qobject_unref(qdict);
     g_free(params);
=20
     /* Crap after valid key */
@@ -92,13 +92,13 @@ static void test_keyval_parse(void)
     g_assert_cmpuint(qdict_size(qdict), =3D=3D, 2);
     g_assert_cmpstr(qdict_get_try_str(qdict, "a"), =3D=3D, "3");
     g_assert_cmpstr(qdict_get_try_str(qdict, "b"), =3D=3D, "2,x");
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Even when it doesn't in qemu_opts_parse() */
     qdict =3D keyval_parse("id=3Dfoo,id=3Dbar", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "id"), =3D=3D, "bar");
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Dotted keys */
     qdict =3D keyval_parse("a.b.c=3D1,a.b.c=3D2,d=3D3", NULL, &error_abo=
rt);
@@ -111,7 +111,7 @@ static void test_keyval_parse(void)
     g_assert_cmpuint(qdict_size(sub_qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(sub_qdict, "c"), =3D=3D, "2");
     g_assert_cmpstr(qdict_get_try_str(qdict, "d"), =3D=3D, "3");
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Inconsistent dotted keys */
     qdict =3D keyval_parse("a.b=3D1,a=3D2", NULL, &err);
@@ -125,7 +125,7 @@ static void test_keyval_parse(void)
     qdict =3D keyval_parse("x=3Dy,", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "x"), =3D=3D, "y");
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Except when it isn't */
     qdict =3D keyval_parse(",", NULL, &err);
@@ -136,13 +136,13 @@ static void test_keyval_parse(void)
     qdict =3D keyval_parse("x=3D,,id=3Dbar", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "x"), =3D=3D, ",id=3Dbar");
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Anti-social ID is left to caller (qemu_opts_parse() rejects it) *=
/
     qdict =3D keyval_parse("id=3D666", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "id"), =3D=3D, "666");
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Implied value not supported (unlike qemu_opts_parse()) */
     qdict =3D keyval_parse("an,noaus,noaus=3D", NULL, &err);
@@ -160,7 +160,7 @@ static void test_keyval_parse(void)
     g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "an");
     g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), =3D=3D, "off");
     g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), =3D=3D, "");
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Implied dotted key */
     qdict =3D keyval_parse("val", "eins.zwei", &error_abort);
@@ -169,7 +169,7 @@ static void test_keyval_parse(void)
     g_assert(sub_qdict);
     g_assert_cmpuint(qdict_size(sub_qdict), =3D=3D, 1);
     g_assert_cmpstr(qdict_get_try_str(sub_qdict, "zwei"), =3D=3D, "val")=
;
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Implied key with empty value (qemu_opts_parse() accepts this) */
     qdict =3D keyval_parse(",", "implied", &err);
@@ -198,7 +198,7 @@ static void check_list012(QList *qlist)
         qstr =3D qobject_to(QString, qlist_pop(qlist));
         g_assert(qstr);
         g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, expected[i]);
-        QDECREF(qstr);
+        qobject_unref(qstr);
     }
     g_assert(qlist_empty(qlist));
 }
@@ -218,14 +218,14 @@ static void test_keyval_parse_list(void)
                          NULL, &error_abort);
     g_assert_cmpint(qdict_size(qdict), =3D=3D, 1);
     check_list012(qdict_get_qlist(qdict, "list"));
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Multiple indexes, last one wins */
     qdict =3D keyval_parse("list.1=3Dgoner,list.0=3Dnull,list.01=3Deins,=
list.2=3Dzwei",
                          NULL, &error_abort);
     g_assert_cmpint(qdict_size(qdict), =3D=3D, 1);
     check_list012(qdict_get_qlist(qdict, "list"));
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* List at deeper nesting */
     qdict =3D keyval_parse("a.list.1=3Deins,a.list.00=3Dnull,a.list.2=3D=
zwei",
@@ -234,7 +234,7 @@ static void test_keyval_parse_list(void)
     sub_qdict =3D qdict_get_qdict(qdict, "a");
     g_assert_cmpint(qdict_size(sub_qdict), =3D=3D, 1);
     check_list012(qdict_get_qlist(sub_qdict, "list"));
-    QDECREF(qdict);
+    qobject_unref(qdict);
=20
     /* Inconsistent dotted keys: both list and dictionary */
     qdict =3D keyval_parse("a.b.c=3D1,a.b.0=3D2", NULL, &err);
@@ -262,7 +262,7 @@ static void test_keyval_visit_bool(void)
=20
     qdict =3D keyval_parse("bool1=3Don,bool2=3Doff", NULL, &error_abort)=
;
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_bool(v, "bool1", &b, &error_abort);
     g_assert(b);
@@ -274,7 +274,7 @@ static void test_keyval_visit_bool(void)
=20
     qdict =3D keyval_parse("bool1=3Doffer", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_bool(v, "bool1", &b, &err);
     error_free_or_abort(&err);
@@ -292,7 +292,7 @@ static void test_keyval_visit_number(void)
     /* Lower limit zero */
     qdict =3D keyval_parse("number1=3D0", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_uint64(v, "number1", &u, &error_abort);
     g_assert_cmpuint(u, =3D=3D, 0);
@@ -304,7 +304,7 @@ static void test_keyval_visit_number(void)
     qdict =3D keyval_parse("number1=3D18446744073709551615,number2=3D-1"=
,
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_uint64(v, "number1", &u, &error_abort);
     g_assert_cmphex(u, =3D=3D, UINT64_MAX);
@@ -318,7 +318,7 @@ static void test_keyval_visit_number(void)
     qdict =3D keyval_parse("number1=3D18446744073709551616",
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_uint64(v, "number1", &u, &err);
     error_free_or_abort(&err);
@@ -329,7 +329,7 @@ static void test_keyval_visit_number(void)
     qdict =3D keyval_parse("number1=3D-18446744073709551616",
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_uint64(v, "number1", &u, &err);
     error_free_or_abort(&err);
@@ -340,7 +340,7 @@ static void test_keyval_visit_number(void)
     qdict =3D keyval_parse("number1=3D0x2a,number2=3D052",
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_uint64(v, "number1", &u, &error_abort);
     g_assert_cmpuint(u, =3D=3D, 42);
@@ -354,7 +354,7 @@ static void test_keyval_visit_number(void)
     qdict =3D keyval_parse("number1=3D3.14,number2=3D08",
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_uint64(v, "number1", &u, &err);
     error_free_or_abort(&err);
@@ -374,7 +374,7 @@ static void test_keyval_visit_size(void)
     /* Lower limit zero */
     qdict =3D keyval_parse("sz1=3D0", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &error_abort);
     g_assert_cmpuint(sz, =3D=3D, 0);
@@ -390,7 +390,7 @@ static void test_keyval_visit_size(void)
                          "sz3=3D9007199254740993",
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &error_abort);
     g_assert_cmphex(sz, =3D=3D, 0x1fffffffffffff);
@@ -407,7 +407,7 @@ static void test_keyval_visit_size(void)
                          "sz2=3D9223372036854775295", /* 7ffffffffffffdf=
f */
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &error_abort);
     g_assert_cmphex(sz, =3D=3D, 0x7ffffffffffffc00);
@@ -422,7 +422,7 @@ static void test_keyval_visit_size(void)
                          "sz2=3D18446744073709550591", /* fffffffffffffb=
ff */
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &error_abort);
     g_assert_cmphex(sz, =3D=3D, 0xfffffffffffff800);
@@ -437,7 +437,7 @@ static void test_keyval_visit_size(void)
                          "sz2=3D18446744073709550592", /* fffffffffffffc=
00 */
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &err);
     error_free_or_abort(&err);
@@ -450,7 +450,7 @@ static void test_keyval_visit_size(void)
     qdict =3D keyval_parse("sz1=3D8b,sz2=3D1.5k,sz3=3D2M,sz4=3D0.1G,sz5=3D=
16777215T",
                          NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &error_abort);
     g_assert_cmpuint(sz, =3D=3D, 8);
@@ -469,7 +469,7 @@ static void test_keyval_visit_size(void)
     /* Beyond limit with suffix */
     qdict =3D keyval_parse("sz1=3D16777216T", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &err);
     error_free_or_abort(&err);
@@ -479,7 +479,7 @@ static void test_keyval_visit_size(void)
     /* Trailing crap */
     qdict =3D keyval_parse("sz1=3D16E,sz2=3D16Gi", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_size(v, "sz1", &sz, &err);
     error_free_or_abort(&err);
@@ -498,7 +498,7 @@ static void test_keyval_visit_dict(void)
=20
     qdict =3D keyval_parse("a.b.c=3D1,a.b.c=3D2,d=3D3", NULL, &error_abo=
rt);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_start_struct(v, "a", NULL, 0, &error_abort);
     visit_start_struct(v, "b", NULL, 0, &error_abort);
@@ -516,7 +516,7 @@ static void test_keyval_visit_dict(void)
=20
     qdict =3D keyval_parse("a.b=3D", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_start_struct(v, "a", NULL, 0, &error_abort);
     visit_type_int(v, "c", &i, &err);   /* a.c missing */
@@ -539,7 +539,7 @@ static void test_keyval_visit_list(void)
     qdict =3D keyval_parse("a.0=3D,a.1=3DI,a.2.0=3DII", NULL, &error_abo=
rt);
     /* TODO empty list */
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_start_list(v, "a", NULL, 0, &error_abort);
     visit_type_str(v, NULL, &s, &error_abort);
@@ -562,7 +562,7 @@ static void test_keyval_visit_list(void)
=20
     qdict =3D keyval_parse("a.0=3D,b.0.0=3Dhead", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_start_list(v, "a", NULL, 0, &error_abort);
     visit_check_list(v, &err);  /* a[0] unexpected */
@@ -591,7 +591,7 @@ static void test_keyval_visit_optional(void)
=20
     qdict =3D keyval_parse("a.b=3D1", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_optional(v, "b", &present);
     g_assert(!present);         /* b missing */
@@ -627,7 +627,7 @@ static void test_keyval_visit_alternate(void)
      */
     qdict =3D keyval_parse("a=3D1,b=3D2,c=3Don", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_AltStrObj(v, "a", &aso, &error_abort);
     g_assert_cmpint(aso->type, =3D=3D, QTYPE_QSTRING);
@@ -651,19 +651,19 @@ static void test_keyval_visit_any(void)
=20
     qdict =3D keyval_parse("a.0=3Dnull,a.1=3D1", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    QDECREF(qdict);
+    qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_any(v, "a", &any, &error_abort);
     qlist =3D qobject_to(QList, any);
     g_assert(qlist);
     qstr =3D qobject_to(QString, qlist_pop(qlist));
     g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "null");
-    QDECREF(qstr);
+    qobject_unref(qstr);
     qstr =3D qobject_to(QString, qlist_pop(qlist));
     g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "1");
     g_assert(qlist_empty(qlist));
-    QDECREF(qstr);
-    qobject_decref(any);
+    qobject_unref(qstr);
+    qobject_unref(any);
     visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
     visit_free(v);
diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index 95f7839aef..e47075dd06 100644
--- a/tests/test-netfilter.c
+++ b/tests/test-netfilter.c
@@ -29,7 +29,7 @@ static void add_one_netfilter(void)
=20
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     response =3D qmp("{'execute': 'object-del',"
                    " 'arguments': {"
@@ -37,7 +37,7 @@ static void add_one_netfilter(void)
                    "}}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 /* add a netfilter to a netdev and then remove the netdev */
@@ -57,7 +57,7 @@ static void remove_netdev_with_one_netfilter(void)
=20
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     response =3D qmp("{'execute': 'netdev_del',"
                    " 'arguments': {"
@@ -65,7 +65,7 @@ static void remove_netdev_with_one_netfilter(void)
                    "}}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     /* add back the netdev */
     response =3D qmp("{'execute': 'netdev_add',"
@@ -75,7 +75,7 @@ static void remove_netdev_with_one_netfilter(void)
                    "}}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 /* add multi(2) netfilters to a netdev and then remove them */
@@ -95,7 +95,7 @@ static void add_multi_netfilter(void)
=20
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     response =3D qmp("{'execute': 'object-add',"
                    " 'arguments': {"
@@ -109,7 +109,7 @@ static void add_multi_netfilter(void)
=20
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     response =3D qmp("{'execute': 'object-del',"
                    " 'arguments': {"
@@ -117,7 +117,7 @@ static void add_multi_netfilter(void)
                    "}}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     response =3D qmp("{'execute': 'object-del',"
                    " 'arguments': {"
@@ -125,7 +125,7 @@ static void add_multi_netfilter(void)
                    "}}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 /* add multi(2) netfilters to a netdev and then remove the netdev */
@@ -145,7 +145,7 @@ static void remove_netdev_with_multi_netfilter(void)
=20
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     response =3D qmp("{'execute': 'object-add',"
                    " 'arguments': {"
@@ -159,7 +159,7 @@ static void remove_netdev_with_multi_netfilter(void)
=20
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     response =3D qmp("{'execute': 'netdev_del',"
                    " 'arguments': {"
@@ -167,7 +167,7 @@ static void remove_netdev_with_multi_netfilter(void)
                    "}}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
=20
     /* add back the netdev */
     response =3D qmp("{'execute': 'netdev_add',"
@@ -177,7 +177,7 @@ static void remove_netdev_with_multi_netfilter(void)
                    "}}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 2c422abcd4..77dd72b403 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -887,7 +887,7 @@ static void test_opts_to_qdict_basic(void)
     g_assert_cmpstr(qdict_get_str(dict, "number1"), =3D=3D, "42");
     g_assert_false(qdict_haskey(dict, "number2"));
=20
-    QDECREF(dict);
+    qobject_unref(dict);
     qemu_opts_del(opts);
 }
=20
@@ -914,7 +914,7 @@ static void test_opts_to_qdict_filtered(void)
     g_assert_cmpstr(qdict_get_str(dict, "number1"), =3D=3D, "42");
     g_assert_false(qdict_haskey(dict, "number2"));
     g_assert_false(qdict_haskey(dict, "bool1"));
-    QDECREF(dict);
+    qobject_unref(dict);
=20
     dict =3D qemu_opts_to_qdict_filtered(opts, NULL, &opts_list_02, fals=
e);
     g_assert(dict !=3D NULL);
@@ -924,7 +924,7 @@ static void test_opts_to_qdict_filtered(void)
     g_assert_false(qdict_haskey(dict, "str3"));
     g_assert_false(qdict_haskey(dict, "number1"));
     g_assert_false(qdict_haskey(dict, "number2"));
-    QDECREF(dict);
+    qobject_unref(dict);
=20
     /* Now delete converted options from opts */
     dict =3D qemu_opts_to_qdict_filtered(opts, NULL, &opts_list_01, true=
);
@@ -935,7 +935,7 @@ static void test_opts_to_qdict_filtered(void)
     g_assert_cmpstr(qdict_get_str(dict, "number1"), =3D=3D, "42");
     g_assert_false(qdict_haskey(dict, "number2"));
     g_assert_false(qdict_haskey(dict, "bool1"));
-    QDECREF(dict);
+    qobject_unref(dict);
=20
     dict =3D qemu_opts_to_qdict_filtered(opts, NULL, &opts_list_02, true=
);
     g_assert(dict !=3D NULL);
@@ -945,7 +945,7 @@ static void test_opts_to_qdict_filtered(void)
     g_assert_false(qdict_haskey(dict, "str3"));
     g_assert_false(qdict_haskey(dict, "number1"));
     g_assert_false(qdict_haskey(dict, "number2"));
-    QDECREF(dict);
+    qobject_unref(dict);
=20
     g_assert_true(QTAILQ_EMPTY(&opts->head));
=20
@@ -978,13 +978,13 @@ static void test_opts_to_qdict_duplicates(void)
     dict =3D qemu_opts_to_qdict(opts, NULL);
     g_assert(dict !=3D NULL);
     g_assert_cmpstr(qdict_get_str(dict, "foo"), =3D=3D, "b");
-    QDECREF(dict);
+    qobject_unref(dict);
=20
     /* The last one still wins if entries are deleted, and both are dele=
ted */
     dict =3D qemu_opts_to_qdict_filtered(opts, NULL, NULL, true);
     g_assert(dict !=3D NULL);
     g_assert_cmpstr(qdict_get_str(dict, "foo"), =3D=3D, "b");
-    QDECREF(dict);
+    qobject_unref(dict);
=20
     g_assert_true(QTAILQ_EMPTY(&opts->head));
=20
diff --git a/tests/test-qga.c b/tests/test-qga.c
index e6ab788f31..18e63cb533 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -180,7 +180,7 @@ static void test_qga_sync_delimited(gconstpointer fix=
)
     v =3D qdict_get_int(ret, "return");
     g_assert_cmpint(r, =3D=3D, v);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_sync(gconstpointer fix)
@@ -212,7 +212,7 @@ static void test_qga_sync(gconstpointer fix)
     v =3D qdict_get_int(ret, "return");
     g_assert_cmpint(r, =3D=3D, v);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_ping(gconstpointer fix)
@@ -224,7 +224,7 @@ static void test_qga_ping(gconstpointer fix)
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_invalid_args(gconstpointer fix)
@@ -244,7 +244,7 @@ static void test_qga_invalid_args(gconstpointer fix)
     g_assert_cmpstr(class, =3D=3D, "GenericError");
     g_assert_cmpstr(desc, =3D=3D, "Parameter 'foo' is unexpected");
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_invalid_cmd(gconstpointer fix)
@@ -263,7 +263,7 @@ static void test_qga_invalid_cmd(gconstpointer fix)
     g_assert_cmpstr(class, =3D=3D, "CommandNotFound");
     g_assert_cmpint(strlen(desc), >, 0);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_info(gconstpointer fix)
@@ -280,7 +280,7 @@ static void test_qga_info(gconstpointer fix)
     version =3D qdict_get_try_str(val, "version");
     g_assert_cmpstr(version, =3D=3D, QEMU_VERSION);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_get_vcpus(gconstpointer fix)
@@ -300,7 +300,7 @@ static void test_qga_get_vcpus(gconstpointer fix)
     g_assert(qdict_haskey(qobject_to(QDict, entry->value), "online"));
     g_assert(qdict_haskey(qobject_to(QDict, entry->value), "logical-id")=
);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_get_fsinfo(gconstpointer fix)
@@ -324,7 +324,7 @@ static void test_qga_get_fsinfo(gconstpointer fix)
         g_assert(qdict_haskey(qobject_to(QDict, entry->value), "disk"));
     }
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_get_memory_block_info(gconstpointer fix)
@@ -344,7 +344,7 @@ static void test_qga_get_memory_block_info(gconstpoin=
ter fix)
         g_assert_cmpint(size, >, 0);
     }
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_get_memory_blocks(gconstpointer fix)
@@ -369,7 +369,7 @@ static void test_qga_get_memory_blocks(gconstpointer =
fix)
         }
     }
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_network_get_interfaces(gconstpointer fix)
@@ -388,7 +388,7 @@ static void test_qga_network_get_interfaces(gconstpoi=
nter fix)
     entry =3D qlist_first(list);
     g_assert(qdict_haskey(qobject_to(QDict, entry->value), "name"));
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_file_ops(gconstpointer fix)
@@ -410,7 +410,7 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     id =3D qdict_get_int(ret, "return");
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     enc =3D g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
@@ -426,7 +426,7 @@ static void test_qga_file_ops(gconstpointer fix)
     eof =3D qdict_get_bool(val, "eof");
     g_assert_cmpint(count, =3D=3D, sizeof(helloworld));
     g_assert_cmpint(eof, =3D=3D, 0);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* flush */
@@ -434,7 +434,7 @@ static void test_qga_file_ops(gconstpointer fix)
                           " 'arguments': {'handle': %" PRId64 "} }",
                           id);
     ret =3D qmp_fd(fixture->fd, cmd);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* close */
@@ -442,7 +442,7 @@ static void test_qga_file_ops(gconstpointer fix)
                           " 'arguments': {'handle': %" PRId64 "} }",
                           id);
     ret =3D qmp_fd(fixture->fd, cmd);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* check content */
@@ -462,7 +462,7 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     id =3D qdict_get_int(ret, "return");
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     /* read */
     cmd =3D g_strdup_printf("{'execute': 'guest-file-read',"
@@ -477,7 +477,7 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert(eof);
     g_assert_cmpstr(b64, =3D=3D, enc);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
     g_free(enc);
=20
@@ -493,7 +493,7 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpint(count, =3D=3D, 0);
     g_assert(eof);
     g_assert_cmpstr(b64, =3D=3D, "");
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* seek */
@@ -508,7 +508,7 @@ static void test_qga_file_ops(gconstpointer fix)
     eof =3D qdict_get_bool(val, "eof");
     g_assert_cmpint(count, =3D=3D, 6);
     g_assert(!eof);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* partial read */
@@ -527,7 +527,7 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpmem(dec, count, helloworld + 6, sizeof(helloworld) - 6);
     g_free(dec);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* close */
@@ -535,7 +535,7 @@ static void test_qga_file_ops(gconstpointer fix)
                           " 'arguments': {'handle': %" PRId64 "} }",
                           id);
     ret =3D qmp_fd(fixture->fd, cmd);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
 }
=20
@@ -555,7 +555,7 @@ static void test_qga_file_write_read(gconstpointer fi=
x)
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     id =3D qdict_get_int(ret, "return");
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     enc =3D g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
@@ -571,7 +571,7 @@ static void test_qga_file_write_read(gconstpointer fi=
x)
     eof =3D qdict_get_bool(val, "eof");
     g_assert_cmpint(count, =3D=3D, sizeof(helloworld));
     g_assert_cmpint(eof, =3D=3D, 0);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* read (check implicit flush) */
@@ -586,7 +586,7 @@ static void test_qga_file_write_read(gconstpointer fi=
x)
     g_assert_cmpint(count, =3D=3D, 0);
     g_assert(eof);
     g_assert_cmpstr(b64, =3D=3D, "");
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* seek to 0 */
@@ -601,7 +601,7 @@ static void test_qga_file_write_read(gconstpointer fi=
x)
     eof =3D qdict_get_bool(val, "eof");
     g_assert_cmpint(count, =3D=3D, 0);
     g_assert(!eof);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
=20
     /* read */
@@ -616,7 +616,7 @@ static void test_qga_file_write_read(gconstpointer fi=
x)
     g_assert_cmpint(count, =3D=3D, sizeof(helloworld));
     g_assert(eof);
     g_assert_cmpstr(b64, =3D=3D, enc);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
     g_free(enc);
=20
@@ -625,7 +625,7 @@ static void test_qga_file_write_read(gconstpointer fi=
x)
                           " 'arguments': {'handle': %" PRId64 "} }",
                           id);
     ret =3D qmp_fd(fixture->fd, cmd);
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(cmd);
 }
=20
@@ -642,7 +642,7 @@ static void test_qga_get_time(gconstpointer fix)
     time =3D qdict_get_int(ret, "return");
     g_assert_cmpint(time, >, 0);
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_blacklist(gconstpointer data)
@@ -661,7 +661,7 @@ static void test_qga_blacklist(gconstpointer data)
     desc =3D qdict_get_try_str(error, "desc");
     g_assert_cmpstr(class, =3D=3D, "GenericError");
     g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     ret =3D qmp_fd(fix.fd, "{'execute': 'guest-get-time'}");
     g_assert_nonnull(ret);
@@ -670,12 +670,12 @@ static void test_qga_blacklist(gconstpointer data)
     desc =3D qdict_get_try_str(error, "desc");
     g_assert_cmpstr(class, =3D=3D, "GenericError");
     g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     /* check something work */
     ret =3D qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
     qmp_assert_no_error(ret);
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     fixture_tear_down(&fix, NULL);
 }
@@ -772,7 +772,7 @@ static void test_qga_fsfreeze_status(gconstpointer fi=
x)
     status =3D qdict_get_try_str(ret, "return");
     g_assert_cmpstr(status, =3D=3D, "thawed");
=20
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_guest_exec(gconstpointer fix)
@@ -795,7 +795,7 @@ static void test_qga_guest_exec(gconstpointer fix)
     val =3D qdict_get_qdict(ret, "return");
     pid =3D qdict_get_int(val, "pid");
     g_assert_cmpint(pid, >, 0);
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     /* wait for completion */
     now =3D g_get_monotonic_time();
@@ -807,7 +807,7 @@ static void test_qga_guest_exec(gconstpointer fix)
         val =3D qdict_get_qdict(ret, "return");
         exited =3D qdict_get_bool(val, "exited");
         if (!exited) {
-            QDECREF(ret);
+            qobject_unref(ret);
         }
     } while (!exited &&
              g_get_monotonic_time() < now + 5 * G_TIME_SPAN_SECOND);
@@ -822,7 +822,7 @@ static void test_qga_guest_exec(gconstpointer fix)
     g_assert_cmpint(len, =3D=3D, 12);
     g_assert_cmpstr((char *)decoded, =3D=3D, "\" test_str \"");
     g_free(decoded);
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_guest_exec_invalid(gconstpointer fix)
@@ -841,7 +841,7 @@ static void test_qga_guest_exec_invalid(gconstpointer=
 fix)
     desc =3D qdict_get_str(error, "desc");
     g_assert_cmpstr(class, =3D=3D, "GenericError");
     g_assert_cmpint(strlen(desc), >, 0);
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     /* invalid pid */
     ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-exec-status',"
@@ -853,7 +853,7 @@ static void test_qga_guest_exec_invalid(gconstpointer=
 fix)
     desc =3D qdict_get_str(error, "desc");
     g_assert_cmpstr(class, =3D=3D, "GenericError");
     g_assert_cmpint(strlen(desc), >, 0);
-    QDECREF(ret);
+    qobject_unref(ret);
 }
=20
 static void test_qga_guest_get_osinfo(gconstpointer data)
@@ -905,7 +905,7 @@ static void test_qga_guest_get_osinfo(gconstpointer d=
ata)
     g_assert_nonnull(str);
     g_assert_cmpstr(str, =3D=3D, "unit-test");
=20
-    QDECREF(ret);
+    qobject_unref(ret);
     g_free(env[0]);
     fixture_tear_down(&fixture, NULL);
 }
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index db690cc5ae..e0ed461f58 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -106,8 +106,8 @@ static void test_dispatch_cmd(void)
     assert(resp !=3D NULL);
     assert(!qdict_haskey(qobject_to(QDict, resp), "error"));
=20
-    qobject_decref(resp);
-    QDECREF(req);
+    qobject_unref(resp);
+    qobject_unref(req);
 }
=20
 /* test commands that return an error due to invalid parameters */
@@ -123,8 +123,8 @@ static void test_dispatch_cmd_failure(void)
     assert(resp !=3D NULL);
     assert(qdict_haskey(qobject_to(QDict, resp), "error"));
=20
-    qobject_decref(resp);
-    QDECREF(req);
+    qobject_unref(resp);
+    qobject_unref(req);
=20
     /* check that with extra arguments it throws an error */
     req =3D qdict_new();
@@ -137,8 +137,8 @@ static void test_dispatch_cmd_failure(void)
     assert(resp !=3D NULL);
     assert(qdict_haskey(qobject_to(QDict, resp), "error"));
=20
-    qobject_decref(resp);
-    QDECREF(req);
+    qobject_unref(resp);
+    qobject_unref(req);
 }
=20
 static QObject *test_qmp_dispatch(QDict *req)
@@ -153,8 +153,8 @@ static QObject *test_qmp_dispatch(QDict *req)
     assert(resp && !qdict_haskey(resp, "error"));
     ret =3D qdict_get(resp, "return");
     assert(ret);
-    qobject_incref(ret);
-    qobject_decref(resp_obj);
+    qobject_ref(ret);
+    qobject_unref(resp_obj);
     return ret;
 }
=20
@@ -195,7 +195,7 @@ static void test_dispatch_cmd_io(void)
     assert(qdict_get_int(ret_dict_dict2_userdef, "integer") =3D=3D 422);
     assert(!strcmp(qdict_get_str(ret_dict_dict2_userdef, "string"), "hel=
lo2"));
     assert(!strcmp(qdict_get_str(ret_dict_dict2, "string"), "blah4"));
-    QDECREF(ret);
+    qobject_unref(ret);
=20
     qdict_put_int(args3, "a", 66);
     qdict_put(req, "arguments", args3);
@@ -204,9 +204,9 @@ static void test_dispatch_cmd_io(void)
     ret3 =3D qobject_to(QNum, test_qmp_dispatch(req));
     g_assert(qnum_get_try_int(ret3, &val));
     g_assert_cmpint(val, =3D=3D, 66);
-    QDECREF(ret3);
+    qobject_unref(ret3);
=20
-    QDECREF(req);
+    qobject_unref(req);
 }
=20
 /* test generated dealloc functions for generated types */
@@ -257,7 +257,7 @@ static void test_dealloc_partial(void)
         v =3D qobject_input_visitor_new(QOBJECT(ud2_dict));
         visit_type_UserDefTwo(v, NULL, &ud2, &err);
         visit_free(v);
-        QDECREF(ud2_dict);
+        qobject_unref(ud2_dict);
     }
=20
     /* verify that visit_type_XXX() cleans up properly on error */
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index bb1036615f..3a7c227a1d 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -133,7 +133,7 @@ static void event_prepare(TestEventData *data,
 static void event_teardown(TestEventData *data,
                            const void *unused)
 {
-    QDECREF(data->expect);
+    qobject_unref(data->expect);
     test_event_data =3D NULL;
=20
     g_mutex_unlock(&test_event_lock);
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 6dc59c6211..0f4d234c3f 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -35,7 +35,7 @@ typedef struct TestInputVisitorData {
 static void visitor_input_teardown(TestInputVisitorData *data,
                                    const void *unused)
 {
-    qobject_decref(data->obj);
+    qobject_unref(data->obj);
     data->obj =3D NULL;
=20
     if (data->qiv) {
@@ -483,7 +483,7 @@ static void test_visitor_in_any(TestInputVisitorData =
*data,
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, =3D=3D, -42);
-    qobject_decref(res);
+    qobject_unref(res);
=20
     v =3D visitor_input_test_init(data, "{ 'integer': -42, 'boolean': tr=
ue, 'string': 'foo' }");
     visit_type_any(v, NULL, &res, &error_abort);
@@ -505,7 +505,7 @@ static void test_visitor_in_any(TestInputVisitorData =
*data,
     qstring =3D qobject_to(QString, qobj);
     g_assert(qstring);
     g_assert_cmpstr(qstring_get_str(qstring), =3D=3D, "foo");
-    qobject_decref(res);
+    qobject_unref(res);
 }
=20
 static void test_visitor_in_null(TestInputVisitorData *data,
@@ -530,7 +530,7 @@ static void test_visitor_in_null(TestInputVisitorData=
 *data,
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_null(v, "a", &null, &error_abort);
     g_assert(qobject_type(QOBJECT(null)) =3D=3D QTYPE_QNULL);
-    QDECREF(null);
+    qobject_unref(null);
     visit_type_null(v, "b", &null, &err);
     error_free_or_abort(&err);
     g_assert(!null);
@@ -1262,7 +1262,7 @@ static void do_test_visitor_in_qmp_introspect(TestI=
nputVisitorData *data,
     g_assert(schema);
=20
     qapi_free_SchemaInfoList(schema);
-    qobject_decref(obj);
+    qobject_unref(obj);
     visit_free(v);
 }
=20
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index ecf21c0f31..be635854b4 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -40,7 +40,7 @@ static void visitor_output_teardown(TestOutputVisitorDa=
ta *data,
 {
     visit_free(data->ov);
     data->ov =3D NULL;
-    qobject_decref(data->obj);
+    qobject_unref(data->obj);
     data->obj =3D NULL;
 }
=20
@@ -346,7 +346,7 @@ static void test_visitor_out_any(TestOutputVisitorDat=
a *data,
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, =3D=3D, -42);
-    qobject_decref(qobj);
+    qobject_unref(qobj);
=20
     visitor_reset(data);
     qdict =3D qdict_new();
@@ -355,7 +355,7 @@ static void test_visitor_out_any(TestOutputVisitorDat=
a *data,
     qdict_put_str(qdict, "string", "foo");
     qobj =3D QOBJECT(qdict);
     visit_type_any(data->ov, NULL, &qobj, &error_abort);
-    qobject_decref(qobj);
+    qobject_unref(qobj);
     qdict =3D qobject_to(QDict, visitor_get(data));
     g_assert(qdict);
     qnum =3D qobject_to(QNum, qdict_get(qdict, "integer"));
@@ -630,7 +630,7 @@ static void check_native_list(QObject *qobj,
             qvalue =3D qobject_to(QNum, tmp);
             g_assert(qnum_get_try_uint(qvalue, &val));
             g_assert_cmpint(val, =3D=3D, i);
-            qobject_decref(qlist_pop(qlist));
+            qobject_unref(qlist_pop(qlist));
         }
         break;
=20
@@ -654,7 +654,7 @@ static void check_native_list(QObject *qobj,
             qvalue =3D qobject_to(QNum, tmp);
             g_assert(qnum_get_try_int(qvalue, &val));
             g_assert_cmpint(val, =3D=3D, i);
-            qobject_decref(qlist_pop(qlist));
+            qobject_unref(qlist_pop(qlist));
         }
         break;
     case USER_DEF_NATIVE_LIST_UNION_KIND_BOOLEAN:
@@ -665,7 +665,7 @@ static void check_native_list(QObject *qobj,
             g_assert(tmp);
             qvalue =3D qobject_to(QBool, tmp);
             g_assert_cmpint(qbool_get_bool(qvalue), =3D=3D, i % 3 =3D=3D=
 0);
-            qobject_decref(qlist_pop(qlist));
+            qobject_unref(qlist_pop(qlist));
         }
         break;
     case USER_DEF_NATIVE_LIST_UNION_KIND_STRING:
@@ -678,7 +678,7 @@ static void check_native_list(QObject *qobj,
             qvalue =3D qobject_to(QString, tmp);
             sprintf(str, "%d", i);
             g_assert_cmpstr(qstring_get_str(qvalue), =3D=3D, str);
-            qobject_decref(qlist_pop(qlist));
+            qobject_unref(qlist_pop(qlist));
         }
         break;
     case USER_DEF_NATIVE_LIST_UNION_KIND_NUMBER:
@@ -695,7 +695,7 @@ static void check_native_list(QObject *qobj,
             g_string_printf(double_actual, "%.6f", qnum_get_double(qvalu=
e));
             g_assert_cmpstr(double_actual->str, =3D=3D, double_expected-=
>str);
=20
-            qobject_decref(qlist_pop(qlist));
+            qobject_unref(qlist_pop(qlist));
             g_string_free(double_expected, true);
             g_string_free(double_actual, true);
         }
@@ -703,7 +703,7 @@ static void check_native_list(QObject *qobj,
     default:
         g_assert_not_reached();
     }
-    QDECREF(qlist);
+    qobject_unref(qlist);
 }
=20
 static void test_native_list(TestOutputVisitorData *data,
diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-seri=
alization.c
index d18d90db2c..1c5a8b94ea 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -1036,10 +1036,10 @@ static void qmp_deserialize(void **native_out, vo=
id *datap,
     output_json =3D qobject_to_json(obj_orig);
     obj =3D qobject_from_json(qstring_get_str(output_json), &error_abort=
);
=20
-    QDECREF(output_json);
+    qobject_unref(output_json);
     d->qiv =3D qobject_input_visitor_new(obj);
-    qobject_decref(obj_orig);
-    qobject_decref(obj);
+    qobject_unref(obj_orig);
+    qobject_unref(obj);
     visit(d->qiv, native_out, errp);
 }
=20
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.=
c
index 02e41843fc..84ce9c71ae 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -19,7 +19,7 @@ static char *get_cpu0_qom_path(void)
=20
     cpu0 =3D qobject_to(QDict, qlist_peek(ret));
     path =3D g_strdup(qdict_get_str(cpu0, "qom_path"));
-    QDECREF(resp);
+    qobject_unref(resp);
     return path;
 }
=20
@@ -30,8 +30,8 @@ static QObject *qom_get(const char *path, const char *p=
rop)
                       "                 'property': %s } }",
                       path, prop);
     QObject *ret =3D qdict_get(resp, "return");
-    qobject_incref(ret);
-    QDECREF(resp);
+    qobject_ref(ret);
+    qobject_unref(resp);
     return ret;
 }
=20
@@ -41,7 +41,7 @@ static bool qom_get_bool(const char *path, const char *=
prop)
     QBool *value =3D qobject_to(QBool, qom_get(path, prop));
     bool b =3D qbool_get_bool(value);
=20
-    QDECREF(value);
+    qobject_unref(value);
     return b;
 }
 #endif
@@ -66,7 +66,7 @@ static void test_cpuid_prop(const void *data)
     g_assert_cmpint(val, =3D=3D, args->expected_value);
     qtest_end();
=20
-    QDECREF(value);
+    qobject_unref(value);
     g_free(path);
 }
=20
@@ -142,8 +142,8 @@ static void test_feature_flag(const void *data)
=20
     g_assert(!!(value & (1U << args->bitnr)) =3D=3D args->expected_value=
);
=20
-    QDECREF(present);
-    QDECREF(filtered);
+    qobject_unref(present);
+    qobject_unref(filtered);
     g_free(path);
 }
=20
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index 66c7a0147f..d093cffe1e 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -74,7 +74,7 @@ static int qmp_tmp105_get_temperature(const char *id)
                    "'property': 'temperature' } }", id);
     g_assert(qdict_haskey(response, "return"));
     ret =3D qdict_get_int(response, "return");
-    QDECREF(response);
+    qobject_unref(response);
     return ret;
 }
=20
@@ -85,7 +85,7 @@ static void qmp_tmp105_set_temperature(const char *id, =
int value)
     response =3D qmp("{ 'execute': 'qom-set', 'arguments': { 'path': %s,=
 "
                    "'property': 'temperature', 'value': %d } }", id, val=
ue);
     g_assert(qdict_haskey(response, "return"));
-    QDECREF(response);
+    qobject_unref(response);
 }
=20
 #define TMP105_PRECISION (1000/16)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 61d997253c..bbc8091286 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -727,7 +727,7 @@ static void test_migrate(void)
     rsp =3D qmp("{ 'execute': 'migrate_set_speed',"
               "'arguments': { 'value': 10 } }");
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
                           "'arguments': { 'uri': '%s' } }",
@@ -735,7 +735,7 @@ static void test_migrate(void)
     rsp =3D qmp(cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     wait_for_log_fd(s);
=20
@@ -751,7 +751,7 @@ static void test_migrate(void)
     rsp =3D qmp("{ 'execute': 'migrate_set_speed',"
               "'arguments': { 'value': 0 } }");
     g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     qmp_eventwait("STOP");
=20
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 0a3c5dd257..b285a262e9 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -173,7 +173,7 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     qvirtqueue_kick(dev, vq, free_head);
=20
     rsp =3D qmp("{ 'execute' : 'stop'}");
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     ret =3D iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
     g_assert_cmpint(ret, =3D=3D, sizeof(test) + sizeof(len));
@@ -182,9 +182,9 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
      * ensure the packet data gets queued in QEMU, before we do 'cont'.
      */
     rsp =3D qmp("{ 'execute' : 'query-status'}");
-    QDECREF(rsp);
+    qobject_unref(rsp);
     rsp =3D qmp("{ 'execute' : 'cont'}");
-    QDECREF(rsp);
+    qobject_unref(rsp);
=20
     qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_NET_TIMEOUT=
_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 2ec274e37c..8d915c610c 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -125,7 +125,7 @@ static void read_guid_from_monitor(QemuUUID *guid)
         guid_str =3D qdict_get_str(rsp_ret, "guid");
         g_assert(qemu_uuid_parse(guid_str, guid) =3D=3D 0);
     }
-    QDECREF(rsp);
+    qobject_unref(rsp);
 }
=20
 static char disk[] =3D "tests/vmgenid-test-disk-XXXXXX";
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 3b5bbcf007..797288d939 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -16,7 +16,7 @@ static void qmp_check_no_event(QTestState *s)
 {
     QDict *resp =3D qtest_qmp(s, "{'execute':'query-status'}");
     g_assert(qdict_haskey(resp, "return"));
-    QDECREF(resp);
+    qobject_unref(resp);
 }
=20
 static QDict *ib700_program_and_wait(QTestState *s)
@@ -48,8 +48,8 @@ static QDict *ib700_program_and_wait(QTestState *s)
     qtest_clock_step(s, 2 * NANOSECONDS_PER_SECOND);
     event =3D qtest_qmp_eventwait_ref(s, "WATCHDOG");
     data =3D qdict_get_qdict(event, "data");
-    QINCREF(data);
-    QDECREF(event);
+    qobject_ref(data);
+    qobject_unref(event);
     return data;
 }
=20
@@ -62,7 +62,7 @@ static void ib700_pause(void)
     qtest_irq_intercept_in(s, "ioapic");
     d =3D ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "pause"));
-    QDECREF(d);
+    qobject_unref(d);
     qtest_qmp_eventwait(s, "STOP");
     qtest_quit(s);
 }
@@ -75,7 +75,7 @@ static void ib700_reset(void)
     qtest_irq_intercept_in(s, "ioapic");
     d =3D ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
-    QDECREF(d);
+    qobject_unref(d);
     qtest_qmp_eventwait(s, "RESET");
     qtest_quit(s);
 }
@@ -89,7 +89,7 @@ static void ib700_shutdown(void)
     qtest_irq_intercept_in(s, "ioapic");
     d =3D ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
-    QDECREF(d);
+    qobject_unref(d);
     qtest_qmp_eventwait(s, "SHUTDOWN");
     qtest_quit(s);
 }
@@ -102,7 +102,7 @@ static void ib700_none(void)
     qtest_irq_intercept_in(s, "ioapic");
     d =3D ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "none"));
-    QDECREF(d);
+    qobject_unref(d);
     qtest_quit(s);
 }
=20
diff --git a/util/keyval.c b/util/keyval.c
index 1c7351a233..13def4af54 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -126,7 +126,7 @@ static int key_to_index(const char *key, const char *=
*end)
  * Else, fail because we have conflicting needs on how to map
  * @key_in_cur.
  * In any case, take over the reference to @value, i.e. if the caller
- * wants to hold on to a reference, it needs to QINCREF().
+ * wants to hold on to a reference, it needs to qobject_ref().
  * Use @key up to @key_cursor to identify the key in error messages.
  * On success, return the mapped value.
  * On failure, store an error through @errp and return NULL.
@@ -143,7 +143,7 @@ static QObject *keyval_parse_put(QDict *cur,
         if (qobject_type(old) !=3D (value ? QTYPE_QSTRING : QTYPE_QDICT)=
) {
             error_setg(errp, "Parameters '%.*s.*' used inconsistently",
                        (int)(key_cursor - key), key);
-            QDECREF(value);
+            qobject_unref(value);
             return NULL;
         }
         if (!value) {
@@ -375,10 +375,10 @@ static QObject *keyval_listify(QDict *cur, GSList *=
key_of_cur, Error **errp)
             error_setg(errp, "Parameter '%s%d' missing", key, i);
             g_free(key);
             g_free(elt);
-            QDECREF(list);
+            qobject_unref(list);
             return NULL;
         }
-        qobject_incref(elt[i]);
+        qobject_ref(elt[i]);
         qlist_append_obj(list, elt[i]);
     }
=20
@@ -404,7 +404,7 @@ QDict *keyval_parse(const char *params, const char *i=
mplied_key,
     while (*s) {
         s =3D keyval_parse_one(qdict, s, implied_key, errp);
         if (!s) {
-            QDECREF(qdict);
+            qobject_unref(qdict);
             return NULL;
         }
         implied_key =3D NULL;
@@ -412,7 +412,7 @@ QDict *keyval_parse(const char *params, const char *i=
mplied_key,
=20
     listified =3D keyval_listify(qdict, NULL, errp);
     if (!listified) {
-        QDECREF(qdict);
+        qobject_unref(qdict);
         return NULL;
     }
     assert(listified =3D=3D QOBJECT(qdict));
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 20f7d1429d..14d84022dc 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -562,8 +562,8 @@ static void config_parse_qdict_section(QDict *options=
, QemuOptsList *opts,
     }
=20
 out:
-    QDECREF(subqdict);
-    QDECREF(list);
+    qobject_unref(subqdict);
+    qobject_unref(list);
 }
=20
 void qemu_config_parse_qdict(QDict *options, QemuOptsList **lists,
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index a569d24745..b9b6eabd08 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1340,7 +1340,7 @@ Example:
         emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp, &err);
=20
         error_propagate(errp, err);
-        QDECREF(qmp);
+        qobject_unref(qmp);
     }
=20
     const QEnumLookup example_QAPIEvent_lookup =3D {
diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobjec=
t.cocci
index 47bcafe9a9..9fee9c0d9a 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -3,11 +3,11 @@
 expression Obj, Key, E;
 @@
 (
-- qobject_incref(QOBJECT(E));
-+ QINCREF(E);
+- qobject_ref(QOBJECT(E));
++ qobject_ref(E);
 |
-- qobject_decref(QOBJECT(E));
-+ QDECREF(E);
+- qobject_unref(QOBJECT(E));
++ qobject_unref(E);
 |
 - qdict_put_obj(Obj, Key, QOBJECT(E));
 + qdict_put(Obj, Key, E);
--=20
2.17.0.rc1.1.g4c4f2b46a3
