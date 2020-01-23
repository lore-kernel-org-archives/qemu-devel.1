Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F76BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB62217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFfvJE7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB62217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucvg-0002m6-QT
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub8s-00023m-3B
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub8q-00051o-20
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31489
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub8p-00050o-UC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbK2M664VeD4EebvP9HVM8XSFfKMYMH/6meiQEmwLDE=;
 b=AFfvJE7H5qMeh0US6K4JvSTtbpQ9xn1rGaU3RTjFwwlA4VZk2JFh0Ykkt1tA7drEkO1iGv
 k0onkaGfom1T5GyytIMcSt0WfOXExqRHeImlO5QPbl8j/cLW7bvm73x84cpcVxlblUgVnV
 SGD1RuV4EM5TWVfy0EtgY+oauiVWuKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-dUrOXlciNXimuB7H0fVmCA-1; Thu, 23 Jan 2020 06:59:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A33B418A6EDE
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E729D8575A;
 Thu, 23 Jan 2020 11:59:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 024/111] virtiofsd: Start reading commands from queue
Date: Thu, 23 Jan 2020 11:57:14 +0000
Message-Id: <20200123115841.138849-25-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dUrOXlciNXimuB7H0fVmCA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Pop queue elements off queues, copy the data from them and
pass that to fuse.

  Note: 'out' in a VuVirtqElement is from QEMU
        'in' in libfuse is into the daemon

  So we read from the out iov's to get a fuse_in_header

When we get a kick we've got to read all the elements until the queue
is empty.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h      |  2 +
 tools/virtiofsd/fuse_virtio.c | 99 +++++++++++++++++++++++++++++++++--
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index ec04449069..1126723d18 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -14,6 +14,7 @@
 #include "fuse_lowlevel.h"
=20
 struct fv_VuDev;
+struct fv_QueueInfo;
=20
 struct fuse_req {
     struct fuse_session *se;
@@ -75,6 +76,7 @@ struct fuse_chan {
     pthread_mutex_t lock;
     int ctr;
     int fd;
+    struct fv_QueueInfo *qi;
 };
=20
 /**
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 05e7258712..3841b20129 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/iov.h"
 #include "fuse_virtio.h"
 #include "fuse_i.h"
 #include "standard-headers/linux/fuse.h"
@@ -32,6 +33,7 @@
=20
 #include "contrib/libvhost-user/libvhost-user.h"
=20
+struct fv_VuDev;
 struct fv_QueueInfo {
     pthread_t thread;
     struct fv_VuDev *virtio_dev;
@@ -101,10 +103,41 @@ static void fv_panic(VuDev *dev, const char *err)
     exit(EXIT_FAILURE);
 }
=20
+/*
+ * Copy from an iovec into a fuse_buf (memory only)
+ * Caller must ensure there is space
+ */
+static void copy_from_iov(struct fuse_buf *buf, size_t out_num,
+                          const struct iovec *out_sg)
+{
+    void *dest =3D buf->mem;
+
+    while (out_num) {
+        size_t onelen =3D out_sg->iov_len;
+        memcpy(dest, out_sg->iov_base, onelen);
+        dest +=3D onelen;
+        out_sg++;
+        out_num--;
+    }
+}
+
 /* Thread function for individual queues, created when a queue is 'started=
' */
 static void *fv_queue_thread(void *opaque)
 {
     struct fv_QueueInfo *qi =3D opaque;
+    struct VuDev *dev =3D &qi->virtio_dev->dev;
+    struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+    struct fuse_session *se =3D qi->virtio_dev->se;
+    struct fuse_chan ch;
+    struct fuse_buf fbuf;
+
+    fbuf.mem =3D NULL;
+    fbuf.flags =3D 0;
+
+    fuse_mutex_init(&ch.lock);
+    ch.fd =3D (int)0xdaff0d111;
+    ch.qi =3D qi;
+
     fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __func_=
_,
              qi->qidx, qi->kick_fd);
     while (1) {
@@ -141,11 +174,71 @@ static void *fv_queue_thread(void *opaque)
             fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
             break;
         }
-        if (qi->virtio_dev->se->debug) {
-            fprintf(stderr, "%s: Queue %d gave evalue: %zx\n", __func__,
-                    qi->qidx, (size_t)evalue);
+        /* out is from guest, in is too guest */
+        unsigned int in_bytes, out_bytes;
+        vu_queue_get_avail_bytes(dev, q, &in_bytes, &out_bytes, ~0, ~0);
+
+        fuse_log(FUSE_LOG_DEBUG,
+                 "%s: Queue %d gave evalue: %zx available: in: %u out: %u\=
n",
+                 __func__, qi->qidx, (size_t)evalue, in_bytes, out_bytes);
+
+        while (1) {
+            /*
+             * An element contains one request and the space to send our
+             * response They're spread over multiple descriptors in a
+             * scatter/gather set and we can't trust the guest to keep the=
m
+             * still; so copy in/out.
+             */
+            VuVirtqElement *elem =3D vu_queue_pop(dev, q, sizeof(VuVirtqEl=
ement));
+            if (!elem) {
+                break;
+            }
+
+            if (!fbuf.mem) {
+                fbuf.mem =3D malloc(se->bufsize);
+                assert(fbuf.mem);
+                assert(se->bufsize > sizeof(struct fuse_in_header));
+            }
+            /* The 'out' part of the elem is from qemu */
+            unsigned int out_num =3D elem->out_num;
+            struct iovec *out_sg =3D elem->out_sg;
+            size_t out_len =3D iov_size(out_sg, out_num);
+            fuse_log(FUSE_LOG_DEBUG,
+                     "%s: elem %d: with %d out desc of length %zd\n", __fu=
nc__,
+                     elem->index, out_num, out_len);
+
+            /*
+             * The elem should contain a 'fuse_in_header' (in to fuse)
+             * plus the data based on the len in the header.
+             */
+            if (out_len < sizeof(struct fuse_in_header)) {
+                fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for in_heade=
r\n",
+                         __func__, elem->index);
+                assert(0); /* TODO */
+            }
+            if (out_len > se->bufsize) {
+                fuse_log(FUSE_LOG_ERR, "%s: elem %d too large for buffer\n=
",
+                         __func__, elem->index);
+                assert(0); /* TODO */
+            }
+            copy_from_iov(&fbuf, out_num, out_sg);
+            fbuf.size =3D out_len;
+
+            /* TODO! Endianness of header */
+
+            /* TODO: Fixup fuse_send_msg */
+            /* TODO: Add checks for fuse_session_exited */
+            fuse_session_process_buf_int(se, &fbuf, &ch);
+
+            /* TODO: vu_queue_push(dev, q, elem, qi->write_count); */
+            vu_queue_notify(dev, q);
+
+            free(elem);
+            elem =3D NULL;
         }
     }
+    pthread_mutex_destroy(&ch.lock);
+    free(fbuf.mem);
=20
     return NULL;
 }
--=20
2.24.1


