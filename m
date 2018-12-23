Received: from eggs.gnu.org ([208.118.235.92]:52041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjk-0007MA-C3
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAji-0001Vn-45
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:36 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjh-0001R3-Pj
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id v13so10103041wrw.5
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:33 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:38 +0100
Message-Id: <8b272e5a75fa89e5acaa7ae9aa3a8260de6744db.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/52] qapi: support nested structs in
 OptsVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Jason Wang <jasowang@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

From: Kővágó, Zoltán <dirty.ice.hu@gmail.com>

The current OptsVisitor flattens the whole structure, if there are same
named fields under different paths (like `in' and `out' in `Audiodev'),
the current visitor can't cope with them (for example setting
`frequency=44100' will set the in's frequency to 44100 and leave out's
frequency unspecified).

This patch fixes it, by always requiring a complete path in case of
nested structs.  Fields in the path are separated by dots, similar to C
structs (without pointers), like `in.frequency' or `out.frequency'.  You
must provide a full path even in non-ambiguous cases.

To keep backward compatibility, this new feature can be disabled when
creating a new OptsVisitor, in that case it will work identical to
previous versions.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 hw/acpi/core.c                          |   2 +-
 include/qapi/opts-visitor.h             |   2 +-
 net/net.c                               |   2 +-
 numa.c                                  |   2 +-
 qapi/opts-visitor.c                     | 129 ++++++++++++++++++++----
 qom/object_interfaces.c                 |   2 +-
 tests/qapi-schema/qapi-schema-test.json |   9 +-
 tests/qapi-schema/qapi-schema-test.out  |   4 +
 tests/test-opts-visitor.c               |  43 +++++++-
 9 files changed, 163 insertions(+), 32 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index d6f0709691..654508ac13 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -243,7 +243,7 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
     {
         Visitor *v;
 
-        v = opts_visitor_new(opts);
+        v = opts_visitor_new(opts, false);
         visit_type_AcpiTableOptions(v, NULL, &hdrs, &err);
         visit_free(v);
     }
diff --git a/include/qapi/opts-visitor.h b/include/qapi/opts-visitor.h
index ca044e3b33..84edb49f7a 100644
--- a/include/qapi/opts-visitor.h
+++ b/include/qapi/opts-visitor.h
@@ -33,6 +33,6 @@ typedef struct OptsVisitor OptsVisitor;
  * (other than integers), null, or arbitrary QTypes. It also requires a
  * non-null list argument to visit_start_list().
  */
-Visitor *opts_visitor_new(const QemuOpts *opts);
+Visitor *opts_visitor_new(const QemuOpts *opts, bool nested);
 
 #endif
diff --git a/net/net.c b/net/net.c
index 1f7d626197..f5e7d8a6ef 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1106,7 +1106,7 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
     void *object = NULL;
     Error *err = NULL;
     int ret = -1;
-    Visitor *v = opts_visitor_new(opts);
+    Visitor *v = opts_visitor_new(opts, false);
 
     const char *type = qemu_opt_get(opts, "type");
 
diff --git a/numa.c b/numa.c
index 50ec016013..31a24f750f 100644
--- a/numa.c
+++ b/numa.c
@@ -220,7 +220,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
     NumaOptions *object = NULL;
     MachineState *ms = MACHINE(opaque);
     Error *err = NULL;
-    Visitor *v = opts_visitor_new(opts);
+    Visitor *v = opts_visitor_new(opts, false);
 
     visit_type_NumaOptions(v, NULL, &object, &err);
     visit_free(v);
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 4af6043b75..d8af51b16c 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -72,6 +72,7 @@ struct OptsVisitor
      * schema, with a single mandatory scalar member. */
     ListMode list_mode;
     GQueue *repeated_opts;
+    char *repeated_name;
 
     /* When parsing a list of repeating options as integers, values of the form
      * "a-b", representing a closed interval, are allowed. Elements in the
@@ -87,6 +88,9 @@ struct OptsVisitor
      * not survive or escape the OptsVisitor object.
      */
     QemuOpt *fake_id_opt;
+
+    /* List of field names leading to the current structure. */
+    GQueue *nested_names;
 };
 
 
@@ -107,6 +111,7 @@ static void
 opts_visitor_insert(GHashTable *unprocessed_opts, const QemuOpt *opt)
 {
     GQueue *list;
+    assert(opt);
 
     list = g_hash_table_lookup(unprocessed_opts, opt->name);
     if (list == NULL) {
@@ -134,6 +139,11 @@ opts_start_struct(Visitor *v, const char *name, void **obj,
     if (obj) {
         *obj = g_malloc0(size);
     }
+
+    if (ov->nested_names != NULL) {
+        g_queue_push_tail(ov->nested_names, (gpointer) name);
+    }
+
     if (ov->depth++ > 0) {
         return;
     }
@@ -171,6 +181,10 @@ opts_check_struct(Visitor *v, Error **errp)
     GHashTableIter iter;
     GQueue *any;
 
+    if (ov->nested_names != NULL) {
+        g_queue_pop_tail(ov->nested_names);
+    }
+
     if (ov->depth > 1) {
         return;
     }
@@ -212,15 +226,59 @@ opts_end_alternate(Visitor *v, void **obj)
 }
 
 
+static void
+sum_strlen(gpointer data, gpointer user_data)
+{
+    const char *str = data;
+    size_t *sum_len = user_data;
+
+    if (str) { /* skip NULLs */
+        *sum_len += strlen(str) + 1;
+    }
+}
+
+static void
+append_str(gpointer data, gpointer user_data)
+{
+    const char *str = data;
+    char *concat_str = user_data;
+
+    if (str) {
+        strcat(concat_str, str);
+        strcat(concat_str, ".");
+    }
+}
+
+/* lookup a name, using a fully qualified version */
 static GQueue *
-lookup_distinct(const OptsVisitor *ov, const char *name, Error **errp)
+lookup_distinct(const OptsVisitor *ov, const char *name, char **out_key,
+                Error **errp)
 {
-    GQueue *list;
+    GQueue *list = NULL;
+    char *key;
+
+    if (ov->nested_names != NULL) {
+        size_t sum_len = strlen(name);
+        g_queue_foreach(ov->nested_names, sum_strlen, &sum_len);
+        key = g_malloc(sum_len + 1);
+        key[0] = 0;
+        g_queue_foreach(ov->nested_names, append_str, key);
+        strcat(key, name);
+    } else {
+        key = g_strdup(name);
+    }
+
+    list = g_hash_table_lookup(ov->unprocessed_opts, key);
+    if (list && out_key) {
+        *out_key = key;
+        key = NULL;
+    }
 
-    list = g_hash_table_lookup(ov->unprocessed_opts, name);
     if (!list) {
         error_setg(errp, QERR_MISSING_PARAMETER, name);
     }
+
+    g_free(key);
     return list;
 }
 
@@ -235,7 +293,8 @@ opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
     assert(ov->list_mode == LM_NONE);
     /* we don't support visits without a list */
     assert(list);
-    ov->repeated_opts = lookup_distinct(ov, name, errp);
+    assert(ov->repeated_opts == NULL && ov->repeated_name == NULL);
+    ov->repeated_opts = lookup_distinct(ov, name, &ov->repeated_name, errp);
     if (ov->repeated_opts) {
         ov->list_mode = LM_IN_PROGRESS;
         *list = g_malloc0(size);
@@ -266,11 +325,9 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
         /* range has been completed, fall through in order to pop option */
 
     case LM_IN_PROGRESS: {
-        const QemuOpt *opt;
-
-        opt = g_queue_pop_head(ov->repeated_opts);
+        g_queue_pop_head(ov->repeated_opts);
         if (g_queue_is_empty(ov->repeated_opts)) {
-            g_hash_table_remove(ov->unprocessed_opts, opt->name);
+            g_hash_table_remove(ov->unprocessed_opts, ov->repeated_name);
             return NULL;
         }
         break;
@@ -304,22 +361,28 @@ opts_end_list(Visitor *v, void **obj)
            ov->list_mode == LM_SIGNED_INTERVAL ||
            ov->list_mode == LM_UNSIGNED_INTERVAL);
     ov->repeated_opts = NULL;
+
+    g_free(ov->repeated_name);
+    ov->repeated_name = NULL;
+
     ov->list_mode = LM_NONE;
 }
 
 
 static const QemuOpt *
-lookup_scalar(const OptsVisitor *ov, const char *name, Error **errp)
+lookup_scalar(const OptsVisitor *ov, const char *name, char** out_key,
+              Error **errp)
 {
     if (ov->list_mode == LM_NONE) {
         GQueue *list;
 
         /* the last occurrence of any QemuOpt takes effect when queried by name
          */
-        list = lookup_distinct(ov, name, errp);
+        list = lookup_distinct(ov, name, out_key, errp);
         return list ? g_queue_peek_tail(list) : NULL;
     }
     assert(ov->list_mode == LM_IN_PROGRESS);
+    assert(out_key == NULL || *out_key == NULL);
     return g_queue_peek_head(ov->repeated_opts);
 }
 
@@ -341,8 +404,9 @@ opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
     const QemuOpt *opt;
+    char *key = NULL;
 
-    opt = lookup_scalar(ov, name, errp);
+    opt = lookup_scalar(ov, name, &key, errp);
     if (!opt) {
         *obj = NULL;
         return;
@@ -353,7 +417,8 @@ opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
      * valid enum value; this is harmless because tracking what gets
      * consumed only matters to visit_end_struct() as the final error
      * check if there were no other failures during the visit.  */
-    processed(ov, name);
+    processed(ov, key);
+    g_free(key);
 }
 
 
@@ -363,8 +428,9 @@ opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
     const QemuOpt *opt;
+    char *key = NULL;
 
-    opt = lookup_scalar(ov, name, errp);
+    opt = lookup_scalar(ov, name, &key, errp);
     if (!opt) {
         return;
     }
@@ -381,13 +447,15 @@ opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
         } else {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                        "on|yes|y|off|no|n");
+            g_free(key);
             return;
         }
     } else {
         *obj = true;
     }
 
-    processed(ov, name);
+    processed(ov, key);
+    g_free(key);
 }
 
 
@@ -399,13 +467,14 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
     const char *str;
     long long val;
     char *endptr;
+    char *key = NULL;
 
     if (ov->list_mode == LM_SIGNED_INTERVAL) {
         *obj = ov->range_next.s;
         return;
     }
 
-    opt = lookup_scalar(ov, name, errp);
+    opt = lookup_scalar(ov, name, &key, errp);
     if (!opt) {
         return;
     }
@@ -419,11 +488,13 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
     if (errno == 0 && endptr > str && INT64_MIN <= val && val <= INT64_MAX) {
         if (*endptr == '\0') {
             *obj = val;
-            processed(ov, name);
+            processed(ov, key);
+            g_free(key);
             return;
         }
         if (*endptr == '-' && ov->list_mode == LM_IN_PROGRESS) {
             long long val2;
+            assert(key == NULL);
 
             str = endptr + 1;
             val2 = strtoll(str, &endptr, 0);
@@ -444,6 +515,7 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                (ov->list_mode == LM_NONE) ? "an int64 value" :
                                             "an int64 value or range");
+    g_free(key);
 }
 
 
@@ -455,13 +527,14 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     const char *str;
     unsigned long long val;
     char *endptr;
+    char *key = NULL;
 
     if (ov->list_mode == LM_UNSIGNED_INTERVAL) {
         *obj = ov->range_next.u;
         return;
     }
 
-    opt = lookup_scalar(ov, name, errp);
+    opt = lookup_scalar(ov, name, &key, errp);
     if (!opt) {
         return;
     }
@@ -473,11 +546,13 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     if (parse_uint(str, &val, &endptr, 0) == 0 && val <= UINT64_MAX) {
         if (*endptr == '\0') {
             *obj = val;
-            processed(ov, name);
+            processed(ov, key);
+            g_free(key);
             return;
         }
         if (*endptr == '-' && ov->list_mode == LM_IN_PROGRESS) {
             unsigned long long val2;
+            assert(key == NULL);
 
             str = endptr + 1;
             if (parse_uint_full(str, &val2, 0) == 0 &&
@@ -496,6 +571,7 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                (ov->list_mode == LM_NONE) ? "a uint64 value" :
                                             "a uint64 value or range");
+    g_free(key);
 }
 
 
@@ -505,8 +581,9 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     OptsVisitor *ov = to_ov(v);
     const QemuOpt *opt;
     int err;
+    char *key = NULL;
 
-    opt = lookup_scalar(ov, name, errp);
+    opt = lookup_scalar(ov, name, &key, errp);
     if (!opt) {
         return;
     }
@@ -515,10 +592,12 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     if (err < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                    "a size value");
+        g_free(key);
         return;
     }
 
-    processed(ov, name);
+    processed(ov, key);
+    g_free(key);
 }
 
 
@@ -529,7 +608,7 @@ opts_optional(Visitor *v, const char *name, bool *present)
 
     /* we only support a single mandatory scalar field in a list node */
     assert(ov->list_mode == LM_NONE);
-    *present = (lookup_distinct(ov, name, NULL) != NULL);
+    *present = (lookup_distinct(ov, name, NULL, NULL) != NULL);
 }
 
 
@@ -547,7 +626,7 @@ opts_free(Visitor *v)
 
 
 Visitor *
-opts_visitor_new(const QemuOpts *opts)
+opts_visitor_new(const QemuOpts *opts, bool nested)
 {
     OptsVisitor *ov;
 
@@ -556,6 +635,12 @@ opts_visitor_new(const QemuOpts *opts)
 
     ov->visitor.type = VISITOR_INPUT;
 
+    if (nested) {
+        ov->nested_names = g_queue_new();
+    } else {
+        ov->nested_names = NULL;
+    }
+
     ov->visitor.start_struct = &opts_start_struct;
     ov->visitor.check_struct = &opts_check_struct;
     ov->visitor.end_struct   = &opts_end_struct;
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index db85d1eb75..17f995ee31 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -119,7 +119,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
     qemu_opts_set_id(opts, NULL);
     pdict = qemu_opts_to_qdict(opts, NULL);
 
-    v = opts_visitor_new(opts);
+    v = opts_visitor_new(opts, false);
     obj = user_creatable_add_type(type, id, pdict, v, errp);
     visit_free(v);
 
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index cb0857df52..324b9eb40c 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -149,6 +149,11 @@
 # Smoke test on out-of-band and allow-preconfig-test
 { 'command': 'test-flags-command', 'allow-oob': true, 'allow-preconfig': true }
 
+# For testing hierarchy support in opts-visitor
+{ 'struct': 'UserDefOptionsSub',
+  'data': {
+    '*nint': 'int' } }
+
 # For testing integer range flattening in opts-visitor. The following schema
 # corresponds to the option format:
 #
@@ -162,7 +167,9 @@
     '*u64' : [ 'uint64' ],
     '*u16' : [ 'uint16' ],
     '*i64x':   'int'     ,
-    '*u64x':   'uint64'  } }
+    '*u64x':   'uint64'  ,
+    'sub0':    'UserDefOptionsSub',
+    'sub1':    'UserDefOptionsSub' } }
 
 # testing event
 { 'struct': 'EventStructOne',
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 9464101d26..3c1b47c7cd 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -200,12 +200,16 @@ command boxed-union UserDefNativeListUnion -> None
    gen=True success_response=True boxed=True oob=False preconfig=False
 command test-flags-command None -> None
    gen=True success_response=True boxed=False oob=True preconfig=True
+object UserDefOptionsSub
+    member nint: int optional=True
 object UserDefOptions
     member i64: intList optional=True
     member u64: uint64List optional=True
     member u16: uint16List optional=True
     member i64x: int optional=True
     member u64x: uint64 optional=True
+    member sub0: UserDefOptionsSub optional=False
+    member sub1: UserDefOptionsSub optional=False
 object EventStructOne
     member struct1: UserDefOne optional=False
     member string: str optional=False
diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index 23e897061c..52950dfc4a 100644
--- a/tests/test-opts-visitor.c
+++ b/tests/test-opts-visitor.c
@@ -43,7 +43,7 @@ setup_fixture(OptsVisitorFixture *f, gconstpointer test_data)
                            NULL);
     g_assert(opts != NULL);
 
-    v = opts_visitor_new(opts);
+    v = opts_visitor_new(opts, true);
     visit_type_UserDefOptions(v, NULL, &f->userdef, &f->err);
     visit_free(v);
     qemu_opts_del(opts);
@@ -170,6 +170,34 @@ expect_u64_max(OptsVisitorFixture *f, gconstpointer test_data)
     g_assert(f->userdef->u64->value == UINT64_MAX);
 }
 
+static void
+expect_both(OptsVisitorFixture *f, gconstpointer test_data)
+{
+    expect_ok(f, test_data);
+    g_assert(f->userdef->sub0->has_nint);
+    g_assert(f->userdef->sub0->nint == 13);
+    g_assert(f->userdef->sub1->has_nint);
+    g_assert(f->userdef->sub1->nint == 17);
+}
+
+static void
+expect_sub0(OptsVisitorFixture *f, gconstpointer test_data)
+{
+    expect_ok(f, test_data);
+    g_assert(f->userdef->sub0->has_nint);
+    g_assert(f->userdef->sub0->nint == 13);
+    g_assert(!f->userdef->sub1->has_nint);
+}
+
+static void
+expect_sub1(OptsVisitorFixture *f, gconstpointer test_data)
+{
+    expect_ok(f, test_data);
+    g_assert(!f->userdef->sub0->has_nint);
+    g_assert(f->userdef->sub1->has_nint);
+    g_assert(f->userdef->sub1->nint == 13);
+}
+
 /* test cases */
 
 static void
@@ -184,7 +212,7 @@ test_opts_range_unvisited(void)
     opts = qemu_opts_parse(qemu_find_opts("userdef"), "ilist=0-2", false,
                            &error_abort);
 
-    v = opts_visitor_new(opts);
+    v = opts_visitor_new(opts, false);
 
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
 
@@ -225,7 +253,7 @@ test_opts_range_beyond(void)
     opts = qemu_opts_parse(qemu_find_opts("userdef"), "ilist=0", false,
                            &error_abort);
 
-    v = opts_visitor_new(opts);
+    v = opts_visitor_new(opts, false);
 
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
 
@@ -260,7 +288,7 @@ test_opts_dict_unvisited(void)
     opts = qemu_opts_parse(qemu_find_opts("userdef"), "i64x=0,bogus=1", false,
                            &error_abort);
 
-    v = opts_visitor_new(opts);
+    v = opts_visitor_new(opts, false);
     visit_type_UserDefOptions(v, NULL, &userdef, &err);
     error_free_or_abort(&err);
     visit_free(v);
@@ -366,6 +394,13 @@ main(int argc, char **argv)
 
     g_test_add_func("/visitor/opts/dict/unvisited", test_opts_dict_unvisited);
 
+    /* Test nested structs support */
+    add_test("/visitor/opts/nested/unqualified", &expect_fail, "nint=13");
+    add_test("/visitor/opts/nested/both",        &expect_both,
+             "sub0.nint=13,sub1.nint=17");
+    add_test("/visitor/opts/nested/sub0",        &expect_sub0, "sub0.nint=13");
+    add_test("/visitor/opts/nested/sub1",        &expect_sub1, "sub1.nint=13");
+
     g_test_run();
     return 0;
 }
-- 
2.20.1
