Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F04C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E0B2087D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="xuDUfWKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E0B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAAEe-0004G3-Bf
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kAADb-00031s-U9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:00:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kAADU-000630-7r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:00:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id p15so488370pli.6
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sU/Kh8iXRyrB08qIeRaZSK9NbEbPtPjaRnwRZAPg+FQ=;
 b=xuDUfWKFArUFUT027dSdDi8xXBsBMQpPY3jpgqREyDVV1PtkzrzFmOpSuK9Le1M9kJ
 CqgXsiiKaAbDcrToIGP468O7UUJ8tav+Oo1oUo8IShw3Zi1wvo383Gzto6RO3Enm41mg
 6JdeCZv319GhexmNmiK9//+IXJHHvOXYnfIIE9lYmytQgfwHMki/+2ZyAk9jpy/Rh2r5
 2G0L5ILmK1zoBx1xVa0MirG94Exve4IOoGz+mtOE3XBlLzfXV3FxVSemixIsCYiJfkKc
 tjtjngpw1p0OxR18TNx/pz1b04UaVDzAPE79l/yOV8ALnO7PVgOBs1J2dy2m4Jyu6dSY
 Zmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sU/Kh8iXRyrB08qIeRaZSK9NbEbPtPjaRnwRZAPg+FQ=;
 b=F3dbEnglEc5fWBrJNEuCSktMKnhJFNUFEOP2iOZKA4/NAGgl0D4Z2zwhZgJUO+1QEq
 TR94AoStB4T6lvjj0uKJ37bouiyz6brT+cLkrxd/Mzp165n99Bf5sMPqjSmDROvACdhy
 YRcA0o6YYjiGUvBlIQGqPkEEaECgPIxDWDyE7YDYyb+Pgu+pr80ME2IzymCWhz2fjrhq
 YTTHoTUCGnABuqhoLgseQH28lPZ9n2ACLpuH6lF+Ez1D5KqGgqDy3O7jiNQBkgXLD9Qr
 B2HCtbFwxuBqzlbaCmoHck+MHNO6kD1UeFB5T3q2slFbGxJwTwB21ZQgCay4Hop8xQR8
 cpLQ==
X-Gm-Message-State: AOAM5324UKUajA9adnvExbAlKwrp0Gh2NSxCtZOQiJGfEbPR8YG05Ny7
 ZQNxy7l9sjs/FK8dYV1KwDATWQ==
X-Google-Smtp-Source: ABdhPJzCcu4nmWt0u4z3CoeEKtU/VG5LUuemUpUGStZ6+DSDbQ2g8gVPAsZXalzp0HG8oqRKPD6ysA==
X-Received: by 2002:a17:902:7c12:: with SMTP id
 x18mr3384783pll.227.1598266841245; 
 Mon, 24 Aug 2020 04:00:41 -0700 (PDT)
Received: from C02CW2YLMD6R.bytedance.net ([61.120.150.73])
 by smtp.gmail.com with ESMTPSA id q2sm11069995pff.107.2020.08.24.04.00.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2020 04:00:40 -0700 (PDT)
From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] virtiofsd: Add -o allow_direct_io|no_allow_direct_io
 options
Date: Mon, 24 Aug 2020 18:59:57 +0800
Message-Id: <20200824105957.61265-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Yongji Xie <xieyongji@bytedance.com>,
 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 tools/virtiofsd/helper.c         |  4 ++++
 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 3105b6c23a..45b310ff3c 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
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
index 94e0de2d2b..c1ae897b77 100644
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
@@ -2824,6 +2831,7 @@ int main(int argc, char *argv[])
         .debug = 0,
         .writeback = 0,
         .posix_lock = 1,
+        .allow_direct_io = 0,
         .proc_self_fd = -1,
     };
     struct lo_map_elem *root_elem;
-- 
2.11.0


