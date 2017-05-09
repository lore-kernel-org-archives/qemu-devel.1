Received: from eggs.gnu.org ([2001:4830:134:3::10]:44097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Aa-000856-QV
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AU-0007XP-4c
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AT-0007WF-Rg
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF0E461D15
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:23 +0200
Message-Id: <1494317205-2211-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 06/28] qobject: Drop useless QObject casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We have macros in place to make it less verbose to add a subtype
of QObject to both QDict and QList. While we have made cleanups
like this in the past (see commit fcfcd8ffc, for example), having
it be automated by Coccinelle makes it easier to maintain.

Patch created mechanically via:
  spatch --sp-file scripts/coccinelle/qobject.cocci \
    --macro-file scripts/cocci-macro-file.h --dir . --in-place
then I verified that no manual touchups were required.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-5-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                   | 12 ++++--------
 block/blkdebug.c          |  4 ++--
 block/blkverify.c         |  7 +++----
 block/file-posix.c        |  6 +++---
 block/file-win32.c        |  4 ++--
 block/quorum.c            | 16 ++++++----------
 tests/check-qdict.c       | 20 ++++++++++----------
 tests/test-qmp-commands.c | 24 ++++++++++++------------
 8 files changed, 42 insertions(+), 51 deletions(-)

diff --git a/block.c b/block.c
index 6c6bb3e..cb5856b 100644
--- a/block.c
+++ b/block.c
@@ -4712,11 +4712,9 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * contain a representation of the filename, therefore the following
          * suffices without querying the (exact_)filename of this BDS. */
         if (bs->file->bs->full_open_options) {
-            qdict_put_obj(opts, "driver",
-                          QOBJECT(qstring_from_str(drv->format_name)));
+            qdict_put(opts, "driver", qstring_from_str(drv->format_name));
             QINCREF(bs->file->bs->full_open_options);
-            qdict_put_obj(opts, "file",
-                          QOBJECT(bs->file->bs->full_open_options));
+            qdict_put(opts, "file", bs->file->bs->full_open_options);
 
             bs->full_open_options = opts;
         } else {
@@ -4732,8 +4730,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
         opts = qdict_new();
         append_open_options(opts, bs);
-        qdict_put_obj(opts, "driver",
-                      QOBJECT(qstring_from_str(drv->format_name)));
+        qdict_put(opts, "driver", qstring_from_str(drv->format_name));
 
         if (bs->exact_filename[0]) {
             /* This may not work for all block protocol drivers (some may
@@ -4743,8 +4740,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
              * needs some special format of the options QDict, it needs to
              * implement the driver-specific bdrv_refresh_filename() function.
              */
-            qdict_put_obj(opts, "filename",
-                          QOBJECT(qstring_from_str(bs->exact_filename)));
+            qdict_put(opts, "filename", qstring_from_str(bs->exact_filename));
         }
 
         bs->full_open_options = opts;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index d2a7561..16322d8 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -693,10 +693,10 @@ static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     opts = qdict_new();
-    qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("blkdebug")));
+    qdict_put(opts, "driver", qstring_from_str("blkdebug"));
 
     QINCREF(bs->file->bs->full_open_options);
-    qdict_put_obj(opts, "image", QOBJECT(bs->file->bs->full_open_options));
+    qdict_put(opts, "image", bs->file->bs->full_open_options);
 
     for (e = qdict_first(options); e; e = qdict_next(options, e)) {
         if (strcmp(qdict_entry_key(e), "x-image")) {
diff --git a/block/blkverify.c b/block/blkverify.c
index af23281..cc29cd2 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -288,13 +288,12 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
         && s->test_file->bs->full_open_options)
     {
         QDict *opts = qdict_new();
-        qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("blkverify")));
+        qdict_put(opts, "driver", qstring_from_str("blkverify"));
 
         QINCREF(bs->file->bs->full_open_options);
-        qdict_put_obj(opts, "raw", QOBJECT(bs->file->bs->full_open_options));
+        qdict_put(opts, "raw", bs->file->bs->full_open_options);
         QINCREF(s->test_file->bs->full_open_options);
-        qdict_put_obj(opts, "test",
-                      QOBJECT(s->test_file->bs->full_open_options));
+        qdict_put(opts, "test", s->test_file->bs->full_open_options);
 
         bs->full_open_options = opts;
     }
diff --git a/block/file-posix.c b/block/file-posix.c
index 1941fb6..fc4b052 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -375,7 +375,7 @@ static void raw_parse_filename(const char *filename, QDict *options,
      * function call can be ignored. */
     strstart(filename, "file:", &filename);
 
-    qdict_put_obj(options, "filename", QOBJECT(qstring_from_str(filename)));
+    qdict_put(options, "filename", qstring_from_str(filename));
 }
 
 static QemuOptsList raw_runtime_opts = {
@@ -2155,7 +2155,7 @@ static void hdev_parse_filename(const char *filename, QDict *options,
     /* The prefix is optional, just as for "file". */
     strstart(filename, "host_device:", &filename);
 
-    qdict_put_obj(options, "filename", QOBJECT(qstring_from_str(filename)));
+    qdict_put(options, "filename", qstring_from_str(filename));
 }
 
 static bool hdev_is_sg(BlockDriverState *bs)
@@ -2454,7 +2454,7 @@ static void cdrom_parse_filename(const char *filename, QDict *options,
     /* The prefix is optional, just as for "file". */
     strstart(filename, "host_cdrom:", &filename);
 
-    qdict_put_obj(options, "filename", QOBJECT(qstring_from_str(filename)));
+    qdict_put(options, "filename", qstring_from_str(filename));
 }
 #endif
 
diff --git a/block/file-win32.c b/block/file-win32.c
index 7872e00..c4a6be7 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -281,7 +281,7 @@ static void raw_parse_filename(const char *filename, QDict *options,
      * function call can be ignored. */
     strstart(filename, "file:", &filename);
 
-    qdict_put_obj(options, "filename", QOBJECT(qstring_from_str(filename)));
+    qdict_put(options, "filename", qstring_from_str(filename));
 }
 
 static QemuOptsList raw_runtime_opts = {
@@ -668,7 +668,7 @@ static void hdev_parse_filename(const char *filename, QDict *options,
     /* The prefix is optional, just as for "file". */
     strstart(filename, "host_device:", &filename);
 
-    qdict_put_obj(options, "filename", QOBJECT(qstring_from_str(filename)));
+    qdict_put(options, "filename", qstring_from_str(filename));
 }
 
 static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
diff --git a/block/quorum.c b/block/quorum.c
index 40205fb..f7949e2 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1096,19 +1096,15 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     children = qlist_new();
     for (i = 0; i < s->num_children; i++) {
         QINCREF(s->children[i]->bs->full_open_options);
-        qlist_append_obj(children,
-                         QOBJECT(s->children[i]->bs->full_open_options));
+        qlist_append(children, s->children[i]->bs->full_open_options);
     }
 
     opts = qdict_new();
-    qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("quorum")));
-    qdict_put_obj(opts, QUORUM_OPT_VOTE_THRESHOLD,
-                  QOBJECT(qint_from_int(s->threshold)));
-    qdict_put_obj(opts, QUORUM_OPT_BLKVERIFY,
-                  QOBJECT(qbool_from_bool(s->is_blkverify)));
-    qdict_put_obj(opts, QUORUM_OPT_REWRITE,
-                  QOBJECT(qbool_from_bool(s->rewrite_corrupted)));
-    qdict_put_obj(opts, "children", QOBJECT(children));
+    qdict_put(opts, "driver", qstring_from_str("quorum"));
+    qdict_put(opts, QUORUM_OPT_VOTE_THRESHOLD, qint_from_int(s->threshold));
+    qdict_put(opts, QUORUM_OPT_BLKVERIFY, qbool_from_bool(s->is_blkverify));
+    qdict_put(opts, QUORUM_OPT_REWRITE, qbool_from_bool(s->rewrite_corrupted));
+    qdict_put(opts, "children", children);
 
     bs->full_open_options = opts;
 }
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 6f3fbcf..3cb72fb 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -47,7 +47,7 @@ static void qdict_put_obj_test(void)
     qdict = qdict_new();
 
     // key "" will have tdb hash 12345
-    qdict_put_obj(qdict, "", QOBJECT(qint_from_int(num)));
+    qdict_put(qdict, "", qint_from_int(num));
 
     g_assert(qdict_size(qdict) == 1);
     ent = QLIST_FIRST(&qdict->table[12345 % QDICT_BUCKET_MAX]);
@@ -66,8 +66,8 @@ static void qdict_destroy_simple_test(void)
     QDict *qdict;
 
     qdict = qdict_new();
-    qdict_put_obj(qdict, "num", QOBJECT(qint_from_int(0)));
-    qdict_put_obj(qdict, "str", QOBJECT(qstring_from_str("foo")));
+    qdict_put(qdict, "num", qint_from_int(0));
+    qdict_put(qdict, "str", qstring_from_str("foo"));
 
     QDECREF(qdict);
 }
@@ -297,16 +297,16 @@ static void qdict_flatten_test(void)
     qdict_put(dict1, "a", qint_from_int(0));
     qdict_put(dict1, "b", qint_from_int(1));
 
-    qlist_append_obj(list1, QOBJECT(qint_from_int(23)));
-    qlist_append_obj(list1, QOBJECT(qint_from_int(66)));
-    qlist_append_obj(list1, QOBJECT(dict1));
-    qlist_append_obj(list2, QOBJECT(qint_from_int(42)));
-    qlist_append_obj(list2, QOBJECT(list1));
+    qlist_append(list1, qint_from_int(23));
+    qlist_append(list1, qint_from_int(66));
+    qlist_append(list1, dict1);
+    qlist_append(list2, qint_from_int(42));
+    qlist_append(list2, list1);
 
     qdict_put(dict2, "c", qint_from_int(2));
     qdict_put(dict2, "d", qint_from_int(3));
-    qdict_put_obj(dict3, "e", QOBJECT(list2));
-    qdict_put_obj(dict3, "f", QOBJECT(dict2));
+    qdict_put(dict3, "e", list2);
+    qdict_put(dict3, "f", dict2);
     qdict_put(dict3, "g", qint_from_int(4));
 
     qdict_flatten(dict3);
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 0f81a98..ac3fd03 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -94,7 +94,7 @@ static void test_dispatch_cmd(void)
     QDict *req = qdict_new();
     QObject *resp;
 
-    qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd")));
+    qdict_put(req, "execute", qstring_from_str("user_def_cmd"));
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
@@ -111,7 +111,7 @@ static void test_dispatch_cmd_failure(void)
     QDict *args = qdict_new();
     QObject *resp;
 
-    qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd2")));
+    qdict_put(req, "execute", qstring_from_str("user_def_cmd2"));
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
@@ -125,7 +125,7 @@ static void test_dispatch_cmd_failure(void)
     qdict_put(args, "a", qint_from_int(66));
     qdict_put(req, "arguments", args);
 
-    qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd")));
+    qdict_put(req, "execute", qstring_from_str("user_def_cmd"));
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
@@ -164,14 +164,14 @@ static void test_dispatch_cmd_io(void)
     QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
     QInt *ret3;
 
-    qdict_put_obj(ud1a, "integer", QOBJECT(qint_from_int(42)));
-    qdict_put_obj(ud1a, "string", QOBJECT(qstring_from_str("hello")));
-    qdict_put_obj(ud1b, "integer", QOBJECT(qint_from_int(422)));
-    qdict_put_obj(ud1b, "string", QOBJECT(qstring_from_str("hello2")));
-    qdict_put_obj(args, "ud1a", QOBJECT(ud1a));
-    qdict_put_obj(args, "ud1b", QOBJECT(ud1b));
-    qdict_put_obj(req, "arguments", QOBJECT(args));
-    qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd2")));
+    qdict_put(ud1a, "integer", qint_from_int(42));
+    qdict_put(ud1a, "string", qstring_from_str("hello"));
+    qdict_put(ud1b, "integer", qint_from_int(422));
+    qdict_put(ud1b, "string", qstring_from_str("hello2"));
+    qdict_put(args, "ud1a", ud1a);
+    qdict_put(args, "ud1b", ud1b);
+    qdict_put(req, "arguments", args);
+    qdict_put(req, "execute", qstring_from_str("user_def_cmd2"));
 
     ret = qobject_to_qdict(test_qmp_dispatch(req));
 
@@ -244,7 +244,7 @@ static void test_dealloc_partial(void)
         Visitor *v;
 
         ud2_dict = qdict_new();
-        qdict_put_obj(ud2_dict, "string0", QOBJECT(qstring_from_str(text)));
+        qdict_put(ud2_dict, "string0", qstring_from_str(text));
 
         v = qobject_input_visitor_new(QOBJECT(ud2_dict));
         visit_type_UserDefTwo(v, NULL, &ud2, &err);
-- 
2.7.4
