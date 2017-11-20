Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsPy-0000a3-QS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsPw-0007kS-Lh
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:11:46 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:59 +0100
Message-Id: <20171120201004.14999-21-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 20/25] block: Generically refresh
 runtime options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Instead of having every block driver which implements
bdrv_refresh_filename() copy all of the significant runtime options over
to bs->full_open_options, implement this process generically in
bdrv_refresh_filename().

This patch only adds this new generic implementation, it does not remove
the old functionality. This is done in a follow-up patch.

With this patch, some superfluous information (that should never have
been there) may be removed from some JSON filenames, as can be seen in
the change to iotest 110's reference output.  In case of 191, backing
nodes that have not been overridden are now removed from the filename.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 116 ++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/110.out |   2 +-
 tests/qemu-iotests/191.out |  24 +++++-----
 3 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index 2e59e77f9d..64ef30bbac 100644
--- a/block.c
+++ b/block.c
@@ -4944,6 +4944,92 @@ out:
     return to_replace_bs;
 }
 
+/**
+ * Iterates through the list of runtime option keys that are said to be
+ * "significant" for a BDS. An option is called "significant" if it changes a
+ * BDS's data. For example, the null block driver's "size" and "read-zeroes"
+ * options are significant, but its "latency-ns" option is not.
+ *
+ * If a key returned by this function ends with a dot, all options starting with
+ * that prefix are significant.
+ */
+static const char *const *significant_options(BlockDriverState *bs,
+                                              const char *const *curopt)
+{
+    static const char *const global_options[] = {
+        "driver", "filename", "base-directory", NULL
+    };
+
+    if (!curopt) {
+        return &global_options[0];
+    }
+
+    curopt++;
+    if (curopt == &global_options[ARRAY_SIZE(global_options) - 1] && bs->drv) {
+        curopt = bs->drv->sgfnt_runtime_opts;
+    }
+
+    return (curopt && *curopt) ? curopt : NULL;
+}
+
+/**
+ * Copies all significant runtime options from bs->options to the given QDict.
+ * The set of significant option keys is determined by invoking
+ * significant_options().
+ *
+ * Returns true iff any significant option was present in bs->options (and thus
+ * copied to the target QDict) with the exception of "filename" and "driver".
+ * The caller is expected to use this value to decide whether the existence of
+ * significant options prevents the generation of a plain filename.
+ */
+static bool append_significant_runtime_options(QDict *d, BlockDriverState *bs)
+{
+    bool found_any = false;
+    const char *const *option_name = NULL;
+
+    if (!bs->drv) {
+        return false;
+    }
+
+    while ((option_name = significant_options(bs, option_name))) {
+        bool option_given = false;
+
+        assert(strlen(*option_name) > 0);
+        if ((*option_name)[strlen(*option_name) - 1] != '.') {
+            QObject *entry = qdict_get(bs->options, *option_name);
+            if (!entry) {
+                continue;
+            }
+
+            qobject_incref(entry);
+            qdict_put_obj(d, *option_name, entry);
+            option_given = true;
+        } else {
+            const QDictEntry *entry;
+            for (entry = qdict_first(bs->options); entry;
+                 entry = qdict_next(bs->options, entry))
+            {
+                if (strstart(qdict_entry_key(entry), *option_name, NULL)) {
+                    qobject_incref(qdict_entry_value(entry));
+                    qdict_put_obj(d, qdict_entry_key(entry),
+                                  qdict_entry_value(entry));
+                    option_given = true;
+                }
+            }
+        }
+
+        /* While "driver" and "filename" need to be included in a JSON filename,
+         * their existence does not prohibit generation of a plain filename. */
+        if (!found_any && option_given &&
+            strcmp(*option_name, "driver") && strcmp(*option_name, "filename"))
+        {
+            found_any = true;
+        }
+    }
+
+    return found_any;
+}
+
 static bool append_open_options(QDict *d, BlockDriverState *bs)
 {
     const QDictEntry *entry;
@@ -5098,9 +5184,37 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         bs->full_open_options = opts;
     }
 
+    /* Gather the options QDict */
+    opts = qdict_new();
+    append_significant_runtime_options(opts, bs);
+
+    if (drv->bdrv_gather_child_options) {
+        /* Some block drivers may not want to present all of their children's
+         * options, or name them differently from BdrvChild.name */
+        drv->bdrv_gather_child_options(bs, opts);
+    } else {
+        QLIST_FOREACH(child, &bs->children, next) {
+            if (child->role == &child_backing && !bs->backing_overridden) {
+                /* We can skip the backing BDS if it has not been overridden */
+                continue;
+            }
+
+            QINCREF(child->bs->full_open_options);
+            qdict_put(opts, child->name, child->bs->full_open_options);
+        }
+
+        if (bs->backing_overridden && !bs->backing) {
+            /* Force no backing file */
+            qdict_put(opts, "backing", qstring_new());
+        }
+    }
+
+    QDECREF(bs->full_open_options);
+    bs->full_open_options = opts;
+
     if (bs->exact_filename[0]) {
         pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
-    } else if (bs->full_open_options) {
+    } else {
         QString *json = qobject_to_json(QOBJECT(bs->full_open_options));
         snprintf(bs->filename, sizeof(bs->filename), "json:%s",
                  qstring_get_str(json));
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 1d0b2475cc..46e6a60510 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -22,7 +22,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=t.IMGFMT.b
 
 === Nodes without a common directory ===
 
-image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.copy"}], "driver": "quorum", "blkverify": false, "rewrite-corrupted": false, "vote-threshold": 1}}
+image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.copy"}], "driver": "quorum", "vote-threshold": 1}}
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index c1ce99985e..7e42b45ddb 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -61,7 +61,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+                "filename": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -95,7 +95,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+            "file": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
             "encryption_key_missing": false
         },
         {
@@ -150,7 +150,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}",
+                "filename": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -184,7 +184,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}",
+            "file": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}",
             "encryption_key_missing": false
         },
         {
@@ -464,7 +464,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+                "filename": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -498,7 +498,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+            "file": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
             "encryption_key_missing": false
         },
         {
@@ -554,7 +554,7 @@ wrote 65536/65536 bytes at offset 1048576
                     },
                     "backing-filename-format": "qcow2",
                     "virtual-size": 67108864,
-                    "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+                    "filename": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                     "cluster-size": 65536,
                     "format": "qcow2",
                     "actual-size": SIZE,
@@ -573,7 +573,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "json:{"backing": {"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl3"}}",
+                "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl3"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -586,8 +586,8 @@ wrote 65536/65536 bytes at offset 1048576
                         "corrupt": false
                     }
                 },
-                "full-backing-filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
-                "backing-filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+                "full-backing-filename": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+                "backing-filename": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -598,7 +598,7 @@ wrote 65536/65536 bytes at offset 1048576
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+            "backing_file": "json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -607,7 +607,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "json:{"backing": {"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl3"}}",
+            "file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl3"}}",
             "encryption_key_missing": false
         },
         {
-- 
2.13.6
