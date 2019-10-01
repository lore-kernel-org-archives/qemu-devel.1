Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAD3ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721E721872
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721E721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIFC-0003cY-Kq
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iFIAy-0000Nd-J2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iFIAx-0000ZA-G7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iFIAx-0000YR-4L
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60CCE30715F9;
 Tue,  1 Oct 2019 13:26:46 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01FFE60BDF;
 Tue,  1 Oct 2019 13:26:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] win32: fix main-loop busy loop on socket/fd event
Date: Tue,  1 Oct 2019 17:26:09 +0400
Message-Id: <20191001132609.23184-4-marcandre.lureau@redhat.com>
In-Reply-To: <20191001132609.23184-1-marcandre.lureau@redhat.com>
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 01 Oct 2019 13:26:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, James Le Cuirot <chewi@gentoo.org>,
 berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 05e514b1d4d5bd4209e2c8bbc76ff05c85a235f3 introduced an AIO
context optimization to avoid calling event_notifier_test_and_clear() on
ctx->notifier. On Windows, the same notifier is being used to wakeup the
wait on socket events (see commit
d3385eb448e38f828c78f8f68ec5d79c66a58b5d).

The ctx->notifier event is added to the gpoll sources in
aio_set_event_notifier(), aio_ctx_check() should clear the event
regardless of ctx->notified, since Windows sets the event by itself,
bypassing the aio->notified. This fixes qemu not clearing the event
resulting in a busy loop.

Paolo suggested to me on irc to call event_notifier_test_and_clear()
after select() >0 from aio-win32.c's aio_prepare. Unfortunately, not all
fds associated with ctx->notifiers are in AIO fd handlers set.
(qemu_set_nonblock() in util/oslib-win32.c calls qemu_fd_register()).

This is essentially a v2 of a patch that was sent earlier:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00420.html

that resurfaced when James investigated Spice performance issues on Windo=
ws:
https://gitlab.freedesktop.org/spice/spice/issues/36

In order to test that patch, I simply tried running test-char on
win32, and it hangs. Applying that patch solves it. QIO idle sources
are not dispatched. I haven't investigated much further, I suspect
source priorities and busy looping still come into play.

This version keeps the "notified" field, so event_notifier_poll()
should still work as expected.

Cc: James Le Cuirot <chewi@gentoo.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/async.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 4e4c7af51e..ca83e32c7f 100644
--- a/util/async.c
+++ b/util/async.c
@@ -354,7 +354,11 @@ void aio_notify(AioContext *ctx)
=20
 void aio_notify_accept(AioContext *ctx)
 {
-    if (atomic_xchg(&ctx->notified, false)) {
+    if (atomic_xchg(&ctx->notified, false)
+#ifdef WIN32
+        || true
+#endif
+    ) {
         event_notifier_test_and_clear(&ctx->notifier);
     }
 }
--=20
2.23.0


