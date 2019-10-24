Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF50A20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihtJKcvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF50A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNc1a-0003de-6n
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHu-0003Pp-Ct
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHs-0008UA-Nr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHq-0008Tb-5P
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kc/gbo+upybElFbY3/lui49elaqZGdHA6I+6dPD8EcM=;
 b=ihtJKcvfyxYZ9bPKub7BTVUp1SUWPHh5cxSmlzEQkcsksKxZBAovxR0vGBuOLYgrih9Cq0
 UCKkF/lOd9jw0veBkvN34ZuJfEavsdoEgLan4Farq571rRTjByHFzALP4D5q4qYoUUkim8
 TwgcihL3dWDnu92nUCGa55iF7WBCNuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-uPdozyFLNn2UnDCjrxYpvA-1; Thu, 24 Oct 2019 07:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51B98107AD31;
 Thu, 24 Oct 2019 11:28:08 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB4A74524;
 Thu, 24 Oct 2019 11:28:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 11/25] virtiofsd: validate input buffer sizes in do_write_buf()
Date: Thu, 24 Oct 2019 12:27:04 +0100
Message-Id: <20191024112718.34657-12-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uPdozyFLNn2UnDCjrxYpvA-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

There is a small change in behavior: if fuse_write_in->size doesn't
match the input buffer size then the request is failed.  Previously
write requests with 1 fuse_buf element would truncate to
fuse_write_in->size.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.c | 62 +++++++++++++++++++------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 2bd2ba00b9..7927348398 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -1006,7 +1006,8 @@ static void do_write(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg,
+static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09 struct fuse_mbuf_iter *iter,
 =09=09=09 struct fuse_bufvec *ibufv)
 {
 =09struct fuse_session *se =3D req->se;
@@ -1015,34 +1016,36 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg,
 =09=09.buf[0] =3D ibufv->buf[0],
 =09=09.count =3D 1,
 =09};
-=09struct fuse_write_in *arg =3D (struct fuse_write_in *) inarg;
+=09struct fuse_write_in *arg;
+=09size_t arg_size =3D sizeof(*arg);
 =09struct fuse_file_info fi;
=20
 =09memset(&fi, 0, sizeof(fi));
+
+=09if (se->conn.proto_minor < 9) {
+=09=09arg_size =3D FUSE_COMPAT_WRITE_IN_SIZE;
+=09}
+
+=09arg =3D fuse_mbuf_iter_advance(iter, arg_size);
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09/* Only access non-compat fields here! */
+=09if (se->conn.proto_minor >=3D 9) {
+=09=09fi.lock_owner =3D arg->lock_owner;
+=09=09fi.flags =3D arg->flags;
+=09}
+
 =09fi.fh =3D arg->fh;
 =09fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
=20
 =09if (ibufv->count =3D=3D 1) {
-=09=09if (se->conn.proto_minor < 9) {
-=09=09=09tmpbufv.buf[0].mem =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE=
;
-=09=09=09tmpbufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09=09=09FUSE_COMPAT_WRITE_IN_SIZE;
-=09=09=09assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
-=09=09} else {
-=09=09=09fi.lock_owner =3D arg->lock_owner;
-=09=09=09fi.flags =3D arg->flags;
-=09=09=09if (!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD))
-=09=09=09=09tmpbufv.buf[0].mem =3D PARAM(arg);
-
-=09=09=09tmpbufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09=09=09sizeof(struct fuse_write_in);
-=09=09}
-=09=09if (tmpbufv.buf[0].size < arg->size) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small=
\n");
-=09=09=09fuse_reply_err(req, EIO);
-=09=09=09return;
-=09=09}
-=09=09tmpbufv.buf[0].size =3D arg->size;
+=09=09assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
+=09=09tmpbufv.buf[0].mem =3D ((char *) arg) + arg_size;
+=09=09tmpbufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
+=09=09=09=09       arg_size;
 =09=09pbufv =3D &tmpbufv;
 =09} else {
 =09=09// Input bufv contains the headers in the first element
@@ -1050,6 +1053,12 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg,
 =09=09ibufv->buf[0].size =3D 0;
 =09}
=20
+=09if (fuse_buf_size(pbufv) !=3D arg->size) {
+=09=09fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size doesn't matc=
h arg->size\n");
+=09=09fuse_reply_err(req, EIO);
+=09=09return;
+=09}
+
 =09se->op.write_buf(req, nodeid, pbufv, arg->offset, &fi);
 }
=20
@@ -2002,12 +2011,17 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
 =09=09=09=09  struct fuse_bufvec *bufv, struct fuse_chan *ch)
 {
 =09const struct fuse_buf *buf =3D bufv->buf;
+=09struct fuse_mbuf_iter iter =3D FUSE_MBUF_ITER_INIT(buf);
 =09struct fuse_in_header *in;
 =09const void *inarg;
 =09struct fuse_req *req;
 =09int err;
=20
-=09in =3D buf->mem;
+=09/* The first buffer must be a memory buffer */
+=09assert(!(buf->flags & FUSE_BUF_IS_FD));
+
+=09in =3D fuse_mbuf_iter_advance(&iter, sizeof(*in));
+=09assert(in); /* caller guarantees the input buffer is large enough */
=20
 =09if (se->debug) {
 =09=09fuse_log(FUSE_LOG_DEBUG,
@@ -2074,7 +2088,7 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
=20
 =09inarg =3D (void *) &in[1];
 =09if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf)
-=09=09do_write_buf(req, in->nodeid, inarg, bufv);
+=09=09do_write_buf(req, in->nodeid, &iter, bufv);
 =09else
 =09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
=20
--=20
2.23.0


