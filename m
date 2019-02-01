Received: from eggs.gnu.org ([209.51.188.92]:47689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXZ-0007Hi-Bc
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXW-0003MY-9r
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:53 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:27 +0100
Message-Id: <20190201192935.18394-24-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 23/31] block: Generically refresh runtime
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Instead of having every block driver which implements
bdrv_refresh_filename() copy all of the strong runtime options over to
bs->full_open_options, implement this process generically in
bdrv_refresh_filename().

This patch only adds this new generic implementation, it does not remove
the old functionality. This is done in a follow-up patch.

With this patch, some superfluous information (that should never have
been there) may be removed from some JSON filenames, as can be seen in
the change to iotests 110's and 228's reference outputs.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 116 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/110.out |   2 +-
 tests/qemu-iotests/228     |   7 ++-
 tests/qemu-iotests/228.out |   2 +-
 4 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 05135152d5..f7a0c78697 100644
--- a/block.c
+++ b/block.c
@@ -5474,6 +5474,92 @@ out:
     return to_replace_bs;
 }
=20
+/**
+ * Iterates through the list of runtime option keys that are said to
+ * be "strong" for a BDS.  An option is called "strong" if it changes
+ * a BDS's data.  For example, the null block driver's "size" and
+ * "read-zeroes" options are strong, but its "latency-ns" option is
+ * not.
+ *
+ * If a key returned by this function ends with a dot, all options
+ * starting with that prefix are strong.
+ */
+static const char *const *strong_options(BlockDriverState *bs,
+                                         const char *const *curopt)
+{
+    static const char *const global_options[] =3D {
+        "driver", "filename", NULL
+    };
+
+    if (!curopt) {
+        return &global_options[0];
+    }
+
+    curopt++;
+    if (curopt =3D=3D &global_options[ARRAY_SIZE(global_options) - 1] &&=
 bs->drv) {
+        curopt =3D bs->drv->strong_runtime_opts;
+    }
+
+    return (curopt && *curopt) ? curopt : NULL;
+}
+
+/**
+ * Copies all strong runtime options from bs->options to the given
+ * QDict.  The set of strong option keys is determined by invoking
+ * strong_options().
+ *
+ * Returns true iff any strong option was present in bs->options (and
+ * thus copied to the target QDict) with the exception of "filename"
+ * and "driver".  The caller is expected to use this value to decide
+ * whether the existence of strong options prevents the generation of
+ * a plain filename.
+ */
+static bool append_strong_runtime_options(QDict *d, BlockDriverState *bs=
)
+{
+    bool found_any =3D false;
+    const char *const *option_name =3D NULL;
+
+    if (!bs->drv) {
+        return false;
+    }
+
+    while ((option_name =3D strong_options(bs, option_name))) {
+        bool option_given =3D false;
+
+        assert(strlen(*option_name) > 0);
+        if ((*option_name)[strlen(*option_name) - 1] !=3D '.') {
+            QObject *entry =3D qdict_get(bs->options, *option_name);
+            if (!entry) {
+                continue;
+            }
+
+            qdict_put_obj(d, *option_name, qobject_ref(entry));
+            option_given =3D true;
+        } else {
+            const QDictEntry *entry;
+            for (entry =3D qdict_first(bs->options); entry;
+                 entry =3D qdict_next(bs->options, entry))
+            {
+                if (strstart(qdict_entry_key(entry), *option_name, NULL)=
) {
+                    qdict_put_obj(d, qdict_entry_key(entry),
+                                  qobject_ref(qdict_entry_value(entry)))=
;
+                    option_given =3D true;
+                }
+            }
+        }
+
+        /* While "driver" and "filename" need to be included in a JSON f=
ilename,
+         * their existence does not prohibit generation of a plain filen=
ame. */
+        if (!found_any && option_given &&
+            strcmp(*option_name, "driver") && strcmp(*option_name, "file=
name"))
+        {
+            found_any =3D true;
+        }
+    }
+
+    return found_any;
+}
+
 static bool append_open_options(QDict *d, BlockDriverState *bs)
 {
     const QDictEntry *entry;
@@ -5650,9 +5736,37 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         bs->full_open_options =3D opts;
     }
=20
+    /* Gather the options QDict */
+    opts =3D qdict_new();
+    append_strong_runtime_options(opts, bs);
+
+    if (drv->bdrv_gather_child_options) {
+        /* Some block drivers may not want to present all of their child=
ren's
+         * options, or name them differently from BdrvChild.name */
+        drv->bdrv_gather_child_options(bs, opts, backing_overridden);
+    } else {
+        QLIST_FOREACH(child, &bs->children, next) {
+            if (child->role =3D=3D &child_backing && !backing_overridden=
) {
+                /* We can skip the backing BDS if it has not been overri=
dden */
+                continue;
+            }
+
+            qdict_put(opts, child->name,
+                      qobject_ref(child->bs->full_open_options));
+        }
+
+        if (backing_overridden && !bs->backing) {
+            /* Force no backing file */
+            qdict_put_null(opts, "backing");
+        }
+    }
+
+    qobject_unref(bs->full_open_options);
+    bs->full_open_options =3D opts;
+
     if (bs->exact_filename[0]) {
         pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
-    } else if (bs->full_open_options) {
+    } else {
         QString *json =3D qobject_to_json(QOBJECT(bs->full_open_options)=
);
         snprintf(bs->filename, sizeof(bs->filename), "json:%s",
                  qstring_get_str(json));
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 1d0b2475cc..46e6a60510 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -22,7 +22,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864 backing_file=3Dt.IMGFMT.b
=20
 =3D=3D=3D Nodes without a common directory =3D=3D=3D
=20
-image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_=
DIR/t.IMGFMT.copy"}], "driver": "quorum", "blkverify": false, "rewrite-co=
rrupted": false, "vote-threshold": 1}}
+image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_=
DIR/t.IMGFMT.copy"}], "driver": "quorum", "vote-threshold": 1}}
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 2930f8442c..7a57c41e29 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -230,9 +230,10 @@ with iotests.FilePath('base.img') as base_img_path, =
\
                overlay=3D'node0')
=20
     # This should give us the original plain result
-    # FIXME: Currently, the block layer considers the runtime backing
-    #        file to be different from the image header, which is
-    #        wrong.  This is fixed by a future patch.
+    # FIXME: Currently, it yields a json:{} filename even though it
+    #        only contains a @driver and a @file entry, so a plain
+    #        filename would obviously suffice.  This is fixed by a
+    #        future patch.
=20
     log_node_info(vm.node_info('node0'))
=20
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
index 57fe97d4bc..393ab09164 100644
--- a/tests/qemu-iotests/228.out
+++ b/tests/qemu-iotests/228.out
@@ -74,7 +74,7 @@ bs->backing: (none)
 {"execute": "blockdev-snapshot", "arguments": {"node": "original-backing=
", "overlay": "node0"}}
 {"return": {}}
=20
-bs->filename: json:{"backing": {"driver": "IMGFMT", "file": {"driver": "=
file", "filename": "TEST_DIR/PID-base.img"}}, "driver": "IMGFMT", "file":=
 {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->filename: json:{"driver": "IMGFMT", "file": {"driver": "file", "file=
name": "TEST_DIR/PID-top.img"}}
 bs->backing_file: TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
=20
--=20
2.20.1
