Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB7DC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C012B2087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C012B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htERZ-0002j6-3p
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1htEQU-0001sz-E4
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1htEQS-0008QM-Qx
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:59:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1htELl-0005P0-Rl
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6B8D30C58AE;
 Thu,  1 Aug 2019 16:54:29 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0068C1000336;
 Thu,  1 Aug 2019 16:54:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 17:54:07 +0100
Message-Id: <20190801165409.20121-3-stefanha@redhat.com>
In-Reply-To: <20190801165409.20121-1-stefanha@redhat.com>
References: <20190801165409.20121-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 01 Aug 2019 16:54:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] virtiofsd: prevent FUSE_INIT/FUSE_DESTROY
 races
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running with multiple threads it can be tricky to handle
FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
malicious clients cannot trigger race conditions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_i.h        |  1 +
 contrib/virtiofsd/fuse_lowlevel.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index ff6e1b75ba..dcde9feb97 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -63,6 +63,7 @@ struct fuse_session {
 	struct fuse_req list;
 	struct fuse_req interrupts;
 	pthread_mutex_t lock;
+	pthread_rwlock_t init_rwlock;
 	int got_destroy;
 	int broken_splice_nonblock;
 	uint64_t notify_ctr;
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_l=
owlevel.c
index 6ebf237baa..483a1bc9be 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -2473,6 +2473,18 @@ void fuse_session_process_buf_int(struct fuse_sess=
ion *se,
 	req->ctx.pid =3D in->pid;
 	req->ch =3D ch ? fuse_chan_get(ch) : NULL;
=20
+	/* INIT and DESTROY requests are serialized, all other request types
+	 * run in parallel.  This prevents races between FUSE_INIT and ordinary
+	 * requests, FUSE_INIT and FUSE_INIT, FUSE_INIT and FUSE_DESTROY, and
+	 * FUSE_DESTROY and FUSE_DESTROY.
+	 */
+	if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INIT ||
+	    in->opcode =3D=3D FUSE_DESTROY) {
+		pthread_rwlock_wrlock(&se->init_rwlock);
+	} else {
+		pthread_rwlock_rdlock(&se->init_rwlock);
+	}
+
 	err =3D EIO;
 	if (!se->got_init) {
 		enum fuse_opcode expected;
@@ -2524,10 +2536,13 @@ void fuse_session_process_buf_int(struct fuse_ses=
sion *se,
 		do_write_buf(req, in->nodeid, &iter, bufv);
 	else
 		fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
+
+	pthread_rwlock_unlock(&se->init_rwlock);
 	return;
=20
 reply_err:
 	fuse_reply_err(req, err);
+	pthread_rwlock_unlock(&se->init_rwlock);
 }
=20
 #define LL_OPTION(n,o,v) \
@@ -2569,6 +2584,7 @@ void fuse_session_destroy(struct fuse_session *se)
 		if (se->op.destroy)
 			se->op.destroy(se->userdata, se);
 	}
+	pthread_rwlock_destroy(&se->init_rwlock);
 	pthread_mutex_destroy(&se->lock);
 	free(se->cuse_data);
 	if (se->fd !=3D -1)
@@ -2656,6 +2672,7 @@ struct fuse_session *fuse_session_new(struct fuse_a=
rgs *args,
 	list_init_req(&se->list);
 	list_init_req(&se->interrupts);
 	fuse_mutex_init(&se->lock);
+	pthread_rwlock_init(&se->init_rwlock, NULL);
=20
 	memcpy(&se->op, op, op_size);
 	se->owner =3D getuid();
--=20
2.21.0


