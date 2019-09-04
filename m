Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA0C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2760421848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="chu7pN1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2760421848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5qcf-0004D4-6B
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 08:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fdbcf8b7735f93f04215b244b36385ac5b6020b7@lizzy.crudebyte.com>)
 id 1i5qaS-0002wh-0F
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fdbcf8b7735f93f04215b244b36385ac5b6020b7@lizzy.crudebyte.com>)
 id 1i5qaQ-0001gy-04
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:10:03 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:57521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <fdbcf8b7735f93f04215b244b36385ac5b6020b7@lizzy.crudebyte.com>)
 id 1i5qaP-00068T-NV
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=ciBT8qSOOszbeyliPkB3VD+a4Gv0tSDSlFk9cnpgesI=; b=chu7p
 N1M1oeZaT4jC87IVcKwAKPTZ7NORonDbfbd3mgO0SSShe8GtYANGr31Mh78KiRzsE4R/y8/ncgtG2
 X/ktmyM8psHArDwIME7MpSB9P8NwgNvokXzP5AAeVgzRqoToseFB2jyRDeTWj9WdNp7JWlrC8EbZI
 S/2W7mYflcMNyM1w7qy1esEWfV9pElg68NVLZBe+YnVbt+CoXsYQEnxcX9JH2MYy07WyetyCJ2IAP
 eRr/rUoroQ0Xk+Dou2F0ZpZNmcEXbUroqNRW/0FXzk0TTLTPrPDamCxa5BeGn+LpW9Geran/dKDi0
 7vceskov+agayoanWYKdt0pIhq9xA==;
Message-Id: <fdbcf8b7735f93f04215b244b36385ac5b6020b7.1567680121.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1567680121.git.qemu_oss@crudebyte.com>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Thu, 5 Sep 2019 00:05:03 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v7 2/3] 9p: stat_to_qid: implement slow path
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

stat_to_qid attempts via qid_path_prefixmap to map unique files (which are
identified by 64 bit inode nr and 32 bit device id) to a 64 QID path value.
However this implementation makes some assumptions about inode number
generation on the host.

If qid_path_prefixmap fails, we still have 48 bits available in the QID
path to fall back to a less memory efficient full mapping.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
[CS: - Rebased to https://github.com/gkurz/qemu/commits/9p-next
       (SHA1 7fc4c49e91).
     - Updated hash calls to new xxhash API.
     - Removed unnecessary parantheses in qpf_lookup_func().
     - Removed unnecessary g_malloc0() result checks.
     - Log error message when running out of prefixes in
       qid_path_fullmap().
     - Log warning message about potential degraded performance in
       qid_path_prefixmap().
     - Wrapped qpf_table initialization to dedicated qpf_table_init()
       function.
     - Fixed typo in comment. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h |  9 +++++++
 2 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 8eb89c5c7d..d9be2d45d3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -579,23 +579,34 @@ static uint32_t qpp_hash(QppEntry e)
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
     if (!ht || !ht->map) {
         return;
     }
-    qht_iter(ht, qpp_table_remove, NULL);
+    qht_iter(ht, qp_table_remove, NULL);
     qht_destroy(ht);
 }
 
@@ -604,6 +615,50 @@ static void qpp_table_init(struct qht *ht)
     qht_init(ht, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
 }
 
+static void qpf_table_init(struct qht *ht)
+{
+    qht_init(ht, qpf_lookup_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
+}
+
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
+        qpf_table_init(&pdu->s->qpf_table);
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
 /*
  * stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
  * to a unique QID path (64 bits). To avoid having to map and keep track
@@ -629,9 +684,8 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
     if (!val) {
         if (pdu->s->qp_prefix_next == 0) {
             /* we ran out of prefixes */
-            error_report_once(
-                "9p: No more prefixes available for remapping inodes from "
-                "host to guest."
+            warn_report_once(
+                "9p: Potential degraded performance of inode remapping"
             );
             return -ENFILE;
         }
@@ -656,6 +710,10 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
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
@@ -3820,6 +3878,7 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     qpp_table_init(&s->qpp_table);
     s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+    s->qp_fullpath_next = 1;
 
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
@@ -3842,7 +3901,8 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
         fsdev_throttle_cleanup(s->ctx.fst);
     }
     g_free(s->tag);
-    qpp_table_destroy(&s->qpp_table);
+    qp_table_destroy(&s->qpp_table);
+    qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 7262fe80aa..35a362c0d7 100644
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
@@ -268,7 +275,9 @@ struct V9fsState
     V9fsQID root_qid;
     dev_t dev_id;
     struct qht qpp_table;
+    struct qht qpf_table;
     uint16_t qp_prefix_next;
+    uint64_t qp_fullpath_next;
 };
 
 /* 9p2000.L open flags */
-- 
2.20.1


