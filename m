Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C20C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706F021655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS4WBlCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706F021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34621 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSCU-0006It-9A
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVh-0005rd-Q1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVg-0002FP-AH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVg-0002Eh-2i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVCU0QAEMpRAgyvXWsnEyJwCGjSbQAWBP1xMWm8k5kI=;
 b=BS4WBlCNZuyqfBq4gU+XszBTO2oNoeELMivFeI7S+ITTAJZdf00YcFnb+U6zaLr49+K0/I
 1BZU04LPPXmzXyeNcrZCWstxmsqUzb5470LHpKiDXQZszSIzFNj7c8SoZyJAQlpQDA5oxS
 ExRrxbAnfE8VNX8hmd7kGKO3djIAyvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-nVziACeQP8udgFneCGcNew-1; Thu, 12 Dec 2019 11:40:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E1DD107ACC4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:13 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72C1A60BE1;
 Thu, 12 Dec 2019 16:40:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 040/104] virtiofsd: Pass write iov's all the way through
Date: Thu, 12 Dec 2019 16:38:00 +0000
Message-Id: <20191212163904.159893-41-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: nVziACeQP8udgFneCGcNew-1
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Pass the write iov pointing to guest RAM all the way through rather
than copying the data.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 79 ++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 99c877ea2e..3c778b6296 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -452,6 +452,10 @@ static void *fv_queue_thread(void *opaque)
                  __func__, qi->qidx, (size_t)evalue, in_bytes, out_bytes);
=20
         while (1) {
+            bool allocated_bufv =3D false;
+            struct fuse_bufvec bufv;
+            struct fuse_bufvec *pbufv;
+
             /*
              * An element contains one request and the space to send our
              * response They're spread over multiple descriptors in a
@@ -493,14 +497,76 @@ static void *fv_queue_thread(void *opaque)
                          __func__, elem->index);
                 assert(0); /* TODO */
             }
-            copy_from_iov(&fbuf, out_num, out_sg);
-            fbuf.size =3D out_len;
+            /* Copy just the first element and look at it */
+            copy_from_iov(&fbuf, 1, out_sg);
+
+            if (out_num > 2 &&
+                out_sg[0].iov_len =3D=3D sizeof(struct fuse_in_header) &&
+                ((struct fuse_in_header *)fbuf.mem)->opcode =3D=3D FUSE_WR=
ITE &&
+                out_sg[1].iov_len =3D=3D sizeof(struct fuse_write_in)) {
+                /*
+                 * For a write we don't actually need to copy the
+                 * data, we can just do it straight out of guest memory
+                 * but we must still copy the headers in case the guest
+                 * was nasty and changed them while we were using them.
+                 */
+                fuse_log(FUSE_LOG_DEBUG, "%s: Write special case\n", __fun=
c__);
+
+                /* copy the fuse_write_in header after the fuse_in_header =
*/
+                fbuf.mem +=3D out_sg->iov_len;
+                copy_from_iov(&fbuf, 1, out_sg + 1);
+                fbuf.mem -=3D out_sg->iov_len;
+                fbuf.size =3D out_sg[0].iov_len + out_sg[1].iov_len;
+
+                /* Allocate the bufv, with space for the rest of the iov *=
/
+                allocated_bufv =3D true;
+                pbufv =3D malloc(sizeof(struct fuse_bufvec) +
+                               sizeof(struct fuse_buf) * (out_num - 2));
+                if (!pbufv) {
+                    vu_queue_unpop(dev, q, elem, 0);
+                    free(elem);
+                    fuse_log(FUSE_LOG_ERR, "%s: pbufv malloc failed\n",
+                             __func__);
+                    goto out;
+                }
+
+                pbufv->count =3D 1;
+                pbufv->buf[0] =3D fbuf;
+
+                size_t iovindex, pbufvindex;
+                iovindex =3D 2; /* 2 headers, separate iovs */
+                pbufvindex =3D 1; /* 2 headers, 1 fusebuf */
+
+                for (; iovindex < out_num; iovindex++, pbufvindex++) {
+                    pbufv->count++;
+                    pbufv->buf[pbufvindex].pos =3D ~0; /* Dummy */
+                    pbufv->buf[pbufvindex].flags =3D 0;
+                    pbufv->buf[pbufvindex].mem =3D out_sg[iovindex].iov_ba=
se;
+                    pbufv->buf[pbufvindex].size =3D out_sg[iovindex].iov_l=
en;
+                }
+            } else {
+                /* Normal (non fast write) path */
+
+                /* Copy the rest of the buffer */
+                fbuf.mem +=3D out_sg->iov_len;
+                copy_from_iov(&fbuf, out_num - 1, out_sg + 1);
+                fbuf.mem -=3D out_sg->iov_len;
+                fbuf.size =3D out_len;
=20
-            /* TODO! Endianness of header */
+                /* TODO! Endianness of header */
=20
-            /* TODO: Add checks for fuse_session_exited */
-            struct fuse_bufvec bufv =3D { .buf[0] =3D fbuf, .count =3D 1 }=
;
-            fuse_session_process_buf_int(se, &bufv, &ch);
+                /* TODO: Add checks for fuse_session_exited */
+                bufv.buf[0] =3D fbuf;
+                bufv.count =3D 1;
+                pbufv =3D &bufv;
+            }
+            pbufv->idx =3D 0;
+            pbufv->off =3D 0;
+            fuse_session_process_buf_int(se, pbufv, &ch);
+
+            if (allocated_bufv) {
+                free(pbufv);
+            }
=20
             if (!qi->reply_sent) {
                 fuse_log(FUSE_LOG_DEBUG, "%s: elem %d no reply sent\n",
@@ -514,6 +580,7 @@ static void *fv_queue_thread(void *opaque)
             elem =3D NULL;
         }
     }
+out:
     pthread_mutex_destroy(&ch.lock);
     free(fbuf.mem);
=20
--=20
2.23.0


