Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B541ACA9EB7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3D621929
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3D621929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFep-0007mN-KW
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iNFao-0004N5-CP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iNFal-0004gW-Vq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:18:21 -0400
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:29449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iNFak-0004S8-Lb
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:18:19 -0400
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by
 mgwkm02.jp.fujitsu.com with smtp
 id 15b5_42ff_ccf113f5_d6ac_4027_b146_fbd2a933b416;
 Wed, 23 Oct 2019 21:18:00 +0900
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id B17D3AC00CB
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 21:17:59 +0900 (JST)
Received: from g01jpexchyt36.g01.fujitsu.local (unknown [10.128.193.4])
 by g01jpfmpwyt02.exch.g01.fujitsu.local (Postfix) with ESMTP id C35C7298027;
 Wed, 23 Oct 2019 21:17:58 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt36.g01.fujitsu.local (10.128.193.54) with Microsoft SMTP Server id
 14.3.439.0; Wed, 23 Oct 2019 21:17:59 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <virtio-fs@redhat.com>
Subject: [PATCH] virtiofsd: Fix data corruption with O_APPEND wirte in
 writeback mode
Date: Wed, 23 Oct 2019 21:25:23 +0900
Message-ID: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.169
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
Cc: qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When writeback mode is enabled (-o writeback), O_APPEND handling is
done in kernel. Therefore virtiofsd clears O_APPEND flag when open.
Otherwise O_APPEND flag takes precedence over pwrite() and write
data may corrupt.

Currently clearing O_APPEND flag is done in lo_open(), but we also
need the same operation in lo_create(). So, factor out the flag
update operation in lo_open() to update_open_flags() and call it
in both lo_open() and lo_create().

This fixes the failure of xfstest generic/069 in writeback mode
(which tests O_APPEND write data integrity).

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 contrib/virtiofsd/passthrough_ll.c | 56 +++++++++++++++---------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
index e8892c3c32..79fb78ecce 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1733,6 +1733,32 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info
 	fuse_reply_err(req, 0);
 }
 
+static void update_open_flags(int writeback, struct fuse_file_info *fi)
+{
+	/* With writeback cache, kernel may send read requests even
+	   when userspace opened write-only */
+	if (writeback && (fi->flags & O_ACCMODE) == O_WRONLY) {
+		fi->flags &= ~O_ACCMODE;
+		fi->flags |= O_RDWR;
+	}
+
+	/* With writeback cache, O_APPEND is handled by the kernel.
+	   This breaks atomicity (since the file may change in the
+	   underlying filesystem, so that the kernel's idea of the
+	   end of the file isn't accurate anymore). In this example,
+	   we just accept that. A more rigorous filesystem may want
+	   to return an error here */
+	if (writeback && (fi->flags & O_APPEND))
+		fi->flags &= ~O_APPEND;
+
+	/*
+	 * O_DIRECT in guest should not necessarily mean bypassing page
+	 * cache on host as well. If somebody needs that behavior, it
+	 * probably should be a configuration knob in daemon.
+	 */
+	fi->flags &= ~O_DIRECT;
+}
+
 static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
 		      mode_t mode, struct fuse_file_info *fi)
 {
@@ -1760,12 +1786,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
 	if (err)
 		goto out;
 
-	/*
-	 * O_DIRECT in guest should not necessarily mean bypassing page
-	 * cache on host as well. If somebody needs that behavior, it
-	 * probably should be a configuration knob in daemon.
-	 */
-	fi->flags &= ~O_DIRECT;
+	update_open_flags(lo->writeback, fi);
 
 	fd = openat(parent_inode->fd, name,
 		    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
@@ -1966,28 +1987,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
 
 	fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino, fi->flags);
 
-	/* With writeback cache, kernel may send read requests even
-	   when userspace opened write-only */
-	if (lo->writeback && (fi->flags & O_ACCMODE) == O_WRONLY) {
-		fi->flags &= ~O_ACCMODE;
-		fi->flags |= O_RDWR;
-	}
-
-	/* With writeback cache, O_APPEND is handled by the kernel.
-	   This breaks atomicity (since the file may change in the
-	   underlying filesystem, so that the kernel's idea of the
-	   end of the file isn't accurate anymore). In this example,
-	   we just accept that. A more rigorous filesystem may want
-	   to return an error here */
-	if (lo->writeback && (fi->flags & O_APPEND))
-		fi->flags &= ~O_APPEND;
-
-	/*
-	 * O_DIRECT in guest should not necessarily mean bypassing page
-	 * cache on host as well. If somebody needs that behavior, it
-	 * probably should be a configuration knob in daemon.
-	 */
-	fi->flags &= ~O_DIRECT;
+	update_open_flags(lo->writeback, fi);
 
 	sprintf(buf, "%i", lo_fd(req, ino));
 	fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
-- 
2.21.0


