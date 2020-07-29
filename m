Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACF4206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="KYeIrXVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACF4206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ihg-0001np-1e
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 05:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c7c3d1cf4e86611538cef44897842819d9359d7a@lizzy.crudebyte.com>)
 id 1k0ih6-0001Nl-VJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:48:16 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:58115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c7c3d1cf4e86611538cef44897842819d9359d7a@lizzy.crudebyte.com>)
 id 1k0ih5-0004o5-4j
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=ol0hJmQYo1jT2opLuJdHI9w0b1u+9bnIU7qAzpwfRD0=; b=KYeIr
 XVoBUSOHe4tSzT/T0LDxx8F4amWtPdck1tBWpNuGIhMbzSz3pj8T7NaIZtb97vs8B377SnGLGCYQY
 ploNskmAvZKA32RwN3GbTTOyag3Z1Edqpyn+izD+CKtYLhWxl1vO5rlIeoVoMuKnvpvUu1sBKQX7h
 FCOGjacXPKlMZSgpfX/kXbrzgFanUaoQvWWwIBoNpCQanPj0awFjFKVbYwGaBMYsgo5AV0xHOTJA4
 smaeuNAbgxUQ+eLY+TFKZJ0bqc9WjNd2lzN/PEvcDNc8Ky2Tos4eb0ttmG0uizUZKg+RKEMWRpXmA
 aOVHS/CrPetJaOg5r/BDx4aUE7QWQ==;
Message-Id: <c7c3d1cf4e86611538cef44897842819d9359d7a.1596012787.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1596012787.git.qemu_oss@crudebyte.com>
References: <cover.1596012787.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 29 Jul 2020 10:13:05 +0200
Subject: [PATCH v8 5/7] 9pfs: T_readdir latency optimization
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=c7c3d1cf4e86611538cef44897842819d9359d7a@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 05:20:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make top half really top half and bottom half really bottom half:

Each T_readdir request handling is hopping between threads (main
I/O thread and background I/O driver threads) several times for
every individual directory entry, which sums up to huge latencies
for handling just a single T_readdir request.

Instead of doing that, collect now all required directory entries
(including all potentially required stat buffers for each entry) in
one rush on a background I/O thread from fs driver by calling the
previously added function v9fs_co_readdir_many() instead of
v9fs_co_readdir(), then assemble the entire resulting network
response message for the readdir request on main I/O thread. The
fs driver is still aborting the directory entry retrieval loop
(on the background I/O thread inside of v9fs_co_readdir_many())
as soon as it would exceed the client's requested maximum R_readdir
response size. So this will not introduce a performance penalty on
another end.

Also: No longer seek initial directory position in v9fs_readdir(),
as this is now handled (more consistently) by
v9fs_co_readdir_many() instead.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 132 ++++++++++++++++++++++-----------------------------
 1 file changed, 58 insertions(+), 74 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7a228c4828..cc4094b971 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -972,30 +972,6 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
     return 0;
 }
 
-static int coroutine_fn dirent_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
-                                      struct dirent *dent, V9fsQID *qidp)
-{
-    struct stat stbuf;
-    V9fsPath path;
-    int err;
-
-    v9fs_path_init(&path);
-
-    err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
-    if (err < 0) {
-        goto out;
-    }
-    err = v9fs_co_lstat(pdu, &path, &stbuf);
-    if (err < 0) {
-        goto out;
-    }
-    err = stat_to_qid(pdu, &stbuf, qidp);
-
-out:
-    v9fs_path_free(&path);
-    return err;
-}
-
 V9fsPDU *pdu_alloc(V9fsState *s)
 {
     V9fsPDU *pdu = NULL;
@@ -2328,62 +2304,74 @@ size_t v9fs_readdir_response_size(V9fsString *name)
     return 24 + v9fs_string_size(name);
 }
 
+static void v9fs_free_dirents(struct V9fsDirEnt *e)
+{
+    struct V9fsDirEnt *next = NULL;
+
+    for (; e; e = next) {
+        next = e->next;
+        g_free(e->dent);
+        g_free(e->st);
+        g_free(e);
+    }
+}
+
 static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
-                                        int32_t max_count)
+                                        off_t offset, int32_t max_count)
 {
     size_t size;
     V9fsQID qid;
     V9fsString name;
     int len, err = 0;
     int32_t count = 0;
-    off_t saved_dir_pos;
     struct dirent *dent;
+    struct stat *st;
+    struct V9fsDirEnt *entries = NULL;
 
-    /* save the directory position */
-    saved_dir_pos = v9fs_co_telldir(pdu, fidp);
-    if (saved_dir_pos < 0) {
-        return saved_dir_pos;
-    }
-
-    while (1) {
-        v9fs_readdir_lock(&fidp->fs.dir);
+    /*
+     * inode remapping requires the device id, which in turn might be
+     * different for different directory entries, so if inode remapping is
+     * enabled we have to make a full stat for each directory entry
+     */
+    const bool dostat = pdu->s->ctx.export_flags & V9FS_REMAP_INODES;
 
-        err = v9fs_co_readdir(pdu, fidp, &dent);
-        if (err || !dent) {
-            break;
-        }
-        v9fs_string_init(&name);
-        v9fs_string_sprintf(&name, "%s", dent->d_name);
-        if ((count + v9fs_readdir_response_size(&name)) > max_count) {
-            v9fs_readdir_unlock(&fidp->fs.dir);
+    /*
+     * Fetch all required directory entries altogether on a background IO
+     * thread from fs driver. We don't want to do that for each entry
+     * individually, because hopping between threads (this main IO thread
+     * and background IO driver thread) would sum up to huge latencies.
+     */
+    count = v9fs_co_readdir_many(pdu, fidp, &entries, offset, max_count,
+                                 dostat);
+    if (count < 0) {
+        err = count;
+        count = 0;
+        goto out;
+    }
+    count = 0;
 
-            /* Ran out of buffer. Set dir back to old position and return */
-            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
-            v9fs_string_free(&name);
-            return count;
-        }
+    for (struct V9fsDirEnt *e = entries; e; e = e->next) {
+        dent = e->dent;
 
         if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
-            /*
-             * dirent_to_qid() implies expensive stat call for each entry,
-             * we must do that here though since inode remapping requires
-             * the device id, which in turn might be different for
-             * different entries; we cannot make any assumption to avoid
-             * that here.
-             */
-            err = dirent_to_qid(pdu, fidp, dent, &qid);
+            st = e->st;
+            /* e->st should never be NULL, but just to be sure */
+            if (!st) {
+                err = -1;
+                break;
+            }
+
+            /* remap inode */
+            err = stat_to_qid(pdu, st, &qid);
             if (err < 0) {
-                v9fs_readdir_unlock(&fidp->fs.dir);
-                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
-                v9fs_string_free(&name);
-                return err;
+                break;
             }
         } else {
             /*
              * Fill up just the path field of qid because the client uses
              * only that. To fill the entire qid structure we will have
              * to stat each dirent found, which is expensive. For the
-             * latter reason we don't call dirent_to_qid() here. Only drawback
+             * latter reason we don't call stat_to_qid() here. Only drawback
              * is that no multi-device export detection of stat_to_qid()
              * would be done and provided as error to the user here. But
              * user would get that error anyway when accessing those
@@ -2396,25 +2384,26 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
             qid.version = 0;
         }
 
+        v9fs_string_init(&name);
+        v9fs_string_sprintf(&name, "%s", dent->d_name);
+
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "Qqbs",
                           &qid, dent->d_off,
                           dent->d_type, &name);
 
-        v9fs_readdir_unlock(&fidp->fs.dir);
+        v9fs_string_free(&name);
 
         if (len < 0) {
-            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
-            v9fs_string_free(&name);
-            return len;
+            err = len;
+            break;
         }
+
         count += len;
-        v9fs_string_free(&name);
-        saved_dir_pos = dent->d_off;
     }
 
-    v9fs_readdir_unlock(&fidp->fs.dir);
-
+out:
+    v9fs_free_dirents(entries);
     if (err < 0) {
         return err;
     }
@@ -2457,12 +2446,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
         retval = -EINVAL;
         goto out;
     }
-    if (initial_offset == 0) {
-        v9fs_co_rewinddir(pdu, fidp);
-    } else {
-        v9fs_co_seekdir(pdu, fidp, initial_offset);
-    }
-    count = v9fs_do_readdir(pdu, fidp, max_count);
+    count = v9fs_do_readdir(pdu, fidp, (off_t) initial_offset, max_count);
     if (count < 0) {
         retval = count;
         goto out;
-- 
2.20.1


