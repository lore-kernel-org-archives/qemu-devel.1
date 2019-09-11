Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C15C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A832075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A832075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85LE-0007Pf-PU
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i85Im-0005oL-24
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i85Ik-0006TZ-6D
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>)
 id 1i85Ih-0006Q7-Iq; Wed, 11 Sep 2019 12:16:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFB0918CB8E7;
 Wed, 11 Sep 2019 16:16:58 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA2035D704;
 Wed, 11 Sep 2019 16:16:52 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 11 Sep 2019 18:15:22 +0200
Message-Id: <20190911161521.59261-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 11 Sep 2019 16:16:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] nbd/server: attach client channel to the
 export's AioContext
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On creation, the export's AioContext is set to the same one as the
BlockBackend, while the AioContext in the client QIOChannel is left
untouched.

As a result, when using data-plane, nbd_client_receive_next_request()
schedules coroutines in the IOThread AioContext, while the client's
QIOChannel is serviced from the main_loop, potentially triggering the
assertion at qio_channel_restart_[read|write].

To fix this, as soon we have the export corresponding to the client,
we call qio_channel_attach_aio_context() to attach the QIOChannel
context to the export's AioContext. This matches with the logic in
blk_aio_attached().

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1748253
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 nbd/server.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 10faedcfc5..51322e2343 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -471,6 +471,7 @@ static int nbd_negotiate_handle_export_name(NBDClient=
 *client,
     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
     nbd_export_get(client->exp);
     nbd_check_meta_export(client);
+    qio_channel_attach_aio_context(client->ioc, client->exp->ctx);
=20
     return 0;
 }
@@ -673,6 +674,7 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, uint16_t myflags,
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         nbd_export_get(client->exp);
         nbd_check_meta_export(client);
+        qio_channel_attach_aio_context(client->ioc, exp->ctx);
         rc =3D 1;
     }
     return rc;
--=20
2.21.0


