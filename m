Received: from eggs.gnu.org ([209.51.188.92]:40356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gwOjt-00083T-0y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gwOjp-0004Tv-DD
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:04:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Feb 2019 13:03:58 +0300
Message-Id: <20190220100358.25566-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC PATCH v2] coroutines: generate wrapper code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com

Hi all!

We have a very frequent pattern of creating coroutine from function
with several arguments:

  - create structure to pack parameters
  - create _entry function to call original function taking parameters
    from struct
  - do different magic to handle completion: set ret to NOT_DONE or
    EINPROGRESS, use separate bool for void functions
  - fill the struct and create coroutine from _entry function and this
    struct as a parameter

Here is a template code + example how it can be used to drop a lot of
similar code.

TODO: make coroutine-wrapper template file to be header itself, or
      generate header from it

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: - don't generate poll-loop wrappers
    - drop jinja

 Makefile                     |  5 ++
 Makefile.objs                |  2 +-
 include/block/block.h        |  3 ++
 include/block/block_int.h    |  8 +++
 block.c                      | 76 +++++++---------------------
 coroutine-wrapper            |  2 +
 scripts/coroutine-wrapper.py | 98 ++++++++++++++++++++++++++++++++++++
 7 files changed, 136 insertions(+), 58 deletions(-)
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
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..9af6507be7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1175,4 +1175,12 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
 
 int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
+
+Coroutine *bdrv_co_invalidate_cache__create_co(bool *_in_progress,
+                                               BlockDriverState *bs,
+                                               Error **errp);
+Coroutine *bdrv_co_check__create_co(bool *_in_progress, int *_ret,
+                                    BlockDriverState *bs, BdrvCheckResult *res,
+                                    BdrvCheckMode fix);
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index b67d9b7b65..94999bc0fc 100644
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
@@ -3720,44 +3720,25 @@ static int coroutine_fn bdrv_co_check(BlockDriverState *bs,
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
 int bdrv_check(BlockDriverState *bs,
                BdrvCheckResult *res, BdrvCheckMode fix)
 {
+    int ret;
+    bool in_progress;
     Coroutine *co;
-    CheckCo cco = {
-        .bs = bs,
-        .res = res,
-        .ret = -EINPROGRESS,
-        .fix = fix,
-    };
 
     if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_check_co_entry(&cco);
-    } else {
-        co = qemu_coroutine_create(bdrv_check_co_entry, &cco);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, cco.ret == -EINPROGRESS);
+        return bdrv_co_check(bs, res, fix);
     }
 
-    return cco.ret;
-}
+    co = bdrv_co_check__create_co(&in_progress, &ret, bs, res, fix);
+    bdrv_coroutine_enter(bs, co);
+    BDRV_POLL_WHILE(bs, in_progress);
 
+    return ret;
+}
 /*
+ *
  * Return values:
  * 0        - success
  * -EINVAL  - backing format specified, but no file
@@ -4623,8 +4604,7 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                  Error **errp)
+void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
@@ -4705,37 +4685,19 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
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
 void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
+    bool in_progress;
     Coroutine *co;
-    InvalidateCacheCo ico = {
-        .bs = bs,
-        .done = false,
-        .errp = errp
-    };
 
     if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_invalidate_cache_co_entry(&ico);
-    } else {
-        co = qemu_coroutine_create(bdrv_invalidate_cache_co_entry, &ico);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !ico.done);
+        bdrv_co_invalidate_cache(bs, errp);
+        return;
     }
+
+    co = bdrv_co_invalidate_cache__create_co(&in_progress, bs, errp);
+    bdrv_coroutine_enter(bs, co);
+    BDRV_POLL_WHILE(bs, in_progress);
 }
 
 void bdrv_invalidate_cache_all(Error **errp)
diff --git a/coroutine-wrapper b/coroutine-wrapper
new file mode 100644
index 0000000000..47bcd2e6a0
--- /dev/null
+++ b/coroutine-wrapper
@@ -0,0 +1,2 @@
+int bdrv_co_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix)
+void bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
new file mode 100755
index 0000000000..35b0ba8c59
--- /dev/null
+++ b/scripts/coroutine-wrapper.py
@@ -0,0 +1,98 @@
+#!/usr/bin/env python
+
+import re
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
+/*
+ * Wrappers for $name$
+ */
+
+typedef struct $name$__ArgumentsPack {
+    $fields$
+} $name$__ArgumentsPack;
+
+static void $name$__entry(void *opaque)
+{
+    $name$__ArgumentsPack *pack = opaque;
+
+    $call$;
+
+    *pack->_in_progress = false;
+    aio_wait_kick();
+    g_free(opaque);
+}
+
+Coroutine *$name$__create_co($args_def$)
+{
+    $name$__ArgumentsPack *pack = g_new($name$__ArgumentsPack, 1);
+
+    *pack = ($name$__ArgumentsPack) {
+        $initializers$
+    };
+
+    *_in_progress = true;
+
+    return qemu_coroutine_create($name$__entry, pack);
+}
+"""
+
+# We want to use python string.format() formatter, which uses curly brackets
+# as separators. But it's not comfortable with C. So, we used dollars instead,
+# and now is the time to escape curly brackets and convert dollars.
+template = template.replace('{', '{{').replace('}', '}}')
+template = re.sub(r'\$(\w+)\$', r'{\1}', template)
+
+func_decl_re = re.compile(r'^([^(]+) ([a-z][a-z0-9_]*)\((.*)\)$')
+param_re = re.compile(r'(?P<def>.*[ *](?P<name>[a-z][a-z0-9_]*))')
+
+
+def format_args(args, format, separator):
+    return separator.join(format.format(**arg) for arg in args)
+
+
+def make_wrapper(function_declaration):
+    try:
+        m = func_decl_re.match(function_declaration)
+        ret_type = m.group(1).strip()
+        name = m.group(2)
+        raw_args = m.group(3).split(', ')
+        args = [param_re.match(arg).groupdict() for arg in raw_args]
+    except AttributeError:
+        raise ValueError('Failed to parse function declaration')
+
+    xargs = [{'def': 'bool *_in_progress', 'name': '_in_progress'}] + args
+
+    has_ret = ret_type != 'void'
+    if has_ret:
+        xargs.insert(1, {'def': ret_type + ' * _ret', 'name': '_ret'})
+
+    params = {
+        'name': name,
+        'args_def': format_args(xargs, '{def}', ', '),
+        'fields': format_args(xargs, '{def};', '\n    '),
+        'initializers': format_args(xargs, '.{name} = {name},', '\n        '),
+        'call': '{}{}({})'.format('*pack->_ret = ' if has_ret else '',
+                                  name,
+                                  format_args(args, 'pack->{name}', ', '))
+    }
+
+    return template.format(**params)
+
+
+if __name__ == '__main__':
+    import sys
+
+    print(header)
+    try:
+        for ind, line in enumerate(sys.stdin):
+            print(make_wrapper(line))
+    except ValueError as e:
+        sys.exit(('ERROR: {} at line {}:\n{}').format(e, ind + 1, line))
-- 
2.18.0
