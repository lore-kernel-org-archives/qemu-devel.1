Received: from eggs.gnu.org ([2001:4830:134:3::10]:60966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvqug-0002xl-0t
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvqud-00089F-L8
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:48:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Apr 2017 14:47:37 -0500
Message-Id: <20170405194741.18956-10-eblake@redhat.com>
In-Reply-To: <20170405194741.18956-1-eblake@redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/13] qobject: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

We now have macros in place to make it less verbose to add a scalar
to QDict and QList, so use them.  To make this patch smaller to
review, a couple of subdirectories were done in earlier patches.

Patch created mechanically via:
  spatch --sp-file scripts/coccinelle/qobject.cocci \
    --macro-file scripts/cocci-macro-file.h --dir . --in-place
and needed only one touch-up in monitor.c to avoid a long line.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c                   | 45 +++++++++++++++++++--------------------------
 blockdev.c                | 30 +++++++++++++-----------------
 hw/block/xen_disk.c       |  2 +-
 hw/usb/xen-usb.c          | 12 ++++++------
 monitor.c                 | 23 +++++++++++------------
 qapi/qmp-event.c          |  2 +-
 qemu-img.c                |  6 +++---
 qemu-io.c                 |  2 +-
 qemu-nbd.c                |  2 +-
 qobject/qdict.c           |  2 +-
 target/s390x/cpu_models.c |  4 ++--
 util/qemu-option.c        |  2 +-
 12 files changed, 60 insertions(+), 72 deletions(-)

diff --git a/block.c b/block.c
index 1803334..9b87bf6 100644
--- a/block.c
+++ b/block.c
@@ -937,16 +937,14 @@ static void update_flags_from_options(int *flags, QemuOpts *opts)
 static void update_options_from_flags(QDict *options, int flags)
 {
     if (!qdict_haskey(options, BDRV_OPT_CACHE_DIRECT)) {
-        qdict_put(options, BDRV_OPT_CACHE_DIRECT,
-                  qbool_from_bool(flags & BDRV_O_NOCACHE));
+        qdict_put_bool(options, BDRV_OPT_CACHE_DIRECT, flags & BDRV_O_NOCACHE);
     }
     if (!qdict_haskey(options, BDRV_OPT_CACHE_NO_FLUSH)) {
-        qdict_put(options, BDRV_OPT_CACHE_NO_FLUSH,
-                  qbool_from_bool(flags & BDRV_O_NO_FLUSH));
+        qdict_put_bool(options, BDRV_OPT_CACHE_NO_FLUSH,
+                       flags & BDRV_O_NO_FLUSH);
     }
     if (!qdict_haskey(options, BDRV_OPT_READ_ONLY)) {
-        qdict_put(options, BDRV_OPT_READ_ONLY,
-                  qbool_from_bool(!(flags & BDRV_O_RDWR)));
+        qdict_put_bool(options, BDRV_OPT_READ_ONLY, !(flags & BDRV_O_RDWR));
     }
 }

@@ -1362,7 +1360,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     /* Fetch the file name from the options QDict if necessary */
     if (protocol && filename) {
         if (!qdict_haskey(*options, "filename")) {
-            qdict_put(*options, "filename", qstring_from_str(filename));
+            qdict_put_str(*options, "filename", filename);
             parse_filename = true;
         } else {
             error_setg(errp, "Can't specify 'file' and 'filename' options at "
@@ -1383,7 +1381,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
             }

             drvname = drv->format_name;
-            qdict_put(*options, "driver", qstring_from_str(drvname));
+            qdict_put_str(*options, "driver", drvname);
         } else {
             error_setg(errp, "Must specify either driver or file");
             return -EINVAL;
@@ -2034,7 +2032,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }

     if (bs->backing_format[0] != '\0' && !qdict_haskey(options, "driver")) {
-        qdict_put(options, "driver", qstring_from_str(bs->backing_format));
+        qdict_put_str(options, "driver", bs->backing_format);
     }

     backing_hd = bdrv_open_inherit(*backing_filename ? backing_filename : NULL,
@@ -2189,12 +2187,9 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     }

     /* Prepare options QDict for the temporary file */
-    qdict_put(snapshot_options, "file.driver",
-              qstring_from_str("file"));
-    qdict_put(snapshot_options, "file.filename",
-              qstring_from_str(tmp_filename));
-    qdict_put(snapshot_options, "driver",
-              qstring_from_str("qcow2"));
+    qdict_put_str(snapshot_options, "file.driver", "file");
+    qdict_put_str(snapshot_options, "file.filename", tmp_filename);
+    qdict_put_str(snapshot_options, "driver", "qcow2");

     bs_snapshot = bdrv_open(NULL, NULL, snapshot_options, flags, errp);
     snapshot_options = NULL;
@@ -2369,8 +2364,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                 goto fail;
             }

-            qdict_put(options, "file",
-                      qstring_from_str(bdrv_get_node_name(file_bs)));
+            qdict_put_str(options, "file", bdrv_get_node_name(file_bs));
         }
     }

@@ -2392,8 +2386,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
          * sure to update both bs->options (which has the full effective
          * options for bs) and options (which has file.* already removed).
          */
-        qdict_put(bs->options, "driver", qstring_from_str(drv->format_name));
-        qdict_put(options, "driver", qstring_from_str(drv->format_name));
+        qdict_put_str(bs->options, "driver", drv->format_name);
+        qdict_put_str(options, "driver", drv->format_name);
     } else if (!drv) {
         error_setg(errp, "Must specify either driver or file");
         goto fail;
@@ -2768,12 +2762,12 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * that they are checked at the end of this function. */
     value = qemu_opt_get(opts, "node-name");
     if (value) {
-        qdict_put(reopen_state->options, "node-name", qstring_from_str(value));
+        qdict_put_str(reopen_state->options, "node-name", value);
     }

     value = qemu_opt_get(opts, "driver");
     if (value) {
-        qdict_put(reopen_state->options, "driver", qstring_from_str(value));
+        qdict_put_str(reopen_state->options, "driver", value);
     }

     /* if we are to stay read-only, do not allow permission change
@@ -4260,8 +4254,7 @@ void bdrv_img_create(const char *filename, const char *fmt,

             if (backing_fmt) {
                 backing_options = qdict_new();
-                qdict_put(backing_options, "driver",
-                          qstring_from_str(backing_fmt));
+                qdict_put_str(backing_options, "driver", backing_fmt);
             }

             bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
@@ -4658,7 +4651,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * contain a representation of the filename, therefore the following
          * suffices without querying the (exact_)filename of this BDS. */
         if (bs->file->bs->full_open_options) {
-            qdict_put(opts, "driver", qstring_from_str(drv->format_name));
+            qdict_put_str(opts, "driver", drv->format_name);
             QINCREF(bs->file->bs->full_open_options);
             qdict_put(opts, "file", bs->file->bs->full_open_options);

@@ -4676,7 +4669,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)

         opts = qdict_new();
         append_open_options(opts, bs);
-        qdict_put(opts, "driver", qstring_from_str(drv->format_name));
+        qdict_put_str(opts, "driver", drv->format_name);

         if (bs->exact_filename[0]) {
             /* This may not work for all block protocol drivers (some may
@@ -4686,7 +4679,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
              * needs some special format of the options QDict, it needs to
              * implement the driver-specific bdrv_refresh_filename() function.
              */
-            qdict_put(opts, "filename", qstring_from_str(bs->exact_filename));
+            qdict_put_str(opts, "filename", bs->exact_filename);
         }

         bs->full_open_options = opts;
diff --git a/blockdev.c b/blockdev.c
index 040c152..269a5e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -527,7 +527,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
             error_setg(errp, "Cannot specify both 'driver' and 'format'");
             goto early_err;
         }
-        qdict_put(bs_opts, "driver", qstring_from_str(buf));
+        qdict_put_str(bs_opts, "driver", buf);
     }

     on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
@@ -903,10 +903,8 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         copy_on_read = false;
     }

-    qdict_put(bs_opts, BDRV_OPT_READ_ONLY,
-              qstring_from_str(read_only ? "on" : "off"));
-    qdict_put(bs_opts, "copy-on-read",
-              qstring_from_str(copy_on_read ? "on" :"off"));
+    qdict_put_str(bs_opts, BDRV_OPT_READ_ONLY, read_only ? "on" : "off");
+    qdict_put_str(bs_opts, "copy-on-read", copy_on_read ? "on" : "off");

     /* Controller type */
     value = qemu_opt_get(legacy_opts, "if");
@@ -1030,7 +1028,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
             new_id = g_strdup_printf("%s%s%i", if_name[type],
                                      mediastr, unit_id);
         }
-        qdict_put(bs_opts, "id", qstring_from_str(new_id));
+        qdict_put_str(bs_opts, "id", new_id);
         g_free(new_id);
     }

@@ -1067,7 +1065,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
             error_report("werror is not supported by this bus type");
             goto fail;
         }
-        qdict_put(bs_opts, "werror", qstring_from_str(werror));
+        qdict_put_str(bs_opts, "werror", werror);
     }

     rerror = qemu_opt_get(legacy_opts, "rerror");
@@ -1077,7 +1075,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
             error_report("rerror is not supported by this bus type");
             goto fail;
         }
-        qdict_put(bs_opts, "rerror", qstring_from_str(rerror));
+        qdict_put_str(bs_opts, "rerror", rerror);
     }

     /* Actual block device init: Functionality shared with blockdev-add */
@@ -1737,10 +1735,9 @@ static void external_snapshot_prepare(BlkActionState *common,

         options = qdict_new();
         if (s->has_snapshot_node_name) {
-            qdict_put(options, "node-name",
-                      qstring_from_str(snapshot_node_name));
+            qdict_put_str(options, "node-name", snapshot_node_name);
         }
-        qdict_put(options, "driver", qstring_from_str(format));
+        qdict_put_str(options, "driver", format);

         flags |= BDRV_O_NO_BACKING;
     }
@@ -2579,11 +2576,10 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,

     options = qdict_new();
     detect_zeroes = blk_get_detect_zeroes_from_root_state(blk);
-    qdict_put(options, "detect-zeroes",
-              qstring_from_str(detect_zeroes ? "on" : "off"));
+    qdict_put_str(options, "detect-zeroes", detect_zeroes ? "on" : "off");

     if (has_format) {
-        qdict_put(options, "driver", qstring_from_str(format));
+        qdict_put_str(options, "driver", format);
     }

     medium_bs = bdrv_open(filename, NULL, options, bdrv_flags, errp);
@@ -3251,7 +3247,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,

     if (backup->format) {
         options = qdict_new();
-        qdict_put(options, "driver", qstring_from_str(backup->format));
+        qdict_put_str(options, "driver", backup->format);
     }

     target_bs = bdrv_open(backup->target, NULL, options, flags, errp);
@@ -3555,10 +3551,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)

     options = qdict_new();
     if (arg->has_node_name) {
-        qdict_put(options, "node-name", qstring_from_str(arg->node_name));
+        qdict_put_str(options, "node-name", arg->node_name);
     }
     if (format) {
-        qdict_put(options, "driver", qstring_from_str(format));
+        qdict_put_str(options, "driver", format);
     }

     /* Mirroring takes care of copy-on-write using the source's backing
diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 456a2d5..47b2ca1 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1082,7 +1082,7 @@ static int blk_connect(struct XenDevice *xendev)

         if (strcmp(blkdev->fileproto, "<unset>")) {
             options = qdict_new();
-            qdict_put(options, "driver", qstring_from_str(blkdev->fileproto));
+            qdict_put_str(options, "driver", blkdev->fileproto);
         }

         /* setup via xenbus -> create new block driver instance */
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 8e676e6..6659415 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -746,16 +746,16 @@ static void usbback_portid_add(struct usbback_info *usbif, unsigned port,
     portname++;

     qdict = qdict_new();
-    qdict_put(qdict, "driver", qstring_from_str("usb-host"));
+    qdict_put_str(qdict, "driver", "usb-host");
     tmp = g_strdup_printf("%s.0", usbif->xendev.qdev.id);
-    qdict_put(qdict, "bus", qstring_from_str(tmp));
+    qdict_put_str(qdict, "bus", tmp);
     g_free(tmp);
     tmp = g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
-    qdict_put(qdict, "id", qstring_from_str(tmp));
+    qdict_put_str(qdict, "id", tmp);
     g_free(tmp);
-    qdict_put(qdict, "port", qint_from_int(port));
-    qdict_put(qdict, "hostbus", qint_from_int(atoi(busid)));
-    qdict_put(qdict, "hostport", qstring_from_str(portname));
+    qdict_put_int(qdict, "port", port);
+    qdict_put_int(qdict, "hostbus", atoi(busid));
+    qdict_put_str(qdict, "hostport", portname);
     opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
     if (local_err) {
         goto err;
diff --git a/monitor.c b/monitor.c
index be282ec..88f6fe9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2671,7 +2671,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     }
                     goto fail;
                 }
-                qdict_put(qdict, key, qstring_from_str(buf));
+                qdict_put_str(qdict, key, buf);
             }
             break;
         case 'O':
@@ -2773,9 +2773,9 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                         size = -1;
                     }
                 }
-                qdict_put(qdict, "count", qint_from_int(count));
-                qdict_put(qdict, "format", qint_from_int(format));
-                qdict_put(qdict, "size", qint_from_int(size));
+                qdict_put_int(qdict, "count", count);
+                qdict_put_int(qdict, "format", format);
+                qdict_put_int(qdict, "size", size);
             }
             break;
         case 'i':
@@ -2818,7 +2818,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     }
                     val <<= 20;
                 }
-                qdict_put(qdict, key, qint_from_int(val));
+                qdict_put_int(qdict, key, val);
             }
             break;
         case 'o':
@@ -2841,7 +2841,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     monitor_printf(mon, "invalid size\n");
                     goto fail;
                 }
-                qdict_put(qdict, key, qint_from_int(val));
+                qdict_put_int(qdict, key, val);
                 p = end;
             }
             break;
@@ -2897,7 +2897,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     monitor_printf(mon, "Expected 'on' or 'off'\n");
                     goto fail;
                 }
-                qdict_put(qdict, key, qbool_from_bool(val));
+                qdict_put_bool(qdict, key, val);
             }
             break;
         case '-':
@@ -2928,7 +2928,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     } else {
                         /* has option */
                         p++;
-                        qdict_put(qdict, key, qbool_from_bool(true));
+                        qdict_put_bool(qdict, key, true);
                     }
                 }
             }
@@ -2954,7 +2954,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                                    cmd->name);
                     goto fail;
                 }
-                qdict_put(qdict, key, qstring_from_str(p));
+                qdict_put_str(qdict, key, p);
                 p += len;
             }
             break;
@@ -3733,9 +3733,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
                     QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND])) {
             /* Provide a more useful error message */
             qdict_del(qdict, "desc");
-            qdict_put(qdict, "desc",
-                      qstring_from_str("Expecting capabilities negotiation"
-                                       " with 'qmp_capabilities'"));
+            qdict_put_str(qdict, "desc", "Expecting capabilities negotiation"
+                          " with 'qmp_capabilities'");
         }
     }

diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 802ede4..ba3029c 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -51,7 +51,7 @@ static void timestamp_put(QDict *qdict)
 QDict *qmp_event_build_dict(const char *event_name)
 {
     QDict *dict = qdict_new();
-    qdict_put(dict, "event", qstring_from_str(event_name));
+    qdict_put_str(dict, "event", event_name);
     timestamp_put(dict);
     return dict;
 }
diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..efb9833 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -313,7 +313,7 @@ static BlockBackend *img_open_file(const char *filename,

     if (fmt) {
         options = qdict_new();
-        qdict_put(options, "driver", qstring_from_str(fmt));
+        qdict_put_str(options, "driver", fmt);
     }

     blk = blk_new_open(filename, NULL, options, flags, &local_err);
@@ -3158,7 +3158,7 @@ static int img_rebase(int argc, char **argv)

         if (bs->backing_format[0] != '\0') {
             options = qdict_new();
-            qdict_put(options, "driver", qstring_from_str(bs->backing_format));
+            qdict_put_str(options, "driver", bs->backing_format);
         }

         bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
@@ -3175,7 +3175,7 @@ static int img_rebase(int argc, char **argv)
         if (out_baseimg[0]) {
             if (out_basefmt) {
                 options = qdict_new();
-                qdict_put(options, "driver", qstring_from_str(out_basefmt));
+                qdict_put_str(options, "driver", out_basefmt);
             } else {
                 options = NULL;
             }
diff --git a/qemu-io.c b/qemu-io.c
index 427cbae..ed0e2dc 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -601,7 +601,7 @@ int main(int argc, char **argv)
         } else {
             if (format) {
                 opts = qdict_new();
-                qdict_put(opts, "driver", qstring_from_str(format));
+                qdict_put_str(opts, "driver", format);
             }
             if (openfile(argv[optind], flags, writethrough, opts)) {
                 exit(1);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e080fb7..e4f00e2 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -959,7 +959,7 @@ int main(int argc, char **argv)
     } else {
         if (fmt) {
             options = qdict_new();
-            qdict_put(options, "driver", qstring_from_str(fmt));
+            qdict_put_str(options, "driver", fmt);
         }
         blk = blk_new_open(srcpath, NULL, options, flags, &local_err);
     }
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 291eef1..88e2ecd 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -463,7 +463,7 @@ void qdict_set_default_str(QDict *dst, const char *key, const char *val)
         return;
     }

-    qdict_put(dst, key, qstring_from_str(val));
+    qdict_put_str(dst, key, val);
 }

 static void qdict_flatten_qdict(QDict *qdict, QDict *target,
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index ce461cc..8d27363 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -376,12 +376,12 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,

 static void qdict_add_disabled_feat(const char *name, void *opaque)
 {
-    qdict_put(opaque, name, qbool_from_bool(false));
+    qdict_put_bool(opaque, name, false);
 }

 static void qdict_add_enabled_feat(const char *name, void *opaque)
 {
-    qdict_put(opaque, name, qbool_from_bool(true));
+    qdict_put_bool(opaque, name, true);
 }

 /* convert S390CPUDef into a static CpuModelInfo */
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5ce1b5c..a36cafa 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1060,7 +1060,7 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
         qdict = qdict_new();
     }
     if (opts->id) {
-        qdict_put(qdict, "id", qstring_from_str(opts->id));
+        qdict_put_str(qdict, "id", opts->id);
     }
     QTAILQ_FOREACH(opt, &opts->head, next) {
         val = QOBJECT(qstring_from_str(opt->str));
-- 
2.9.3
