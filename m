Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2479C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8CD20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gu6DlJvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8CD20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcPN-0007EM-Ns
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ihcGL-0003Lj-4G
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ihcGJ-0001x0-PS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:33:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ihcGJ-0001sq-Jf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576686803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CH5VXwZlwL83zczRIPWaQ6ySqX8xzOLWMH4GZYtfmQo=;
 b=Gu6DlJvOekIvbvrJORpwPTKVjCJmXkKPzaM6pChpChdX1Vt9Ufx4vfVLkE59DciKyO/8pv
 6WItvHgOcokiWp0BVPgI4kIGzsz8CjUpG81zLfmreA9EKkpdjHI8u0uC7EyQWmjSWnHepW
 v7IuoNTNY/w8xg9wa5iKW83n/ViuS9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-aDBM15ZbOS6RWTkFcajAwg-1; Wed, 18 Dec 2019 11:33:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88606800D4E;
 Wed, 18 Dec 2019 16:33:20 +0000 (UTC)
Received: from localhost (unknown [10.36.118.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E731F5C1D4;
 Wed, 18 Dec 2019 16:33:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 06/15] util/async: add aio interfaces for io_uring
Date: Wed, 18 Dec 2019 16:32:19 +0000
Message-Id: <20191218163228.1613099-7-stefanha@redhat.com>
In-Reply-To: <20191218163228.1613099-1-stefanha@redhat.com>
References: <20191218163228.1613099-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: aDBM15ZbOS6RWTkFcajAwg-1
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, oleksandr@redhat.com,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/async.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/util/async.c b/util/async.c
index b1fa5319e5..c192a24a61 100644
--- a/util/async.c
+++ b/util/async.c
@@ -276,6 +276,14 @@ aio_ctx_finalize(GSource     *source)
     }
 #endif
=20
+#ifdef CONFIG_LINUX_IO_URING
+    if (ctx->linux_io_uring) {
+        luring_detach_aio_context(ctx->linux_io_uring, ctx);
+        luring_cleanup(ctx->linux_io_uring);
+        ctx->linux_io_uring =3D NULL;
+    }
+#endif
+
     assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
     qemu_bh_delete(ctx->co_schedule_bh);
=20
@@ -340,6 +348,29 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
 }
 #endif
=20
+#ifdef CONFIG_LINUX_IO_URING
+LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp)
+{
+    if (ctx->linux_io_uring) {
+        return ctx->linux_io_uring;
+    }
+
+    ctx->linux_io_uring =3D luring_init(errp);
+    if (!ctx->linux_io_uring) {
+        return NULL;
+    }
+
+    luring_attach_aio_context(ctx->linux_io_uring, ctx);
+    return ctx->linux_io_uring;
+}
+
+LuringState *aio_get_linux_io_uring(AioContext *ctx)
+{
+    assert(ctx->linux_io_uring);
+    return ctx->linux_io_uring;
+}
+#endif
+
 void aio_notify(AioContext *ctx)
 {
     /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
@@ -434,6 +465,11 @@ AioContext *aio_context_new(Error **errp)
 #ifdef CONFIG_LINUX_AIO
     ctx->linux_aio =3D NULL;
 #endif
+
+#ifdef CONFIG_LINUX_IO_URING
+    ctx->linux_io_uring =3D NULL;
+#endif
+
     ctx->thread_pool =3D NULL;
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
--=20
2.23.0


