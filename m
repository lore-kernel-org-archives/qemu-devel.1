Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75710C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FB821D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByEXoCba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FB821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iui4D-0003AC-6T
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdO-0004Nd-6S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdN-0006F2-2y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdM-0006Ej-W2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tel/nd2zE/ZyJVWTivJ5OAyTm2pwU+ekwsLBhz3zxc=;
 b=ByEXoCbaYMnaF8fXUC3LnppZ5XFjfSh+K2UZ1fG/LsCxTzUzP1P5lzBLrdVfgQ1lqfzrnS
 o8Und7VUy9WdqcvCzdbpPKpYgh5GX+Bziph17Z/5/6pPpoHWfhjKQcK1A33rZwnzZRXjzQ
 BlvjE0vEujUVWfbBfWioPYD3g4uIxdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-TNwM0dhHOyWLOBjQn-q-Ww-1; Thu, 23 Jan 2020 11:47:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C44F78C7AD2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:04 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D21C28991;
 Thu, 23 Jan 2020 16:47:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 015/108] virtiofsd: Make fsync work even if only inode is
 passed in
Date: Thu, 23 Jan 2020 16:44:57 +0000
Message-Id: <20200123164630.91498-16-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TNwM0dhHOyWLOBjQn-q-Ww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

From: Vivek Goyal <vgoyal@redhat.com>

If caller has not sent file handle in request, then using inode, retrieve
the fd opened using O_PATH and use that to open file again and issue
fsync. This will be needed when dax_flush() calls fsync. At that time
we only have inode information (and not file).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c  |  6 +++++-
 tools/virtiofsd/passthrough_ll.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 514d79cb24..8552cfb8af 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1075,7 +1075,11 @@ static void do_fsync(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
     fi.fh =3D arg->fh;
=20
     if (req->se->op.fsync) {
-        req->se->op.fsync(req, nodeid, datasync, &fi);
+        if (fi.fh =3D=3D (uint64_t)-1) {
+            req->se->op.fsync(req, nodeid, datasync, NULL);
+        } else {
+            req->se->op.fsync(req, nodeid, datasync, &fi);
+        }
     } else {
         fuse_reply_err(req, ENOSYS);
     }
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 6c4da18075..26ac87013b 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -903,10 +903,34 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino, =
int datasync,
 {
     int res;
     (void)ino;
+    int fd;
+    char *buf;
+
+    fuse_log(FUSE_LOG_DEBUG, "lo_fsync(ino=3D%" PRIu64 ", fi=3D0x%p)\n", i=
no,
+             (void *)fi);
+
+    if (!fi) {
+        res =3D asprintf(&buf, "/proc/self/fd/%i", lo_fd(req, ino));
+        if (res =3D=3D -1) {
+            return (void)fuse_reply_err(req, errno);
+        }
+
+        fd =3D open(buf, O_RDWR);
+        free(buf);
+        if (fd =3D=3D -1) {
+            return (void)fuse_reply_err(req, errno);
+        }
+    } else {
+        fd =3D fi->fh;
+    }
+
     if (datasync) {
-        res =3D fdatasync(fi->fh);
+        res =3D fdatasync(fd);
     } else {
-        res =3D fsync(fi->fh);
+        res =3D fsync(fd);
+    }
+    if (!fi) {
+        close(fd);
     }
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
--=20
2.24.1


