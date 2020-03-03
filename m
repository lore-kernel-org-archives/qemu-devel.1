Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC54C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3CF2083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY6V8Zhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3CF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99IE-00070u-6P
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j99HL-0005rC-Hk
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j99HK-0003y9-Ay
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:16:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j99HK-0003xf-7N
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583248573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mU8s4ys1nt2ELzadWGQ2bGhafm8XTPU7jusFyudg6w=;
 b=UY6V8Zhi21giDjYxRFuZ0kSmdvLWmpj09iwknkn7jqIescrmwVHaHNv7Z4Mc04D6fOeb/X
 QaGq17WVU3Moh1LYUm62Nw1sZtka3rDR45HF8f29vfyXULEyqrnEy6ZoABAVJDtla57JwI
 pfeAwdwjEoz0jjCPZyyqd5Xw8JeJ44Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-phz6DBJyMze_0BI62iekPg-1; Tue, 03 Mar 2020 10:16:11 -0500
X-MC-Unique: phz6DBJyMze_0BI62iekPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAEDE13E2
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 15:16:10 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-2.ams2.redhat.com
 [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B08290766
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 15:16:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] virtiofsd: passthrough_ll: cleanup getxattr/listxattr
Date: Tue,  3 Mar 2020 15:16:05 +0000
Message-Id: <20200303151606.108736-2-dgilbert@redhat.com>
In-Reply-To: <20200303151606.108736-1-dgilbert@redhat.com>
References: <20200303151606.108736-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

This is a cleanup patch to simplify the following xattr fix and
there is no functional changes.

- Move memory allocation to head of the function
- Unify fgetxattr/flistxattr call for both size =3D=3D 0 and
  size !=3D 0 case
- Remove redundant lo_inode_put call in error path
  (Note: second call is ignored now since @inode is already NULL)

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Message-Id: <20200227055927.24566-2-misono.tomohiro@jp.fujitsu.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 54 +++++++++++++-------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 02ff01fad0..4690a97947 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2195,34 +2195,30 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
         goto out;
     }
=20
+    if (size) {
+        value =3D malloc(size);
+        if (!value) {
+            goto out_err;
+        }
+    }
+
     sprintf(procname, "%i", inode->fd);
     fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
     if (fd < 0) {
         goto out_err;
     }
=20
+    ret =3D fgetxattr(fd, name, value, size);
+    if (ret =3D=3D -1) {
+        goto out_err;
+    }
     if (size) {
-        value =3D malloc(size);
-        if (!value) {
-            goto out_err;
-        }
-
-        ret =3D fgetxattr(fd, name, value, size);
-        if (ret =3D=3D -1) {
-            goto out_err;
-        }
         saverr =3D 0;
         if (ret =3D=3D 0) {
             goto out;
         }
-
         fuse_reply_buf(req, value, ret);
     } else {
-        ret =3D fgetxattr(fd, name, NULL, 0);
-        if (ret =3D=3D -1) {
-            goto out_err;
-        }
-
         fuse_reply_xattr(req, ret);
     }
 out_free:
@@ -2238,7 +2234,6 @@ out_free:
 out_err:
     saverr =3D errno;
 out:
-    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
     goto out_free;
 }
@@ -2273,34 +2268,30 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t=
 ino, size_t size)
         goto out;
     }
=20
+    if (size) {
+        value =3D malloc(size);
+        if (!value) {
+            goto out_err;
+        }
+    }
+
     sprintf(procname, "%i", inode->fd);
     fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
     if (fd < 0) {
         goto out_err;
     }
=20
+    ret =3D flistxattr(fd, value, size);
+    if (ret =3D=3D -1) {
+        goto out_err;
+    }
     if (size) {
-        value =3D malloc(size);
-        if (!value) {
-            goto out_err;
-        }
-
-        ret =3D flistxattr(fd, value, size);
-        if (ret =3D=3D -1) {
-            goto out_err;
-        }
         saverr =3D 0;
         if (ret =3D=3D 0) {
             goto out;
         }
-
         fuse_reply_buf(req, value, ret);
     } else {
-        ret =3D flistxattr(fd, NULL, 0);
-        if (ret =3D=3D -1) {
-            goto out_err;
-        }
-
         fuse_reply_xattr(req, ret);
     }
 out_free:
@@ -2316,7 +2307,6 @@ out_free:
 out_err:
     saverr =3D errno;
 out:
-    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
     goto out_free;
 }
--=20
2.24.1


