Received: from eggs.gnu.org ([2001:4830:134:3::10]:45582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJj-00011d-Oe
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJd-000656-93
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:37:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:35:58 -0500
Message-Id: <20180312183628.394722-8-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 07/36] qapi: Replace qobject_to_X(o) by
 qobject_to(X, o)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, "open list:S390" <qemu-s390x@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This patch was generated using the following Coccinelle script:

@@
expression Obj;
@@
(
- qobject_to_qnum(Obj)
+ qobject_to(QNum, Obj)
|
- qobject_to_qstring(Obj)
+ qobject_to(QString, Obj)
|
- qobject_to_qdict(Obj)
+ qobject_to(QDict, Obj)
|
- qobject_to_qlist(Obj)
+ qobject_to(QList, Obj)
|
- qobject_to_qbool(Obj)
+ qobject_to(QBool, Obj)
)

and a bit of manual fix-up for overly long lines and three places in
tests/check-qjson.c that Coccinelle did not find.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20180224154033.29559-4-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: swap order from qobject_to(o, X), rebase to master]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c                    |  6 ++---
 block.c                             |  4 +--
 block/qapi.c                        | 12 ++++-----
 block/qcow2.c                       |  2 +-
 block/rbd.c                         |  8 +++---
 block/sheepdog.c                    |  2 +-
 blockdev.c                          |  7 ++---
 hw/i386/acpi-build.c                | 14 +++++-----
 monitor.c                           |  8 +++---
 qapi/qmp-dispatch.c                 |  2 +-
 qapi/qobject-input-visitor.c        | 20 +++++++-------
 qapi/qobject-output-visitor.c       |  4 +--
 qga/main.c                          |  2 +-
 qmp.c                               |  2 +-
 qobject/json-parser.c               |  2 +-
 qobject/qbool.c                     |  4 +--
 qobject/qdict.c                     | 38 +++++++++++++-------------
 qobject/qjson.c                     | 10 +++----
 qobject/qlist.c                     |  6 ++---
 qobject/qlit.c                      | 10 +++----
 qobject/qnum.c                      |  6 ++---
 qobject/qstring.c                   |  6 ++---
 qom/object.c                        |  8 +++---
 target/i386/cpu.c                   |  2 +-
 target/s390x/cpu_models.c           |  2 +-
 tests/check-qdict.c                 | 20 +++++++-------
 tests/check-qjson.c                 | 41 ++++++++++++++--------------
 tests/check-qlist.c                 |  4 +--
 tests/check-qlit.c                  | 10 +++----
 tests/check-qnum.c                  |  4 +--
 tests/check-qobject.c               |  2 +-
 tests/check-qstring.c               |  2 +-
 tests/device-introspect-test.c      | 14 +++++-----
 tests/numa-test.c                   |  8 +++---
 tests/qom-test.c                    |  4 +--
 tests/test-char.c                   |  2 +-
 tests/test-keyval.c                 |  8 +++---
 tests/test-qga.c                    | 19 ++++++-------
 tests/test-qmp-cmds.c               | 12 ++++-----
 tests/test-qmp-event.c              | 16 +++++------
 tests/test-qobject-input-visitor.c  | 10 +++----
 tests/test-qobject-output-visitor.c | 54 ++++++++++++++++++-------------------
 tests/test-x86-cpuid-compat.c       | 17 ++++++------
 util/keyval.c                       |  4 +--
 util/qemu-config.c                  |  2 +-
 util/qemu-option.c                  |  6 ++---
 46 files changed, 225 insertions(+), 221 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 13c910069b5..200b2b9e92a 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -430,7 +430,7 @@ static void qmp_response(JSONMessageParser *parser, GQueue *tokens)
     }

     g_assert(!qmp->response);
-    qmp->response = qobject_to_qdict(obj);
+    qmp->response = qobject_to(QDict, obj);
     g_assert(qmp->response);
 }

@@ -1008,11 +1008,11 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     g_assert(list);

     for (p = qlist_first(list); p; p = qlist_next(p)) {
-        minfo = qobject_to_qdict(qlist_entry_obj(p));
+        minfo = qobject_to(QDict, qlist_entry_obj(p));
         g_assert(minfo);
         qobj = qdict_get(minfo, "name");
         g_assert(qobj);
-        qstr = qobject_to_qstring(qobj);
+        qstr = qobject_to(QString, qobj);
         g_assert(qstr);
         mname = qstring_get_str(qstr);
         cb(mname);
diff --git a/block.c b/block.c
index 75a9fd49de1..cd74da3a601 100644
--- a/block.c
+++ b/block.c
@@ -1457,7 +1457,7 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
         return NULL;
     }

-    options = qobject_to_qdict(options_obj);
+    options = qobject_to(QDict, options_obj);
     if (!options) {
         qobject_decref(options_obj);
         error_setg(errp, "Invalid JSON object given");
@@ -2433,7 +2433,7 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
         }
         visit_complete(v, &obj);

-        qdict = qobject_to_qdict(obj);
+        qdict = qobject_to(QDict, obj);
         qdict_flatten(qdict);

         /* bdrv_open_inherit() defaults to the values in bdrv_flags (for
diff --git a/block/qapi.c b/block/qapi.c
index 4c9923d262b..f2e0aa2cbe7 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -647,29 +647,29 @@ static void dump_qobject(fprintf_function func_fprintf, void *f,
 {
     switch (qobject_type(obj)) {
         case QTYPE_QNUM: {
-            QNum *value = qobject_to_qnum(obj);
+            QNum *value = qobject_to(QNum, obj);
             char *tmp = qnum_to_string(value);
             func_fprintf(f, "%s", tmp);
             g_free(tmp);
             break;
         }
         case QTYPE_QSTRING: {
-            QString *value = qobject_to_qstring(obj);
+            QString *value = qobject_to(QString, obj);
             func_fprintf(f, "%s", qstring_get_str(value));
             break;
         }
         case QTYPE_QDICT: {
-            QDict *value = qobject_to_qdict(obj);
+            QDict *value = qobject_to(QDict, obj);
             dump_qdict(func_fprintf, f, comp_indent, value);
             break;
         }
         case QTYPE_QLIST: {
-            QList *value = qobject_to_qlist(obj);
+            QList *value = qobject_to(QList, obj);
             dump_qlist(func_fprintf, f, comp_indent, value);
             break;
         }
         case QTYPE_QBOOL: {
-            QBool *value = qobject_to_qbool(obj);
+            QBool *value = qobject_to(QBool, obj);
             func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "false");
             break;
         }
@@ -730,7 +730,7 @@ void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *f,

     visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
     visit_complete(v, &obj);
-    data = qdict_get(qobject_to_qdict(obj), "data");
+    data = qdict_get(qobject_to(QDict, obj), "data");
     dump_qobject(func_fprintf, f, 1, data);
     qobject_decref(obj);
     visit_free(v);
diff --git a/block/qcow2.c b/block/qcow2.c
index 7472af69312..cf4f3becae6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3125,7 +3125,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
     /* Now get the QAPI type BlockdevCreateOptions */
     qobj = qdict_crumple(qdict, errp);
     QDECREF(qdict);
-    qdict = qobject_to_qdict(qobj);
+    qdict = qobject_to(QDict, qobj);
     if (qdict == NULL) {
         ret = -EINVAL;
         goto finish;
diff --git a/block/rbd.c b/block/rbd.c
index 294ed07ac41..5b64849dc67 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -263,14 +263,14 @@ static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_json,
     if (!keypairs_json) {
         return ret;
     }
-    keypairs = qobject_to_qlist(qobject_from_json(keypairs_json,
-                                                  &error_abort));
+    keypairs = qobject_to(QList,
+                          qobject_from_json(keypairs_json, &error_abort));
     remaining = qlist_size(keypairs) / 2;
     assert(remaining);

     while (remaining--) {
-        name = qobject_to_qstring(qlist_pop(keypairs));
-        value = qobject_to_qstring(qlist_pop(keypairs));
+        name = qobject_to(QString, qlist_pop(keypairs));
+        value = qobject_to(QString, qlist_pop(keypairs));
         assert(name && value);
         key = qstring_get_str(name);

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 8680b2926f0..abda8857768 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1887,7 +1887,7 @@ static int sd_create_prealloc(BlockdevOptionsSheepdog *location, int64_t size,
         return -EINVAL;
     }

-    qdict = qobject_to_qdict(obj);
+    qdict = qobject_to(QDict, obj);
     qdict_flatten(qdict);

     qdict_put_str(qdict, "driver", "sheepdog");
diff --git a/blockdev.c b/blockdev.c
index 1fbfd3a2c40..c9a212b3149 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -334,7 +334,8 @@ static bool parse_stats_intervals(BlockAcctStats *stats, QList *intervals,

         case QTYPE_QSTRING: {
             unsigned long long length;
-            const char *str = qstring_get_str(qobject_to_qstring(entry->value));
+            const char *str = qstring_get_str(qobject_to(QString,
+                                                         entry->value));
             if (parse_uint_full(str, &length, 10) == 0 &&
                 length > 0 && length <= UINT_MAX) {
                 block_acct_add_interval(stats, (unsigned) length);
@@ -346,7 +347,7 @@ static bool parse_stats_intervals(BlockAcctStats *stats, QList *intervals,
         }

         case QTYPE_QNUM: {
-            int64_t length = qnum_get_int(qobject_to_qnum(entry->value));
+            int64_t length = qnum_get_int(qobject_to(QNum, entry->value));

             if (length > 0 && length <= UINT_MAX) {
                 block_acct_add_interval(stats, (unsigned) length);
@@ -3982,7 +3983,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
     }

     visit_complete(v, &obj);
-    qdict = qobject_to_qdict(obj);
+    qdict = qobject_to(QDict, obj);

     qdict_flatten(qdict);

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index deb440f2863..2d62499bf12 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -154,21 +154,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     /* Fill in optional s3/s4 related properties */
     o = object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NULL);
     if (o) {
-        pm->s3_disabled = qnum_get_uint(qobject_to_qnum(o));
+        pm->s3_disabled = qnum_get_uint(qobject_to(QNum, o));
     } else {
         pm->s3_disabled = false;
     }
     qobject_decref(o);
     o = object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NULL);
     if (o) {
-        pm->s4_disabled = qnum_get_uint(qobject_to_qnum(o));
+        pm->s4_disabled = qnum_get_uint(qobject_to(QNum, o));
     } else {
         pm->s4_disabled = false;
     }
     qobject_decref(o);
     o = object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
     if (o) {
-        pm->s4_val = qnum_get_uint(qobject_to_qnum(o));
+        pm->s4_val = qnum_get_uint(qobject_to(QNum, o));
     } else {
         pm->s4_val = false;
     }
@@ -514,7 +514,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,

     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to_qnum(bsel));
+        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));

         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
         notify_method = aml_method("DVNT", 2, AML_NOTSERIALIZED);
@@ -624,7 +624,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,

     /* If bus supports hotplug select it and notify about local events */
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to_qnum(bsel));
+        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));

         aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
         aml_append(method,
@@ -2638,12 +2638,12 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     if (!o) {
         return false;
     }
-    mcfg->mcfg_base = qnum_get_uint(qobject_to_qnum(o));
+    mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
     qobject_decref(o);

     o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
     assert(o);
-    mcfg->mcfg_size = qnum_get_uint(qobject_to_qnum(o));
+    mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
     qobject_decref(o);
     return true;
 }
diff --git a/monitor.c b/monitor.c
index db166fab52f..c18a2f2dc98 100644
--- a/monitor.c
+++ b/monitor.c
@@ -447,7 +447,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
         /* Unthrottled event */
         monitor_qapi_event_emit(event, qdict);
     } else {
-        QDict *data = qobject_to_qdict(qdict_get(qdict, "data"));
+        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
         MonitorQAPIEventState key = { .event = event, .data = data };

         evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
@@ -3774,7 +3774,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         goto err_out;
     }

-    qdict = qobject_to_qdict(req);
+    qdict = qobject_to(QDict, req);
     if (qdict) {
         id = qdict_get(qdict, "id");
         qobject_incref(id);
@@ -3790,7 +3790,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     rsp = qmp_dispatch(cur_mon->qmp.commands, req);

     if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
-        qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");
+        qdict = qdict_get_qdict(qobject_to(QDict, rsp), "error");
         if (qdict
             && !g_strcmp0(qdict_get_try_str(qdict, "class"),
                     QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) {
@@ -3811,7 +3811,7 @@ err_out:

     if (rsp) {
         if (id) {
-            qdict_put_obj(qobject_to_qdict(rsp), "id", id);
+            qdict_put_obj(qobject_to(QDict, rsp), "id", id);
             id = NULL;
         }

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e31ac4be1fb..af537f3d7d2 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -26,7 +26,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
     bool has_exec_key = false;
     QDict *dict = NULL;

-    dict = qobject_to_qdict(request);
+    dict = qobject_to(QDict, request);
     if (!dict) {
         error_setg(errp, "QMP input must be a JSON object");
         return NULL;
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 023317b05fc..0b5293385e5 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -137,7 +137,7 @@ static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,

     if (qobject_type(qobj) == QTYPE_QDICT) {
         assert(name);
-        ret = qdict_get(qobject_to_qdict(qobj), name);
+        ret = qdict_get(qobject_to(QDict, qobj), name);
         if (tos->h && consume && ret) {
             bool removed = g_hash_table_remove(tos->h, name);
             assert(removed);
@@ -185,7 +185,7 @@ static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
         return NULL;
     }

-    qstr = qobject_to_qstring(qobj);
+    qstr = qobject_to(QString, qobj);
     if (!qstr) {
         switch (qobject_type(qobj)) {
         case QTYPE_QDICT:
@@ -224,11 +224,11 @@ static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,

     if (qobject_type(obj) == QTYPE_QDICT) {
         h = g_hash_table_new(g_str_hash, g_str_equal);
-        qdict_iter(qobject_to_qdict(obj), qdict_add_key, h);
+        qdict_iter(qobject_to(QDict, obj), qdict_add_key, h);
         tos->h = h;
     } else {
         assert(qobject_type(obj) == QTYPE_QLIST);
-        tos->entry = qlist_first(qobject_to_qlist(obj));
+        tos->entry = qlist_first(qobject_to(QList, obj));
         tos->index = -1;
     }

@@ -395,7 +395,7 @@ static void qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
     if (!qobj) {
         return;
     }
-    qnum = qobject_to_qnum(qobj);
+    qnum = qobject_to(QNum, qobj);
     if (!qnum || !qnum_get_try_int(qnum, obj)) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "integer");
@@ -430,7 +430,7 @@ static void qobject_input_type_uint64(Visitor *v, const char *name,
     if (!qobj) {
         return;
     }
-    qnum = qobject_to_qnum(qobj);
+    qnum = qobject_to(QNum, qobj);
     if (!qnum) {
         goto err;
     }
@@ -477,7 +477,7 @@ static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     if (!qobj) {
         return;
     }
-    qbool = qobject_to_qbool(qobj);
+    qbool = qobject_to(QBool, qobj);
     if (!qbool) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "boolean");
@@ -518,7 +518,7 @@ static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
     if (!qobj) {
         return;
     }
-    qstr = qobject_to_qstring(qobj);
+    qstr = qobject_to(QString, qobj);
     if (!qstr) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "string");
@@ -547,7 +547,7 @@ static void qobject_input_type_number(Visitor *v, const char *name, double *obj,
     if (!qobj) {
         return;
     }
-    qnum = qobject_to_qnum(qobj);
+    qnum = qobject_to(QNum, qobj);
     if (!qnum) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "number");
@@ -734,7 +734,7 @@ Visitor *qobject_input_visitor_new_str(const char *str,
             }
             return NULL;
         }
-        args = qobject_to_qdict(obj);
+        args = qobject_to(QDict, obj);
         assert(args);
         v = qobject_input_visitor_new(QOBJECT(args));
     } else {
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 7c3b42cfe2b..877e37eeb88 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -92,11 +92,11 @@ static void qobject_output_add_obj(QObjectOutputVisitor *qov, const char *name,
         switch (qobject_type(cur)) {
         case QTYPE_QDICT:
             assert(name);
-            qdict_put_obj(qobject_to_qdict(cur), name, value);
+            qdict_put_obj(qobject_to(QDict, cur), name, value);
             break;
         case QTYPE_QLIST:
             assert(!name);
-            qlist_append_obj(qobject_to_qlist(cur), value);
+            qlist_append_obj(qobject_to(QList, cur), value);
             break;
         default:
             g_assert_not_reached();
diff --git a/qga/main.c b/qga/main.c
index f9c83050c5d..7cc1748c04f 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -607,7 +607,7 @@ static void process_event(JSONMessageParser *parser, GQueue *tokens)
     g_assert(s && parser);

     g_debug("process_event: called");
-    qdict = qobject_to_qdict(json_parser_parse_err(tokens, NULL, &err));
+    qdict = qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err));
     if (err || !qdict) {
         QDECREF(qdict);
         qdict = qdict_new();
diff --git a/qmp.c b/qmp.c
index 8c7d1cc4790..7e606d84867 100644
--- a/qmp.c
+++ b/qmp.c
@@ -705,7 +705,7 @@ void qmp_object_add(const char *type, const char *id,
     Object *obj;

     if (props) {
-        pdict = qobject_to_qdict(props);
+        pdict = qobject_to(QDict, props);
         if (!pdict) {
             error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
             return;
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index b7245624158..055c7f0272a 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -308,7 +308,7 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
         goto out;
     }

-    qdict_put_obj(dict, qstring_get_str(qobject_to_qstring(key)), value);
+    qdict_put_obj(dict, qstring_get_str(qobject_to(QString, key)), value);

     qobject_decref(key);

diff --git a/qobject/qbool.c b/qobject/qbool.c
index e5a7a538793..5be6277cca8 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -55,7 +55,7 @@ QBool *qobject_to_qbool(const QObject *obj)
  */
 bool qbool_is_equal(const QObject *x, const QObject *y)
 {
-    return qobject_to_qbool(x)->value == qobject_to_qbool(y)->value;
+    return qobject_to(QBool, x)->value == qobject_to(QBool, y)->value;
 }

 /**
@@ -65,5 +65,5 @@ bool qbool_is_equal(const QObject *x, const QObject *y)
 void qbool_destroy_obj(QObject *obj)
 {
     assert(obj != NULL);
-    g_free(qobject_to_qbool(obj));
+    g_free(qobject_to(QBool, obj));
 }
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 229b8c840b1..1e588123d00 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -206,7 +206,7 @@ size_t qdict_size(const QDict *qdict)
  */
 double qdict_get_double(const QDict *qdict, const char *key)
 {
-    return qnum_get_double(qobject_to_qnum(qdict_get(qdict, key)));
+    return qnum_get_double(qobject_to(QNum, qdict_get(qdict, key)));
 }

 /**
@@ -219,7 +219,7 @@ double qdict_get_double(const QDict *qdict, const char *key)
  */
 int64_t qdict_get_int(const QDict *qdict, const char *key)
 {
-    return qnum_get_int(qobject_to_qnum(qdict_get(qdict, key)));
+    return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
 }

 /**
@@ -232,7 +232,7 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
  */
 bool qdict_get_bool(const QDict *qdict, const char *key)
 {
-    return qbool_get_bool(qobject_to_qbool(qdict_get(qdict, key)));
+    return qbool_get_bool(qobject_to(QBool, qdict_get(qdict, key)));
 }

 /**
@@ -240,7 +240,7 @@ bool qdict_get_bool(const QDict *qdict, const char *key)
  */
 QList *qdict_get_qlist(const QDict *qdict, const char *key)
 {
-    return qobject_to_qlist(qdict_get(qdict, key));
+    return qobject_to(QList, qdict_get(qdict, key));
 }

 /**
@@ -248,7 +248,7 @@ QList *qdict_get_qlist(const QDict *qdict, const char *key)
  */
 QDict *qdict_get_qdict(const QDict *qdict, const char *key)
 {
-    return qobject_to_qdict(qdict_get(qdict, key));
+    return qobject_to(QDict, qdict_get(qdict, key));
 }

 /**
@@ -262,7 +262,7 @@ QDict *qdict_get_qdict(const QDict *qdict, const char *key)
  */
 const char *qdict_get_str(const QDict *qdict, const char *key)
 {
-    return qstring_get_str(qobject_to_qstring(qdict_get(qdict, key)));
+    return qstring_get_str(qobject_to(QString, qdict_get(qdict, key)));
 }

 /**
@@ -275,7 +275,7 @@ const char *qdict_get_str(const QDict *qdict, const char *key)
 int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value)
 {
-    QNum *qnum = qobject_to_qnum(qdict_get(qdict, key));
+    QNum *qnum = qobject_to(QNum, qdict_get(qdict, key));
     int64_t val;

     if (!qnum || !qnum_get_try_int(qnum, &val)) {
@@ -294,7 +294,7 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
  */
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value)
 {
-    QBool *qbool = qobject_to_qbool(qdict_get(qdict, key));
+    QBool *qbool = qobject_to(QBool, qdict_get(qdict, key));

     return qbool ? qbool_get_bool(qbool) : def_value;
 }
@@ -309,7 +309,7 @@ bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value)
  */
 const char *qdict_get_try_str(const QDict *qdict, const char *key)
 {
-    QString *qstr = qobject_to_qstring(qdict_get(qdict, key));
+    QString *qstr = qobject_to(QString, qdict_get(qdict, key));

     return qstr ? qstring_get_str(qstr) : NULL;
 }
@@ -432,8 +432,8 @@ void qdict_del(QDict *qdict, const char *key)
  */
 bool qdict_is_equal(const QObject *x, const QObject *y)
 {
-    const QDict *dict_x = qobject_to_qdict(x);
-    const QDict *dict_y = qobject_to_qdict(y);
+    const QDict *dict_x = qobject_to(QDict, x);
+    const QDict *dict_y = qobject_to(QDict, y);
     const QDictEntry *e;

     if (qdict_size(dict_x) != qdict_size(dict_y)) {
@@ -461,7 +461,7 @@ void qdict_destroy_obj(QObject *obj)
     QDict *qdict;

     assert(obj != NULL);
-    qdict = qobject_to_qdict(obj);
+    qdict = qobject_to(QDict, obj);

     for (i = 0; i < QDICT_BUCKET_MAX; i++) {
         QDictEntry *entry = QLIST_FIRST(&qdict->table[i]);
@@ -532,9 +532,9 @@ static void qdict_flatten_qlist(QList *qlist, QDict *target, const char *prefix)
         new_key = g_strdup_printf("%s.%i", prefix, i);

         if (qobject_type(value) == QTYPE_QDICT) {
-            qdict_flatten_qdict(qobject_to_qdict(value), target, new_key);
+            qdict_flatten_qdict(qobject_to(QDict, value), target, new_key);
         } else if (qobject_type(value) == QTYPE_QLIST) {
-            qdict_flatten_qlist(qobject_to_qlist(value), target, new_key);
+            qdict_flatten_qlist(qobject_to(QList, value), target, new_key);
         } else {
             /* All other types are moved to the target unchanged. */
             qobject_incref(value);
@@ -568,11 +568,11 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
         if (qobject_type(value) == QTYPE_QDICT) {
             /* Entries of QDicts are processed recursively, the QDict object
              * itself disappears. */
-            qdict_flatten_qdict(qobject_to_qdict(value), target,
+            qdict_flatten_qdict(qobject_to(QDict, value), target,
                                 new_key ? new_key : entry->key);
             delete = true;
         } else if (qobject_type(value) == QTYPE_QLIST) {
-            qdict_flatten_qlist(qobject_to_qlist(value), target,
+            qdict_flatten_qlist(qobject_to(QList, value), target,
                                 new_key ? new_key : entry->key);
             delete = true;
         } else if (prefix) {
@@ -904,7 +904,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
                 qdict_put_obj(two_level, prefix, child);
             }
             qobject_incref(ent->value);
-            qdict_put_obj(qobject_to_qdict(child), suffix, ent->value);
+            qdict_put_obj(qobject_to(QDict, child), suffix, ent->value);
         } else {
             if (child) {
                 error_setg(errp, "Key %s prefix is already set as a dict",
@@ -926,7 +926,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
          ent = qdict_next(two_level, ent)) {

         if (qobject_type(ent->value) == QTYPE_QDICT) {
-            child = qdict_crumple(qobject_to_qdict(ent->value), errp);
+            child = qdict_crumple(qobject_to(QDict, ent->value), errp);
             if (!child) {
                 goto error;
             }
@@ -961,7 +961,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
             }

             qobject_incref(child);
-            qlist_append_obj(qobject_to_qlist(dst), child);
+            qlist_append_obj(qobject_to(QList, dst), child);
         }
         QDECREF(multi_level);
         multi_level = NULL;
diff --git a/qobject/qjson.c b/qobject/qjson.c
index e1ce75651cc..655d38adf1b 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -137,14 +137,14 @@ static void to_json(const QObject *obj, QString *str, int pretty, int indent)
         qstring_append(str, "null");
         break;
     case QTYPE_QNUM: {
-        QNum *val = qobject_to_qnum(obj);
+        QNum *val = qobject_to(QNum, obj);
         char *buffer = qnum_to_string(val);
         qstring_append(str, buffer);
         g_free(buffer);
         break;
     }
     case QTYPE_QSTRING: {
-        QString *val = qobject_to_qstring(obj);
+        QString *val = qobject_to(QString, obj);
         const char *ptr;
         int cp;
         char buf[16];
@@ -201,7 +201,7 @@ static void to_json(const QObject *obj, QString *str, int pretty, int indent)
     }
     case QTYPE_QDICT: {
         ToJsonIterState s;
-        QDict *val = qobject_to_qdict(obj);
+        QDict *val = qobject_to(QDict, obj);

         s.count = 0;
         s.str = str;
@@ -220,7 +220,7 @@ static void to_json(const QObject *obj, QString *str, int pretty, int indent)
     }
     case QTYPE_QLIST: {
         ToJsonIterState s;
-        QList *val = qobject_to_qlist(obj);
+        QList *val = qobject_to(QList, obj);

         s.count = 0;
         s.str = str;
@@ -238,7 +238,7 @@ static void to_json(const QObject *obj, QString *str, int pretty, int indent)
         break;
     }
     case QTYPE_QBOOL: {
-        QBool *val = qobject_to_qbool(obj);
+        QBool *val = qobject_to(QBool, obj);

         if (qbool_get_bool(val)) {
             qstring_append(str, "true");
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 613a95c12b9..77f19ffda78 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -173,8 +173,8 @@ QList *qobject_to_qlist(const QObject *obj)
  */
 bool qlist_is_equal(const QObject *x, const QObject *y)
 {
-    const QList *list_x = qobject_to_qlist(x);
-    const QList *list_y = qobject_to_qlist(y);
+    const QList *list_x = qobject_to(QList, x);
+    const QList *list_y = qobject_to(QList, y);
     const QListEntry *entry_x, *entry_y;

     entry_x = qlist_first(list_x);
@@ -203,7 +203,7 @@ void qlist_destroy_obj(QObject *obj)
     QListEntry *entry, *next_entry;

     assert(obj != NULL);
-    qlist = qobject_to_qlist(obj);
+    qlist = qobject_to(QList, obj);

     QTAILQ_FOREACH_SAFE(entry, &qlist->head, next, next_entry) {
         QTAILQ_REMOVE(&qlist->head, entry, next);
diff --git a/qobject/qlit.c b/qobject/qlit.c
index d0e1b72fd01..be8332136c2 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -69,16 +69,16 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)

     switch (lhs->type) {
     case QTYPE_QBOOL:
-        return lhs->value.qbool == qbool_get_bool(qobject_to_qbool(rhs));
+        return lhs->value.qbool == qbool_get_bool(qobject_to(QBool, rhs));
     case QTYPE_QNUM:
-        return lhs->value.qnum ==  qnum_get_int(qobject_to_qnum(rhs));
+        return lhs->value.qnum ==  qnum_get_int(qobject_to(QNum, rhs));
     case QTYPE_QSTRING:
         return (strcmp(lhs->value.qstr,
-                       qstring_get_str(qobject_to_qstring(rhs))) == 0);
+                       qstring_get_str(qobject_to(QString, rhs))) == 0);
     case QTYPE_QDICT:
-        return qlit_equal_qdict(lhs, qobject_to_qdict(rhs));
+        return qlit_equal_qdict(lhs, qobject_to(QDict, rhs));
     case QTYPE_QLIST:
-        return qlit_equal_qlist(lhs, qobject_to_qlist(rhs));
+        return qlit_equal_qlist(lhs, qobject_to(QList, rhs));
     case QTYPE_QNULL:
         return true;
     default:
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 60c395c1bce..ea091cfaa4b 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -221,8 +221,8 @@ QNum *qobject_to_qnum(const QObject *obj)
  */
 bool qnum_is_equal(const QObject *x, const QObject *y)
 {
-    QNum *num_x = qobject_to_qnum(x);
-    QNum *num_y = qobject_to_qnum(y);
+    QNum *num_x = qobject_to(QNum, x);
+    QNum *num_y = qobject_to(QNum, y);

     switch (num_x->kind) {
     case QNUM_I64:
@@ -271,5 +271,5 @@ bool qnum_is_equal(const QObject *x, const QObject *y)
 void qnum_destroy_obj(QObject *obj)
 {
     assert(obj != NULL);
-    g_free(qobject_to_qnum(obj));
+    g_free(qobject_to(QNum, obj));
 }
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 05b4bbc2d62..2b2153206df 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -132,8 +132,8 @@ const char *qstring_get_str(const QString *qstring)
  */
 bool qstring_is_equal(const QObject *x, const QObject *y)
 {
-    return !strcmp(qobject_to_qstring(x)->string,
-                   qobject_to_qstring(y)->string);
+    return !strcmp(qobject_to(QString, x)->string,
+                   qobject_to(QString, y)->string);
 }

 /**
@@ -145,7 +145,7 @@ void qstring_destroy_obj(QObject *obj)
     QString *qs;

     assert(obj != NULL);
-    qs = qobject_to_qstring(obj);
+    qs = qobject_to(QString, obj);
     g_free(qs->string);
     g_free(qs);
 }
diff --git a/qom/object.c b/qom/object.c
index 755ad038197..7b3a6158fde 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1129,7 +1129,7 @@ char *object_property_get_str(Object *obj, const char *name,
     if (!ret) {
         return NULL;
     }
-    qstring = qobject_to_qstring(ret);
+    qstring = qobject_to(QString, ret);
     if (!qstring) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "string");
         retval = NULL;
@@ -1190,7 +1190,7 @@ bool object_property_get_bool(Object *obj, const char *name,
     if (!ret) {
         return false;
     }
-    qbool = qobject_to_qbool(ret);
+    qbool = qobject_to(QBool, ret);
     if (!qbool) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "boolean");
         retval = false;
@@ -1222,7 +1222,7 @@ int64_t object_property_get_int(Object *obj, const char *name,
         return -1;
     }

-    qnum = qobject_to_qnum(ret);
+    qnum = qobject_to(QNum, ret);
     if (!qnum || !qnum_get_try_int(qnum, &retval)) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "int");
         retval = -1;
@@ -1251,7 +1251,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
     if (!ret) {
         return 0;
     }
-    qnum = qobject_to_qnum(ret);
+    qnum = qobject_to(QNum, ret);
     if (!qnum || !qnum_get_try_uint(qnum, &retval)) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "uint");
         retval = 0;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2c04645ceac..a1234cc780d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3101,7 +3101,7 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,

     xc = x86_cpu_from_model(model->name,
                             model->has_props ?
-                                qobject_to_qdict(model->props) :
+                                qobject_to(QDict, model->props) :
                                 NULL, &err);
     if (err) {
         goto out;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1d5f0da4fe0..2741b6803f7 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -453,7 +453,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
     Object *obj;

     if (info->props) {
-        qdict = qobject_to_qdict(info->props);
+        qdict = qobject_to(QDict, info->props);
         if (!qdict) {
             error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
             return;
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index a3faea8bfc2..2e73c2f86ea 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -51,7 +51,7 @@ static void qdict_put_obj_test(void)

     g_assert(qdict_size(qdict) == 1);
     ent = QLIST_FIRST(&qdict->table[12345 % QDICT_BUCKET_MAX]);
-    qn = qobject_to_qnum(ent->value);
+    qn = qobject_to(QNum, ent->value);
     g_assert_cmpint(qnum_get_int(qn), ==, num);

     QDECREF(qdict);
@@ -81,7 +81,7 @@ static void qdict_get_test(void)
     obj = qdict_get(tests_dict, key);
     g_assert(obj != NULL);

-    qn = qobject_to_qnum(obj);
+    qn = qobject_to(QNum, obj);
     g_assert_cmpint(qnum_get_int(qn), ==, value);

     QDECREF(tests_dict);
@@ -216,7 +216,7 @@ static void qdict_del_test(void)
 static void qobject_to_qdict_test(void)
 {
     QDict *tests_dict = qdict_new();
-    g_assert(qobject_to_qdict(QOBJECT(tests_dict)) == tests_dict);
+    g_assert(qobject_to(QDict, QOBJECT(tests_dict)) == tests_dict);

     QDECREF(tests_dict);
 }
@@ -381,9 +381,9 @@ static void qdict_array_split_test(void)

     qdict_array_split(test_dict, &test_list);

-    dict1 = qobject_to_qdict(qlist_pop(test_list));
-    dict2 = qobject_to_qdict(qlist_pop(test_list));
-    int1 = qobject_to_qnum(qlist_pop(test_list));
+    dict1 = qobject_to(QDict, qlist_pop(test_list));
+    dict2 = qobject_to(QDict, qlist_pop(test_list));
+    int1 = qobject_to(QNum, qlist_pop(test_list));

     g_assert(dict1);
     g_assert(dict2);
@@ -450,7 +450,7 @@ static void qdict_array_split_test(void)

     qdict_array_split(test_dict, &test_list);

-    int1 = qobject_to_qnum(qlist_pop(test_list));
+    int1 = qobject_to(QNum, qlist_pop(test_list));

     g_assert(int1);
     g_assert(qlist_empty(test_list));
@@ -607,7 +607,7 @@ static void qdict_crumple_test_recursive(void)
     qdict_put_str(src, "vnc.acl..name", "acl0");
     qdict_put_str(src, "vnc.acl.rule..name", "acl0");

-    dst = qobject_to_qdict(qdict_crumple(src, &error_abort));
+    dst = qobject_to(QDict, qdict_crumple(src, &error_abort));
     g_assert(dst);
     g_assert_cmpint(qdict_size(dst), ==, 1);

@@ -629,14 +629,14 @@ static void qdict_crumple_test_recursive(void)
     g_assert(rules);
     g_assert_cmpint(qlist_size(rules), ==, 2);

-    rule = qobject_to_qdict(qlist_pop(rules));
+    rule = qobject_to(QDict, qlist_pop(rules));
     g_assert(rule);
     g_assert_cmpint(qdict_size(rule), ==, 2);
     g_assert_cmpstr("fred", ==, qdict_get_str(rule, "match"));
     g_assert_cmpstr("allow", ==, qdict_get_str(rule, "policy"));
     QDECREF(rule);

-    rule = qobject_to_qdict(qlist_pop(rules));
+    rule = qobject_to(QDict, qlist_pop(rules));
     g_assert(rule);
     g_assert_cmpint(qdict_size(rule), ==, 2);
     g_assert_cmpstr("bob", ==, qdict_get_str(rule, "match"));
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index a18ea47cb74..997f4d3d2c9 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -60,7 +60,7 @@ static void escaped_string(void)
         QString *str;

         obj = qobject_from_json(test_cases[i].encoded, &error_abort);
-        str = qobject_to_qstring(obj);
+        str = qobject_to(QString, obj);
         g_assert(str);
         g_assert_cmpstr(qstring_get_str(str), ==, test_cases[i].decoded);

@@ -92,7 +92,7 @@ static void simple_string(void)
         QString *str;

         obj = qobject_from_json(test_cases[i].encoded, &error_abort);
-        str = qobject_to_qstring(obj);
+        str = qobject_to(QString, obj);
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);

@@ -123,7 +123,7 @@ static void single_quote_string(void)
         QString *str;

         obj = qobject_from_json(test_cases[i].encoded, &error_abort);
-        str = qobject_to_qstring(obj);
+        str = qobject_to(QString, obj);
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);

@@ -817,7 +817,7 @@ static void utf8_string(void)

         obj = qobject_from_json(json_in, utf8_out ? &error_abort : NULL);
         if (utf8_out) {
-            str = qobject_to_qstring(obj);
+            str = qobject_to(QString, obj);
             g_assert(str);
             g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
         } else {
@@ -843,7 +843,7 @@ static void utf8_string(void)
          */
         if (0 && json_out != json_in) {
             obj = qobject_from_json(json_out, &error_abort);
-            str = qobject_to_qstring(obj);
+            str = qobject_to(QString, obj);
             g_assert(str);
             g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
         }
@@ -864,8 +864,8 @@ static void vararg_string(void)
     for (i = 0; test_cases[i].decoded; i++) {
         QString *str;

-        str = qobject_to_qstring(qobject_from_jsonf("%s",
-                                                    test_cases[i].decoded));
+        str = qobject_to(QString,
+                         qobject_from_jsonf("%s", test_cases[i].decoded));
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);

@@ -893,8 +893,9 @@ static void simple_number(void)
         QNum *qnum;
         int64_t val;

-        qnum = qobject_to_qnum(qobject_from_json(test_cases[i].encoded,
-                                                 &error_abort));
+        qnum = qobject_to(QNum,
+                          qobject_from_json(test_cases[i].encoded,
+                                            &error_abort));
         g_assert(qnum);
         g_assert(qnum_get_try_int(qnum, &val));
         g_assert_cmpint(val, ==, test_cases[i].decoded);
@@ -920,7 +921,7 @@ static void large_number(void)
     uint64_t val;
     int64_t ival;

-    qnum = qobject_to_qnum(qobject_from_json(maxu64, &error_abort));
+    qnum = qobject_to(QNum, qobject_from_json(maxu64, &error_abort));
     g_assert(qnum);
     g_assert_cmpuint(qnum_get_uint(qnum), ==, 18446744073709551615U);
     g_assert(!qnum_get_try_int(qnum, &ival));
@@ -930,7 +931,7 @@ static void large_number(void)
     QDECREF(str);
     QDECREF(qnum);

-    qnum = qobject_to_qnum(qobject_from_json(gtu64, &error_abort));
+    qnum = qobject_to(QNum, qobject_from_json(gtu64, &error_abort));
     g_assert(qnum);
     g_assert_cmpfloat(qnum_get_double(qnum), ==, 18446744073709552e3);
     g_assert(!qnum_get_try_uint(qnum, &val));
@@ -941,7 +942,7 @@ static void large_number(void)
     QDECREF(str);
     QDECREF(qnum);

-    qnum = qobject_to_qnum(qobject_from_json(lti64, &error_abort));
+    qnum = qobject_to(QNum, qobject_from_json(lti64, &error_abort));
     g_assert(qnum);
     g_assert_cmpfloat(qnum_get_double(qnum), ==, -92233720368547758e2);
     g_assert(!qnum_get_try_uint(qnum, &val));
@@ -973,7 +974,7 @@ static void float_number(void)
         QNum *qnum;

         obj = qobject_from_json(test_cases[i].encoded, &error_abort);
-        qnum = qobject_to_qnum(obj);
+        qnum = qobject_to(QNum, obj);
         g_assert(qnum);
         g_assert(qnum_get_double(qnum) == test_cases[i].decoded);

@@ -997,17 +998,17 @@ static void vararg_number(void)
     double valuef = 2.323423423;
     int64_t val;

-    qnum = qobject_to_qnum(qobject_from_jsonf("%d", value));
+    qnum = qobject_to(QNum, qobject_from_jsonf("%d", value));
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, value);
     QDECREF(qnum);

-    qnum = qobject_to_qnum(qobject_from_jsonf("%lld", value_ll));
+    qnum = qobject_to(QNum, qobject_from_jsonf("%lld", value_ll));
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, value_ll);
     QDECREF(qnum);

-    qnum = qobject_to_qnum(qobject_from_jsonf("%f", valuef));
+    qnum = qobject_to(QNum, qobject_from_jsonf("%f", valuef));
     g_assert(qnum_get_double(qnum) == valuef);
     QDECREF(qnum);
 }
@@ -1020,7 +1021,7 @@ static void keyword_literal(void)
     QString *str;

     obj = qobject_from_json("true", &error_abort);
-    qbool = qobject_to_qbool(obj);
+    qbool = qobject_to(QBool, obj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);

@@ -1031,7 +1032,7 @@ static void keyword_literal(void)
     QDECREF(qbool);

     obj = qobject_from_json("false", &error_abort);
-    qbool = qobject_to_qbool(obj);
+    qbool = qobject_to(QBool, obj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == false);

@@ -1041,13 +1042,13 @@ static void keyword_literal(void)

     QDECREF(qbool);

-    qbool = qobject_to_qbool(qobject_from_jsonf("%i", false));
+    qbool = qobject_to(QBool, qobject_from_jsonf("%i", false));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == false);
     QDECREF(qbool);

     /* Test that non-zero values other than 1 get collapsed to true */
-    qbool = qobject_to_qbool(qobject_from_jsonf("%i", 2));
+    qbool = qobject_to(QBool, qobject_from_jsonf("%i", 2));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
     QDECREF(qbool);
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index 259980d5239..a1c69ed6481 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -56,7 +56,7 @@ static void qobject_to_qlist_test(void)

     qlist = qlist_new();

-    g_assert(qobject_to_qlist(QOBJECT(qlist)) == qlist);
+    g_assert(qobject_to(QList, QOBJECT(qlist)) == qlist);

     QDECREF(qlist);
 }
@@ -71,7 +71,7 @@ static void iter_func(QObject *obj, void *opaque)

     g_assert(opaque == NULL);

-    qi = qobject_to_qnum(obj);
+    qi = qobject_to(QNum, obj);
     g_assert(qi != NULL);

     g_assert(qnum_get_try_int(qi, &val));
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index 836f4a3090c..96bbb06f2c7 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -59,7 +59,7 @@ static void qlit_equal_qobject_test(void)

     g_assert(!qlit_equal_qobject(&qlit_foo, qobj));

-    qdict_put(qobject_to_qdict(qobj), "bee", qlist_new());
+    qdict_put(qobject_to(QDict, qobj), "bee", qlist_new());
     g_assert(!qlit_equal_qobject(&qlit, qobj));

     qobject_decref(qobj);
@@ -71,20 +71,20 @@ static void qobject_from_qlit_test(void)
     QDict *qdict;
     QList *bee;

-    qdict = qobject_to_qdict(qobj);
+    qdict = qobject_to(QDict, qobj);
     g_assert_cmpint(qdict_get_int(qdict, "foo"), ==, 42);
     g_assert_cmpstr(qdict_get_str(qdict, "bar"), ==, "hello world");
     g_assert(qobject_type(qdict_get(qdict, "baz")) == QTYPE_QNULL);

     bee = qdict_get_qlist(qdict, "bee");
     obj = qlist_pop(bee);
-    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), ==, 43);
+    g_assert_cmpint(qnum_get_int(qobject_to(QNum, obj)), ==, 43);
     qobject_decref(obj);
     obj = qlist_pop(bee);
-    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), ==, 44);
+    g_assert_cmpint(qnum_get_int(qobject_to(QNum, obj)), ==, 44);
     qobject_decref(obj);
     obj = qlist_pop(bee);
-    g_assert(qbool_get_bool(qobject_to_qbool(obj)));
+    g_assert(qbool_get_bool(qobject_to(QBool, obj)));
     qobject_decref(obj);

     qobject_decref(qobj);
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index 2b667f7ad77..9187da734b0 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -126,11 +126,11 @@ static void qobject_to_qnum_test(void)
     QNum *qn;

     qn = qnum_from_int(0);
-    g_assert(qobject_to_qnum(QOBJECT(qn)) == qn);
+    g_assert(qobject_to(QNum, QOBJECT(qn)) == qn);
     QDECREF(qn);

     qn = qnum_from_double(0);
-    g_assert(qobject_to_qnum(QOBJECT(qn)) == qn);
+    g_assert(qobject_to(QNum, QOBJECT(qn)) == qn);
     QDECREF(qn);
 }

diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 7a3670643cb..7629b8071b3 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -275,7 +275,7 @@ static void qobject_is_equal_dict_test(void)
                   dict_different_null_key, dict_longer, dict_shorter,
                   dict_nested);

-    dict_crumpled = qobject_to_qdict(qdict_crumple(dict_1, &local_err));
+    dict_crumpled = qobject_to(QDict, qdict_crumple(dict_1, &local_err));
     g_assert(!local_err);
     check_equal(dict_crumpled, dict_nested);

diff --git a/tests/check-qstring.c b/tests/check-qstring.c
index 112ec08967f..9c4dd3f94fc 100644
--- a/tests/check-qstring.c
+++ b/tests/check-qstring.c
@@ -79,7 +79,7 @@ static void qobject_to_qstring_test(void)
     QString *qstring;

     qstring = qstring_from_str("foo");
-    g_assert(qobject_to_qstring(QOBJECT(qstring)) == qstring);
+    g_assert(qobject_to(QString, QOBJECT(qstring)) == qstring);

     QDECREF(qstring);
 }
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index b80058fe988..a01321aced7 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -52,7 +52,7 @@ static QDict *qom_type_index(QList *types)
     QListEntry *e;

     QLIST_FOREACH_ENTRY(types, e) {
-        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        QDict *d = qobject_to(QDict, qlist_entry_obj(e));
         const char *name = qdict_get_str(d, "name");
         QINCREF(d);
         qdict_put(index, name, d);
@@ -85,7 +85,7 @@ static QDict *type_list_find(QList *types, const char *name)
     QListEntry *e;

     QLIST_FOREACH_ENTRY(types, e) {
-        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        QDict *d = qobject_to(QDict, qlist_entry_obj(e));
         const char *ename = qdict_get_str(d, "name");
         if (!strcmp(ename, name)) {
             return d;
@@ -151,7 +151,7 @@ static void test_qom_list_parents(const char *parent)
     index = qom_type_index(types);

     QLIST_FOREACH_ENTRY(types, e) {
-        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        QDict *d = qobject_to(QDict, qlist_entry_obj(e));
         const char *name = qdict_get_str(d, "name");

         g_assert(qom_has_parent(index, name, parent));
@@ -173,7 +173,7 @@ static void test_qom_list_fields(void)
     non_abstract = qom_list_types(NULL, false);

     QLIST_FOREACH_ENTRY(all_types, e) {
-        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        QDict *d = qobject_to(QDict, qlist_entry_obj(e));
         const char *name = qdict_get_str(d, "name");
         bool abstract = qdict_haskey(d, "abstract") ?
                         qdict_get_bool(d, "abstract") :
@@ -216,8 +216,8 @@ static void test_device_intro_concrete(void)
     types = device_type_list(false);

     QLIST_FOREACH_ENTRY(types, entry) {
-        type = qdict_get_try_str(qobject_to_qdict(qlist_entry_obj(entry)),
-                                "name");
+        type = qdict_get_try_str(qobject_to(QDict, qlist_entry_obj(entry)),
+                                 "name");
         g_assert(type);
         test_one_device(type);
     }
@@ -238,7 +238,7 @@ static void test_abstract_interfaces(void)
     index = qom_type_index(all_types);

     QLIST_FOREACH_ENTRY(all_types, e) {
-        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        QDict *d = qobject_to(QDict, qlist_entry_obj(e));
         const char *name = qdict_get_str(d, "name");

         /*
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 68aca9cb389..0f861d8176d 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -98,7 +98,7 @@ static void test_query_cpus(const void *data)
         QDict *cpu, *props;
         int64_t cpu_idx, node;

-        cpu = qobject_to_qdict(e);
+        cpu = qobject_to(QDict, e);
         g_assert(qdict_haskey(cpu, "CPU"));
         g_assert(qdict_haskey(cpu, "props"));

@@ -140,7 +140,7 @@ static void pc_numa_cpu(const void *data)
         QDict *cpu, *props;
         int64_t socket, core, thread, node;

-        cpu = qobject_to_qdict(e);
+        cpu = qobject_to(QDict, e);
         g_assert(qdict_haskey(cpu, "props"));
         props = qdict_get_qdict(cpu, "props");

@@ -193,7 +193,7 @@ static void spapr_numa_cpu(const void *data)
         QDict *cpu, *props;
         int64_t core, node;

-        cpu = qobject_to_qdict(e);
+        cpu = qobject_to(QDict, e);
         g_assert(qdict_haskey(cpu, "props"));
         props = qdict_get_qdict(cpu, "props");

@@ -236,7 +236,7 @@ static void aarch64_numa_cpu(const void *data)
         QDict *cpu, *props;
         int64_t thread, node;

-        cpu = qobject_to_qdict(e);
+        cpu = qobject_to(QDict, e);
         g_assert(qdict_haskey(cpu, "props"));
         props = qdict_get_qdict(cpu, "props");

diff --git a/tests/qom-test.c b/tests/qom-test.c
index 9dab7ac61ec..a34ff6ba53f 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -62,9 +62,9 @@ static void test_properties(const char *path, bool recurse)
     }

     g_assert(qdict_haskey(response, "return"));
-    list = qobject_to_qlist(qdict_get(response, "return"));
+    list = qobject_to(QList, qdict_get(response, "return"));
     QLIST_FOREACH_ENTRY(list, entry) {
-        tuple = qobject_to_qdict(qlist_entry_obj(entry));
+        tuple = qobject_to(QDict, qlist_entry_obj(entry));
         bool is_child = strstart(qdict_get_str(tuple, "type"), "child<", NULL);
         bool is_link = strstart(qdict_get_str(tuple, "type"), "link<", NULL);

diff --git a/tests/test-char.c b/tests/test-char.c
index b3a77af0855..c4178f95e7f 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -321,7 +321,7 @@ static void char_socket_test(void)
     g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_abort));

     addr = object_property_get_qobject(OBJECT(chr), "addr", &error_abort);
-    qdict = qobject_to_qdict(addr);
+    qdict = qobject_to(QDict, addr);
     port = qdict_get_str(qdict, "port");
     tmp = g_strdup_printf("tcp:127.0.0.1:%s", port);
     QDECREF(qdict);
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 94eb4df28d4..029f05202a8 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -195,7 +195,7 @@ static void check_list012(QList *qlist)

     g_assert(qlist);
     for (i = 0; i < ARRAY_SIZE(expected); i++) {
-        qstr = qobject_to_qstring(qlist_pop(qlist));
+        qstr = qobject_to(QString, qlist_pop(qlist));
         g_assert(qstr);
         g_assert_cmpstr(qstring_get_str(qstr), ==, expected[i]);
         QDECREF(qstr);
@@ -654,12 +654,12 @@ static void test_keyval_visit_any(void)
     QDECREF(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_any(v, "a", &any, &error_abort);
-    qlist = qobject_to_qlist(any);
+    qlist = qobject_to(QList, any);
     g_assert(qlist);
-    qstr = qobject_to_qstring(qlist_pop(qlist));
+    qstr = qobject_to(QString, qlist_pop(qlist));
     g_assert_cmpstr(qstring_get_str(qstr), ==, "null");
     QDECREF(qstr);
-    qstr = qobject_to_qstring(qlist_pop(qlist));
+    qstr = qobject_to(QString, qlist_pop(qlist));
     g_assert_cmpstr(qstring_get_str(qstr), ==, "1");
     g_assert(qlist_empty(qlist));
     QDECREF(qstr);
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 5c5b661f8a3..e6ab788f31a 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -297,8 +297,8 @@ static void test_qga_get_vcpus(gconstpointer fix)
     /* check there is at least a cpu */
     list = qdict_get_qlist(ret, "return");
     entry = qlist_first(list);
-    g_assert(qdict_haskey(qobject_to_qdict(entry->value), "online"));
-    g_assert(qdict_haskey(qobject_to_qdict(entry->value), "logical-id"));
+    g_assert(qdict_haskey(qobject_to(QDict, entry->value), "online"));
+    g_assert(qdict_haskey(qobject_to(QDict, entry->value), "logical-id"));

     QDECREF(ret);
 }
@@ -318,10 +318,10 @@ static void test_qga_get_fsinfo(gconstpointer fix)
     list = qdict_get_qlist(ret, "return");
     entry = qlist_first(list);
     if (entry) {
-        g_assert(qdict_haskey(qobject_to_qdict(entry->value), "name"));
-        g_assert(qdict_haskey(qobject_to_qdict(entry->value), "mountpoint"));
-        g_assert(qdict_haskey(qobject_to_qdict(entry->value), "type"));
-        g_assert(qdict_haskey(qobject_to_qdict(entry->value), "disk"));
+        g_assert(qdict_haskey(qobject_to(QDict, entry->value), "name"));
+        g_assert(qdict_haskey(qobject_to(QDict, entry->value), "mountpoint"));
+        g_assert(qdict_haskey(qobject_to(QDict, entry->value), "type"));
+        g_assert(qdict_haskey(qobject_to(QDict, entry->value), "disk"));
     }

     QDECREF(ret);
@@ -363,8 +363,9 @@ static void test_qga_get_memory_blocks(gconstpointer fix)
         entry = qlist_first(list);
         /* newer versions of qga may return empty list without error */
         if (entry) {
-            g_assert(qdict_haskey(qobject_to_qdict(entry->value), "phys-index"));
-            g_assert(qdict_haskey(qobject_to_qdict(entry->value), "online"));
+            g_assert(qdict_haskey(qobject_to(QDict, entry->value),
+                                  "phys-index"));
+            g_assert(qdict_haskey(qobject_to(QDict, entry->value), "online"));
         }
     }

@@ -385,7 +386,7 @@ static void test_qga_network_get_interfaces(gconstpointer fix)
     /* check there is at least an interface */
     list = qdict_get_qlist(ret, "return");
     entry = qlist_first(list);
-    g_assert(qdict_haskey(qobject_to_qdict(entry->value), "name"));
+    g_assert(qdict_haskey(qobject_to(QDict, entry->value), "name"));

     QDECREF(ret);
 }
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 5b1cee69122..93fbbb1b733 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -100,7 +100,7 @@ static void test_dispatch_cmd(void)

     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
-    assert(!qdict_haskey(qobject_to_qdict(resp), "error"));
+    assert(!qdict_haskey(qobject_to(QDict, resp), "error"));

     qobject_decref(resp);
     QDECREF(req);
@@ -117,7 +117,7 @@ static void test_dispatch_cmd_failure(void)

     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
-    assert(qdict_haskey(qobject_to_qdict(resp), "error"));
+    assert(qdict_haskey(qobject_to(QDict, resp), "error"));

     qobject_decref(resp);
     QDECREF(req);
@@ -131,7 +131,7 @@ static void test_dispatch_cmd_failure(void)

     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
-    assert(qdict_haskey(qobject_to_qdict(resp), "error"));
+    assert(qdict_haskey(qobject_to(QDict, resp), "error"));

     qobject_decref(resp);
     QDECREF(req);
@@ -145,7 +145,7 @@ static QObject *test_qmp_dispatch(QDict *req)

     resp_obj = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp_obj);
-    resp = qobject_to_qdict(resp_obj);
+    resp = qobject_to(QDict, resp_obj);
     assert(resp && !qdict_haskey(resp, "error"));
     ret = qdict_get(resp, "return");
     assert(ret);
@@ -176,7 +176,7 @@ static void test_dispatch_cmd_io(void)
     qdict_put(req, "arguments", args);
     qdict_put_str(req, "execute", "user_def_cmd2");

-    ret = qobject_to_qdict(test_qmp_dispatch(req));
+    ret = qobject_to(QDict, test_qmp_dispatch(req));

     assert(!strcmp(qdict_get_str(ret, "string0"), "blah1"));
     ret_dict = qdict_get_qdict(ret, "dict1");
@@ -197,7 +197,7 @@ static void test_dispatch_cmd_io(void)
     qdict_put(req, "arguments", args3);
     qdict_put_str(req, "execute", "guest-get-time");

-    ret3 = qobject_to_qnum(test_qmp_dispatch(req));
+    ret3 = qobject_to(QNum, test_qmp_dispatch(req));
     g_assert(qnum_get_try_int(ret3, &val));
     g_assert_cmpint(val, ==, 66);
     QDECREF(ret3);
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 31f35b3e66a..bb1036615fd 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -60,22 +60,22 @@ void qdict_cmp_do_simple(const char *key, QObject *obj1, void *opaque)

     switch (qobject_type(obj1)) {
     case QTYPE_QBOOL:
-        d->result = (qbool_get_bool(qobject_to_qbool(obj1)) ==
-                     qbool_get_bool(qobject_to_qbool(obj2)));
+        d->result = (qbool_get_bool(qobject_to(QBool, obj1)) ==
+                     qbool_get_bool(qobject_to(QBool, obj2)));
         return;
     case QTYPE_QNUM:
-        g_assert(qnum_get_try_int(qobject_to_qnum(obj1), &val1));
-        g_assert(qnum_get_try_int(qobject_to_qnum(obj2), &val2));
+        g_assert(qnum_get_try_int(qobject_to(QNum, obj1), &val1));
+        g_assert(qnum_get_try_int(qobject_to(QNum, obj2), &val2));
         d->result = val1 == val2;
         return;
     case QTYPE_QSTRING:
-        d->result = g_strcmp0(qstring_get_str(qobject_to_qstring(obj1)),
-                              qstring_get_str(qobject_to_qstring(obj2))) == 0;
+        d->result = g_strcmp0(qstring_get_str(qobject_to(QString, obj1)),
+                              qstring_get_str(qobject_to(QString, obj2))) == 0;
         return;
     case QTYPE_QDICT:
-        d_new.expect = qobject_to_qdict(obj2);
+        d_new.expect = qobject_to(QDict, obj2);
         d_new.result = true;
-        qdict_iter(qobject_to_qdict(obj1), qdict_cmp_do_simple, &d_new);
+        qdict_iter(qobject_to(QDict, obj1), qdict_cmp_do_simple, &d_new);
         d->result = d_new.result;
         return;
     default:
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 55db6bdef13..6dc59c62116 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -479,7 +479,7 @@ static void test_visitor_in_any(TestInputVisitorData *data,

     v = visitor_input_test_init(data, "-42");
     visit_type_any(v, NULL, &res, &error_abort);
-    qnum = qobject_to_qnum(res);
+    qnum = qobject_to(QNum, res);
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, -42);
@@ -487,22 +487,22 @@ static void test_visitor_in_any(TestInputVisitorData *data,

     v = visitor_input_test_init(data, "{ 'integer': -42, 'boolean': true, 'string': 'foo' }");
     visit_type_any(v, NULL, &res, &error_abort);
-    qdict = qobject_to_qdict(res);
+    qdict = qobject_to(QDict, res);
     g_assert(qdict && qdict_size(qdict) == 3);
     qobj = qdict_get(qdict, "integer");
     g_assert(qobj);
-    qnum = qobject_to_qnum(qobj);
+    qnum = qobject_to(QNum, qobj);
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, -42);
     qobj = qdict_get(qdict, "boolean");
     g_assert(qobj);
-    qbool = qobject_to_qbool(qobj);
+    qbool = qobject_to(QBool, qobj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
     qobj = qdict_get(qdict, "string");
     g_assert(qobj);
-    qstring = qobject_to_qstring(qobj);
+    qstring = qobject_to(QString, qobj);
     g_assert(qstring);
     g_assert_cmpstr(qstring_get_str(qstring), ==, "foo");
     qobject_decref(res);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 11e8c5aa403..ecf21c0f318 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -66,7 +66,7 @@ static void test_visitor_out_int(TestOutputVisitorData *data,

     visit_type_int(data->ov, NULL, &value, &error_abort);

-    qnum = qobject_to_qnum(visitor_get(data));
+    qnum = qobject_to(QNum, visitor_get(data));
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, value);
@@ -80,7 +80,7 @@ static void test_visitor_out_bool(TestOutputVisitorData *data,

     visit_type_bool(data->ov, NULL, &value, &error_abort);

-    qbool = qobject_to_qbool(visitor_get(data));
+    qbool = qobject_to(QBool, visitor_get(data));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == value);
 }
@@ -93,7 +93,7 @@ static void test_visitor_out_number(TestOutputVisitorData *data,

     visit_type_number(data->ov, NULL, &value, &error_abort);

-    qnum = qobject_to_qnum(visitor_get(data));
+    qnum = qobject_to(QNum, visitor_get(data));
     g_assert(qnum);
     g_assert(qnum_get_double(qnum) == value);
 }
@@ -106,7 +106,7 @@ static void test_visitor_out_string(TestOutputVisitorData *data,

     visit_type_str(data->ov, NULL, &string, &error_abort);

-    qstr = qobject_to_qstring(visitor_get(data));
+    qstr = qobject_to(QString, visitor_get(data));
     g_assert(qstr);
     g_assert_cmpstr(qstring_get_str(qstr), ==, string);
 }
@@ -120,7 +120,7 @@ static void test_visitor_out_no_string(TestOutputVisitorData *data,
     /* A null string should return "" */
     visit_type_str(data->ov, NULL, &string, &error_abort);

-    qstr = qobject_to_qstring(visitor_get(data));
+    qstr = qobject_to(QString, visitor_get(data));
     g_assert(qstr);
     g_assert_cmpstr(qstring_get_str(qstr), ==, "");
 }
@@ -134,7 +134,7 @@ static void test_visitor_out_enum(TestOutputVisitorData *data,
     for (i = 0; i < ENUM_ONE__MAX; i++) {
         visit_type_EnumOne(data->ov, "unused", &i, &error_abort);

-        qstr = qobject_to_qstring(visitor_get(data));
+        qstr = qobject_to(QString, visitor_get(data));
         g_assert(qstr);
         g_assert_cmpstr(qstring_get_str(qstr), ==, EnumOne_str(i));
         visitor_reset(data);
@@ -167,7 +167,7 @@ static void test_visitor_out_struct(TestOutputVisitorData *data,

     visit_type_TestStruct(data->ov, NULL, &p, &error_abort);

-    qdict = qobject_to_qdict(visitor_get(data));
+    qdict = qobject_to(QDict, visitor_get(data));
     g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 3);
     g_assert_cmpint(qdict_get_int(qdict, "integer"), ==, 42);
@@ -206,7 +206,7 @@ static void test_visitor_out_struct_nested(TestOutputVisitorData *data,

     visit_type_UserDefTwo(data->ov, "unused", &ud2, &error_abort);

-    qdict = qobject_to_qdict(visitor_get(data));
+    qdict = qobject_to(QDict, visitor_get(data));
     g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 2);
     g_assert_cmpstr(qdict_get_str(qdict, "string0"), ==, strings[0]);
@@ -280,7 +280,7 @@ static void test_visitor_out_list(TestOutputVisitorData *data,

     visit_type_TestStructList(data->ov, NULL, &head, &error_abort);

-    qlist = qobject_to_qlist(visitor_get(data));
+    qlist = qobject_to(QList, visitor_get(data));
     g_assert(qlist);
     g_assert(!qlist_empty(qlist));

@@ -289,7 +289,7 @@ static void test_visitor_out_list(TestOutputVisitorData *data,
     QLIST_FOREACH_ENTRY(qlist, entry) {
         QDict *qdict;

-        qdict = qobject_to_qdict(entry->value);
+        qdict = qobject_to(QDict, entry->value);
         g_assert(qdict);
         g_assert_cmpint(qdict_size(qdict), ==, 3);
         g_assert_cmpint(qdict_get_int(qdict, "integer"), ==, value_int + i);
@@ -342,7 +342,7 @@ static void test_visitor_out_any(TestOutputVisitorData *data,

     qobj = QOBJECT(qnum_from_int(-42));
     visit_type_any(data->ov, NULL, &qobj, &error_abort);
-    qnum = qobject_to_qnum(visitor_get(data));
+    qnum = qobject_to(QNum, visitor_get(data));
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, -42);
@@ -356,16 +356,16 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
     qobj = QOBJECT(qdict);
     visit_type_any(data->ov, NULL, &qobj, &error_abort);
     qobject_decref(qobj);
-    qdict = qobject_to_qdict(visitor_get(data));
+    qdict = qobject_to(QDict, visitor_get(data));
     g_assert(qdict);
-    qnum = qobject_to_qnum(qdict_get(qdict, "integer"));
+    qnum = qobject_to(QNum, qdict_get(qdict, "integer"));
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, -42);
-    qbool = qobject_to_qbool(qdict_get(qdict, "boolean"));
+    qbool = qobject_to(QBool, qdict_get(qdict, "boolean"));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
-    qstring = qobject_to_qstring(qdict_get(qdict, "string"));
+    qstring = qobject_to(QString, qdict_get(qdict, "string"));
     g_assert(qstring);
     g_assert_cmpstr(qstring_get_str(qstring), ==, "foo");
 }
@@ -382,7 +382,7 @@ static void test_visitor_out_union_flat(TestOutputVisitorData *data,
     tmp->u.value1.boolean = true;

     visit_type_UserDefFlatUnion(data->ov, NULL, &tmp, &error_abort);
-    qdict = qobject_to_qdict(visitor_get(data));
+    qdict = qobject_to(QDict, visitor_get(data));
     g_assert(qdict);
     g_assert_cmpstr(qdict_get_str(qdict, "enum1"), ==, "value1");
     g_assert_cmpstr(qdict_get_str(qdict, "string"), ==, "str");
@@ -406,7 +406,7 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
     tmp->u.i = 42;

     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
-    qnum = qobject_to_qnum(visitor_get(data));
+    qnum = qobject_to(QNum, visitor_get(data));
     g_assert(qnum);
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, 42);
@@ -419,7 +419,7 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
     tmp->u.e = ENUM_ONE_VALUE1;

     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
-    qstr = qobject_to_qstring(visitor_get(data));
+    qstr = qobject_to(QString, visitor_get(data));
     g_assert(qstr);
     g_assert_cmpstr(qstring_get_str(qstr), ==, "value1");

@@ -444,7 +444,7 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
     tmp->u.udfu.u.value1.boolean = true;

     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
-    qdict = qobject_to_qdict(visitor_get(data));
+    qdict = qobject_to(QDict, visitor_get(data));
     g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 4);
     g_assert_cmpint(qdict_get_int(qdict, "integer"), ==, 1);
@@ -466,7 +466,7 @@ static void test_visitor_out_null(TestOutputVisitorData *data,
     visit_type_null(data->ov, "a", &null, &error_abort);
     visit_check_struct(data->ov, &error_abort);
     visit_end_struct(data->ov, NULL);
-    qdict = qobject_to_qdict(visitor_get(data));
+    qdict = qobject_to(QDict, visitor_get(data));
     g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 1);
     nil = qdict_get(qdict, "a");
@@ -610,10 +610,10 @@ static void check_native_list(QObject *qobj,
     QList *qlist;
     int i;

-    qdict = qobject_to_qdict(qobj);
+    qdict = qobject_to(QDict, qobj);
     g_assert(qdict);
     g_assert(qdict_haskey(qdict, "data"));
-    qlist = qlist_copy(qobject_to_qlist(qdict_get(qdict, "data")));
+    qlist = qlist_copy(qobject_to(QList, qdict_get(qdict, "data")));

     switch (kind) {
     case USER_DEF_NATIVE_LIST_UNION_KIND_U8:
@@ -627,7 +627,7 @@ static void check_native_list(QObject *qobj,

             tmp = qlist_peek(qlist);
             g_assert(tmp);
-            qvalue = qobject_to_qnum(tmp);
+            qvalue = qobject_to(QNum, tmp);
             g_assert(qnum_get_try_uint(qvalue, &val));
             g_assert_cmpint(val, ==, i);
             qobject_decref(qlist_pop(qlist));
@@ -651,7 +651,7 @@ static void check_native_list(QObject *qobj,

             tmp = qlist_peek(qlist);
             g_assert(tmp);
-            qvalue = qobject_to_qnum(tmp);
+            qvalue = qobject_to(QNum, tmp);
             g_assert(qnum_get_try_int(qvalue, &val));
             g_assert_cmpint(val, ==, i);
             qobject_decref(qlist_pop(qlist));
@@ -663,7 +663,7 @@ static void check_native_list(QObject *qobj,
             QBool *qvalue;
             tmp = qlist_peek(qlist);
             g_assert(tmp);
-            qvalue = qobject_to_qbool(tmp);
+            qvalue = qobject_to(QBool, tmp);
             g_assert_cmpint(qbool_get_bool(qvalue), ==, i % 3 == 0);
             qobject_decref(qlist_pop(qlist));
         }
@@ -675,7 +675,7 @@ static void check_native_list(QObject *qobj,
             gchar str[8];
             tmp = qlist_peek(qlist);
             g_assert(tmp);
-            qvalue = qobject_to_qstring(tmp);
+            qvalue = qobject_to(QString, tmp);
             sprintf(str, "%d", i);
             g_assert_cmpstr(qstring_get_str(qvalue), ==, str);
             qobject_decref(qlist_pop(qlist));
@@ -690,7 +690,7 @@ static void check_native_list(QObject *qobj,

             tmp = qlist_peek(qlist);
             g_assert(tmp);
-            qvalue = qobject_to_qnum(tmp);
+            qvalue = qobject_to(QNum, tmp);
             g_string_printf(double_expected, "%.6f", (double)i / 3);
             g_string_printf(double_actual, "%.6f", qnum_get_double(qvalue));
             g_assert_cmpstr(double_actual->str, ==, double_expected->str);
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 495dd1e7ef3..02e41843fc9 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -17,7 +17,7 @@ static char *get_cpu0_qom_path(void)
     g_assert(qdict_haskey(resp, "return"));
     ret = qdict_get_qlist(resp, "return");

-    cpu0 = qobject_to_qdict(qlist_peek(ret));
+    cpu0 = qobject_to(QDict, qlist_peek(ret));
     path = g_strdup(qdict_get_str(cpu0, "qom_path"));
     QDECREF(resp);
     return path;
@@ -38,7 +38,7 @@ static QObject *qom_get(const char *path, const char *prop)
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 static bool qom_get_bool(const char *path, const char *prop)
 {
-    QBool *value = qobject_to_qbool(qom_get(path, prop));
+    QBool *value = qobject_to(QBool, qom_get(path, prop));
     bool b = qbool_get_bool(value);

     QDECREF(value);
@@ -61,7 +61,7 @@ static void test_cpuid_prop(const void *data)

     qtest_start(args->cmdline);
     path = get_cpu0_qom_path();
-    value = qobject_to_qnum(qom_get(path, args->property));
+    value = qobject_to(QNum, qom_get(path, args->property));
     g_assert(qnum_get_try_int(value, &val));
     g_assert_cmpint(val, ==, args->expected_value);
     qtest_end();
@@ -105,7 +105,7 @@ static uint32_t get_feature_word(QList *features, uint32_t eax, uint32_t ecx,
     const QListEntry *e;

     for (e = qlist_first(features); e; e = qlist_next(e)) {
-        QDict *w = qobject_to_qdict(qlist_entry_obj(e));
+        QDict *w = qobject_to(QDict, qlist_entry_obj(e));
         const char *rreg = qdict_get_str(w, "cpuid-register");
         uint32_t reax = qdict_get_int(w, "cpuid-input-eax");
         bool has_ecx = qdict_haskey(w, "cpuid-input-ecx");
@@ -116,8 +116,9 @@ static uint32_t get_feature_word(QList *features, uint32_t eax, uint32_t ecx,
             recx = qdict_get_int(w, "cpuid-input-ecx");
         }
         if (eax == reax && (!has_ecx || ecx == recx) && !strcmp(rreg, reg)) {
-            g_assert(qnum_get_try_int(qobject_to_qnum(qdict_get(w, "features")),
-                                  &val));
+            g_assert(qnum_get_try_int(qobject_to(QNum,
+                                                 qdict_get(w, "features")),
+                                      &val));
             return val;
         }
     }
@@ -133,8 +134,8 @@ static void test_feature_flag(const void *data)

     qtest_start(args->cmdline);
     path = get_cpu0_qom_path();
-    present = qobject_to_qlist(qom_get(path, "feature-words"));
-    filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
+    present = qobject_to(QList, qom_get(path, "feature-words"));
+    filtered = qobject_to(QList, qom_get(path, "filtered-features"));
     value = get_feature_word(present, args->in_eax, args->in_ecx, args->reg);
     value |= get_feature_word(filtered, args->in_eax, args->in_ecx, args->reg);
     qtest_end();
diff --git a/util/keyval.c b/util/keyval.c
index 212ae90d003..1c7351a233e 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -221,7 +221,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
             if (!next) {
                 return NULL;
             }
-            cur = qobject_to_qdict(next);
+            cur = qobject_to(QDict, next);
             assert(cur);
         }

@@ -314,7 +314,7 @@ static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
             has_member = true;
         }

-        qdict = qobject_to_qdict(ent->value);
+        qdict = qobject_to(QDict, ent->value);
         if (!qdict) {
             continue;
         }
diff --git a/util/qemu-config.c b/util/qemu-config.c
index c651c4826e7..20f7d1429d8 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -528,7 +528,7 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
         }

         QLIST_FOREACH_ENTRY(list, list_entry) {
-            QDict *section = qobject_to_qdict(qlist_entry_obj(list_entry));
+            QDict *section = qobject_to(QDict, qlist_entry_obj(list_entry));
             char *opt_name;

             if (!section) {
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 2b412eff5e5..d0756fda58d 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -919,15 +919,15 @@ static void qemu_opts_from_qdict_1(const char *key, QObject *obj, void *opaque)

     switch (qobject_type(obj)) {
     case QTYPE_QSTRING:
-        value = qstring_get_str(qobject_to_qstring(obj));
+        value = qstring_get_str(qobject_to(QString, obj));
         break;
     case QTYPE_QNUM:
-        tmp = qnum_to_string(qobject_to_qnum(obj));
+        tmp = qnum_to_string(qobject_to(QNum, obj));
         value = tmp;
         break;
     case QTYPE_QBOOL:
         pstrcpy(buf, sizeof(buf),
-                qbool_get_bool(qobject_to_qbool(obj)) ? "on" : "off");
+                qbool_get_bool(qobject_to(QBool, obj)) ? "on" : "off");
         value = buf;
         break;
     default:
-- 
2.14.3
