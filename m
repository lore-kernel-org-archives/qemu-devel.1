Received: from eggs.gnu.org ([209.51.188.92]:34735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gs6sU-0008VH-Bp
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gs6sO-0007Rl-OV
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:11:34 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Feb 2019 17:11:22 +0300
Message-Id: <20190208141122.53046-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC PATCH] coroutines: generate wrapper code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, crosa@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Hi all!

We have a very frequent pattern of wrapping a coroutine_fn function
to be called from non-coroutine context:

  - create structure to pack parameters
  - create function to call original function taking parameters from
    struct
  - create wrapper, which in case of non-coroutine context will
    create a coroutine, enter it and start poll-loop.

Here is a draft of template code + example how it can be used to drop a
lot of similar code.

Hope someone like it except me)

Hmm, it's possible to write it in pure python without jinja2, but I
think it's not a true way.

It's also possible to generate functions which will just create a
corresponding coroutines, for not generic cases. Such generated
generators should look like

Coroutine *bdrv_co_check__create_co(
    BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix,
    int *_ret, bool *_in_progress);

 - same parameters as in original bdrv_co_check(), plus out-pointers to
   set return value and mark finished.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 Makefile                     |  5 ++
 Makefile.objs                |  2 +-
 include/block/block.h        |  3 ++
 block.c                      | 77 ++---------------------------
 coroutine-wrapper            |  2 +
 scripts/coroutine-wrapper.py | 96 ++++++++++++++++++++++++++++++++++++
 6 files changed, 110 insertions(+), 75 deletions(-)
 create mode 100644 coroutine-wrapper
 create mode 100755 scripts/coroutine-wrapper.py

diff --git a/Makefile b/Makefile
index 1278a3eb52..8d19b06cf1 100644
--- a/Makefile
+++ b/Makefile
@@ -122,6 +122,8 @@ endif
 
 GENERATED_FILES += module_block.h
 
+GENERATED_FILES += block-gen.c
+
 TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
 TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
 TRACE_DTRACE =
@@ -138,6 +140,9 @@ GENERATED_FILES += $(TRACE_SOURCES)
 GENERATED_FILES += $(BUILD_DIR)/trace-events-all
 GENERATED_FILES += .git-submodule-status
 
+block-gen.c: coroutine-wrapper $(SRC_PATH)/scripts/coroutine-wrapper.py
+	$(call quiet-command, python $(SRC_PATH)/scripts/coroutine-wrapper.py < $< > $@,"GEN","$(TARGET_DIR)$@")
+
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
diff --git a/Makefile.objs b/Makefile.objs
index 67a054b08a..16159d3e0f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -23,7 +23,7 @@ slirp-obj-$(CONFIG_SLIRP) = slirp/
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
 block-obj-y += nbd/
-block-obj-y += block.o blockjob.o job.o
+block-obj-y += block.o blockjob.o job.o block-gen.o
 block-obj-y += block/ scsi/
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
diff --git a/include/block/block.h b/include/block/block.h
index 57233cf2c0..61b2ca6fe5 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -371,6 +371,8 @@ typedef enum {
 } BdrvCheckMode;
 
 int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
+int coroutine_fn bdrv_co_check(BlockDriverState *bs,
+                               BdrvCheckResult *res, BdrvCheckMode fix);
 
 /* The units of offset and total_work_size may be chosen arbitrarily by the
  * block driver; total_work_size may change during the course of the amendment
@@ -399,6 +401,7 @@ int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
 /* Invalidate any cached metadata used by image formats */
 void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
diff --git a/block.c b/block.c
index b67d9b7b65..37ab050f0e 100644
--- a/block.c
+++ b/block.c
@@ -3706,8 +3706,8 @@ static void bdrv_delete(BlockDriverState *bs)
  * free of errors) or -errno when an internal error occurred. The results of the
  * check are stored in res.
  */
-static int coroutine_fn bdrv_co_check(BlockDriverState *bs,
-                                      BdrvCheckResult *res, BdrvCheckMode fix)
+int coroutine_fn bdrv_co_check(BlockDriverState *bs,
+                               BdrvCheckResult *res, BdrvCheckMode fix)
 {
     if (bs->drv == NULL) {
         return -ENOMEDIUM;
@@ -3720,43 +3720,6 @@ static int coroutine_fn bdrv_co_check(BlockDriverState *bs,
     return bs->drv->bdrv_co_check(bs, res, fix);
 }
 
-typedef struct CheckCo {
-    BlockDriverState *bs;
-    BdrvCheckResult *res;
-    BdrvCheckMode fix;
-    int ret;
-} CheckCo;
-
-static void bdrv_check_co_entry(void *opaque)
-{
-    CheckCo *cco = opaque;
-    cco->ret = bdrv_co_check(cco->bs, cco->res, cco->fix);
-    aio_wait_kick();
-}
-
-int bdrv_check(BlockDriverState *bs,
-               BdrvCheckResult *res, BdrvCheckMode fix)
-{
-    Coroutine *co;
-    CheckCo cco = {
-        .bs = bs,
-        .res = res,
-        .ret = -EINPROGRESS,
-        .fix = fix,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_check_co_entry(&cco);
-    } else {
-        co = qemu_coroutine_create(bdrv_check_co_entry, &cco);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, cco.ret == -EINPROGRESS);
-    }
-
-    return cco.ret;
-}
-
 /*
  * Return values:
  * 0        - success
@@ -4623,8 +4586,7 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                  Error **errp)
+void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
@@ -4705,39 +4667,6 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
     }
 }
 
-typedef struct InvalidateCacheCo {
-    BlockDriverState *bs;
-    Error **errp;
-    bool done;
-} InvalidateCacheCo;
-
-static void coroutine_fn bdrv_invalidate_cache_co_entry(void *opaque)
-{
-    InvalidateCacheCo *ico = opaque;
-    bdrv_co_invalidate_cache(ico->bs, ico->errp);
-    ico->done = true;
-    aio_wait_kick();
-}
-
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
-{
-    Coroutine *co;
-    InvalidateCacheCo ico = {
-        .bs = bs,
-        .done = false,
-        .errp = errp
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_invalidate_cache_co_entry(&ico);
-    } else {
-        co = qemu_coroutine_create(bdrv_invalidate_cache_co_entry, &ico);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !ico.done);
-    }
-}
-
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
diff --git a/coroutine-wrapper b/coroutine-wrapper
new file mode 100644
index 0000000000..9d8bc35afc
--- /dev/null
+++ b/coroutine-wrapper
@@ -0,0 +1,2 @@
+bdrv_check: int bdrv_co_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix)
+bdrv_invalidate_cache: void bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
new file mode 100755
index 0000000000..16cd2d5e71
--- /dev/null
+++ b/scripts/coroutine-wrapper.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python
+
+import re
+from jinja2 import Environment
+
+env = Environment(trim_blocks=True, lstrip_blocks=True)
+
+header = """/*
+ * File is generated by scripts/coroutine-wrapper.py
+ */
+
+#include "qemu/osdep.h"
+#include "block/block_int.h"
+"""
+
+template = """
+{% set has_ret = ret_type != 'void' %}
+{% set arg_names = args|map(attribute='name')|list %}
+
+/*
+ * Wrappers for {{name}}
+ */
+
+typedef struct {{name}}__ArgumentsPack {
+{% for arg in args %}
+    {{arg['full']}};
+{% endfor %}
+
+{% if has_ret %}
+    {{ret_type}} _ret;
+{% endif %}
+    bool _in_progress;
+} {{name}}__ArgumentsPack;
+
+static void {{name}}__entry(void *opaque)
+{
+    {{name}}__ArgumentsPack *pack = opaque;
+    {%+ if has_ret %}pack->_ret = {% endif %}{{name}}(pack->{{ arg_names|join(', pack->') }});
+    pack->_in_progress = false;
+    aio_wait_kick();
+}
+
+{{ret_type}} {{bdrv_poll_name}}({{args|join(', ', attribute='full')}})
+{
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        {%+ if has_ret %}return {% endif %}{{name}}({{ arg_names|join(', ') }});
+    } else {
+        {{name}}__ArgumentsPack pack = {
+        {% for arg in args %}
+            .{{arg['name']}} = {{arg['name']}},
+        {% endfor %}
+
+            ._in_progress = true,
+        };
+        Coroutine *co = qemu_coroutine_create({{name}}__entry, &pack);
+        bdrv_coroutine_enter(bs, co);
+        BDRV_POLL_WHILE(bs, pack._in_progress);
+    {% if has_ret %}
+
+        return pack._ret;
+    {% endif %}
+    }
+}
+"""
+
+func_decl_re = re.compile(r'^(([^:]+):\s*)?([^(]+) ([a-z][a-z0-9_]*)\((.*)\)$')
+param_re = re.compile(r'(.*[ *])([a-z][a-z0-9_]*)')
+
+def make_wrapper(funcrion_declaration):
+    params = {}
+
+    try:
+        m = func_decl_re.match(funcrion_declaration)
+        params['ret_type'] = m.group(3)
+        params['name'] = m.group(4)
+        params['bdrv_poll_name'] = m.group(2) or params['name'] + '__bdrv_poll'
+        raw_args = m.group(5).split(', ')
+        args = []
+        for raw_arg in raw_args:
+            arg = param_re.match(raw_arg).group(0, 1, 2)
+            args.append({'full': arg[0], 'type': arg[1], 'name': arg[2]})
+
+        params['args'] = args
+    except ValueError:
+        sys.exit('Failed to parse function declaration')
+
+    return env.from_string(template).render(**params)
+
+
+if __name__ == '__main__':
+    import sys
+
+    print(header)
+    for line in sys.stdin:
+        print(make_wrapper(line))
-- 
2.18.0
