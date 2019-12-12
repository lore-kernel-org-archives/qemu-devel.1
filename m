Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8D4214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwH0tSZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8D4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifStU-0007sw-1v
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX6-0007u3-Jd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX5-0004y0-B9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRX5-0004xE-6k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFOhaz/MIcdwLDvYiOYmdxgGOZ3sAEj21IFcioo4jZg=;
 b=GwH0tSZXdUHY/OTxNqcdCz4738abE4IdDDZ3grfYV4Za+it32mv2JGa4oL4QwnY3WwfxxP
 +8ZNn6+2eghlwdI/vyPlsB+WIePM/rGrZjdeQ+cjZIlHEkwJabnI6egde6AhYNbi1sF9kU
 h/my1c+yL1+cuSS1t+FgwM22wFITNTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-tqVVDFvhMByITLglbkjlGg-1; Thu, 12 Dec 2019 11:41:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FD7D100551A
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5F2B60BE1;
 Thu, 12 Dec 2019 16:41:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 097/104] virtiofsd: Fix data corruption with O_APPEND wirte in
 writeback mode
Date: Thu, 12 Dec 2019 16:38:57 +0000
Message-Id: <20191212163904.159893-98-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tqVVDFvhMByITLglbkjlGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

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
 tools/virtiofsd/passthrough_ll.c | 66 ++++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 6b3d396b6f..1bf251a91d 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1676,6 +1676,37 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t=
 ino,
     fuse_reply_err(req, 0);
 }
=20
+static void update_open_flags(int writeback, struct fuse_file_info *fi)
+{
+    /*
+     * With writeback cache, kernel may send read requests even
+     * when userspace opened write-only
+     */
+    if (writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
+        fi->flags &=3D ~O_ACCMODE;
+        fi->flags |=3D O_RDWR;
+    }
+
+    /*
+     * With writeback cache, O_APPEND is handled by the kernel.
+     * This breaks atomicity (since the file may change in the
+     * underlying filesystem, so that the kernel's idea of the
+     * end of the file isn't accurate anymore). In this example,
+     * we just accept that. A more rigorous filesystem may want
+     * to return an error here
+     */
+    if (writeback && (fi->flags & O_APPEND)) {
+        fi->flags &=3D ~O_APPEND;
+    }
+
+    /*
+     * O_DIRECT in guest should not necessarily mean bypassing page
+     * cache on host as well. If somebody needs that behavior, it
+     * probably should be a configuration knob in daemon.
+     */
+    fi->flags &=3D ~O_DIRECT;
+}
+
 static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
                       mode_t mode, struct fuse_file_info *fi)
 {
@@ -1705,12 +1736,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
         goto out;
     }
=20
-    /*
-     * O_DIRECT in guest should not necessarily mean bypassing page
-     * cache on host as well. If somebody needs that behavior, it
-     * probably should be a configuration knob in daemon.
-     */
-    fi->flags &=3D ~O_DIRECT;
+    update_open_flags(lo->writeback, fi);
=20
     fd =3D openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOL=
LOW,
                 mode);
@@ -1920,33 +1946,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
     fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n", i=
no,
              fi->flags);
=20
-    /*
-     * With writeback cache, kernel may send read requests even
-     * when userspace opened write-only
-     */
-    if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
-        fi->flags &=3D ~O_ACCMODE;
-        fi->flags |=3D O_RDWR;
-    }
-
-    /*
-     * With writeback cache, O_APPEND is handled by the kernel.
-     * This breaks atomicity (since the file may change in the
-     * underlying filesystem, so that the kernel's idea of the
-     * end of the file isn't accurate anymore). In this example,
-     * we just accept that. A more rigorous filesystem may want
-     * to return an error here
-     */
-    if (lo->writeback && (fi->flags & O_APPEND)) {
-        fi->flags &=3D ~O_APPEND;
-    }
-
-    /*
-     * O_DIRECT in guest should not necessarily mean bypassing page
-     * cache on host as well. If somebody needs that behavior, it
-     * probably should be a configuration knob in daemon.
-     */
-    fi->flags &=3D ~O_DIRECT;
+    update_open_flags(lo->writeback, fi);
=20
     sprintf(buf, "%i", lo_fd(req, ino));
     fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
--=20
2.23.0


