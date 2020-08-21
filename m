Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C266DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 04:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B0B2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 04:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="PTYX720r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B0B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ygX-0003Iz-O4
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 00:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1k8xxd-0005wE-Ga
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 23:43:25 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:32843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1k8xxZ-000627-8F
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 23:43:23 -0400
Received: by mail-pf1-x443.google.com with SMTP id u20so416098pfn.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 20:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8MbYl0w8KPtxHI8U8wqywGUi0NN1+rSEVLrdvNwORY=;
 b=PTYX720r7DYlco1P8EDjvJHsd6YugdddgJaOr7W5l+3q5hBleGDNYjT6e0044UGYiF
 SWmFdwp/j1BlS/no9aZV0zHuJSAtfYGvIMapke7U8s1bX7manTo7mZs2A9X+z0t8j0mh
 Zhot8YYwcxWRNq/32TH9IU2JVKIOspeZswjUHoVi0vJOtjUgvhTOWX9MzlpKAiLhpFrg
 fV8CcJN9fx5nygn72IqKrlFnSFuGoYQ7jJWUz2wOA3AGCKF+wOmZOuzaRJ6LdcngXrP2
 ZSuLZtzFo+VN+IX0NjgnyRnl/1MU6W6Lmz/azpk6o5/2tOKolYFiZnXaRkieHe/xjWXO
 CVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8MbYl0w8KPtxHI8U8wqywGUi0NN1+rSEVLrdvNwORY=;
 b=HB2JMRxEeKynQdTcUh8yMLTBNcsfI0LjBDbu/KaAd5x7GF/0nEvpu1deJ2atsivFfK
 eBJdutPk6z/ioiR39OpyTMvAtTD8EhUDbpPI1xxK0ib9IczB9nj8BKeXZJtqkBmR2duR
 vqNm++h9pAELXXQsFruFfx4H2yqOeTSDRB4svDDrcK4cma+SIF/7Wdz94GHrYgxFlrq4
 ctPQU8nG0JwyEvIblXEIvOtdgpGd/x4ohG24nJ3hM38HZfdtTGzi2BAuq4zLSkfvMDau
 KVW8xV9Do9C42+x0NRMdMrJArOCX+iy6KV3CBrYaEO3eMz1f4hs5NmhB4AIKbbAYYwJJ
 Rc0g==
X-Gm-Message-State: AOAM531EwmU6+/0rdScuhs3+roBIj2piiM/YJJelh+03KFUbNQH0kgJN
 q9oPTPsZf8Nvq/jAO/Ao4D9ELg==
X-Google-Smtp-Source: ABdhPJztgGrpoNM1K01qSU0nbUlqzg7nk8SX+07Vdrq5JTeQA74rjQtmJujYBxv4yMYxWRU61q9hhQ==
X-Received: by 2002:a65:614a:: with SMTP id o10mr892988pgv.411.1597981398311; 
 Thu, 20 Aug 2020 20:43:18 -0700 (PDT)
Received: from C02CW2YLMD6R.bytedance.net ([61.120.150.73])
 by smtp.gmail.com with ESMTPSA id lk16sm322447pjb.13.2020.08.20.20.43.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Aug 2020 20:43:17 -0700 (PDT)
From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtiofsd: add -o allow_directio|no_directio option
Date: Fri, 21 Aug 2020 11:41:26 +0800
Message-Id: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Aug 2020 00:29:02 -0400
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
applications using direct I/O, we no longer have any chance to bypass
the host page cache.

Therefore, we add a flag 'allow_directio' to lo_data. If '-o no_directio'
option is added, or none of '-o no_directio' or '-o allow_directio' is
added, the 'allow_directio' will be set to 0, and virtiofsd discards
O_DIRECT as before. If '-o allow_directio' is added to the stariting
command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
flags will be retained and host page cache can be bypassed.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 tools/virtiofsd/helper.c         |  4 ++++
 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 3105b6c23a..534ff52c64 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
            "                               (0 leaves rlimit unchanged)\n"
            "                               default: min(1000000, fs.file-max - 16384)\n"
            "                                        if the current rlimit is lower\n"
+           "    -o allow_directio|no_directio\n"
+           "                               retain/discard O_DIRECT flags passed down\n"
+           "                               to virtiofsd from guest applications.\n"
+           "                               default: no_directio\n"
            );
 }
 
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 94e0de2d2b..1c5ea27821 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -151,6 +151,7 @@ struct lo_data {
     int timeout_set;
     int readdirplus_set;
     int readdirplus_clear;
+    int allow_directio;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
@@ -179,6 +180,8 @@ static const struct fuse_opt lo_opts[] = {
     { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
     { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
     { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
+    { "allow_directio", offsetof(struct lo_data, allow_directio), 1 },
+    { "no_directio", offsetof(struct lo_data, allow_directio), 0 },
     FUSE_OPT_END
 };
 static bool use_syslog = false;
@@ -1516,7 +1519,8 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
     fuse_reply_err(req, 0);
 }
 
-static void update_open_flags(int writeback, struct fuse_file_info *fi)
+static void update_open_flags(int writeback, int allow_directio,
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
+     * ('-o no_directio'). If somebody needs that behavior, the
+     * '-o allow_directio' option should be set.
      */
-    fi->flags &= ~O_DIRECT;
+    if (!allow_directio) {
+        fi->flags &= ~O_DIRECT;
+    }
 }
 
 static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -1576,7 +1583,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
         goto out;
     }
 
-    update_open_flags(lo->writeback, fi);
+    update_open_flags(lo->writeback, lo->allow_directio, fi);
 
     fd = openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOLLOW,
                 mode);
@@ -1786,7 +1793,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
     fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino,
              fi->flags);
 
-    update_open_flags(lo->writeback, fi);
+    update_open_flags(lo->writeback, lo->allow_directio, fi);
 
     sprintf(buf, "%i", lo_fd(req, ino));
     fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
@@ -2824,6 +2831,7 @@ int main(int argc, char *argv[])
         .debug = 0,
         .writeback = 0,
         .posix_lock = 1,
+        .allow_directio = 0,
         .proc_self_fd = -1,
     };
     struct lo_map_elem *root_elem;
-- 
2.11.0


