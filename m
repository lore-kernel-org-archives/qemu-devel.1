Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B35C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2455A2076C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csQmuuwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2455A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnli-0001Nl-9S
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 13:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCnkU-0008GE-3N
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCnkT-0006WZ-77
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCnkT-0006Vo-4N
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584119124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUaacz0F07iHwqBui53ieGg3mQimCJNRw9rjHNPi9Og=;
 b=csQmuuwoBG0QW8LR5+2xrF+sPs6Z6NiFFiX0H7IlL/l6S8QwnqhdzdIkWh+jTTNk4MQPxz
 rRiiAiiyCYmy4RmLDsrKkoT0G//Rzz5/0Hk0qoKPvtil3tey8a9eA9SX87N+xmcJf0xU55
 ry7xU4K8AQRnkSyMgdsHMJURhXsMqmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-fkdCrRLKNaOSEmwyoLDOgA-1; Fri, 13 Mar 2020 13:05:21 -0400
X-MC-Unique: fkdCrRLKNaOSEmwyoLDOgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC75A8018D3;
 Fri, 13 Mar 2020 17:05:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F6210027AB;
 Fri, 13 Mar 2020 17:05:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D42DC1138611; Fri, 13 Mar 2020 18:05:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] xen-block: Use one Error * variable instead of two
Date: Fri, 13 Mar 2020 18:05:17 +0100
Message-Id: <20200313170517.22480-4-armbru@redhat.com>
In-Reply-To: <20200313170517.22480-1-armbru@redhat.com>
References: <20200313170517.22480-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: alxndr@bu.edu, vsementsov@virtuozzo.com, ashijeetacharya@gmail.com,
 qemu-block@nongnu.org, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/xen-block.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 3885464513..7b3b6dee97 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -998,14 +998,13 @@ static void xen_block_device_destroy(XenBackendInstan=
ce *backend,
     XenBlockVdev *vdev =3D &blockdev->props.vdev;
     XenBlockDrive *drive =3D blockdev->drive;
     XenBlockIOThread *iothread =3D blockdev->iothread;
+    Error *local_err =3D NULL;
=20
     trace_xen_block_device_destroy(vdev->number);
=20
     object_unparent(OBJECT(xendev));
=20
     if (iothread) {
-        Error *local_err =3D NULL;
-
         xen_block_iothread_destroy(iothread, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err,
@@ -1015,8 +1014,6 @@ static void xen_block_device_destroy(XenBackendInstan=
ce *backend,
     }
=20
     if (drive) {
-        Error *local_err =3D NULL;
-
         xen_block_drive_destroy(drive, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err,
--=20
2.21.1


