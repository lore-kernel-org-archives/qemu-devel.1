Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23530C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25FB206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TA0xeA2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25FB206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx3w-0006VE-B1
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwx5-00051o-Ny
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwx4-00060k-3s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwx3-0005z8-T5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLOks+qv1M1T2afZOLBNYfeBUjGSG7lcEpu4Yb4Mnlw=;
 b=TA0xeA2qX+PIH2Yb80N14721Vux3ciyCz6Hx1GincMwD3Djo9RiVSJykjPo8W3f7JM9d9p
 OA2PWcfasHylkzIiW9Z5bFCww7fEniSECA0av07Hn8wm5krsY/9Sj0KRKy2Fq0CUA+ahcP
 rUSxmqSoWMj4rmpCpPvqe5V8xxWp1tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-CFEpgPflN42VzCjv0B6mBg-1; Thu, 19 Dec 2019 09:38:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8B82800D50;
 Thu, 19 Dec 2019 14:38:47 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9E6F5D9E2;
 Thu, 19 Dec 2019 14:38:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 06/18] fuse: (Partially) implement fallocate()
Date: Thu, 19 Dec 2019 15:38:06 +0100
Message-Id: <20191219143818.1646168-7-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CFEpgPflN42VzCjv0B6mBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows allocating areas after the EOF, writing zeroes, and
discarding.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/fuse.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/block/fuse.c b/block/fuse.c
index d7c7824815..018afee6cd 100644
--- a/block/fuse.c
+++ b/block/fuse.c
@@ -488,6 +488,84 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inod=
e, const char *buf,
     }
 }
=20
+/**
+ * Let clients perform various fallocate() operations.
+ */
+static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
+                           off_t offset, off_t length,
+                           struct fuse_file_info *fi)
+{
+    BdrvFuseSession *session =3D fuse_req_userdata(req);
+    int64_t blk_len;
+    int ret;
+
+    if (!session->writable) {
+        fuse_reply_err(req, EACCES);
+        return;
+    }
+
+    blk_len =3D blk_getlength(session->blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
+        return;
+    }
+
+    if (mode & FALLOC_FL_KEEP_SIZE) {
+        length =3D MIN(length, blk_len - offset);
+    }
+
+    if (mode & FALLOC_FL_PUNCH_HOLE) {
+        if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+            fuse_reply_err(req, EINVAL);
+            return;
+        }
+
+        do {
+            int size =3D MIN(length, BDRV_REQUEST_MAX_BYTES);
+
+            ret =3D blk_pdiscard(session->blk, offset, size);
+            length -=3D size;
+        } while (ret =3D=3D 0 && length > 0);
+    } else if (mode & FALLOC_FL_ZERO_RANGE) {
+        if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + length > blk_len) {
+            ret =3D fuse_do_truncate(session, offset + length, PREALLOC_MO=
DE_OFF);
+            if (ret < 0) {
+                fuse_reply_err(req, -ret);
+                return;
+            }
+        }
+
+        do {
+            int size =3D MIN(length, BDRV_REQUEST_MAX_BYTES);
+
+            ret =3D blk_pwrite_zeroes(session->blk,
+                                    offset, size, 0);
+            length -=3D size;
+        } while (ret =3D=3D 0 && length > 0);
+    } else if (!mode) {
+        /* We can only fallocate at the EOF with a truncate */
+        if (offset < blk_len) {
+            fuse_reply_err(req, EOPNOTSUPP);
+            return;
+        }
+
+        if (offset > blk_len) {
+            /* No preallocation needed here */
+            ret =3D fuse_do_truncate(session, offset, PREALLOC_MODE_OFF);
+            if (ret < 0) {
+                fuse_reply_err(req, -ret);
+                return;
+            }
+        }
+
+        ret =3D fuse_do_truncate(session, offset + length, PREALLOC_MODE_F=
ALLOC);
+    } else {
+        ret =3D -EOPNOTSUPP;
+    }
+
+    fuse_reply_err(req, ret < 0 ? -ret : 0);
+}
+
 /**
  * Let clients flush the exported image.
  */
@@ -508,5 +586,6 @@ static const struct fuse_lowlevel_ops fuse_ops =3D {
     .open       =3D fuse_open,
     .read       =3D fuse_read,
     .write      =3D fuse_write,
+    .fallocate  =3D fuse_fallocate,
     .flush      =3D fuse_flush,
 };
--=20
2.23.0


