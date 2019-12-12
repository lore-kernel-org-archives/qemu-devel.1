Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E85214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUkNi4bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E85214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSwn-0003t6-CR
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX7-0007va-Em
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX6-00050O-CT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRX6-0004zH-89
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFc4dMo8yhjVoP8o+Z/ZpPcPlDW3x2vHa3Noqh0Na0E=;
 b=jUkNi4bbDFZXdc2qpiS9fTkxjgAO/n3oqrYwngB1V+8prUjc+AxAa4G2fFo5Twro0GyQKr
 tnaaLJg1wqV4CmoIiKLe0uTbocCXJlWO0LERKW8eJnWlAkcbmaQoIQl8b9zRujXpmZUOT8
 6Qn6Co7gUJ4TOa/XgsrCCO4gSRofh1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-uEWIHJbHPSKVWZgpCuPlmw-1; Thu, 12 Dec 2019 11:41:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2A80107ACFE
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6F1060BE1;
 Thu, 12 Dec 2019 16:41:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 098/104] virtiofsd: add definition of fuse_buf_writev()
Date: Thu, 12 Dec 2019 16:38:58 +0000
Message-Id: <20191212163904.159893-99-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uEWIHJbHPSKVWZgpCuPlmw-1
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

From: piaojun <piaojun@huawei.com>

Define fuse_buf_writev() which use pwritev and writev to improve io
bandwidth. Especially, the src bufs with 0 size should be skipped as
their mems are not *block_size* aligned which will cause writev failed
in direct io mode.

Signed-off-by: Jun Piao <piaojun@huawei.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/buffer.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index f59d8d72eb..ae420c70c4 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -13,6 +13,7 @@
 #include "fuse_lowlevel.h"
 #include <assert.h>
 #include <errno.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
=20
@@ -32,6 +33,44 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv)
     return size;
 }
=20
+__attribute__((unused))
+static ssize_t fuse_buf_writev(fuse_req_t req,
+                               struct fuse_buf *out_buf,
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
2.23.0


