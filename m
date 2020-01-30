Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D9AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF512083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8XAfLtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF512083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHY3-0004hX-3V
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHQa-000088-T8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHQZ-0006eq-SM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:32:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHQZ-0006ca-OO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a44NGMn6vruT3WLbd+9LXW35cusyc+fsGPwVh38cNRU=;
 b=d8XAfLtdDguIIw0Kdi5Qul7uJnCdXgjwQtIY5vqN9az9lg/HrnuBncN4O4WEqVihIah4aC
 sbYB9KfOl3IsajJLO3uUet8aQLeue/kFsij7wPAPSYK9SS8N9b6wvnr4vFC2DrCcy58eWz
 d+IIWJx0s1zbu5l/flpiSZakjzwxa6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-AOYuaHChMS20BXrLL49Tkg-1; Thu, 30 Jan 2020 16:32:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E54F1005513;
 Thu, 30 Jan 2020 21:32:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEFEA7792C;
 Thu, 30 Jan 2020 21:32:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] block/io_uring: adds userspace completion polling
Date: Thu, 30 Jan 2020 21:31:09 +0000
Message-Id: <20200130213114.325157-14-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
References: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: AOYuaHChMS20BXrLL49Tkg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20200120141858.587874-11-stefanha@redhat.com
Message-Id: <20200120141858.587874-11-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index a5c0d16220..56892fd1ab 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -274,6 +274,21 @@ static void qemu_luring_completion_cb(void *opaque)
     luring_process_completions_and_submit(s);
 }
=20
+static bool qemu_luring_poll_cb(void *opaque)
+{
+    LuringState *s =3D opaque;
+    struct io_uring_cqe *cqes;
+
+    if (io_uring_peek_cqe(&s->ring, &cqes) =3D=3D 0) {
+        if (cqes) {
+            luring_process_completions_and_submit(s);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void ioq_init(LuringQueue *io_q)
 {
     QSIMPLEQ_INIT(&io_q->submit_queue);
@@ -387,7 +402,7 @@ void luring_attach_aio_context(LuringState *s, AioConte=
xt *new_context)
     s->aio_context =3D new_context;
     s->completion_bh =3D aio_bh_new(new_context, qemu_luring_completion_bh=
, s);
     aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
-                       qemu_luring_completion_cb, NULL, NULL, s);
+                       qemu_luring_completion_cb, NULL, qemu_luring_poll_c=
b, s);
 }
=20
 LuringState *luring_init(Error **errp)
--=20
2.24.1


