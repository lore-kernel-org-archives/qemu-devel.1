Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF34C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D5921850
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WICo0MKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D5921850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hifcg-0003YL-6k
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 09:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44720)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ec68cd4c68726f09cb340348f682265060d914d4@lizzy.crudebyte.com>)
 id 1hifYb-0001mx-8I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ec68cd4c68726f09cb340348f682265060d914d4@lizzy.crudebyte.com>)
 id 1hifYY-0005XW-Qr
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:44:21 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <ec68cd4c68726f09cb340348f682265060d914d4@lizzy.crudebyte.com>)
 id 1hifYY-0004w6-GH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e9E6YxEkoYHYP3wq2pIpcucKeRvWLDTZq/XQEevv7Ek=; b=WICo0MKx0mwG72eMNscJ8f7XV
 XNqJ3vSwN8p1J2VMiMjWapLLM6RtevMmbVekfXFAD56l0PHMEg/JN5UjUr3dkK0Jj5w6S50dUrhIx
 hJt/5OHpFXiQ9+6m8I1FOgtMGOkgFvpQGEQ4ac6slHpDR8mhyQJ4UYkmweCtz2GJhZtgO97WBiyq0
 hUQ7ID9u6zqrV38bLiyrV9vc14FR0EtHMIrl+cO/kl6okU/PP48r8LVZsCNA6PF70p4euv+LKrkQB
 qWUD33sK8+sSd5qmhDx4mtD1CJka8ymb6ikoxN4i+XZvW3ISQwOJtmdgIc1wuxb75yis2pi3yfVlo
 xjgyZiC3w==;
Message-Id: <ec68cd4c68726f09cb340348f682265060d914d4.1562154272.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1562154272.git.qemu_oss@crudebyte.com>
References: <cover.1562154272.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Wed, 3 Jul 2019 13:13:26 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v5 3/5] 9p: Added virtfs option 'remap_inodes'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To support multiple devices on the 9p share, and avoid
qid path collisions we take the device id as input
to generate a unique QID path. The lowest 48 bits of
the path will be set equal to the file inode, and the
top bits will be uniquely assigned based on the top
16 bits of the inode and the device id.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
[CS: - Rebased to master head.
     - Updated hash calls to new xxhash API.
     - Added virtfs option 'remap_inodes', original patch
       simply did the inode remapping without being asked.
     - Updated docs for new option 'remap_inodes'.
     - Capture root_ino in v9fs_device_realize_common() as
       well, not just the device id.
     - Fixed v9fs_do_readdir() having exposed info outside
       export root with '..' entry.
     - Fixed v9fs_do_readdir() not having remapped inodes.
     - Log error message when running out of prefixes in
       qid_path_prefixmap().
     - Fixed definition of QPATH_INO_MASK.
     - Dropped unnecessary parantheses in qpp_lookup_func().
     - Dropped unnecessary g_malloc0() result checks. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h      |   1 +
 fsdev/qemu-fsdev-opts.c |   7 +-
 fsdev/qemu-fsdev.c      |   6 ++
 hw/9pfs/9p.c            | 196 +++++++++++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h            |  13 ++++
 qemu-options.hx         |  25 ++++--
 vl.c                    |   3 +
 7 files changed, 224 insertions(+), 27 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index c757c8099f..6c1663c252 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -59,6 +59,7 @@ typedef struct ExtendedOps {
 #define V9FS_RDONLY                 0x00000040
 #define V9FS_PROXY_SOCK_FD          0x00000080
 #define V9FS_PROXY_SOCK_NAME        0x00000100
+#define V9FS_REMAP_INODES           0x00000200
 
 #define V9FS_SEC_MASK               0x0000003C
 
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 7c31ffffaf..64a8052266 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -31,7 +31,9 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "readonly",
             .type = QEMU_OPT_BOOL,
-
+        }, {
+            .name = "remap_inodes",
+            .type = QEMU_OPT_BOOL,
         }, {
             .name = "socket",
             .type = QEMU_OPT_STRING,
@@ -76,6 +78,9 @@ static QemuOptsList qemu_virtfs_opts = {
             .name = "readonly",
             .type = QEMU_OPT_BOOL,
         }, {
+            .name = "remap_inodes",
+            .type = QEMU_OPT_BOOL,
+        }, {
             .name = "socket",
             .type = QEMU_OPT_STRING,
         }, {
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 077a8c4e2b..b6fa9799be 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -121,6 +121,7 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     const char *fsdev_id = qemu_opts_id(opts);
     const char *fsdriver = qemu_opt_get(opts, "fsdriver");
     const char *writeout = qemu_opt_get(opts, "writeout");
+    bool remap_inodes = qemu_opt_get_bool(opts, "remap_inodes", 0);
     bool ro = qemu_opt_get_bool(opts, "readonly", 0);
 
     if (!fsdev_id) {
@@ -161,6 +162,11 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     } else {
         fsle->fse.export_flags &= ~V9FS_RDONLY;
     }
+    if (remap_inodes) {
+        fsle->fse.export_flags |= V9FS_REMAP_INODES;
+    } else {
+        fsle->fse.export_flags &= ~V9FS_REMAP_INODES;
+    }
 
     if (fsle->fse.ops->parse_opts) {
         if (fsle->fse.ops->parse_opts(opts, &fsle->fse, errp)) {
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 8cc65c2c67..39c6c2a894 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
+#include "qemu/xxhash.h"
 
 int open_fd_hw;
 int total_open_fd;
@@ -571,22 +572,98 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
-/* This is the algorithm from ufs in spfs */
+
+/* creative abuse of tb_hash_func7, which is based on xxhash */
+static uint32_t qpp_hash(QppEntry e)
+{
+    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
+}
+
+static bool qpp_lookup_func(const void *obj, const void *userp)
+{
+    const QppEntry *e1 = obj, *e2 = userp;
+    return e1->dev == e2->dev && e1->ino_prefix == e2->ino_prefix;
+}
+
+static void qpp_table_remove(void *p, uint32_t h, void *up)
+{
+    g_free(p);
+}
+
+static void qpp_table_destroy(struct qht *ht)
+{
+    qht_iter(ht, qpp_table_remove, NULL);
+    qht_destroy(ht);
+}
+
+/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
+ * to a unique QID path (64 bits). To avoid having to map and keep track
+ * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
+ * the device id to the 16 highest bits of the QID path. The 48 lowest bits
+ * of the QID path equal to the lowest bits of the inode number.
+ *
+ * This takes advantage of the fact that inode number are usually not
+ * random but allocated sequentially, so we have fewer items to keep
+ * track of.
+ */
+static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
+                                uint64_t *path)
+{
+    QppEntry lookup = {
+        .dev = stbuf->st_dev,
+        .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
+    }, *val;
+    uint32_t hash = qpp_hash(lookup);
+
+    val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
+
+    if (!val) {
+        if (pdu->s->qp_prefix_next == 0) {
+            /* we ran out of prefixes */
+            error_report_once(
+                "9p: No more prefixes available for remapping inodes from "
+                "host to guest."
+            );
+            return -ENFILE;
+        }
+
+        val = g_malloc0(sizeof(QppEntry));
+        *val = lookup;
+
+        /* new unique inode prefix and device combo */
+        val->qp_prefix = pdu->s->qp_prefix_next++;
+        qht_insert(&pdu->s->qpp_table, val, hash, NULL);
+    }
+
+    *path = ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
+    return 0;
+}
+
 static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
 {
+    int err;
     size_t size;
 
-    if (pdu->s->dev_id != stbuf->st_dev) {
-        error_report_once(
-            "9p: Multiple devices detected in same VirtFS export. "
-            "You must use a separate export for each device."
-        );
-        return -ENODEV;
+    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
+        /* map inode+device to qid path (fast path) */
+        err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+        if (err) {
+            return err;
+        }
+    } else {
+        if (pdu->s->dev_id != stbuf->st_dev) {
+            error_report_once(
+                "9p: Multiple devices detected in same VirtFS export. "
+                "You must either use a separate export for each device "
+                "shared from host or enable virtfs option 'remap_inodes'."
+            );
+            return -ENODEV;
+        }
+        memset(&qidp->path, 0, sizeof(qidp->path));
+        size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
+        memcpy(&qidp->path, &stbuf->st_ino, size);
     }
 
-    memset(&qidp->path, 0, sizeof(qidp->path));
-    size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
-    memcpy(&qidp->path, &stbuf->st_ino, size);
     qidp->version = stbuf->st_mtime ^ (stbuf->st_size << 8);
     qidp->type = 0;
     if (S_ISDIR(stbuf->st_mode)) {
@@ -616,6 +693,30 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
     return 0;
 }
 
+static int coroutine_fn dirent_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
+                                      struct dirent *dent, V9fsQID *qidp)
+{
+    struct stat stbuf;
+    V9fsPath path;
+    int err;
+
+    v9fs_path_init(&path);
+
+    err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
+    if (err < 0) {
+        goto out;
+    }
+    err = v9fs_co_lstat(pdu, &path, &stbuf);
+    if (err < 0) {
+        goto out;
+    }
+    err = stat_to_qid(pdu, &stbuf, qidp);
+
+out:
+    v9fs_path_free(&path);
+    return err;
+}
+
 V9fsPDU *pdu_alloc(V9fsState *s)
 {
     V9fsPDU *pdu = NULL;
@@ -1940,6 +2041,19 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
     int32_t count = 0;
     off_t saved_dir_pos;
     struct dirent *dent;
+    struct stat stbuf;
+    bool fidIsExportRoot;
+
+    /*
+     * determine if fidp is the export root, which is required for safe
+     * handling of ".." below
+     */
+    err = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
+    if (err < 0) {
+        return err;
+    }
+    fidIsExportRoot = pdu->s->dev_id == stbuf.st_dev &&
+                      pdu->s->root_ino == stbuf.st_ino;
 
     /* save the directory position */
     saved_dir_pos = v9fs_co_telldir(pdu, fidp);
@@ -1964,16 +2078,51 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
             v9fs_string_free(&name);
             return count;
         }
-        /*
-         * Fill up just the path field of qid because the client uses
-         * only that. To fill the entire qid structure we will have
-         * to stat each dirent found, which is expensive
-         */
-        size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
-        memcpy(&qid.path, &dent->d_ino, size);
-        /* Fill the other fields with dummy values */
-        qid.type = 0;
-        qid.version = 0;
+
+        if (fidIsExportRoot && !strcmp("..", dent->d_name)) {
+            /*
+             * if "." is export root, then return qid of export root for
+             * ".." to avoid exposing anything outside the export
+             */
+            err = fid_to_qid(pdu, fidp, &qid);
+            if (err < 0) {
+                v9fs_readdir_unlock(&fidp->fs.dir);
+                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
+                v9fs_string_free(&name);
+                return err;
+            }
+        } else if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
+            /*
+             * dirent_to_qid() implies expensive stat call for each entry,
+             * we must do that here though since inode remapping requires
+             * the device id, which in turn might be different for
+             * different entries; we cannot make any assumption to avoid
+             * that here.
+             */
+            err = dirent_to_qid(pdu, fidp, dent, &qid);
+            if (err < 0) {
+                v9fs_readdir_unlock(&fidp->fs.dir);
+                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
+                v9fs_string_free(&name);
+                return err;
+            }
+        } else {
+            /*
+             * Fill up just the path field of qid because the client uses
+             * only that. To fill the entire qid structure we will have
+             * to stat each dirent found, which is expensive. For the
+             * latter reason we don't call dirent_to_qid() here. Only drawback
+             * is that no multi-device export detection of stat_to_qid()
+             * would be done and provided as error to the user here. But
+             * user would get that error anyway when accessing those
+             * files/dirs through other ways.
+             */
+            size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
+            memcpy(&qid.path, &dent->d_ino, size);
+            /* Fill the other fields with dummy values */
+            qid.type = 0;
+            qid.version = 0;
+        }
 
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "Qqbs",
@@ -3672,8 +3821,13 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
         goto out;
     }
 
+    s->root_ino = stat.st_ino;
     s->dev_id = stat.st_dev;
 
+    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
+    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
+    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
@@ -3687,6 +3841,7 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
+        qpp_table_destroy(&s->qpp_table);
         v9fs_path_free(&path);
     }
     return rc;
@@ -3699,6 +3854,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
+    qpp_table_destroy(&s->qpp_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5e316178d5..a283b0193e 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -8,6 +8,7 @@
 #include "fsdev/9p-iov-marshal.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/qht.h"
 
 enum {
     P9_TLERROR = 6,
@@ -235,6 +236,15 @@ struct V9fsFidState
     V9fsFidState *rclm_lst;
 };
 
+#define QPATH_INO_MASK        ((1ULL << 48) - 1)
+
+/* QID path prefix entry, see stat_to_qid */
+typedef struct {
+    dev_t dev;
+    uint16_t ino_prefix;
+    uint16_t qp_prefix;
+} QppEntry;
+
 struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
@@ -256,7 +266,10 @@ struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
+    ino_t root_ino;
     dev_t dev_id;
+    struct qht qpp_table;
+    uint16_t qp_prefix_next;
 };
 
 /* 9p2000.L open flags */
diff --git a/qemu-options.hx b/qemu-options.hx
index c18b79099a..08823e6e9a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1334,17 +1334,17 @@ ETEXI
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
-    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
-    "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly]\n"
-    "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly]\n"
+    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode][,remap_inodes]\n"
+    "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly][,remap_inodes]\n"
+    "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly][,remap_inodes]\n"
     "-virtfs synth,mount_tag=tag[,id=id][,readonly]\n",
     QEMU_ARCH_ALL)
 
 STEXI
 
-@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}]
-@itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
-@itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
+@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}][,remap_inodes]
+@itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly][,remap_inodes]
+@itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly][,remap_inodes]
 @itemx -virtfs synth,mount_tag=@var{mount_tag}
 @findex -virtfs
 
@@ -1398,6 +1398,19 @@ Specifies the default mode for newly created directories on the host. Works
 only with security models "mapped-xattr" and "mapped-file".
 @item mount_tag=@var{mount_tag}
 Specifies the tag name to be used by the guest to mount this export point.
+@item remap_inodes
+By default virtfs 9p supports only one device per export in order to avoid
+file ID collisions on guest which may otherwise happen because the original
+device IDs from host are not passed and exposed on guest. Instead all files
+of an export shared with virtfs do have the same device id on guest. So two
+files with identical inode numbers but from actually different devices on
+host would otherwise cause a file ID collision and hence potential
+misbehaviours on guest. For that reason it is recommended to create a
+separate virtfs export for each device to be shared with guests. However
+you may also enable "remap_inodes" which allows you to share multiple
+devices with only one export instead, which is achieved by remapping the
+original inode numbers from host to guest in a way that would prevent such
+collisions.
 @end table
 ETEXI
 
diff --git a/vl.c b/vl.c
index 99a56b5556..de9d7b846c 100644
--- a/vl.c
+++ b/vl.c
@@ -3457,6 +3457,9 @@ int main(int argc, char **argv, char **envp)
                 qemu_opt_set_bool(fsdev, "readonly",
                                   qemu_opt_get_bool(opts, "readonly", 0),
                                   &error_abort);
+                qemu_opt_set_bool(fsdev, "remap_inodes",
+                                  qemu_opt_get_bool(opts, "remap_inodes", 0),
+                                  &error_abort);
                 device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
                                           &error_abort);
                 qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
-- 
2.11.0


