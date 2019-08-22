Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5493C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE1921655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bMI2h6a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE1921655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0v76-0006gc-Hy
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 17:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <2f8ddf611be0b69ce936e4bd1bf3b18156a22995@lizzy.crudebyte.com>)
 id 1i0v5y-0005rP-7W
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <2f8ddf611be0b69ce936e4bd1bf3b18156a22995@lizzy.crudebyte.com>)
 id 1i0v5w-0006ar-QY
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:58:14 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:38799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <2f8ddf611be0b69ce936e4bd1bf3b18156a22995@lizzy.crudebyte.com>)
 id 1i0v5w-0006I3-K8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t+Ow+NmaIpgO7UyfrCCEQHSXZ9UqtAyOsPA67TZO4Rk=; b=bMI2h6a62H01nlUY0OxJkbeJt
 aP4CnMyDXelbnxpiBXcObWurXAVpLJVT5UTBa9/vpLIgeB32RyGFLI/UiP1cUj0cfX8C4skhZwAv5
 MCS2gdHgiY4LhzJCVoXucctW92Z0gmi7kNtIuZbNLYWftw+TjZHCihvcaeBuUWPXQqJ8mn34wTbtM
 CjN8Th0Rc/18OvIqgViKm8tB6fjN5qSwwUO9V2BHP+kqyi5C90o3dfXtc5lvkQMuawUS9RnUaah6r
 ClcYyBmqA8JhAGan3hupRyrpmnCfg1QTcIcdX34aJHaO33CL5wGbrIqGMeqg7y3SGzrA1lZHPo2Iw
 546ki2kzw==;
Message-Id: <2f8ddf611be0b69ce936e4bd1bf3b18156a22995.1566503584.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1566503584.git.qemu_oss@crudebyte.com>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 21:44:28 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v6 3/4] 9p: stat_to_qid: implement slow path
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

stat_to_qid attempts via qid_path_prefixmap to map unique files (which are
identified by 64 bit inode nr and 32 bit device id) to a 64 QID path value.
However this implementation makes some assumptions about inode number
generation on the host.

If qid_path_prefixmap fails, we still have 48 bits available in the QID
path to fall back to a less memory efficient full mapping.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
[CS: - Rebased to https://github.com/gkurz/qemu/commits/9p-next
       (SHA1 177fd3b6a8).
     - Updated hash calls to new xxhash API.
     - Removed unnecessary parantheses in qpf_lookup_func().
     - Removed unnecessary g_malloc0() result checks.
     - Log error message when running out of prefixes in
       qid_path_fullmap().
     - Log error message about potential degraded performance in
       qid_path_prefixmap().
     - Fixed typo in comment. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 hw/9pfs/9p.h |  9 ++++++++
 2 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c96ea51116..728641fb7f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -579,23 +579,73 @@ static uint32_t qpp_hash(QppEntry e)
     return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
 }
 
+static uint32_t qpf_hash(QpfEntry e)
+{
+    return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
+}
+
 static bool qpp_lookup_func(const void *obj, const void *userp)
 {
     const QppEntry *e1 = obj, *e2 = userp;
     return e1->dev == e2->dev && e1->ino_prefix == e2->ino_prefix;
 }
 
-static void qpp_table_remove(void *p, uint32_t h, void *up)
+static bool qpf_lookup_func(const void *obj, const void *userp)
+{
+    const QpfEntry *e1 = obj, *e2 = userp;
+    return e1->dev == e2->dev && e1->ino == e2->ino;
+}
+
+static void qp_table_remove(void *p, uint32_t h, void *up)
 {
     g_free(p);
 }
 
-static void qpp_table_destroy(struct qht *ht)
+static void qp_table_destroy(struct qht *ht)
 {
-    qht_iter(ht, qpp_table_remove, NULL);
+    qht_iter(ht, qp_table_remove, NULL);
     qht_destroy(ht);
 }
 
+static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
+                            uint64_t *path)
+{
+    QpfEntry lookup = {
+        .dev = stbuf->st_dev,
+        .ino = stbuf->st_ino
+    }, *val;
+    uint32_t hash = qpf_hash(lookup);
+
+    /* most users won't need the fullmap, so init the table lazily */
+    if (!pdu->s->qpf_table.map) {
+        qht_init(&pdu->s->qpf_table, qpf_lookup_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
+    }
+
+    val = qht_lookup(&pdu->s->qpf_table, &lookup, hash);
+
+    if (!val) {
+        if (pdu->s->qp_fullpath_next == 0) {
+            /* no more files can be mapped :'( */
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
+        /* new unique inode and device combo */
+        val->path = pdu->s->qp_fullpath_next++;
+        pdu->s->qp_fullpath_next &= QPATH_INO_MASK;
+        qht_insert(&pdu->s->qpf_table, val, hash, NULL);
+    }
+
+    *path = val->path;
+    return 0;
+}
+
 /* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
  * to a unique QID path (64 bits). To avoid having to map and keep track
  * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
@@ -621,8 +671,7 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
         if (pdu->s->qp_prefix_next == 0) {
             /* we ran out of prefixes */
             error_report_once(
-                "9p: No more prefixes available for remapping inodes from "
-                "host to guest."
+                "9p: Potential degraded performance of inode remapping"
             );
             return -ENFILE;
         }
@@ -647,6 +696,10 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
     if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
         /* map inode+device to qid path (fast path) */
         err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+        if (err == -ENFILE) {
+            /* fast path didn't work, fall back to full map */
+            err = qid_path_fullmap(pdu, stbuf, &qidp->path);
+        }
         if (err) {
             return err;
         }
@@ -3813,6 +3866,7 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     /* QID path hash table. 1 entry ought to be enough for anybody ;) */
     qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
     s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+    s->qp_fullpath_next = 1;
 
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
@@ -3827,7 +3881,8 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
-        qpp_table_destroy(&s->qpp_table);
+        qp_table_destroy(&s->qpp_table);
+        qp_table_destroy(&s->qpf_table);
         v9fs_path_free(&path);
     }
     return rc;
@@ -3840,7 +3895,8 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
-    qpp_table_destroy(&s->qpp_table);
+    qp_table_destroy(&s->qpp_table);
+    qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index a283b0193e..f044a88a41 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -245,6 +245,13 @@ typedef struct {
     uint16_t qp_prefix;
 } QppEntry;
 
+/* QID path full entry, as above */
+typedef struct {
+    dev_t dev;
+    ino_t ino;
+    uint64_t path;
+} QpfEntry;
+
 struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
@@ -269,7 +276,9 @@ struct V9fsState
     ino_t root_ino;
     dev_t dev_id;
     struct qht qpp_table;
+    struct qht qpf_table;
     uint16_t qp_prefix_next;
+    uint64_t qp_fullpath_next;
 };
 
 /* 9p2000.L open flags */
-- 
2.11.0


