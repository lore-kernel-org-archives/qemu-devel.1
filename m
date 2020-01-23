Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B85C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDF92051A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5va55/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDF92051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudqJ-0003nS-Jv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAw-0004NW-5W
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAu-0006qZ-Um
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAu-0006qQ-RW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BaKkhOPYBmQm13qrx27mas1rTlYoHzoKc+rGhVsrGg=;
 b=H5va55/iVKynnKYG6Mje+VpMS9pqsOP8PxrX+ZzVb/lu33rQ+NBI35v6IwPzdvXUhOzWtN
 EeW/m2wrNPpSt1lSrOiZwBwFJqMDnPdUf+2C6DjMgg9wIZEK0fxrqxMzPmB+NiquyJMHeG
 uw+SaczocCMvYw6zCnalBwwF/zGq34I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-7D5pY-EGMwaY3skkFhWbng-1; Thu, 23 Jan 2020 07:01:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20F6B1005F64
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:01:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6779F85754;
 Thu, 23 Jan 2020 12:01:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 105/111] virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
Date: Thu, 23 Jan 2020 11:58:35 +0000
Message-Id: <20200123115841.138849-106-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 7D5pY-EGMwaY3skkFhWbng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Stefan Hajnoczi <stefanha@redhat.com>

When running with multiple threads it can be tricky to handle
FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
malicious clients cannot trigger race conditions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h        |  1 +
 tools/virtiofsd/fuse_lowlevel.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index a20854f1c4..1447d86866 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -61,6 +61,7 @@ struct fuse_session {
     struct fuse_req list;
     struct fuse_req interrupts;
     pthread_mutex_t lock;
+    pthread_rwlock_t init_rwlock;
     int got_destroy;
     int broken_splice_nonblock;
     uint64_t notify_ctr;
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index dab6a31e08..79a4031266 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2428,6 +2428,19 @@ void fuse_session_process_buf_int(struct fuse_sessio=
n *se,
     req->ctx.pid =3D in->pid;
     req->ch =3D ch;
=20
+    /*
+     * INIT and DESTROY requests are serialized, all other request types
+     * run in parallel.  This prevents races between FUSE_INIT and ordinar=
y
+     * requests, FUSE_INIT and FUSE_INIT, FUSE_INIT and FUSE_DESTROY, and
+     * FUSE_DESTROY and FUSE_DESTROY.
+     */
+    if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INIT ||
+        in->opcode =3D=3D FUSE_DESTROY) {
+        pthread_rwlock_wrlock(&se->init_rwlock);
+    } else {
+        pthread_rwlock_rdlock(&se->init_rwlock);
+    }
+
     err =3D EIO;
     if (!se->got_init) {
         enum fuse_opcode expected;
@@ -2485,10 +2498,13 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
     } else {
         fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
     }
+
+    pthread_rwlock_unlock(&se->init_rwlock);
     return;
=20
 reply_err:
     fuse_reply_err(req, err);
+    pthread_rwlock_unlock(&se->init_rwlock);
 }
=20
 #define LL_OPTION(n, o, v)                     \
@@ -2531,6 +2547,7 @@ void fuse_session_destroy(struct fuse_session *se)
             se->op.destroy(se->userdata);
         }
     }
+    pthread_rwlock_destroy(&se->init_rwlock);
     pthread_mutex_destroy(&se->lock);
     free(se->cuse_data);
     if (se->fd !=3D -1) {
@@ -2610,6 +2627,7 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
     list_init_req(&se->list);
     list_init_req(&se->interrupts);
     fuse_mutex_init(&se->lock);
+    pthread_rwlock_init(&se->init_rwlock, NULL);
=20
     memcpy(&se->op, op, op_size);
     se->owner =3D getuid();
--=20
2.24.1


