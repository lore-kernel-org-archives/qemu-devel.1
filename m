Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09452C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA43214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiQCnbnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA43214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSTx-0004wI-0u
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX8-0007xS-P4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX7-00052j-IL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRX7-00051e-EQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUB0WF7WUgGKIalrFtHeZRh0OrVfwoA1fO7F1MpTrsc=;
 b=HiQCnbnjx2HuBST9BakFlgY4UsC/8Tf1xpfvqIwnzGIKMqLbmALbnUUheim+rcz0ASorP2
 X6Xn+RztSZq3JcUPqOEp6zdVdwTckOxH3jvu2aDqxoETJR+64ZnpyTJkqhdm1cJZSIcBfQ
 PZ4d/3sB2d20raSFbki7NrpysUcFca4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-_OTNTp86NvSU_VGEmOhtaw-1; Thu, 12 Dec 2019 11:41:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D703118B6457
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:42 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0872B60BE1;
 Thu, 12 Dec 2019 16:41:41 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 099/104] virtiofsd: use fuse_buf_writev to replace
 fuse_buf_write for better performance
Date: Thu, 12 Dec 2019 16:38:59 +0000
Message-Id: <20191212163904.159893-100-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _OTNTp86NvSU_VGEmOhtaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

fuse_buf_writev() only handles the normal write in which src is buffer
and dest is fd. Specially if src buffer represents guest physical
address that can't be mapped by the daemon process, IO must be bounced
back to the VMM to do it by fuse_buf_copy().

Signed-off-by: Jun Piao <piaojun@huawei.com>
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/buffer.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index ae420c70c4..4875473785 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -33,9 +33,7 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv)
     return size;
 }
=20
-__attribute__((unused))
-static ssize_t fuse_buf_writev(fuse_req_t req,
-                               struct fuse_buf *out_buf,
+static ssize_t fuse_buf_writev(struct fuse_buf *out_buf,
                                struct fuse_bufvec *in_buf)
 {
     ssize_t res, i, j;
@@ -334,12 +332,29 @@ static int fuse_bufvec_advance(struct fuse_bufvec *bu=
fv, size_t len)
 ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct fuse_bufvec *srcv,
                       enum fuse_buf_copy_flags flags)
 {
-    size_t copied =3D 0;
+    size_t copied =3D 0, i;
=20
     if (dstv =3D=3D srcv) {
         return fuse_buf_size(dstv);
     }
=20
+    /*
+     * use writev to improve bandwidth when all the
+     * src buffers already mapped by the daemon
+     * process
+     */
+    for (i =3D 0; i < srcv->count; i++) {
+        if (srcv->buf[i].flags & FUSE_BUF_IS_FD) {
+            break;
+        }
+    }
+    if ((i =3D=3D srcv->count) && (dstv->count =3D=3D 1) &&
+        (dstv->idx =3D=3D 0) &&
+        (dstv->buf[0].flags & FUSE_BUF_IS_FD)) {
+        dstv->buf[0].pos +=3D dstv->off;
+        return fuse_buf_writev(&dstv->buf[0], srcv);
+    }
+
     for (;;) {
         const struct fuse_buf *src =3D fuse_bufvec_current(srcv);
         const struct fuse_buf *dst =3D fuse_bufvec_current(dstv);
--=20
2.23.0


