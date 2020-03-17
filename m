Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A3BC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7726320735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbuFH6jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7726320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFI8-0008H7-Ia
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEFA8-0006uP-At
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEFA7-0004wn-1X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEFA6-0004uo-T7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584462830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Px0X9H785H2y1QeaPhBzK01f4MiNP9U/SjH/J6SPl6k=;
 b=JbuFH6jywPCuksszQcEBM2QPaK75yW9zrncwoyJkJ0C+8/fl3DFThVTNhk1mIRNxrjpV7B
 GME7DUUE8cj0XYbN97+ioevqI3BtThdDWnQfGJUv6yLuidOtwTmMZ6gGeim1UhoOR6Cmcb
 6nyRELDbB0jXPt0h4orbEJ+cIeXNl7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-kDzL92RMOb-Ml7aitxhz4g-1; Tue, 17 Mar 2020 12:33:46 -0400
X-MC-Unique: kDzL92RMOb-Ml7aitxhz4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55E5F800D5A;
 Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 256E790808;
 Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A719B11366CC; Tue, 17 Mar 2020 17:33:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] hw/misc/ivshmem: Use one Error * variable instead of two
Date: Tue, 17 Mar 2020 17:33:41 +0100
Message-Id: <20200317163343.25028-3-armbru@redhat.com>
In-Reply-To: <20200317163343.25028-1-armbru@redhat.com>
References: <20200317163343.25028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit fe44dc9180 "migration: disallow migrate_add_blocker during
migration" accidentally added a second Error * variable.  Use the
first one instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200313170517.22480-3-armbru@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/misc/ivshmem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 1a0fad74e1..a8dc9b377d 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -832,7 +832,6 @@ static void ivshmem_common_realize(PCIDevice *dev, Erro=
r **errp)
     IVShmemState *s =3D IVSHMEM_COMMON(dev);
     Error *err =3D NULL;
     uint8_t *pci_conf;
-    Error *local_err =3D NULL;
=20
     /* IRQFD requires MSI */
     if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD) &&
@@ -899,9 +898,9 @@ static void ivshmem_common_realize(PCIDevice *dev, Erro=
r **errp)
     if (!ivshmem_is_master(s)) {
         error_setg(&s->migration_blocker,
                    "Migration is disabled when using feature 'peer mode' i=
n device 'ivshmem'");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(s->migration_blocker, &err);
+        if (err) {
+            error_propagate(errp, err);
             error_free(s->migration_blocker);
             return;
         }
--=20
2.21.1


