Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F2CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDE920679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eloCevhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDE920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVm0-0002Zr-Lb
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQh-00046a-9C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQf-0004Jx-7i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQZ-0004HY-Go
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fjouwg58ShMEwm1HFgAhtE1bxH/orY/c2g8VuzSN5Bw=;
 b=eloCevhXOUNGiVxGIJY11Xlhrc/hY0sGKyWUv8tFkZAQrtc6Yy4Ph48P9WeURf2TQ6sLEg
 0x0GwmK3WzqL6IQQgghBm9kRA9HwLIAHn6tZxEi/6mQZlm6es6YmneKYbeUJz4c/SrAWvG
 iT2g47XCQh9wxuHrFF2pHTfrAI8Hkig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-RtdTKVfwNOS7O4isGR6lCw-1; Mon, 21 Oct 2019 07:00:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC001800DD6;
 Mon, 21 Oct 2019 11:00:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF7C6060D;
 Mon, 21 Oct 2019 11:00:29 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 22/30] virtiofsd: Send replies to messages
Date: Mon, 21 Oct 2019 11:58:24 +0100
Message-Id: <20191021105832.36574-23-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RtdTKVfwNOS7O4isGR6lCw-1
X-Mimecast-Spam-Score: 0
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Route fuse out messages back through the same queue elements
that had the command that triggered the request.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.c |   4 ++
 contrib/virtiofsd/fuse_virtio.c   | 107 ++++++++++++++++++++++++++++--
 contrib/virtiofsd/fuse_virtio.h   |   4 ++
 3 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 328a9aa001..fc7707b330 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -171,6 +171,10 @@ static int fuse_send_msg(struct fuse_session *se, stru=
ct fuse_chan *ch,
 =09=09}
 =09}
=20
+=09if (fuse_lowlevel_is_virtio(se)) {
+=09=09return virtio_send_msg(se, ch, iov, count);
+=09}
+
 =09abort(); /* virtio should have taken it before here */
 =09return 0;
 }
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index e189511729..2dae08c26f 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -40,6 +40,9 @@ struct fv_QueueInfo {
     /* Our queue index, corresponds to array position */
     int qidx;
     int kick_fd;
+
+    /* The element for the command currently being processed */
+    VuVirtqElement *qe;
 };
=20
 /*
@@ -120,6 +123,105 @@ static void copy_from_iov(struct fuse_buf *buf, size_=
t out_num,
     }
 }
=20
+/*
+ * Copy from one iov to another, the given number of bytes
+ * The caller must have checked sizes.
+ */
+static void copy_iov(struct iovec *src_iov, int src_count,
+                     struct iovec *dst_iov, int dst_count, size_t to_copy)
+{
+    size_t dst_offset =3D 0;
+    /* Outer loop copies 'src' elements */
+    while (to_copy) {
+        assert(src_count);
+        size_t src_len =3D src_iov[0].iov_len;
+        size_t src_offset =3D 0;
+
+        if (src_len > to_copy) {
+            src_len =3D to_copy;
+        }
+        /* Inner loop copies contents of one 'src' to maybe multiple dst. =
*/
+        while (src_len) {
+            assert(dst_count);
+            size_t dst_len =3D dst_iov[0].iov_len - dst_offset;
+            if (dst_len > src_len) {
+                dst_len =3D src_len;
+            }
+
+            memcpy(dst_iov[0].iov_base + dst_offset,
+                   src_iov[0].iov_base + src_offset, dst_len);
+            src_len -=3D dst_len;
+            to_copy -=3D dst_len;
+            src_offset +=3D dst_len;
+            dst_offset +=3D dst_len;
+
+            assert(dst_offset <=3D dst_iov[0].iov_len);
+            if (dst_offset =3D=3D dst_iov[0].iov_len) {
+                dst_offset =3D 0;
+                dst_iov++;
+                dst_count--;
+            }
+        }
+        src_iov++;
+        src_count--;
+    }
+}
+
+/*
+ * Called back by ll whenever it wants to send a reply/message back
+ * The 1st element of the iov starts with the fuse_out_header
+ * 'unique'=3D=3D0 means it's a notify message.
+ */
+int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
+                    struct iovec *iov, int count)
+{
+    VuVirtqElement *elem;
+    VuVirtq *q;
+
+    assert(count >=3D 1);
+    assert(iov[0].iov_len >=3D sizeof(struct fuse_out_header));
+
+    struct fuse_out_header *out =3D iov[0].iov_base;
+    /* TODO: Endianness! */
+
+    size_t tosend_len =3D iov_length(iov, count);
+
+    /* unique =3D=3D 0 is notification, which we don't support */
+    assert(out->unique);
+    /* For virtio we always have ch */
+    assert(ch);
+    elem =3D ch->qi->qe;
+    q =3D &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
+
+    /* The 'in' part of the elem is to qemu */
+    unsigned int in_num =3D elem->in_num;
+    struct iovec *in_sg =3D elem->in_sg;
+    size_t in_len =3D iov_length(in_sg, in_num);
+    fuse_log(FUSE_LOG_DEBUG, "%s: elem %d: with %d in desc of length %zd\n=
",
+             __func__, elem->index, in_num, in_len);
+
+    /*
+     * The elem should have room for a 'fuse_out_header' (out from fuse)
+     * plus the data based on the len in the header.
+     */
+    if (in_len < sizeof(struct fuse_out_header)) {
+        fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for out_header\n",
+                 __func__, elem->index);
+        return -E2BIG;
+    }
+    if (in_len < tosend_len) {
+        fuse_log(FUSE_LOG_ERR, "%s: elem %d too small for data len %zd\n",
+                 __func__, elem->index, tosend_len);
+        return -E2BIG;
+    }
+
+    copy_iov(iov, count, in_sg, in_num, tosend_len);
+    vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
+    vu_queue_notify(&se->virtio_dev->dev, q);
+
+    return 0;
+}
+
 /* Thread function for individual queues, created when a queue is 'started=
' */
 static void *fv_queue_thread(void *opaque)
 {
@@ -226,13 +328,10 @@ static void *fv_queue_thread(void *opaque)
=20
             /* TODO! Endianness of header */
=20
-            /* TODO: Fixup fuse_send_msg */
             /* TODO: Add checks for fuse_session_exited */
             fuse_session_process_buf_int(se, &fbuf, &ch);
=20
-            /* TODO: vu_queue_push(dev, q, elem, qi->write_count); */
-            vu_queue_notify(dev, q);
-
+            qi->qe =3D NULL;
             free(elem);
             elem =3D NULL;
         }
diff --git a/contrib/virtiofsd/fuse_virtio.h b/contrib/virtiofsd/fuse_virti=
o.h
index 025a4d30ae..f1e7391e44 100644
--- a/contrib/virtiofsd/fuse_virtio.h
+++ b/contrib/virtiofsd/fuse_virtio.h
@@ -22,4 +22,8 @@ int virtio_session_mount(struct fuse_session *se);
=20
 int virtio_loop(struct fuse_session *se);
=20
+
+int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
+                    struct iovec *iov, int count);
+
 #endif
--=20
2.23.0


