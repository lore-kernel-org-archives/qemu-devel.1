Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E444C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6E522281
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUB3mWGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6E522281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7dw-0005Wi-IW
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7Tg-0002ml-ST
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7Te-0003eQ-Gt
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603737857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuRSSzyf8b+9XH+gLT608at4jR7/gO2V/yGyhY+6rv4=;
 b=gUB3mWGBU8d3CGzNkk4qjKQaF95hoYXg4lqRdkkof7WduML9HAdTqSsRmgR8enzrA4tW4j
 LOiD8oNsvq1kS/G/juRO2TxJqM5W2S+F88/spv5otZzNBsA3Q8lm/3tQMFRgQG9GjBpdLm
 RrVo6fUofhIerZvGWmCCQVxJ0DH8ByQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-R4H-cCUlMTmT2S_Pab4osg-1; Mon, 26 Oct 2020 14:44:12 -0400
X-MC-Unique: R4H-cCUlMTmT2S_Pab4osg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77597809DD1;
 Mon, 26 Oct 2020 18:44:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 257AA5D9CA;
 Mon, 26 Oct 2020 18:44:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 misono.tomohiro@jp.fujitsu.com
Subject: [PULL 14/16] virtiofsd: Announce sub-mount points
Date: Mon, 26 Oct 2020 18:43:29 +0000
Message-Id: <20201026184331.272953-15-dgilbert@redhat.com>
In-Reply-To: <20201026184331.272953-1-dgilbert@redhat.com>
References: <20201026184331.272953-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Whenever we encounter a directory with an st_dev that differs from that
of its parent, we set the FUSE_ATTR_SUBMOUNT flag so the guest can
create a submount for it.

Make this behavior optional, so submounts are only announced to the
guest with the announce_submounts option.  Some users may prefer the
current behavior, so that the guest learns nothing about the host mount
structure.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200909184028.262297-7-mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Manual merge
---
 tools/virtiofsd/helper.c         |  1 +
 tools/virtiofsd/passthrough_ll.c | 67 ++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 2e181a49b5..a212f32931 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -178,6 +178,7 @@ void fuse_cmdline_help(void)
            "                               default: depends on cache= option.\n"
            "    -o writeback|no_writeback  enable/disable writeback cache\n"
            "                               default: no_writeback\n"
+           "    -o announce_submounts      Announce sub-mount points to the guest\n"
            "    -o xattr|no_xattr          enable/disable xattr\n"
            "                               default: no_xattr\n"
            "    -o modcaps=CAPLIST         Modify the list of capabilities\n"
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 4188bf3ad2..4db50046d4 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -40,6 +40,7 @@
 #include "fuse_virtio.h"
 #include "fuse_log.h"
 #include "fuse_lowlevel.h"
+#include "standard-headers/linux/fuse.h"
 #include <assert.h>
 #include <cap-ng.h>
 #include <dirent.h>
@@ -173,6 +174,7 @@ struct lo_data {
     int timeout_set;
     int readdirplus_set;
     int readdirplus_clear;
+    int announce_submounts;
     int allow_direct_io;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
@@ -211,6 +213,7 @@ static const struct fuse_opt lo_opts[] = {
     { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
     { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
     { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
+    { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
     { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1 },
     { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io), 0 },
     FUSE_OPT_END
@@ -608,22 +611,52 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
     }
 }
 
+/**
+ * Call fstatat() and set st_rdev whenever a directory's st_dev
+ * differs from the rparent's st_dev (@parent_dev).  This will
+ * announce submounts to the FUSE client (unless @announce_submounts
+ * is false).
+ */
+static int do_fstatat(int dirfd, const char *pathname, struct stat *statbuf,
+                      int flags, dev_t parent_dev, uint32_t *fuse_attr_flags)
+{
+    int res = fstatat(dirfd, pathname, statbuf, flags);
+    if (res == -1) {
+        return res;
+    }
+
+    if (statbuf->st_dev != parent_dev && S_ISDIR(statbuf->st_mode) &&
+        fuse_attr_flags)
+    {
+        *fuse_attr_flags |= FUSE_ATTR_SUBMOUNT;
+    }
+
+    return 0;
+}
+
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
                        struct fuse_file_info *fi)
 {
     int res;
     struct stat buf;
     struct lo_data *lo = lo_data(req);
+    struct lo_inode *inode = lo_inode(req, ino);
+    uint32_t fuse_attr_flags = 0;
 
     (void)fi;
 
-    res =
-        fstatat(lo_fd(req, ino), "", &buf, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+    res = do_fstatat(inode->fd, "", &buf, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW,
+                     inode->parent_dev, &fuse_attr_flags);
+    lo_inode_put(lo, &inode);
     if (res == -1) {
         return (void)fuse_reply_err(req, errno);
     }
 
-    fuse_reply_attr(req, &buf, lo->timeout);
+    if (!lo->announce_submounts) {
+        fuse_attr_flags &= ~FUSE_ATTR_SUBMOUNT;
+    }
+
+    fuse_reply_attr_with_flags(req, &buf, lo->timeout, fuse_attr_flags);
 }
 
 static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
@@ -819,11 +852,16 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         goto out_err;
     }
 
-    res = fstatat(newfd, "", &e->attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+    res = do_fstatat(newfd, "", &e->attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW,
+                     dir->key.dev, &e->attr_flags);
     if (res == -1) {
         goto out_err;
     }
 
+    if (!lo->announce_submounts) {
+        e->attr_flags &= ~FUSE_ATTR_SUBMOUNT;
+    }
+
     inode = lo_find(lo, &e->attr);
     if (inode) {
         close(newfd);
@@ -1069,11 +1107,17 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
         goto out_err;
     }
 
-    res = fstatat(inode->fd, "", &e.attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+    res = do_fstatat(inode->fd, "", &e.attr,
+                     AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW,
+                     parent_inode->key.dev, &e.attr_flags);
     if (res == -1) {
         goto out_err;
     }
 
+    if (!lo->announce_submounts) {
+        e.attr_flags &= ~FUSE_ATTR_SUBMOUNT;
+    }
+
     pthread_mutex_lock(&lo->mutex);
     inode->nlookup++;
     pthread_mutex_unlock(&lo->mutex);
@@ -1108,14 +1152,21 @@ static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
 {
     int res;
     struct stat attr;
+    struct lo_data *lo = lo_data(req);
+    struct lo_inode *dir = lo_inode(req, parent);
+
+    if (!dir) {
+        return NULL;
+    }
 
-    res = fstatat(lo_fd(req, parent), name, &attr,
-                  AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+    res = do_fstatat(dir->fd, name, &attr,
+                     AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW, dir->key.dev, NULL);
+    lo_inode_put(lo, &dir);
     if (res == -1) {
         return NULL;
     }
 
-    return lo_find(lo_data(req), &attr);
+    return lo_find(lo, &attr);
 }
 
 static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)
-- 
2.28.0


