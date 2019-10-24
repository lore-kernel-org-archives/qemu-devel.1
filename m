Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1F3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 04:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E130F21655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 04:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E130F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNVC3-00087S-14
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 00:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1iNVAi-00076o-Md
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 00:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1iNVAh-0002N1-8l
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 00:56:28 -0400
Received: from 212-186-127-178.static.upcbusiness.at ([212.186.127.178]:39081
 helo=rtest1.maurer-it.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1iNVAg-0002Go-Uw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 00:56:27 -0400
Received: by rtest1.maurer-it.com (Postfix, from userid 0)
 id 0516E500AE8; Thu, 24 Oct 2019 06:56:16 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] yield_until_fd_readable: make it work with any AioContect
Date: Thu, 24 Oct 2019 06:56:10 +0200
Message-Id: <20191024045610.9071-1-dietmar@proxmox.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.178
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
Cc: Dietmar Maurer <dietmar@proxmox.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simply use qemu_get_current_aio_context().

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
Changelog for v4:

- avoid unsafe cast and keep fd_coroutine_enter()

Changelog for v3:

- use (IOHandler *) instead of ((void (*)(void *))
- coding style: fix max line length

Changelog for v2:

- use correct read handler in aio_set_fd_handler (instead of write handle=
r)

 util/qemu-coroutine-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 44a8969a69..5b80bb416f 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -67,6 +67,7 @@ qemu_co_send_recv(int sockfd, void *buf, size_t bytes, =
bool do_send)
 }
=20
 typedef struct {
+    AioContext *ctx;
     Coroutine *co;
     int fd;
 } FDYieldUntilData;
@@ -74,7 +75,7 @@ typedef struct {
 static void fd_coroutine_enter(void *opaque)
 {
     FDYieldUntilData *data =3D opaque;
-    qemu_set_fd_handler(data->fd, NULL, NULL, NULL);
+    aio_set_fd_handler(data->ctx, data->fd, false, NULL, NULL, NULL, NUL=
L);
     qemu_coroutine_enter(data->co);
 }
=20
@@ -83,8 +84,10 @@ void coroutine_fn yield_until_fd_readable(int fd)
     FDYieldUntilData data;
=20
     assert(qemu_in_coroutine());
+    data.ctx =3D qemu_get_current_aio_context();
     data.co =3D qemu_coroutine_self();
     data.fd =3D fd;
-    qemu_set_fd_handler(fd, fd_coroutine_enter, NULL, &data);
+    aio_set_fd_handler(
+        data.ctx, fd, false, fd_coroutine_enter, NULL, NULL, &data);
     qemu_coroutine_yield();
 }
--=20
2.20.1


