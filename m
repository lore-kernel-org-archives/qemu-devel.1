Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50CCC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2832080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVJxIGa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2832080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG54l-0001QZ-Bq
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51r-0005yw-0n
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51p-0007SL-F5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599676868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nh0FPSe4hR16BIoT/N4xYTXt5vkDFlUFUIGOhNvTSeI=;
 b=bVJxIGa/7KsWqzYC62toP4Fsw+3JH84DMbhflW/KbTRsOKiHQ4oS6V2GT+twXeAoODDFcV
 iZgbzAr3GIvPop8H5/FGXrdsXVSXrOQ4z4Vfa6yW1Utu0s7OW7qJNDBjXHRca7m5suCU/H
 M2DnnuOZTiE26hUaWS0YpEzImtMZkjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-cn6qZ8zrMl6JqWeBZOb9_Q-1; Wed, 09 Sep 2020 14:41:06 -0400
X-MC-Unique: cn6qZ8zrMl6JqWeBZOb9_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E94FC80EF8A
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 18:41:05 +0000 (UTC)
Received: from localhost (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC2A860BEC;
 Wed,  9 Sep 2020 18:40:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] virtiofsd: Store every lo_inode's parent_dev
Date: Wed,  9 Sep 2020 20:40:25 +0200
Message-Id: <20200909184028.262297-6-mreitz@redhat.com>
In-Reply-To: <20200909184028.262297-1-mreitz@redhat.com>
References: <20200909184028.262297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
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

We want to detect mount points in the shared tree.  We report them to
the guest by setting the FUSE_ATTR_SUBMOUNT flag in fuse_attr.flags, but
because the FUSE client will create a submount for every directory that
has this flag set, we must do this only for the actual mount points.

We can detect mount points by comparing a directory's st_dev with its
parent's st_dev.  To be able to do so, we need to store the parent's
st_dev in the lo_inode object.

Note that mount points need not necessarily be directories; a single
file can be a mount point as well.  However, for the sake of simplicity
let us ignore any non-directory mount points for now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 784330e0e4..2c48c03b4c 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -124,6 +124,14 @@ struct lo_inode {
     GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
 
     mode_t filetype;
+
+    /*
+     * So we can detect crossmount roots
+     * (As such, this only needs to be valid for directories.  Note
+     * that files can have multiple parents due to hard links, and so
+     * their parent_dev may fluctuate.)
+     */
+    dev_t parent_dev;
 };
 
 struct lo_cred {
@@ -821,6 +829,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         g_hash_table_insert(lo->inodes, &inode->key, inode);
         pthread_mutex_unlock(&lo->mutex);
     }
+    inode->parent_dev = dir->key.dev;
     e->ino = inode->fuse_ino;
     lo_inode_put(lo, &inode);
     lo_inode_put(lo, &dir);
@@ -1047,6 +1056,14 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
     fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n", (unsigned long long)parent,
              name, (unsigned long long)e.ino);
 
+    /*
+     * No need to update inode->parent_dev, because
+     * (1) We cannot, the inode now has more than one parent,
+     * (2) Directories cannot have more than one parent, so link()
+     *     does not work for them; but parent_dev only needs to be
+     *     valid for directories.
+     */
+
     fuse_reply_entry(req, &e);
     lo_inode_put(lo, &parent_inode);
     lo_inode_put(lo, &inode);
-- 
2.26.2


