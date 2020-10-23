Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48592C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBBF20795
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S32JTRw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBBF20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0U2-0005Xt-Bt
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW0Oo-0001NG-Ht
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW0Oi-0005A6-Ie
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603472311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSDWjWEqs/z+Rjo4H/tYL8xvBGokWHXRX6SfnwxYerI=;
 b=S32JTRw6iXw2SLsKCRZjLA9hz1sUHByXNWmeiULP5bHXBa7ZmfOFXcyvuLgc5se6gicI4X
 TV6TXSA1ChI5YhBM/W3/dMVT84AejqLNSXrTnKJ4gvZ8rwDnskPjvLuiKCbXOpYv0+ycuU
 smX5QMA12CfbSl+VIFbbYfPzL6VaSgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-_YQYOpO-P1y1GsNrOUzcoA-1; Fri, 23 Oct 2020 12:58:29 -0400
X-MC-Unique: _YQYOpO-P1y1GsNrOUzcoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78122805EF8
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 16:58:28 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44DC810013D7;
 Fri, 23 Oct 2020 16:58:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 dinechin@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v4 2/5] tools/virtiofsd: xattr name mappings: Map client xattr
 names
Date: Fri, 23 Oct 2020 17:58:09 +0100
Message-Id: <20201023165812.36028-3-dgilbert@redhat.com>
In-Reply-To: <20201023165812.36028-1-dgilbert@redhat.com>
References: <20201023165812.36028-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Map xattr names originating at the client; from get/set/remove xattr.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 101 ++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index d47fe3db31..ec3ef7b50d 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2176,20 +2176,80 @@ static void parse_xattrmap(struct lo_data *lo)
     }
 }
 
-static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
+/*
+ * For use with getxattr/setxattr/removexattr, where the client
+ * gives us a name and we may need to choose a different one.
+ * Allocates a buffer for the result placing it in *out_name.
+ *   If there's no change then *out_name is not set.
+ * Returns 0 on success
+ * Can return -EPERM to indicate we block a given attribute
+ *   (in which case out_name is not allocated)
+ * Can return -ENOMEM to indicate out_name couldn't be allocated.
+ */
+static int xattr_map_client(const struct lo_data *lo, const char *client_name,
+                            char **out_name)
+{
+    size_t i;
+    for (i = 0; i < lo->xattr_map_nentries; i++) {
+        const XattrMapEntry *cur_entry = lo->xattr_map_list + i;
+
+        if ((cur_entry->flags & XATTR_MAP_FLAG_CLIENT) &&
+            (strstart(client_name, cur_entry->key, NULL))) {
+            if (cur_entry->flags & XATTR_MAP_FLAG_BAD) {
+                return -EPERM;
+            }
+            if (cur_entry->flags & XATTR_MAP_FLAG_OK) {
+                /* Unmodified name */
+                return 0;
+            }
+            if (cur_entry->flags & XATTR_MAP_FLAG_PREFIX) {
+                *out_name = g_try_malloc(strlen(client_name) +
+                                         strlen(cur_entry->prepend) + 1);
+                if (!*out_name) {
+                    return -ENOMEM;
+                }
+                sprintf(*out_name, "%s%s", cur_entry->prepend, client_name);
+                return 0;
+            }
+        }
+    }
+
+    return -EPERM;
+}
+
+static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *in_name,
                         size_t size)
 {
     struct lo_data *lo = lo_data(req);
     char *value = NULL;
     char procname[64];
+    const char *name;
+    char *mapped_name;
     struct lo_inode *inode;
     ssize_t ret;
     int saverr;
     int fd = -1;
 
+    mapped_name = NULL;
+    name = in_name;
+    if (lo->xattrmap) {
+        ret = xattr_map_client(lo, in_name, &mapped_name);
+        if (ret < 0) {
+            if (ret == -EPERM) {
+                ret = -ENODATA;
+            }
+            fuse_reply_err(req, -ret);
+            return;
+        }
+        if (mapped_name) {
+            name = mapped_name;
+        }
+    }
+
     inode = lo_inode(req, ino);
     if (!inode) {
         fuse_reply_err(req, EBADF);
+        g_free(mapped_name);
         return;
     }
 
@@ -2254,6 +2314,7 @@ out_err:
     saverr = errno;
 out:
     fuse_reply_err(req, saverr);
+    g_free(mapped_name);
     goto out_free;
 }
 
@@ -2331,19 +2392,35 @@ out:
     goto out_free;
 }
 
-static void lo_setxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
+static void lo_setxattr(fuse_req_t req, fuse_ino_t ino, const char *in_name,
                         const char *value, size_t size, int flags)
 {
     char procname[64];
+    const char *name;
+    char *mapped_name;
     struct lo_data *lo = lo_data(req);
     struct lo_inode *inode;
     ssize_t ret;
     int saverr;
     int fd = -1;
 
+    mapped_name = NULL;
+    name = in_name;
+    if (lo->xattrmap) {
+        ret = xattr_map_client(lo, in_name, &mapped_name);
+        if (ret < 0) {
+            fuse_reply_err(req, -ret);
+            return;
+        }
+        if (mapped_name) {
+            name = mapped_name;
+        }
+    }
+
     inode = lo_inode(req, ino);
     if (!inode) {
         fuse_reply_err(req, EBADF);
+        g_free(mapped_name);
         return;
     }
 
@@ -2378,21 +2455,38 @@ out:
     }
 
     lo_inode_put(lo, &inode);
+    g_free(mapped_name);
     fuse_reply_err(req, saverr);
 }
 
-static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *name)
+static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *in_name)
 {
     char procname[64];
+    const char *name;
+    char *mapped_name;
     struct lo_data *lo = lo_data(req);
     struct lo_inode *inode;
     ssize_t ret;
     int saverr;
     int fd = -1;
 
+    mapped_name = NULL;
+    name = in_name;
+    if (lo->xattrmap) {
+        ret = xattr_map_client(lo, in_name, &mapped_name);
+        if (ret < 0) {
+            fuse_reply_err(req, -ret);
+            return;
+        }
+        if (mapped_name) {
+            name = mapped_name;
+        }
+    }
+
     inode = lo_inode(req, ino);
     if (!inode) {
         fuse_reply_err(req, EBADF);
+        g_free(mapped_name);
         return;
     }
 
@@ -2427,6 +2521,7 @@ out:
     }
 
     lo_inode_put(lo, &inode);
+    g_free(mapped_name);
     fuse_reply_err(req, saverr);
 }
 
-- 
2.28.0


