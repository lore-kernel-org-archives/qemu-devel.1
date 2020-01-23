Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9BF2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPp/+ukh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9BF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudnI-00080z-1e
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAl-0004Fl-Iq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAj-0006d7-L0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52437
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAi-0006bJ-4R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gB1RSOX5RQcMIwg7eijdA5s/Ix1cF/u9GB6nvKLgVHA=;
 b=OPp/+ukhvbqKlr2mbRps72T6nHQVcpVXhraGGvKqp+MN5WkiTPNC7IDo3LVmzKKSnNYi1s
 Ph8T4yfxqgT+mR0m++fZ+H4O/6NOiUF+Da6lLyI7f/ZWYQ99anz2aX1aMesCp9AMsuZFPV
 lyZiFIkr42xSGNfGPEJ0DLKgHOJsL9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-g6n4aSmAOxOp8ChHkJtIbg-1; Thu, 23 Jan 2020 07:01:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A353118A6EC1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:01:10 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEBCF1CB;
 Thu, 23 Jan 2020 12:01:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 102/111] virtiofsd: add definition of fuse_buf_writev()
Date: Thu, 23 Jan 2020 11:58:32 +0000
Message-Id: <20200123115841.138849-103-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: g6n4aSmAOxOp8ChHkJtIbg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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

From: piaojun <piaojun@huawei.com>

Define fuse_buf_writev() which use pwritev and writev to improve io
bandwidth. Especially, the src bufs with 0 size should be skipped as
their mems are not *block_size* aligned which will cause writev failed
in direct io mode.

Signed-off-by: Jun Piao <piaojun@huawei.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/buffer.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 42a608f6bd..37befebac2 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -14,6 +14,7 @@
 #include "fuse_lowlevel.h"
 #include <assert.h>
 #include <errno.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
=20
@@ -33,6 +34,43 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv)
     return size;
 }
=20
+__attribute__((unused))
+static ssize_t fuse_buf_writev(struct fuse_buf *out_buf,
+                               struct fuse_bufvec *in_buf)
+{
+    ssize_t res, i, j;
+    size_t iovcnt =3D in_buf->count;
+    struct iovec *iov;
+    int fd =3D out_buf->fd;
+
+    iov =3D calloc(iovcnt, sizeof(struct iovec));
+    if (!iov) {
+        return -ENOMEM;
+    }
+
+    for (i =3D 0, j =3D 0; i < iovcnt; i++) {
+        /* Skip the buf with 0 size */
+        if (in_buf->buf[i].size) {
+            iov[j].iov_base =3D in_buf->buf[i].mem;
+            iov[j].iov_len =3D in_buf->buf[i].size;
+            j++;
+        }
+    }
+
+    if (out_buf->flags & FUSE_BUF_FD_SEEK) {
+        res =3D pwritev(fd, iov, iovcnt, out_buf->pos);
+    } else {
+        res =3D writev(fd, iov, iovcnt);
+    }
+
+    if (res =3D=3D -1) {
+        res =3D -errno;
+    }
+
+    free(iov);
+    return res;
+}
+
 static size_t min_size(size_t s1, size_t s2)
 {
     return s1 < s2 ? s1 : s2;
--=20
2.24.1


