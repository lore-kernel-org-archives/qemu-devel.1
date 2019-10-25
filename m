Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DFF20679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHyQhJUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DFF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5B7-0002iV-SG
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iO578-0003O3-Iq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iO577-00041U-BW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:19:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iO577-00041B-8E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572031148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sr17DgsbZ7ImG015LCCWf023lD0EvitkEuYcDLqFRmo=;
 b=aHyQhJUgpLTjtMIY4WZOWBK4VDBVR7vwULfu2ZPMrsMlDsg4UxrE0SoGWn4CB4ZW9yaecv
 v8lXuBtoRN4HJwxkzenF19dk/4fJxzpxA5n8OyWeEku80MuS2barFMr/u75DZvqG1MVl0T
 cVmLQNcpb1Ts7M5R5mau32Kkfv6JhrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-aDvGPMy_PsyqcM1HYpR5Vg-1; Fri, 25 Oct 2019 15:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 224D780183E;
 Fri, 25 Oct 2019 19:19:04 +0000 (UTC)
Received: from localhost (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26A315D9C9;
 Fri, 25 Oct 2019 19:18:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] yield_until_fd_readable: make it work with any AioContect
Date: Fri, 25 Oct 2019 21:18:39 +0200
Message-Id: <20191025191839.1215-3-stefanha@redhat.com>
In-Reply-To: <20191025191839.1215-1-stefanha@redhat.com>
References: <20191025191839.1215-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: aDvGPMy_PsyqcM1HYpR5Vg-1
X-Mimecast-Spam-Score: 0
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
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dietmar Maurer <dietmar@proxmox.com>

Simply use qemu_get_current_aio_context().

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
Message-Id: <20191024045610.9071-1-dietmar@proxmox.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/qemu-coroutine-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 44a8969a69..5b80bb416f 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -67,6 +67,7 @@ qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bo=
ol do_send)
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
+    aio_set_fd_handler(data->ctx, data->fd, false, NULL, NULL, NULL, NULL)=
;
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
2.21.0


