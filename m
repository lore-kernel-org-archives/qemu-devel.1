Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE168C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F7B2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1YBOiQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F7B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG54I-0000dI-9r
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51c-0005TE-Sh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:40:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51b-0007Lx-4b
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599676854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iD3nU3q29aS+NTmVIJFCCkIEfzkuLj2dF9Y2ZbLAPos=;
 b=X1YBOiQD6eLxyQS3brne9RcitLtHe3jyHvBz/KNFQVKMZCbXVP0/uGFQEI0ZIYIOV8uTBi
 tTYZlrmaHj3I0XD4L3FremjprtcWI42m8pciVpX5xxLw2caAKgPz1n3aj6Dvp/A1WnNZ9q
 k5Kwkh6amJx3Zxt2YbkGGUxg4VHY0+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-RRXArTR_OmylrN2gsfeP4A-1; Wed, 09 Sep 2020 14:40:52 -0400
X-MC-Unique: RRXArTR_OmylrN2gsfeP4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1024B80EF8C
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 18:40:52 +0000 (UTC)
Received: from localhost (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3079719C78;
 Wed,  9 Sep 2020 18:40:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] virtiofsd: Announce FUSE_ATTR_FLAGS
Date: Wed,  9 Sep 2020 20:40:22 +0200
Message-Id: <20200909184028.262297-3-mreitz@redhat.com>
In-Reply-To: <20200909184028.262297-1-mreitz@redhat.com>
References: <20200909184028.262297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
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

The fuse_attr.flags field is currently just initialized to 0, which is
valid.  Thus, there is no reason not to always announce FUSE_ATTR_FLAGS
(when the kernel supports it).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tools/virtiofsd/fuse_common.h   | 8 ++++++++
 tools/virtiofsd/fuse_lowlevel.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 686c42c0a5..870544fe13 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -352,6 +352,14 @@ struct fuse_file_info {
  */
 #define FUSE_CAP_NO_OPENDIR_SUPPORT (1 << 24)
 
+/**
+ * Indicates that the client will provide fuse_attr.flags, and the kernel will
+ * interpret it.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_ATTR_FLAGS (1 << 27)
+
 /**
  * Ioctl flags
  *
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 2dd36ec03b..e9e2652d33 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1988,6 +1988,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
             bufsize = max_bufsize;
         }
     }
+    if (arg->flags & FUSE_ATTR_FLAGS) {
+        se->conn.capable |= FUSE_CAP_ATTR_FLAGS;
+    }
 #ifdef HAVE_SPLICE
 #ifdef HAVE_VMSPLICE
     se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
@@ -2014,6 +2017,7 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_DIO);
     LL_SET_DEFAULT(1, FUSE_CAP_IOCTL_DIR);
     LL_SET_DEFAULT(1, FUSE_CAP_ATOMIC_O_TRUNC);
+    LL_SET_DEFAULT(1, FUSE_CAP_ATTR_FLAGS);
     LL_SET_DEFAULT(se->op.write_buf, FUSE_CAP_SPLICE_READ);
     LL_SET_DEFAULT(se->op.getlk && se->op.setlk, FUSE_CAP_POSIX_LOCKS);
     LL_SET_DEFAULT(se->op.flock, FUSE_CAP_FLOCK_LOCKS);
@@ -2103,6 +2107,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     if (se->conn.want & FUSE_CAP_POSIX_ACL) {
         outarg.flags |= FUSE_POSIX_ACL;
     }
+    if (se->conn.want & FUSE_CAP_ATTR_FLAGS) {
+        outarg.flags |= FUSE_ATTR_FLAGS;
+    }
     outarg.max_readahead = se->conn.max_readahead;
     outarg.max_write = se->conn.max_write;
     if (se->conn.max_background >= (1 << 16)) {
-- 
2.26.2


