Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94395C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431E5222BA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5Ffo3WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431E5222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZca8-0000bi-B3
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZcYo-0007cu-Ru
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZcYm-0007Yw-TJ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604333996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cb9eigB01K0h9pef671lAJN9aVVE2X1PhLZNZ7RoqM=;
 b=K5Ffo3WSRiQwUAhykYlkeBFBStZAU500+D96wqLlEKDPPYGiuYj82YhtN8HHxIcMSkNdcr
 pTBiT2bKayJ49SrqL2fM76KRivT1tfUmY8Coyi4fNt6v0AONZN1XUE4ytRE0nQlL2Q3ok1
 pR/gLFPm0GvwkjdfQ4jQKyN9esRYYcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-LVlDYdjbO1Wt2NiC2IZnKA-1; Mon, 02 Nov 2020 11:19:53 -0500
X-MC-Unique: LVlDYdjbO1Wt2NiC2IZnKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 891111016CE4
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 16:19:47 +0000 (UTC)
Received: from localhost (unknown [10.40.194.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FF485D9DD;
 Mon,  2 Nov 2020 16:19:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] virtiofsd: Announce sub-mount points
Date: Mon,  2 Nov 2020 17:18:57 +0100
Message-Id: <20201102161859.156603-6-mreitz@redhat.com>
In-Reply-To: <20201102161859.156603-1-mreitz@redhat.com>
References: <20201102161859.156603-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Whenever we encounter a directory with an st_dev or mount ID that
differs from that of its parent, we set the FUSE_ATTR_SUBMOUNT flag so
the guest can create a submount for it.

We only need to do so in lo_do_lookup().  The following functions return
a fuse_attr object:
- lo_create(), though fuse_reply_create(): Calls lo_do_lookup().
- lo_lookup(), though fuse_reply_entry(): Calls lo_do_lookup().
- lo_mknod_symlink(), through fuse_reply_entry(): Calls lo_do_lookup().
- lo_link(), through fuse_reply_entry(): Creating a link cannot create a
  submount, so there is no need to check for it.
- lo_getattr(), through fuse_reply_attr(): Announcing submounts when the
  node is first detected (at lookup) is sufficient.  We do not need to
  return the submount attribute later.
- lo_do_readdir(), through fuse_add_direntry_plus(): Calls
  lo_do_lookup().

Make announcing submounts optional, so submounts are only announced to
the guest with the announce_submounts option.  Some users may prefer the
current behavior, so that the guest learns nothing about the host mount
structure.

(announce_submounts is force-disabled when the guest does not present
the FUSE_SUBMOUNTS capability, or when there is no statx().)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/helper.c         |  1 +
 tools/virtiofsd/passthrough_ll.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 2e181a49b5..4433724d3a 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -190,6 +190,7 @@ void fuse_cmdline_help(void)
            "                               retain/discard O_DIRECT flags passed down\n"
            "                               to virtiofsd from guest applications.\n"
            "                               default: no_allow_direct_io\n"
+           "    -o announce_submounts      Announce sub-mount points to the guest\n"
            );
 }
 
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 34d107975f..ec1008bceb 100644
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
@@ -167,6 +168,7 @@ struct lo_data {
     int readdirplus_set;
     int readdirplus_clear;
     int allow_direct_io;
+    int announce_submounts;
     bool use_statx;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
@@ -207,6 +209,7 @@ static const struct fuse_opt lo_opts[] = {
     { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
     { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1 },
     { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io), 0 },
+    { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
     FUSE_OPT_END
 };
 static bool use_syslog = false;
@@ -601,6 +604,20 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
         fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
         conn->want &= ~FUSE_CAP_READDIRPLUS;
     }
+
+    if (!(conn->capable & FUSE_CAP_SUBMOUNTS) && lo->announce_submounts) {
+        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submounts, client "
+                 "does not support it\n");
+        lo->announce_submounts = false;
+    }
+
+#ifndef CONFIG_STATX
+    if (lo->announce_submounts) {
+        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submounts, there "
+                 "is no statx()\n");
+        lo->announce_submounts = false;
+    }
+#endif
 }
 
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
@@ -877,6 +894,11 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         goto out_err;
     }
 
+    if (S_ISDIR(e->attr.st_mode) && lo->announce_submounts &&
+        (e->attr.st_dev != dir->key.dev || mnt_id != dir->key.mnt_id)) {
+        e->attr_flags |= FUSE_ATTR_SUBMOUNT;
+    }
+
     inode = lo_find(lo, &e->attr, mnt_id);
     if (inode) {
         close(newfd);
-- 
2.26.2


