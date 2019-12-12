Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C52214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icYow69w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C52214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRkT-0005HC-4g
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVM-0005Qt-6b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVK-0001fE-La
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVK-0001ef-Gb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZnB7Rhtu4ntwEhgMVuiwoszT6jzVyPSFV1MYjVZdEJE=;
 b=icYow69wLBDIBaz2OvSnLsDTCd+uQSgmWP3jQeFYVC2ZwVExBqQnMNxHKODzXlsbLTQU6i
 LcpeYsabidyD3KlykiS1wV3mNskCgJ/M2bLtYGKjlfUt/YvumoU4R14Df6pQ9GV2F8Ftj7
 AKdfmOryq6N/T0Q3BL12BT5/gF9bFYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-gF9R4cWZOMWggXU7Mh5kEQ-1; Thu, 12 Dec 2019 11:39:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E04AB801E7A
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 147E060BE1;
 Thu, 12 Dec 2019 16:39:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 026/104] virtiofsd: Fast path for virtio read
Date: Thu, 12 Dec 2019 16:37:46 +0000
Message-Id: <20191212163904.159893-27-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gF9R4cWZOMWggXU7Mh5kEQ-1
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Readv the data straight into the guests buffer.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
With fix by:
Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 tools/virtiofsd/fuse_lowlevel.c |   5 +
 tools/virtiofsd/fuse_virtio.c   | 159 ++++++++++++++++++++++++++++++++
 tools/virtiofsd/fuse_virtio.h   |   4 +
 3 files changed, 168 insertions(+)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index c2b114cf5b..5f80625652 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -475,6 +475,11 @@ static int fuse_send_data_iov_fallback(struct fuse_ses=
sion *se,
         return fuse_send_msg(se, ch, iov, iov_count);
     }
=20
+    if (fuse_lowlevel_is_virtio(se) && buf->count =3D=3D 1 &&
+        buf->buf[0].flags =3D=3D (FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK)) {
+        return virtio_send_data_iov(se, ch, iov, iov_count, buf, len);
+    }
+
     abort(); /* Will have taken vhost path */
     return 0;
 }
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index c33e0f7e8c..146cd3f702 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -230,6 +230,165 @@ err:
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
+    size_t iov_len =3D iov_size(iov, count);
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
+    size_t in_len =3D iov_size(in_sg, in_num);
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
diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
index 135a14875a..cc676b9193 100644
--- a/tools/virtiofsd/fuse_virtio.h
+++ b/tools/virtiofsd/fuse_virtio.h
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


