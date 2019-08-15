Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B894C3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2379920578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2379920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyImb-0006Tl-SZ
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIii-0001L7-Pj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIid-00026u-Qd
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIid-00026W-Ge
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8D448E37A;
 Thu, 15 Aug 2019 16:35:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50B5A60F8C;
 Thu, 15 Aug 2019 16:35:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:34 +0100
Message-Id: <20190815163504.18937-4-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 15 Aug 2019 16:35:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/33] migration: consolidate time info into
 populate_time_info
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Consolidate time information fill up into its function for better
readability.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190716005411.4156-1-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28342969ea..7c66da3a83 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -823,6 +823,25 @@ bool migration_is_setup_or_active(int state)
     }
 }
=20
+static void populate_time_info(MigrationInfo *info, MigrationState *s)
+{
+    info->has_status =3D true;
+    info->has_setup_time =3D true;
+    info->setup_time =3D s->setup_time;
+    if (s->state =3D=3D MIGRATION_STATUS_COMPLETED) {
+        info->has_total_time =3D true;
+        info->total_time =3D s->total_time;
+        info->has_downtime =3D true;
+        info->downtime =3D s->downtime;
+    } else {
+        info->has_total_time =3D true;
+        info->total_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
+                           s->start_time;
+        info->has_expected_downtime =3D true;
+        info->expected_downtime =3D s->expected_downtime;
+    }
+}
+
 static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 {
     info->has_ram =3D true;
@@ -908,16 +927,8 @@ static void fill_source_migration_info(MigrationInfo=
 *info)
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
-         /* TODO add some postcopy stats */
-        info->has_status =3D true;
-        info->has_total_time =3D true;
-        info->total_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
-            - s->start_time;
-        info->has_expected_downtime =3D true;
-        info->expected_downtime =3D s->expected_downtime;
-        info->has_setup_time =3D true;
-        info->setup_time =3D s->setup_time;
-
+        /* TODO add some postcopy stats */
+        populate_time_info(info, s);
         populate_ram_info(info, s);
         populate_disk_info(info);
         break;
@@ -926,14 +937,7 @@ static void fill_source_migration_info(MigrationInfo=
 *info)
         /* TODO: display COLO specific information (checkpoint info etc.=
) */
         break;
     case MIGRATION_STATUS_COMPLETED:
-        info->has_status =3D true;
-        info->has_total_time =3D true;
-        info->total_time =3D s->total_time;
-        info->has_downtime =3D true;
-        info->downtime =3D s->downtime;
-        info->has_setup_time =3D true;
-        info->setup_time =3D s->setup_time;
-
+        populate_time_info(info, s);
         populate_ram_info(info, s);
         break;
     case MIGRATION_STATUS_FAILED:
--=20
2.21.0


