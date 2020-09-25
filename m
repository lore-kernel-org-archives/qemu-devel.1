Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBBF21D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avscC13O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBBF21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmpC-0001Kt-5o
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWu-0004ZY-A9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWr-0004L1-RQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YsBaT4DJHkqdygiSvDUVi/ykdYW4lCujueR9t1v3JVc=;
 b=avscC13Ol+pqrUVes5G3e7ts37Zzdp7B5A8wC6IRl6hXygo4pAr+q6scr37DHVaFnTHBfF
 3w/El2gK7oTHaXfYwcVbV+HCmBU4D6FAbiSTq7yo0zg/zu1Mw2oyG0YaFVRbNs6u5g8KRM
 JmBJ9C/hxdiU1SXF8x8THOMelftKVsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-Dma4gezJPbyvSfJjcxVmxA-1; Fri, 25 Sep 2020 08:08:43 -0400
X-MC-Unique: Dma4gezJPbyvSfJjcxVmxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 888308030CD;
 Fri, 25 Sep 2020 12:08:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CD3A73695;
 Fri, 25 Sep 2020 12:08:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 26/26] virtiofsd: Add -o allow_direct_io|no_allow_direct_io
 options
Date: Fri, 25 Sep 2020 13:06:55 +0100
Message-Id: <20200925120655.295142-27-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
open flag of guest applications will be discarded by virtiofsd. While
this behavior makes it consistent with the virtio-9p scheme when guest
applications use direct I/O, we no longer have any chance to bypass the
host page cache.

Therefore, we add a flag 'allow_direct_io' to lo_data. If '-o
 no_allow_direct_io' option is added, or none of '-o allow_direct_io' or
 '-o no_allow_direct_io' is added, the 'allow_direct_io' will be set to
 0, and virtiofsd discards O_DIRECT as before. If '-o allow_direct_io'
is added to the starting command-line, 'allow_direct_io' will be set to
1, so that the O_DIRECT flags will be retained and host page cache can
be bypassed.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200824105957.61265-1-zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c         |  4 ++++
 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 7bc5d7dc5a..85770d63f1 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -178,6 +178,10 @@ void fuse_cmdline_help(void)
            "                               (0 leaves rlimit unchanged)\n"
            "                               default: min(1000000, fs.file-max - 16384)\n"
            "                                        if the current rlimit is lower\n"
+           "    -o allow_direct_io|no_allow_direct_io\n"
+           "                               retain/discard O_DIRECT flags passed down\n"
+           "                               to virtiofsd from guest applications.\n"
+           "                               default: no_allow_direct_io\n"
            );
 }
 
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 784330e0e4..0b229ebd57 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -151,6 +151,7 @@ struct lo_data {
     int timeout_set;
     int readdirplus_set;
     int readdirplus_clear;
+    int allow_direct_io;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
@@ -179,6 +180,8 @@ static const struct fuse_opt lo_opts[] = {
     { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
     { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
     { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
+    { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1 },
+    { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io), 0 },
     FUSE_OPT_END
 };
 static bool use_syslog = false;
@@ -1516,7 +1519,8 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
     fuse_reply_err(req, 0);
 }
 
-static void update_open_flags(int writeback, struct fuse_file_info *fi)
+static void update_open_flags(int writeback, int allow_direct_io,
+                              struct fuse_file_info *fi)
 {
     /*
      * With writeback cache, kernel may send read requests even
@@ -1541,10 +1545,13 @@ static void update_open_flags(int writeback, struct fuse_file_info *fi)
 
     /*
      * O_DIRECT in guest should not necessarily mean bypassing page
-     * cache on host as well. If somebody needs that behavior, it
-     * probably should be a configuration knob in daemon.
+     * cache on host as well. Therefore, we discard it by default
+     * ('-o no_allow_direct_io'). If somebody needs that behavior,
+     * the '-o allow_direct_io' option should be set.
      */
-    fi->flags &= ~O_DIRECT;
+    if (!allow_direct_io) {
+        fi->flags &= ~O_DIRECT;
+    }
 }
 
 static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -1576,7 +1583,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
         goto out;
     }
 
-    update_open_flags(lo->writeback, fi);
+    update_open_flags(lo->writeback, lo->allow_direct_io, fi);
 
     fd = openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOLLOW,
                 mode);
@@ -1786,7 +1793,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
     fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino,
              fi->flags);
 
-    update_open_flags(lo->writeback, fi);
+    update_open_flags(lo->writeback, lo->allow_direct_io, fi);
 
     sprintf(buf, "%i", lo_fd(req, ino));
     fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
@@ -2823,6 +2830,7 @@ int main(int argc, char *argv[])
         .debug = 0,
         .writeback = 0,
         .posix_lock = 0,
+        .allow_direct_io = 0,
         .proc_self_fd = -1,
     };
     struct lo_map_elem *root_elem;
-- 
2.26.2


