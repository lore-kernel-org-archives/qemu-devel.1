Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C62C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB53207F7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Nb8Z7Lju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB53207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qBa-0004Bx-GB
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d2c5cf7ca15490b4737a5393e51abf0301b98971@lizzy.crudebyte.com>)
 id 1k5qAp-0002w9-Om
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:48:07 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d2c5cf7ca15490b4737a5393e51abf0301b98971@lizzy.crudebyte.com>)
 id 1k5qAo-00066H-24
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=l/mKW0rgsRslNa0OpCdF8sGaF5LPo7bjDCxdEeS9IPo=; b=Nb8Z7
 LjunagzVVC8gGnCwB+V+ZqYGLNKXpPVH6Soid29IX0gJxXMi8IUoVB2w4aDVE+n3Xuqoq0FYvQEUP
 cNETDgGikiwEzpqENUZ6RqtjZMUccDvajkNPRBnCy8FPWNz+DIgxzr7YQjTYvpilTCz7JWbjg2JXw
 GsxIbt5zmIgu/jpLTnToboYAXHPUSWYcRbtUDgMo+dmrlgv54jy/ScyqC6p/0qb6pwJ+3ILov5Pjb
 EnESW0Oyald+okCtAkOsFU0iBb+mccRmkE/dNXxWvN1TwT9OYFF3vqmqP4hrrE1zgvotKr2O+qrty
 vnPn9qAzY9zvbFqdBo+9kM43tsj6Q==;
Message-Id: <d2c5cf7ca15490b4737a5393e51abf0301b98971.1597226797.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1597226797.git.qemu_oss@crudebyte.com>
References: <cover.1597226797.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 29 Jul 2020 10:39:12 +0200
Subject: [PULL 6/7] 9pfs: differentiate readdir lock between 9P2000.u vs.
 9P2000.L
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=d2c5cf7ca15490b4737a5393e51abf0301b98971@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 08:16:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

Previous patch suggests that it might make sense to use a different mutex
type now while handling readdir requests, depending on the precise
protocol variant, as v9fs_do_readdir_with_stat() (used by 9P2000.u) uses
a CoMutex to avoid deadlocks that might happen with QemuMutex otherwise,
whereas do_readdir_many() (used by 9P2000.L) should better use a
QemuMutex, as the precise behaviour of a failed CoMutex lock on fs driver
side would not be clear.

And to avoid the wrong lock type being used, be now strict and error out
if a 9P2000.L client sends a Tread on a directory, and likeweise error out
if a 9P2000.u client sends a Treaddir request.

This patch is just intended as transitional measure, as currently 9P2000.u
vs. 9P2000.L implementations currently differ where the main logic of
fetching directory entries is located at (9P2000.u still being more top
half focused, while 9P2000.L already being bottom half focused in regards
to fetching directory entries that is).

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <9a2ddc347e533b0d801866afd9dfac853d2d4106.1596012787.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 21 ++++++++++++++++++---
 hw/9pfs/9p.h | 27 ++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index cc4094b971..7bb994bbf2 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -314,8 +314,8 @@ static V9fsFidState *alloc_fid(V9fsState *s, int32_t fid)
     f->next = s->fid_list;
     s->fid_list = f;
 
-    v9fs_readdir_init(&f->fs.dir);
-    v9fs_readdir_init(&f->fs_reclaim.dir);
+    v9fs_readdir_init(s->proto_version, &f->fs.dir);
+    v9fs_readdir_init(s->proto_version, &f->fs_reclaim.dir);
 
     return f;
 }
@@ -2228,7 +2228,14 @@ static void coroutine_fn v9fs_read(void *opaque)
         goto out_nofid;
     }
     if (fidp->fid_type == P9_FID_DIR) {
-
+        if (s->proto_version != V9FS_PROTO_2000U) {
+            warn_report_once(
+                "9p: bad client: T_read request on directory only expected "
+                "with 9P2000.u protocol version"
+            );
+            err = -EOPNOTSUPP;
+            goto out;
+        }
         if (off == 0) {
             v9fs_co_rewinddir(pdu, fidp);
         }
@@ -2446,6 +2453,14 @@ static void coroutine_fn v9fs_readdir(void *opaque)
         retval = -EINVAL;
         goto out;
     }
+    if (s->proto_version != V9FS_PROTO_2000L) {
+        warn_report_once(
+            "9p: bad client: T_readdir request only expected with 9P2000.L "
+            "protocol version"
+        );
+        retval = -EOPNOTSUPP;
+        goto out;
+    }
     count = v9fs_do_readdir(pdu, fidp, (off_t) initial_offset, max_count);
     if (count < 0) {
         retval = count;
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 93b7030edf..3dd1b50b1a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -197,22 +197,39 @@ typedef struct V9fsXattr
 
 typedef struct V9fsDir {
     DIR *stream;
-    CoMutex readdir_mutex;
+    P9ProtoVersion proto_version;
+    /* readdir mutex type used for 9P2000.u protocol variant */
+    CoMutex readdir_mutex_u;
+    /* readdir mutex type used for 9P2000.L protocol variant */
+    QemuMutex readdir_mutex_L;
 } V9fsDir;
 
 static inline void v9fs_readdir_lock(V9fsDir *dir)
 {
-    qemu_co_mutex_lock(&dir->readdir_mutex);
+    if (dir->proto_version == V9FS_PROTO_2000U) {
+        qemu_co_mutex_lock(&dir->readdir_mutex_u);
+    } else {
+        qemu_mutex_lock(&dir->readdir_mutex_L);
+    }
 }
 
 static inline void v9fs_readdir_unlock(V9fsDir *dir)
 {
-    qemu_co_mutex_unlock(&dir->readdir_mutex);
+    if (dir->proto_version == V9FS_PROTO_2000U) {
+        qemu_co_mutex_unlock(&dir->readdir_mutex_u);
+    } else {
+        qemu_mutex_unlock(&dir->readdir_mutex_L);
+    }
 }
 
-static inline void v9fs_readdir_init(V9fsDir *dir)
+static inline void v9fs_readdir_init(P9ProtoVersion proto_version, V9fsDir *dir)
 {
-    qemu_co_mutex_init(&dir->readdir_mutex);
+    dir->proto_version = proto_version;
+    if (proto_version == V9FS_PROTO_2000U) {
+        qemu_co_mutex_init(&dir->readdir_mutex_u);
+    } else {
+        qemu_mutex_init(&dir->readdir_mutex_L);
+    }
 }
 
 /**
-- 
2.20.1


