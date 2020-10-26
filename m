Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA2C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E32A2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKH+sEKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E32A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7dz-0005d0-3A
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7Tb-0002cK-KM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TZ-0003cP-R7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603737852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oc+dmUX2To63s+lZkfkb1mzuLK1KZe6J4nW/upXzUv0=;
 b=eKH+sEKuIOwBc8ZOeXAJBI6l3khCj9NulmPKb4QfSFhjgIuLl+w2fnSdEqnHrAbor/kHin
 SZi4OIKiUQH5zLKPKVwces+hUBMFovXCv+Xb64033HPtf2P1nrHHiYGinMq4U35UvL7ET/
 wN09kjLC50Xj18P9K80gNBMOVlYhPeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-rsQDjw4vOfGYC0ZpcjAiUQ-1; Mon, 26 Oct 2020 14:44:10 -0400
X-MC-Unique: rsQDjw4vOfGYC0ZpcjAiUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDFE7803F4F;
 Mon, 26 Oct 2020 18:44:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 779C15D9CA;
 Mon, 26 Oct 2020 18:44:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 misono.tomohiro@jp.fujitsu.com
Subject: [PULL 13/16] virtiofsd: Store every lo_inode's parent_dev
Date: Mon, 26 Oct 2020 18:43:28 +0000
Message-Id: <20201026184331.272953-14-dgilbert@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: virtio-fs@redhat.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

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
Message-Id: <20200909184028.262297-6-mreitz@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index a0beb986f3..4188bf3ad2 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -125,6 +125,14 @@ struct lo_inode {
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
@@ -847,6 +855,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         g_hash_table_insert(lo->inodes, &inode->key, inode);
         pthread_mutex_unlock(&lo->mutex);
     }
+    inode->parent_dev = dir->key.dev;
     e->ino = inode->fuse_ino;
     lo_inode_put(lo, &inode);
     lo_inode_put(lo, &dir);
@@ -1073,6 +1082,14 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
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
2.28.0


