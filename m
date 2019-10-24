Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F175CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7A320856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf/cMqMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7A320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbxr-00063w-Cu
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHe-0002mh-VP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHd-0008R2-GP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34995
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHd-0008Qi-CB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kmNhZHrq0m4CvYxseyl13rsoPKAYCBCzN65QhazXD4=;
 b=Tf/cMqMH10eTLoin94I7xf+UXzHZS3llJc04Zjh0PNDaDzjJYxoPV3fQw4aM4dcYTUXOm2
 hEHfOn2t+hKHDKD/ZmF9wM18GqpuXvNYi3DACjLp1t7nBkqNKC1nmbP4TMlbOVThy5IkR5
 tHOEGWCm2R3kC2Jq37gNr90nRSNrkCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-mmvMSa-bPmmEGLr66kNHUg-1; Thu, 24 Oct 2019 07:27:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D754C100550E;
 Thu, 24 Oct 2019 11:27:54 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E86C1C93D;
 Thu, 24 Oct 2019 11:27:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 08/25] virtiofsd: Plumb fuse_bufvec through to do_write_buf
Date: Thu, 24 Oct 2019 12:27:01 +0100
Message-Id: <20191024112718.34657-9-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mmvMSa-bPmmEGLr66kNHUg-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Let fuse_session_process_buf_int take a fuse_bufvec * instead of a
fuse_buf;  and then through to do_write_buf - where in the best
case it can pass that stragiht through to op.write_buf without copying
(other than ksipping a header).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_i.h        |  2 +-
 contrib/virtiofsd/fuse_lowlevel.c | 67 +++++++++++++++++++------------
 contrib/virtiofsd/fuse_virtio.c   |  3 +-
 3 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index 4b718f1aec..06f3d88a44 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -119,7 +119,7 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int erro=
r, struct iovec *iov,
 void fuse_free_req(fuse_req_t req);
=20
 void fuse_session_process_buf_int(struct fuse_session *se,
-=09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch);
+=09=09=09=09  struct fuse_bufvec *bufv, struct fuse_chan *ch);
=20
=20
 #define FUSE_MAX_MAX_PAGES 256
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index dd046ecf07..2bd2ba00b9 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -1007,11 +1007,12 @@ static void do_write(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 }
=20
 static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg,
-=09=09=09 const struct fuse_buf *ibuf)
+=09=09=09 struct fuse_bufvec *ibufv)
 {
 =09struct fuse_session *se =3D req->se;
-=09struct fuse_bufvec bufv =3D {
-=09=09.buf[0] =3D *ibuf,
+=09struct fuse_bufvec *pbufv =3D ibufv;
+=09struct fuse_bufvec tmpbufv =3D {
+=09=09.buf[0] =3D ibufv->buf[0],
 =09=09.count =3D 1,
 =09};
 =09struct fuse_write_in *arg =3D (struct fuse_write_in *) inarg;
@@ -1021,28 +1022,35 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg,
 =09fi.fh =3D arg->fh;
 =09fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
=20
-=09if (se->conn.proto_minor < 9) {
-=09=09bufv.buf[0].mem =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
-=09=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09=09FUSE_COMPAT_WRITE_IN_SIZE;
-=09=09assert(!(bufv.buf[0].flags & FUSE_BUF_IS_FD));
-=09} else {
-=09=09fi.lock_owner =3D arg->lock_owner;
-=09=09fi.flags =3D arg->flags;
-=09=09if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD))
-=09=09=09bufv.buf[0].mem =3D PARAM(arg);
+=09if (ibufv->count =3D=3D 1) {
+=09=09if (se->conn.proto_minor < 9) {
+=09=09=09tmpbufv.buf[0].mem =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE=
;
+=09=09=09tmpbufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
+=09=09=09=09FUSE_COMPAT_WRITE_IN_SIZE;
+=09=09=09assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
+=09=09} else {
+=09=09=09fi.lock_owner =3D arg->lock_owner;
+=09=09=09fi.flags =3D arg->flags;
+=09=09=09if (!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD))
+=09=09=09=09tmpbufv.buf[0].mem =3D PARAM(arg);
=20
-=09=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09=09sizeof(struct fuse_write_in);
-=09}
-=09if (bufv.buf[0].size < arg->size) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small\n"=
);
-=09=09fuse_reply_err(req, EIO);
-=09=09return;
+=09=09=09tmpbufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
+=09=09=09=09sizeof(struct fuse_write_in);
+=09=09}
+=09=09if (tmpbufv.buf[0].size < arg->size) {
+=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small=
\n");
+=09=09=09fuse_reply_err(req, EIO);
+=09=09=09return;
+=09=09}
+=09=09tmpbufv.buf[0].size =3D arg->size;
+=09=09pbufv =3D &tmpbufv;
+=09} else {
+=09=09// Input bufv contains the headers in the first element
+=09=09// and the data in the rest, we need to skip that first element
+=09=09ibufv->buf[0].size =3D 0;
 =09}
-=09bufv.buf[0].size =3D arg->size;
=20
-=09se->op.write_buf(req, nodeid, &bufv, arg->offset, &fi);
+=09se->op.write_buf(req, nodeid, pbufv, arg->offset, &fi);
 }
=20
 static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
@@ -1979,12 +1987,21 @@ static const char *opname(enum fuse_opcode opcode)
 void fuse_session_process_buf(struct fuse_session *se,
 =09=09=09      const struct fuse_buf *buf)
 {
-=09fuse_session_process_buf_int(se, buf, NULL);
+=09struct fuse_bufvec bufv =3D { .buf[0] =3D *buf, .count =3D 1 };
+=09fuse_session_process_buf_int(se, &bufv, NULL);
 }
=20
+// Restriction:
+//   bufv is normally a single entry buffer, except for a write
+//   where (if it's in memory) then the bufv may be multiple entries,
+//   where the first entry contains all headers and subsequent entries
+//   contain data
+//   bufv shall not use any offsets etc to make the data anything
+//   other than contiguous starting from 0.
 void fuse_session_process_buf_int(struct fuse_session *se,
-=09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch)
+=09=09=09=09  struct fuse_bufvec *bufv, struct fuse_chan *ch)
 {
+=09const struct fuse_buf *buf =3D bufv->buf;
 =09struct fuse_in_header *in;
 =09const void *inarg;
 =09struct fuse_req *req;
@@ -2057,7 +2074,7 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
=20
 =09inarg =3D (void *) &in[1];
 =09if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf)
-=09=09do_write_buf(req, in->nodeid, inarg, buf);
+=09=09do_write_buf(req, in->nodeid, inarg, bufv);
 =09else
 =09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
=20
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 1f09fad93d..68036e2171 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -499,7 +499,8 @@ static void *fv_queue_thread(void *opaque)
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
2.23.0


