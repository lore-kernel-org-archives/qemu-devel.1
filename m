Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD26C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C9E20658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Huu+x7lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C9E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrl4-0000Zu-6h
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHriA-0005sj-To
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHri9-0004yk-OQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57275)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHri9-0004w1-JD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585325997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzIgZ8XqoLLXDLEutOzkw+h9pS2LHHFl9byIIxdSFP0=;
 b=Huu+x7ljOEnkiu5lI+ZQV4XV9pEW6xGLX4I8JAb9LuOTukoEiZv721X1LykurcCU5D/alS
 H0LwiJhT9wJnhIWtWzvjx7hYxx44CDCp0t4pYNkxWkjfa7dxOhFRiqzwJUyDttwaUwSbAc
 gr2Ndkzfh6K1iwFOqLSe/vP6MoGxjDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-32P2UKB7Me2BomMIpZ-pUg-1; Fri, 27 Mar 2020 12:19:53 -0400
X-MC-Unique: 32P2UKB7Me2BomMIpZ-pUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B97C80257F;
 Fri, 27 Mar 2020 16:19:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDB025C1D8;
 Fri, 27 Mar 2020 16:19:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] nbd: Use shutdown(SHUT_WR) after last item sent
Date: Fri, 27 Mar 2020 11:19:36 -0500
Message-Id: <20200327161936.2225989-4-eblake@redhat.com>
In-Reply-To: <20200327161936.2225989-1-eblake@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although the remote end should always be tolerant of a socket being
arbitrarily closed, there are situations where it is a lot easier if
the remote end can be guaranteed to read EOF even before the socket
has closed.  In particular, when using gnutls, if we fail to inform
the remote end about an impending teardown, the remote end cannot
distinguish between our closing the socket as intended vs. a malicious
intermediary interrupting things, and may result in spurious error
messages.  Or, we can end up with a deadlock where both ends are stuck
on a read() from the other end but neither gets an EOF.  Thus, after
any time a client sends NBD_OPT_ABORT or NBD_CMD_DISC, or a server has
finished replying (where appropriate) to such a request, it is worth
informing the channel that we will not be transmitting anything else.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c  | 1 +
 nbd/client.c | 3 ++-
 nbd/server.c | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 2160859f6499..2906484390f9 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1402,6 +1402,7 @@ static void nbd_client_close(BlockDriverState *bs)

     if (s->ioc) {
         nbd_send_request(s->ioc, &request);
+        qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_WRITE, NULL);
     }

     nbd_teardown_connection(bs);
diff --git a/nbd/client.c b/nbd/client.c
index ba173108baab..1b8b3a9ae3bd 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2019 Red Hat, Inc.
+ *  Copyright (C) 2016-2020 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -103,6 +103,7 @@ static void nbd_send_opt_abort(QIOChannel *ioc)
      * even care if the request makes it to the server, let alone
      * waiting around for whether the server replies. */
     nbd_send_option_request(ioc, NBD_OPT_ABORT, 0, NULL, NULL);
+    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_WRITE, NULL);
 }


diff --git a/nbd/server.c b/nbd/server.c
index 02b1ed080145..e21a1f662cc2 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1168,6 +1168,8 @@ static int nbd_negotiate_options(NBDClient *client, E=
rror **errp)
                                    "Option 0x%" PRIx32
                                    " not permitted before TLS", option);
                 if (option =3D=3D NBD_OPT_ABORT) {
+                    qio_channel_shutdown(client->ioc,
+                                         QIO_CHANNEL_SHUTDOWN_WRITE, NULL)=
;
                     return 1;
                 }
                 break;
@@ -1187,6 +1189,8 @@ static int nbd_negotiate_options(NBDClient *client, E=
rror **errp)
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
                 nbd_negotiate_send_rep(client, NBD_REP_ACK, NULL);
+                qio_channel_shutdown(client->ioc,
+                                     QIO_CHANNEL_SHUTDOWN_WRITE, NULL);
                 return 1;

             case NBD_OPT_EXPORT_NAME:
--=20
2.26.0.rc2


