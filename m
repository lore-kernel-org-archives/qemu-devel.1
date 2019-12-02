Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622F1C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220A62073C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LplcCK1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220A62073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnjn-0006b2-6E
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibncL-0006dW-6O
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibncH-0002Hj-LL
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:28:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibncF-0002FU-P3
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575300478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kcUZTGSiLMTPm77liPqmIhGfhTUFPmm1VSRjsADLlM=;
 b=LplcCK1jm33rAY7hd/eNEMDxI/UlFJ5r2osLqUaQCOG7hMl1Lq39wpUKBWoRPrxWPjLk5G
 bsR28XNg8mfQKrC9u3zZDR8YtE16IRTvSxO2x6ZPRTzzPwWYDPXLlqY790ZdQbJNUQSaFx
 H1fNvFtV1Au0cnd62P7/rgJhB3pMj3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-O79bpIUPMbuSYLELkLm5qQ-1; Mon, 02 Dec 2019 10:27:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3ECB8C02D1
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 15:27:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93F5D5E240;
 Mon,  2 Dec 2019 15:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F70311385C7; Mon,  2 Dec 2019 16:27:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-4.2 1/3] net/virtio: Drop useless n->primary_dev not null
 checks
Date: Mon,  2 Dec 2019 16:27:44 +0100
Message-Id: <20191202152746.32292-2-armbru@redhat.com>
In-Reply-To: <20191202152746.32292-1-armbru@redhat.com>
References: <20191202152746.32292-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: O79bpIUPMbuSYLELkLm5qQ-1
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
Cc: Jens Freimann <jfreimann@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio_net_handle_migration_primary() returns early when it can't
ensure n->primary_dev is non-null.  Checking it again right after that
early return is redundant.  Drop.

If n->primary_dev is null on entering failover_replug_primary(), @pdev
will become null, and pdev->partially_hotplugged will crash.  Checking
n->primary_dev later is useless.  It can't actually be null, because
its caller virtio_net_handle_migration_primary() ensures it isn't.
Drop the useless check.

Cc: Jens Freimann <jfreimann@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191130194240.10517-2-armbru@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/net/virtio-net.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3c31471026..87088ba374 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2810,11 +2810,6 @@ static bool failover_replug_primary(VirtIONet *n, Er=
ror **errp)
             goto out;
         }
     }
-    if (!n->primary_dev) {
-            error_setg(errp, "virtio_net: couldn't find primary device");
-            goto out;
-    }
-
     n->primary_bus =3D n->primary_dev->parent_bus;
     if (!n->primary_bus) {
         error_setg(errp, "virtio_net: couldn't find primary bus");
@@ -2849,8 +2844,7 @@ static void virtio_net_handle_migration_primary(VirtI=
ONet *n,
         }
     }
=20
-    if (migration_in_setup(s) && !should_be_hidden &&
-        n->primary_dev) {
+    if (migration_in_setup(s) && !should_be_hidden) {
         if (failover_unplug_primary(n)) {
             vmstate_unregister(n->primary_dev, qdev_get_vmsd(n->primary_de=
v),
                     n->primary_dev);
--=20
2.21.0


