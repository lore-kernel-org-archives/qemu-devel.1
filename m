Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190AFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D603E20684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDhqEZ98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D603E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVsE-0002Z1-9x
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQn-0004AR-4u
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQl-0004Ml-Br
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQl-0004Lc-7f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x3uz4ko1y0NPiA8p8yJaTpY1vDC0Egvmzw55NQUy5V8=;
 b=cDhqEZ98HfiZCHAXFvEFX90oWWjZrIalQFusCNI2OAfWrWfRnNb6P7TZ4sLhQYzrNAlUUP
 WPih3K2YUvop2gNChfAS/WxGFZC9hxqzDeu07GKBtjV+JNwL55lAuIBje+dM9fEKlqwnTT
 P+zY7qYtljIHfWknbZPFHm3yn06pohM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-KMgcBWU1NQGEyASqi3mdiw-1; Mon, 21 Oct 2019 07:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D7561005525;
 Mon, 21 Oct 2019 11:00:42 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8884E60A9F;
 Mon, 21 Oct 2019 11:00:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 25/30] virtiofsd: Fast path for virtio read
Date: Mon, 21 Oct 2019 11:58:27 +0100
Message-Id: <20191021105832.36574-26-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KMgcBWU1NQGEyASqi3mdiw-1
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Readv the data straight into the guests buffer.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
With fix by:
Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 contrib/virtiofsd/fuse_lowlevel.c |   6 ++
 contrib/virtiofsd/fuse_virtio.c   | 159 ++++++++++++++++++++++++++++++
 contrib/virtiofsd/fuse_virtio.h   |   4 +
 3 files changed, 169 insertions(+)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index fc7707b330..b1f44ca17e 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -471,6 +471,12 @@ static int fuse_send_data_iov_fallback(struct fuse_ses=
sion *se,
 =09=09return fuse_send_msg(se, ch, iov, iov_count);
 =09}
=20
+=09if (fuse_lowlevel_is_virtio(se) && buf->count=3D=3D1 &&
+=09    buf->buf[0].flags =3D=3D (FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK)) {
+=09=09return virtio_send_data_iov(se, ch, iov, iov_count,
+=09=09=09=09=09    buf, len);
+=09}
+
 =09abort(); /* Will have taken vhost path */
 =09return 0;
 }
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 8dac47d42a..f52d815596 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -229,6 +229,165 @@ err:
     return ret;
 }
=20
+/*
+ * Callback from fuse_send_data_iov_* when it's virtio and the buffer
+ * is a single FD with FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK
+ * We need send the iov and then the buffer.
+ * Return 0 on success
+ */
+int virtio_send_data_iov(struct fuse_session *se, struct fuse_chan *ch,
+                         struct iovec *iov, int count, struct fuse_bufvec =
*buf,
+                         size_t len)
+{
+    int ret =3D 0;
+    VuVirtqElement *elem;
+    VuVirtq *q;
+
+    assert(count >=3D 1);
+    assert(iov[0].iov_len >=3D sizeof(struct fuse_out_header));
+
+    struct fuse_out_header *out =3D iov[0].iov_base;
+    /* TODO: Endianness! */
+
+    size_t iov_len =3D iov_length(iov, count);
+    size_t tosend_len =3D iov_len + len;
+
+    out->len =3D tosend_len;
+
+    fuse_log(FUSE_LOG_DEBUG, "%s: count=3D%d len=3D%zd iov_len=3D%zd\n", _=
_func__,
+             count, len, iov_len);
+
+    /* unique =3D=3D 0 is notification which we don't support */
+    assert(out->unique);
+
+    /* For virtio we always have ch */
+    assert(ch);
+    assert(!ch->qi->reply_sent);
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
+        ret =3D -E2BIG;
+        goto err;
+    }
+    if (in_len < tosend_len) {
+        fuse_log(FUSE_LOG_ERR, "%s: elem %d too small for data len %zd\n",
+                 __func__, elem->index, tosend_len);
+        ret =3D -E2BIG;
+        goto err;
+    }
+
+    /* TODO: Limit to 'len' */
+
+    /* First copy the header data from iov->in_sg */
+    copy_iov(iov, count, in_sg, in_num, iov_len);
+
+    /*
+     * Build a copy of the the in_sg iov so we can skip bits in it,
+     * including changing the offsets
+     */
+    struct iovec *in_sg_cpy =3D calloc(sizeof(struct iovec), in_num);
+    memcpy(in_sg_cpy, in_sg, sizeof(struct iovec) * in_num);
+    /* These get updated as we skip */
+    struct iovec *in_sg_ptr =3D in_sg_cpy;
+    int in_sg_cpy_count =3D in_num;
+
+    /* skip over parts of in_sg that contained the header iov */
+    size_t skip_size =3D iov_len;
+
+    size_t in_sg_left =3D 0;
+    do {
+        while (skip_size !=3D 0 && in_sg_cpy_count) {
+            if (skip_size >=3D in_sg_ptr[0].iov_len) {
+                skip_size -=3D in_sg_ptr[0].iov_len;
+                in_sg_ptr++;
+                in_sg_cpy_count--;
+            } else {
+                in_sg_ptr[0].iov_len -=3D skip_size;
+                in_sg_ptr[0].iov_base +=3D skip_size;
+                break;
+            }
+        }
+
+        int i;
+        for (i =3D 0, in_sg_left =3D 0; i < in_sg_cpy_count; i++) {
+            in_sg_left +=3D in_sg_ptr[i].iov_len;
+        }
+        fuse_log(FUSE_LOG_DEBUG,
+                 "%s: after skip skip_size=3D%zd in_sg_cpy_count=3D%d "
+                 "in_sg_left=3D%zd\n",
+                 __func__, skip_size, in_sg_cpy_count, in_sg_left);
+        ret =3D preadv(buf->buf[0].fd, in_sg_ptr, in_sg_cpy_count,
+                     buf->buf[0].pos);
+
+        fuse_log(FUSE_LOG_DEBUG, "%s: preadv_res=3D%d(%m) len=3D%zd\n",
+                 __func__, ret, len);
+        if (ret =3D=3D -1) {
+            ret =3D errno;
+            free(in_sg_cpy);
+            goto err;
+        }
+        if (ret < len && ret) {
+            fuse_log(FUSE_LOG_DEBUG, "%s: ret < len\n", __func__);
+            /* Skip over this much next time around */
+            skip_size =3D ret;
+            buf->buf[0].pos +=3D ret;
+            len -=3D ret;
+
+            /* Lets do another read */
+            continue;
+        }
+        if (!ret) {
+            /* EOF case? */
+            fuse_log(FUSE_LOG_DEBUG, "%s: !ret in_sg_left=3D%zd\n", __func=
__,
+                     in_sg_left);
+            break;
+        }
+        if (ret !=3D len) {
+            fuse_log(FUSE_LOG_DEBUG, "%s: ret!=3Dlen\n", __func__);
+            ret =3D EIO;
+            free(in_sg_cpy);
+            goto err;
+        }
+        in_sg_left -=3D ret;
+        len -=3D ret;
+    } while (in_sg_left);
+    free(in_sg_cpy);
+
+    /* Need to fix out->len on EOF */
+    if (len) {
+        struct fuse_out_header *out_sg =3D in_sg[0].iov_base;
+
+        tosend_len -=3D len;
+        out_sg->len =3D tosend_len;
+    }
+
+    ret =3D 0;
+
+    vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
+    vu_queue_notify(&se->virtio_dev->dev, q);
+
+err:
+    if (ret =3D=3D 0) {
+        ch->qi->reply_sent =3D true;
+    }
+
+    return ret;
+}
+
 /* Thread function for individual queues, created when a queue is 'started=
' */
 static void *fv_queue_thread(void *opaque)
 {
diff --git a/contrib/virtiofsd/fuse_virtio.h b/contrib/virtiofsd/fuse_virti=
o.h
index f1e7391e44..19c468ee31 100644
--- a/contrib/virtiofsd/fuse_virtio.h
+++ b/contrib/virtiofsd/fuse_virtio.h
@@ -26,4 +26,8 @@ int virtio_loop(struct fuse_session *se);
 int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
                     struct iovec *iov, int count);
=20
+int virtio_send_data_iov(struct fuse_session *se, struct fuse_chan *ch,
+                         struct iovec *iov, int count,
+                         struct fuse_bufvec *buf, size_t len);
+
 #endif
--=20
2.23.0


