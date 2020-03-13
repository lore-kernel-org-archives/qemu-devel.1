Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF69BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F292076C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go/E21JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F292076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34147 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnlf-0001IR-SD
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 13:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCnkU-0008GC-1z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCnkS-0006Sj-0H
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCnkR-0006PW-M0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584119123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcGUQnF//ws46FOHD+iYW1Ws69BV+qLyFvtgelEnUe8=;
 b=go/E21JPdBpGaKmHIjPYCxpstuSM/xjFZRzzcmj0GtUA9+Aw9TmbsDWeID75XZBxT95a5v
 oh/5HuQkP4PGitqAydud9WkO1ZOTgwu/cd07b4/5Yx+VUcjDlt5KTZclHOGudecltRFMkV
 bbwmt8rYATAezQsnptKKHCbQ2aMaC6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-fW02z642MeCAKRhHG2LXZA-1; Fri, 13 Mar 2020 13:05:21 -0400
X-MC-Unique: fW02z642MeCAKRhHG2LXZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87AD8024D5;
 Fri, 13 Mar 2020 17:05:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 566351001DF0;
 Fri, 13 Mar 2020 17:05:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB36911385F4; Fri, 13 Mar 2020 18:05:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/misc/ivshmem: Use one Error * variable instead of two
Date: Fri, 13 Mar 2020 18:05:16 +0100
Message-Id: <20200313170517.22480-3-armbru@redhat.com>
In-Reply-To: <20200313170517.22480-1-armbru@redhat.com>
References: <20200313170517.22480-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: alxndr@bu.edu, vsementsov@virtuozzo.com, ashijeetacharya@gmail.com,
 qemu-block@nongnu.org, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit fe44dc9180 "migration: disallow migrate_add_blocker during
migration" accidentally added a second Error * variable.  Use the
first one instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


