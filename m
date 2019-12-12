Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67067C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369D32067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCR/UcyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369D32067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSaX-0003kN-De
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXE-000851-SM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXC-0005CO-ER
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRXC-0005BS-A4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8yqdPTVQDekQjGPhaXS/9UYKrLqxCuFnNjgoVrw9LU=;
 b=KCR/UcyCOZa7JaRyjIxQ6F4+g8jFNX3X0M6E2ix1KWPgoshzvxNrMotvlpkvQaxXdL2xwq
 zDNSTEWPMeTYuWexFLGOf6a8vPEkFUx2Fb3dRSki65e1PmCt6Tk71rjxG8warl9iQmAGMZ
 uISuRphopIAEWMg4hY7rXdxMxN3/ExY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-QSRsO-2UPQ6H6QX_xbL3aA-1; Thu, 12 Dec 2019 11:41:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30DB612A7E53
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:45 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55F9560BE1;
 Thu, 12 Dec 2019 16:41:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 101/104] virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
Date: Thu, 12 Dec 2019 16:39:01 +0000
Message-Id: <20191212163904.159893-102-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QSRsO-2UPQ6H6QX_xbL3aA-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

When running with multiple threads it can be tricky to handle
FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
malicious clients cannot trigger race conditions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_i.h        |  1 +
 tools/virtiofsd/fuse_lowlevel.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index d0679508cd..8a4a05b319 100644
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
index 10f478b00c..9f01c05e3e 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2431,6 +2431,19 @@ void fuse_session_process_buf_int(struct fuse_sessio=
n *se,
     req->ctx.pid =3D in->pid;
     req->ch =3D ch ? fuse_chan_get(ch) : NULL;
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
@@ -2488,10 +2501,13 @@ void fuse_session_process_buf_int(struct fuse_sessi=
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
@@ -2538,6 +2554,7 @@ void fuse_session_destroy(struct fuse_session *se)
             se->op.destroy(se->userdata);
         }
     }
+    pthread_rwlock_destroy(&se->init_rwlock);
     pthread_mutex_destroy(&se->lock);
     free(se->cuse_data);
     if (se->fd !=3D -1) {
@@ -2631,6 +2648,7 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
     list_init_req(&se->list);
     list_init_req(&se->interrupts);
     fuse_mutex_init(&se->lock);
+    pthread_rwlock_init(&se->init_rwlock, NULL);
=20
     memcpy(&se->op, op, op_size);
     se->owner =3D getuid();
--=20
2.23.0


