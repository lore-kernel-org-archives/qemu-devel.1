Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C1ACA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F932166E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6sAKgGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F932166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVYD-00031W-Mu
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPa-0003QR-NF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPY-0003pm-Aq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVPW-0003pK-Sb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Np8/rc3kF6pAl1hV49lsE9rXiMXb4lFg8OnIENllNqs=;
 b=c6sAKgGJjEXhqpp50kKVUCmxfoBL+J1Bit+I/Ofo6dPXkk2Fo7JeKn7vm4eCs8n6ZDbvan
 fDmGXIpMaBejOqff3EkVevzYZxWFVU8ixk3MA7tR8dH7CwZku8HzZMhaduvMlEjZ5wm0ou
 3iu4LpmMY6C9qhbVx/i+wJz6ua2k4iI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-8wceR2idOc--d_XCki8kNQ-1; Mon, 21 Oct 2019 06:59:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3784107AD31;
 Mon, 21 Oct 2019 10:59:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF42614C1;
 Mon, 21 Oct 2019 10:59:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 08/30] virtiofsd: remove unused notify reply support
Date: Mon, 21 Oct 2019 11:58:10 +0100
Message-Id: <20191021105832.36574-9-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8wceR2idOc--d_XCki8kNQ-1
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Notify reply support is unused by virtiofsd.  The code would need to be
updated to validate input buffer sizes.  Remove this unused code since
changes to it are untestable.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.c | 142 +-----------------------------
 contrib/virtiofsd/fuse_lowlevel.h |  47 ----------
 2 files changed, 1 insertion(+), 188 deletions(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 2f40510707..a36a00e793 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -33,10 +33,6 @@
 #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
-#define container_of(ptr, type, member) ({=09=09=09=09\
-=09=09=09const typeof( ((type *)0)->member ) *__mptr =3D (ptr); \
-=09=09=09(type *)( (char *)__mptr - offsetof(type,member) );})
-
 struct fuse_pollhandle {
 =09uint64_t kh;
 =09struct fuse_session *se;
@@ -1735,51 +1731,6 @@ static void do_destroy(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
 =09send_reply_ok(req, NULL, 0);
 }
=20
-static void list_del_nreq(struct fuse_notify_req *nreq)
-{
-=09struct fuse_notify_req *prev =3D nreq->prev;
-=09struct fuse_notify_req *next =3D nreq->next;
-=09prev->next =3D next;
-=09next->prev =3D prev;
-}
-
-static void list_add_nreq(struct fuse_notify_req *nreq,
-=09=09=09  struct fuse_notify_req *next)
-{
-=09struct fuse_notify_req *prev =3D next->prev;
-=09nreq->next =3D next;
-=09nreq->prev =3D prev;
-=09prev->next =3D nreq;
-=09next->prev =3D nreq;
-}
-
-static void list_init_nreq(struct fuse_notify_req *nreq)
-{
-=09nreq->next =3D nreq;
-=09nreq->prev =3D nreq;
-}
-
-static void do_notify_reply(fuse_req_t req, fuse_ino_t nodeid,
-=09=09=09    const void *inarg, const struct fuse_buf *buf)
-{
-=09struct fuse_session *se =3D req->se;
-=09struct fuse_notify_req *nreq;
-=09struct fuse_notify_req *head;
-
-=09pthread_mutex_lock(&se->lock);
-=09head =3D &se->notify_list;
-=09for (nreq =3D head->next; nreq !=3D head; nreq =3D nreq->next) {
-=09=09if (nreq->unique =3D=3D req->unique) {
-=09=09=09list_del_nreq(nreq);
-=09=09=09break;
-=09=09}
-=09}
-=09pthread_mutex_unlock(&se->lock);
-
-=09if (nreq !=3D head)
-=09=09nreq->reply(nreq, req, nodeid, inarg, buf);
-}
-
 static int send_notify_iov(struct fuse_session *se, int notify_code,
 =09=09=09   struct iovec *iov, int count)
 {
@@ -1921,93 +1872,6 @@ int fuse_lowlevel_notify_store(struct fuse_session *=
se, fuse_ino_t ino,
 =09return res;
 }
=20
-struct fuse_retrieve_req {
-=09struct fuse_notify_req nreq;
-=09void *cookie;
-};
-
-static void fuse_ll_retrieve_reply(struct fuse_notify_req *nreq,
-=09=09=09=09   fuse_req_t req, fuse_ino_t ino,
-=09=09=09=09   const void *inarg,
-=09=09=09=09   const struct fuse_buf *ibuf)
-{
-=09struct fuse_session *se =3D req->se;
-=09struct fuse_retrieve_req *rreq =3D
-=09=09container_of(nreq, struct fuse_retrieve_req, nreq);
-=09const struct fuse_notify_retrieve_in *arg =3D inarg;
-=09struct fuse_bufvec bufv =3D {
-=09=09.buf[0] =3D *ibuf,
-=09=09.count =3D 1,
-=09};
-
-=09if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD))
-=09=09bufv.buf[0].mem =3D PARAM(arg);
-
-=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09sizeof(struct fuse_notify_retrieve_in);
-
-=09if (bufv.buf[0].size < arg->size) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: retrieve reply: buffer size too small\=
n");
-=09=09fuse_reply_none(req);
-=09=09goto out;
-=09}
-=09bufv.buf[0].size =3D arg->size;
-
-=09if (se->op.retrieve_reply) {
-=09=09se->op.retrieve_reply(req, rreq->cookie, ino,
-=09=09=09=09=09  arg->offset, &bufv);
-=09} else {
-=09=09fuse_reply_none(req);
-=09}
-out:
-=09free(rreq);
-}
-
-int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
-=09=09=09=09  size_t size, off_t offset, void *cookie)
-{
-=09struct fuse_notify_retrieve_out outarg;
-=09struct iovec iov[2];
-=09struct fuse_retrieve_req *rreq;
-=09int err;
-
-=09if (!se)
-=09=09return -EINVAL;
-
-=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 15)
-=09=09return -ENOSYS;
-
-=09rreq =3D malloc(sizeof(*rreq));
-=09if (rreq =3D=3D NULL)
-=09=09return -ENOMEM;
-
-=09pthread_mutex_lock(&se->lock);
-=09rreq->cookie =3D cookie;
-=09rreq->nreq.unique =3D se->notify_ctr++;
-=09rreq->nreq.reply =3D fuse_ll_retrieve_reply;
-=09list_add_nreq(&rreq->nreq, &se->notify_list);
-=09pthread_mutex_unlock(&se->lock);
-
-=09outarg.notify_unique =3D rreq->nreq.unique;
-=09outarg.nodeid =3D ino;
-=09outarg.offset =3D offset;
-=09outarg.size =3D size;
-=09outarg.padding =3D 0;
-
-=09iov[1].iov_base =3D &outarg;
-=09iov[1].iov_len =3D sizeof(outarg);
-
-=09err =3D send_notify_iov(se, FUSE_NOTIFY_RETRIEVE, iov, 2);
-=09if (err) {
-=09=09pthread_mutex_lock(&se->lock);
-=09=09list_del_nreq(&rreq->nreq);
-=09=09pthread_mutex_unlock(&se->lock);
-=09=09free(rreq);
-=09}
-
-=09return err;
-}
-
 void *fuse_req_userdata(fuse_req_t req)
 {
 =09return req->se->userdata;
@@ -2085,7 +1949,7 @@ static struct {
 =09[FUSE_POLL]=09   =3D { do_poll,        "POLL"=09     },
 =09[FUSE_FALLOCATE]   =3D { do_fallocate,   "FALLOCATE"   },
 =09[FUSE_DESTROY]=09   =3D { do_destroy,     "DESTROY"     },
-=09[FUSE_NOTIFY_REPLY] =3D { (void *) 1,    "NOTIFY_REPLY" },
+=09[FUSE_NOTIFY_REPLY] =3D { NULL,    "NOTIFY_REPLY" },
 =09[FUSE_BATCH_FORGET] =3D { do_batch_forget, "BATCH_FORGET" },
 =09[FUSE_READDIRPLUS] =3D { do_readdirplus,=09"READDIRPLUS"},
 =09[FUSE_RENAME2]     =3D { do_rename2,      "RENAME2"    },
@@ -2185,8 +2049,6 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
 =09inarg =3D (void *) &in[1];
 =09if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf)
 =09=09do_write_buf(req, in->nodeid, inarg, buf);
-=09else if (in->opcode =3D=3D FUSE_NOTIFY_REPLY)
-=09=09do_notify_reply(req, in->nodeid, inarg, buf);
 =09else
 =09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
=20
@@ -2297,8 +2159,6 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
=20
 =09list_init_req(&se->list);
 =09list_init_req(&se->interrupts);
-=09list_init_nreq(&se->notify_list);
-=09se->notify_ctr =3D 1;
 =09fuse_mutex_init(&se->lock);
=20
 =09memcpy(&se->op, op, op_size);
diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index b0566ea21d..018e7c0be0 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -1085,21 +1085,6 @@ struct fuse_lowlevel_ops {
 =09=09=09   struct fuse_bufvec *bufv, off_t off,
 =09=09=09   struct fuse_file_info *fi);
=20
-=09/**
-=09 * Callback function for the retrieve request
-=09 *
-=09 * Valid replies:
-=09 *=09fuse_reply_none
-=09 *
-=09 * @param req request handle
-=09 * @param cookie user data supplied to fuse_lowlevel_notify_retrieve()
-=09 * @param ino the inode number supplied to fuse_lowlevel_notify_retriev=
e()
-=09 * @param offset the offset supplied to fuse_lowlevel_notify_retrieve()
-=09 * @param bufv the buffer containing the returned data
-=09 */
-=09void (*retrieve_reply) (fuse_req_t req, void *cookie, fuse_ino_t ino,
-=09=09=09=09off_t offset, struct fuse_bufvec *bufv);
-
 =09/**
 =09 * Forget about multiple inodes
 =09 *
@@ -1696,38 +1681,6 @@ int fuse_lowlevel_notify_delete(struct fuse_session =
*se,
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 =09=09=09       off_t offset, struct fuse_bufvec *bufv,
 =09=09=09       enum fuse_buf_copy_flags flags);
-/**
- * Retrieve data from the kernel buffers
- *
- * Retrieve data in the kernel buffers belonging to the given inode.
- * If successful then the retrieve_reply() method will be called with
- * the returned data.
- *
- * Only present pages are returned in the retrieve reply.  Retrieving
- * stops when it finds a non-present page and only data prior to that
- * is returned.
- *
- * If this function returns an error, then the retrieve will not be
- * completed and no reply will be sent.
- *
- * This function doesn't change the dirty state of pages in the kernel
- * buffer.  For dirty pages the write() method will be called
- * regardless of having been retrieved previously.
- *
- * Added in FUSE protocol version 7.15. If the kernel does not support
- * this (or a newer) version, the function will return -ENOSYS and do
- * nothing.
- *
- * @param se the session object
- * @param ino the inode number
- * @param size the number of bytes to retrieve
- * @param offset the starting offset into the file to retrieve from
- * @param cookie user data to supply to the reply callback
- * @return zero for success, -errno for failure
- */
-int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
-=09=09=09=09  size_t size, off_t offset, void *cookie);
-
=20
 /* ----------------------------------------------------------- *
  * Utility functions=09=09=09=09=09       *
--=20
2.23.0


