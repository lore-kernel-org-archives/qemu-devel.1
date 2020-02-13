Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0222DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1368222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh7t57EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1368222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ESo-0001lL-VJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2EQC-0005qK-HO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2EQB-0007fm-Ar
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2EQA-0007ew-Ep
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3rk4N4XuCcIWOOAIksqrMSXz8VZy5V8PE8Oy5hTwMM=;
 b=Wh7t57EMRyEYmeEq8WC989w29x97OfuiH4g6Umm35vSu5VAcNQgQ3IKhrm+OtzqlUgBOJ4
 BtcwZDLYkMEpdnqAbzIWbSs8eagk4ZOHwVCWisBLM+GB6FA8kxvY7RcVBC67MPC/D7fQFg
 a3nmOT/ZuoVS1gOP9bOdXER5rRFc/HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-ZW_LtA09OyqZXS56AX123A-1; Thu, 13 Feb 2020 08:20:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 247A2802584;
 Thu, 13 Feb 2020 13:20:42 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6E796685A;
 Thu, 13 Feb 2020 13:20:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] migration: Maybe VM is paused when migration is cancelled
Date: Thu, 13 Feb 2020 14:20:25 +0100
Message-Id: <20200213132030.57757-2-quintela@redhat.com>
In-Reply-To: <20200213132030.57757-1-quintela@redhat.com>
References: <20200213132030.57757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZW_LtA09OyqZXS56AX123A-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Zhimin Feng <fengzhimin1@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhimin Feng <fengzhimin1@huawei.com>

If the migration is cancelled when it is in the completion phase,
the migration state is set to MIGRATION_STATUS_CANCELLING.
The VM maybe wait for the 'pause_sem' semaphore in migration_maybe_pause
function, so that VM always is paused.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3a21a4686c..1ca6be2323 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2797,14 +2797,22 @@ static int migration_maybe_pause(MigrationState *s,
         /* This block intentionally left blank */
     }
=20
-    qemu_mutex_unlock_iothread();
-    migrate_set_state(&s->state, *current_active_state,
-                      MIGRATION_STATUS_PRE_SWITCHOVER);
-    qemu_sem_wait(&s->pause_sem);
-    migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
-                      new_state);
-    *current_active_state =3D new_state;
-    qemu_mutex_lock_iothread();
+    /*
+     * If the migration is cancelled when it is in the completion phase,
+     * the migration state is set to MIGRATION_STATUS_CANCELLING.
+     * So we don't need to wait a semaphore, otherwise we would always
+     * wait for the 'pause_sem' semaphore.
+     */
+    if (s->state !=3D MIGRATION_STATUS_CANCELLING) {
+        qemu_mutex_unlock_iothread();
+        migrate_set_state(&s->state, *current_active_state,
+                          MIGRATION_STATUS_PRE_SWITCHOVER);
+        qemu_sem_wait(&s->pause_sem);
+        migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
+                          new_state);
+        *current_active_state =3D new_state;
+        qemu_mutex_lock_iothread();
+    }
=20
     return s->state =3D=3D new_state ? 0 : -EINVAL;
 }
--=20
2.24.1


