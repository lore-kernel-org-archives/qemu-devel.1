Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D3C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7D521D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHg8dBu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7D521D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiTx-000298-Po
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdx-0004yv-M3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdw-0006YC-Av
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdw-0006Xu-7u
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7J2d+/qEC/4s8KwV2sf+Fq1jzRcegakEDeWcp+uogY=;
 b=IHg8dBu9iStMP0EyB6jqv1mPJGufVqzv4WIxKmlDgIz2UfSj8cZ9aaGnsLtZnw+oP+w8qR
 8FHrbN1rO5ifNiQNj73zGnFKNhdHDBRJybkhjXlKJsQh5YD8BZMKTV0Y9p6/kDClV514n4
 FqdPqjm8kU6fJcmko3NkQSsFjopCAws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-t0lx9W7vM0mLE8j-_FIxDA-1; Thu, 23 Jan 2020 11:47:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72C6C8024F9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDB0628998;
 Thu, 23 Jan 2020 16:47:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 044/108] virtiofsd: validate input buffer sizes in
 do_write_buf()
Date: Thu, 23 Jan 2020 16:45:26 +0000
Message-Id: <20200123164630.91498-45-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: t0lx9W7vM0mLE8j-_FIxDA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

From: Stefan Hajnoczi <stefanha@redhat.com>

There is a small change in behavior: if fuse_write_in->size doesn't
match the input buffer size then the request is failed.  Previously
write requests with 1 fuse_buf element would truncate to
fuse_write_in->size.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 49 ++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 7e10995adc..611e8b0354 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1003,8 +1003,8 @@ static void do_write(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg,
-                         struct fuse_bufvec *ibufv)
+static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid,
+                         struct fuse_mbuf_iter *iter, struct fuse_bufvec *=
ibufv)
 {
     struct fuse_session *se =3D req->se;
     struct fuse_bufvec *pbufv =3D ibufv;
@@ -1012,28 +1012,27 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg,
         .buf[0] =3D ibufv->buf[0],
         .count =3D 1,
     };
-    struct fuse_write_in *arg =3D (struct fuse_write_in *)inarg;
+    struct fuse_write_in *arg;
+    size_t arg_size =3D sizeof(*arg);
     struct fuse_file_info fi;
=20
     memset(&fi, 0, sizeof(fi));
+
+    arg =3D fuse_mbuf_iter_advance(iter, arg_size);
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    fi.lock_owner =3D arg->lock_owner;
+    fi.flags =3D arg->flags;
     fi.fh =3D arg->fh;
     fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
=20
     if (ibufv->count =3D=3D 1) {
-        fi.lock_owner =3D arg->lock_owner;
-        fi.flags =3D arg->flags;
-        if (!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD)) {
-            tmpbufv.buf[0].mem =3D PARAM(arg);
-        }
-        tmpbufv.buf[0].size -=3D
-            sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
-        if (tmpbufv.buf[0].size < arg->size) {
-            fuse_log(FUSE_LOG_ERR,
-                     "fuse: do_write_buf: buffer size too small\n");
-            fuse_reply_err(req, EIO);
-            return;
-        }
-        tmpbufv.buf[0].size =3D arg->size;
+        assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
+        tmpbufv.buf[0].mem =3D ((char *)arg) + arg_size;
+        tmpbufv.buf[0].size -=3D sizeof(struct fuse_in_header) + arg_size;
         pbufv =3D &tmpbufv;
     } else {
         /*
@@ -1043,6 +1042,13 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg,
         ibufv->buf[0].size =3D 0;
     }
=20
+    if (fuse_buf_size(pbufv) !=3D arg->size) {
+        fuse_log(FUSE_LOG_ERR,
+                 "fuse: do_write_buf: buffer size doesn't match arg->size\=
n");
+        fuse_reply_err(req, EIO);
+        return;
+    }
+
     se->op.write_buf(req, nodeid, pbufv, arg->offset, &fi);
 }
=20
@@ -2052,12 +2058,17 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
                                   struct fuse_chan *ch)
 {
     const struct fuse_buf *buf =3D bufv->buf;
+    struct fuse_mbuf_iter iter =3D FUSE_MBUF_ITER_INIT(buf);
     struct fuse_in_header *in;
     const void *inarg;
     struct fuse_req *req;
     int err;
=20
-    in =3D buf->mem;
+    /* The first buffer must be a memory buffer */
+    assert(!(buf->flags & FUSE_BUF_IS_FD));
+
+    in =3D fuse_mbuf_iter_advance(&iter, sizeof(*in));
+    assert(in); /* caller guarantees the input buffer is large enough */
=20
     if (se->debug) {
         fuse_log(FUSE_LOG_DEBUG,
@@ -2129,7 +2140,7 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
=20
     inarg =3D (void *)&in[1];
     if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf) {
-        do_write_buf(req, in->nodeid, inarg, bufv);
+        do_write_buf(req, in->nodeid, &iter, bufv);
     } else {
         fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
     }
--=20
2.24.1


