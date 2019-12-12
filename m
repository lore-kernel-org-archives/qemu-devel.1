Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B8AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5680F205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfRQAoKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5680F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS8N-0008VR-PB
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVk-0005v8-1q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVi-0002KB-P2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVi-0002JT-KE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjEwVaezMuip00LU8LWeyiaqeheyGFWg4hB1UkA3M9I=;
 b=cfRQAoKEn9TsifQfn7TsxFTK6P6nowJCWrrgucDi0hZNAYjp2tGleiOcHb3qoL7PmRCW3Q
 AHdO9lF1FDltPO9EpJliz/+4MCH9wdm7C9xjkiRFqQ5ZZQEE6DOxPByHYFRkkToj9pMdbi
 pJpQ8vtnBtTSKomJtIQVd+hQJESqAY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-lOfNfn8yP1O3Zdo1yZsXAg-1; Thu, 12 Dec 2019 11:40:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B46F107ACC5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C009760BE1;
 Thu, 12 Dec 2019 16:40:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 042/104] virtiofsd: validate input buffer sizes in
 do_write_buf()
Date: Thu, 12 Dec 2019 16:38:02 +0000
Message-Id: <20191212163904.159893-43-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: lOfNfn8yP1O3Zdo1yZsXAg-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

There is a small change in behavior: if fuse_write_in->size doesn't
match the input buffer size then the request is failed.  Previously
write requests with 1 fuse_buf element would truncate to
fuse_write_in->size.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 49 ++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 7d33bbf539..4b1777b991 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1005,8 +1005,8 @@ static void do_write(fuse_req_t req, fuse_ino_t nodei=
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
@@ -1014,28 +1014,27 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
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
@@ -1045,6 +1044,13 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t =
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
@@ -2055,12 +2061,17 @@ void fuse_session_process_buf_int(struct fuse_sessi=
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
@@ -2132,7 +2143,7 @@ void fuse_session_process_buf_int(struct fuse_session=
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
2.23.0


