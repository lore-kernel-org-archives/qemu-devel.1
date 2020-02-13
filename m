Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB79C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACF720873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xvf4DgX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ERR-0007b1-EM
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2EQJ-0005zk-Dt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2EQH-0007ib-7o
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2EQH-0007iL-3N
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixHaisp+i77QOlZ41KfAP3G96ORtiggZqOICGYeIUjU=;
 b=Xvf4DgX1QgPYa/RYDxEsa0zMu1I9IBYRcavW2FwCkPkJN79hJsNd2gXuDUYSdI4ynRNL2w
 lS7t5ZaWhDMDsLFlpzb++T8oue9+pkvfcyUL8qvnVcp/XsusRq9UZosdkr4DgkuLY6toUI
 4GiAK0ixtGNQj9B4k0oURJPVR345Umk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-vF9QDLV1NRSa3N7xo4lyMw-1; Thu, 13 Feb 2020 08:20:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B3A1413;
 Thu, 13 Feb 2020 13:20:49 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D1D85C1BB;
 Thu, 13 Feb 2020 13:20:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] migration: Optimization about wait-unplug migration state
Date: Thu, 13 Feb 2020 14:20:26 +0100
Message-Id: <20200213132030.57757-3-quintela@redhat.com>
In-Reply-To: <20200213132030.57757-1-quintela@redhat.com>
References: <20200213132030.57757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vF9QDLV1NRSa3N7xo4lyMw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 Keqian Zhu <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keqian Zhu <zhukeqian1@huawei.com>

qemu_savevm_nr_failover_devices() is originally designed to
get the number of failover devices, but it actually returns
the number of "unplug-pending" failover devices now. Moreover,
what drives migration state to wait-unplug should be the number
of "unplug-pending" failover devices, not all failover devices.

We can also notice that qemu_savevm_state_guest_unplug_pending()
and qemu_savevm_nr_failover_devices() is equivalent almost (from
the code view). So the latter is incorrect semantically and
useless, just delete it.

In the qemu_savevm_state_guest_unplug_pending(), once hit a
unplug-pending failover device, then it can return true right
now to save cpu time.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c |  2 +-
 migration/savevm.c    | 24 +++---------------------
 migration/savevm.h    |  1 -
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1ca6be2323..8fb68795dc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3341,7 +3341,7 @@ static void *migration_thread(void *opaque)
=20
     qemu_savevm_state_setup(s->to_dst_file);
=20
-    if (qemu_savevm_nr_failover_devices()) {
+    if (qemu_savevm_state_guest_unplug_pending()) {
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_WAIT_UNPLUG);
=20
diff --git a/migration/savevm.c b/migration/savevm.c
index f19cb9ec7a..1d4220ece8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1140,36 +1140,18 @@ void qemu_savevm_state_header(QEMUFile *f)
     }
 }
=20
-int qemu_savevm_nr_failover_devices(void)
+bool qemu_savevm_state_guest_unplug_pending(void)
 {
     SaveStateEntry *se;
-    int n =3D 0;
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->dev_unplug_pending &&
             se->vmsd->dev_unplug_pending(se->opaque)) {
-            n++;
-        }
-    }
-
-    return n;
-}
-
-bool qemu_savevm_state_guest_unplug_pending(void)
-{
-    SaveStateEntry *se;
-    int n =3D 0;
-
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
-            continue;
-        }
-        if (se->vmsd->dev_unplug_pending(se->opaque)) {
-            n++;
+            return true;
         }
     }
=20
-    return n > 0;
+    return false;
 }
=20
 void qemu_savevm_state_setup(QEMUFile *f)
diff --git a/migration/savevm.h b/migration/savevm.h
index c42b9c80ee..ba64a7e271 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,7 +31,6 @@
=20
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
-int qemu_savevm_nr_failover_devices(void);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
--=20
2.24.1


