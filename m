Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084F1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64AA22522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQddhb2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64AA22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuh5L-0001Yq-AC
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdv-0004w1-4n
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdt-0006WJ-Kl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdt-0006WC-HX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i36g49Wr23XnPzHPj1e2Sazsa2bVz3Y92a1xoz/YYmg=;
 b=SQddhb2DhyVwMPhmF48Q2b56+USzeHf7agvSv9bgrqKlZ5EvejoCWHmZlBJ2hOFFBVlPX+
 F8wLLw7q1XvAyyqjM/K0vsOljRYrcXtr28etioZMz5xRyea/z684Qr5JxX4tPEfl82hpuv
 nZAKCpuzpzLpsVDgkhjnNPxJAu70C9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-CpqhfcZkN16Gqv8RIiVAdA-1; Thu, 23 Jan 2020 11:47:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A7186B313
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:38 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C728028998;
 Thu, 23 Jan 2020 16:47:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 041/108] virtiofsd: Plumb fuse_bufvec through to do_write_buf
Date: Thu, 23 Jan 2020 16:45:23 +0000
Message-Id: <20200123164630.91498-42-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CpqhfcZkN16Gqv8RIiVAdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

Let fuse_session_process_buf_int take a fuse_bufvec * instead of a
fuse_buf;  and then through to do_write_buf - where in the best
case it can pass that straight through to op.write_buf without copying
(other than skipping a header).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h        |  2 +-
 tools/virtiofsd/fuse_lowlevel.c | 61 ++++++++++++++++++++++-----------
 tools/virtiofsd/fuse_virtio.c   |  3 +-
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 45995f3246..a20854f1c4 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -100,7 +100,7 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int erro=
r, struct iovec *iov,
 void fuse_free_req(fuse_req_t req);
=20
 void fuse_session_process_buf_int(struct fuse_session *se,
-                                  const struct fuse_buf *buf,
+                                  struct fuse_bufvec *bufv,
                                   struct fuse_chan *ch);
=20
=20
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 95f4db8fcf..7e10995adc 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1004,11 +1004,12 @@ static void do_write(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 }
=20
 static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg,
-                         const struct fuse_buf *ibuf)
+                         struct fuse_bufvec *ibufv)
 {
     struct fuse_session *se =3D req->se;
-    struct fuse_bufvec bufv =3D {
-        .buf[0] =3D *ibuf,
+    struct fuse_bufvec *pbufv =3D ibufv;
+    struct fuse_bufvec tmpbufv =3D {
+        .buf[0] =3D ibufv->buf[0],
         .count =3D 1,
     };
     struct fuse_write_in *arg =3D (struct fuse_write_in *)inarg;
@@ -1018,22 +1019,31 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg,
     fi.fh =3D arg->fh;
     fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
=20
-    fi.lock_owner =3D arg->lock_owner;
-    fi.flags =3D arg->flags;
-    if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD)) {
-        bufv.buf[0].mem =3D PARAM(arg);
-    }
-
-    bufv.buf[0].size -=3D
-        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
-    if (bufv.buf[0].size < arg->size) {
-        fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small\=
n");
-        fuse_reply_err(req, EIO);
-        return;
+    if (ibufv->count =3D=3D 1) {
+        fi.lock_owner =3D arg->lock_owner;
+        fi.flags =3D arg->flags;
+        if (!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD)) {
+            tmpbufv.buf[0].mem =3D PARAM(arg);
+        }
+        tmpbufv.buf[0].size -=3D
+            sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
+        if (tmpbufv.buf[0].size < arg->size) {
+            fuse_log(FUSE_LOG_ERR,
+                     "fuse: do_write_buf: buffer size too small\n");
+            fuse_reply_err(req, EIO);
+            return;
+        }
+        tmpbufv.buf[0].size =3D arg->size;
+        pbufv =3D &tmpbufv;
+    } else {
+        /*
+         *  Input bufv contains the headers in the first element
+         * and the data in the rest, we need to skip that first element
+         */
+        ibufv->buf[0].size =3D 0;
     }
-    bufv.buf[0].size =3D arg->size;
=20
-    se->op.write_buf(req, nodeid, &bufv, arg->offset, &fi);
+    se->op.write_buf(req, nodeid, pbufv, arg->offset, &fi);
 }
=20
 static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
@@ -2024,13 +2034,24 @@ static const char *opname(enum fuse_opcode opcode)
 void fuse_session_process_buf(struct fuse_session *se,
                               const struct fuse_buf *buf)
 {
-    fuse_session_process_buf_int(se, buf, NULL);
+    struct fuse_bufvec bufv =3D { .buf[0] =3D *buf, .count =3D 1 };
+    fuse_session_process_buf_int(se, &bufv, NULL);
 }
=20
+/*
+ * Restriction:
+ *   bufv is normally a single entry buffer, except for a write
+ *   where (if it's in memory) then the bufv may be multiple entries,
+ *   where the first entry contains all headers and subsequent entries
+ *   contain data
+ *   bufv shall not use any offsets etc to make the data anything
+ *   other than contiguous starting from 0.
+ */
 void fuse_session_process_buf_int(struct fuse_session *se,
-                                  const struct fuse_buf *buf,
+                                  struct fuse_bufvec *bufv,
                                   struct fuse_chan *ch)
 {
+    const struct fuse_buf *buf =3D bufv->buf;
     struct fuse_in_header *in;
     const void *inarg;
     struct fuse_req *req;
@@ -2108,7 +2129,7 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
=20
     inarg =3D (void *)&in[1];
     if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf) {
-        do_write_buf(req, in->nodeid, inarg, buf);
+        do_write_buf(req, in->nodeid, inarg, bufv);
     } else {
         fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
     }
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 635f87756a..fd588a4829 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -501,7 +501,8 @@ static void *fv_queue_thread(void *opaque)
             /* TODO! Endianness of header */
=20
             /* TODO: Add checks for fuse_session_exited */
-            fuse_session_process_buf_int(se, &fbuf, &ch);
+            struct fuse_bufvec bufv =3D { .buf[0] =3D fbuf, .count =3D 1 }=
;
+            fuse_session_process_buf_int(se, &bufv, &ch);
=20
             if (!qi->reply_sent) {
                 fuse_log(FUSE_LOG_DEBUG, "%s: elem %d no reply sent\n",
--=20
2.24.1


