Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B94C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD32F2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvMZqLe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD32F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG59Y-0007K1-VW
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG52H-0006bo-Ho
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22595
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG528-0007Wm-2L
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599676887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/3RU9i9f4uhYugdG9EKMoXD/+j4KkTslSj3LvNgL4w=;
 b=SvMZqLe0EFQknq2Mcr7JXHcfMrMC8aJAKVDbXZ8xJVXg5ZmgAg8+EO1Yyi89a5wzqII0c9
 wGu89sqgj7GNw7Ajd0MRFyAaDBZwygVuy7EuuCL6fXRTUYifjCUx7DvkrY/XR06ys5muG4
 /L87TF8bIffuewNcFD3OfMaEG6iDsI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-KwrEkrVBOT2iMOWUM526Ng-1; Wed, 09 Sep 2020 14:41:15 -0400
X-MC-Unique: KwrEkrVBOT2iMOWUM526Ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EAFE1882FA1
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 18:41:14 +0000 (UTC)
Received: from localhost (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 102AE5C221;
 Wed,  9 Sep 2020 18:41:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] virtiofsd: Announce sub-mount points
Date: Wed,  9 Sep 2020 20:40:26 +0200
Message-Id: <20200909184028.262297-7-mreitz@redhat.com>
In-Reply-To: <20200909184028.262297-1-mreitz@redhat.com>
References: <20200909184028.262297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Whenever we encounter a directory with an st_dev that differs from that
of its parent, we set the FUSE_ATTR_SUBMOUNT flag so the guest can
create a submount for it.

Make this behavior optional, so submounts are only announced to the
guest with the announce_submounts option.  Some users may prefer the
current behavior, so that the guest learns nothing about the host mount
structure.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tools/virtiofsd/helper.c         |  1 +
 tools/virtiofsd/passthrough_ll.c | 67 ++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 7bc5d7dc5a..8c5b923604 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -178,6 +178,7 @@ void fuse_cmdline_help(void)
            "                               (0 leaves rlimit unchanged)\n"
            "                               default: min(1000000, fs.file-max - 16384)\n"
            "                                        if the current rlimit is lower\n"
+           "    -o announce_submounts      Announce sub-mount points to the guest\n"
            );
 }
 
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 2c48c03b4c..fe7b9fbbb6 100644
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
@@ -159,6 +160,7 @@ struct lo_data {
     int timeout_set;
     int readdirplus_set;
     int readdirplus_clear;
+    int announce_submounts;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
@@ -187,6 +189,7 @@ static const struct fuse_opt lo_opts[] = {
     { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
     { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
     { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
+    { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
     FUSE_OPT_END
 };
 static bool use_syslog = false;
@@ -582,22 +585,52 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
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
@@ -793,11 +826,16 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
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
@@ -1043,11 +1081,17 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
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
@@ -1082,14 +1126,21 @@ static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
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
2.26.2


