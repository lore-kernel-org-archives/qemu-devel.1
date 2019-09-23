Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD82C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 17:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F034E20882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 17:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F034E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCSU8-0000XX-UU
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 13:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iCSTC-0008Ko-8B
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 13:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iCSTA-0008K3-4m
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 13:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iCST9-0008JE-VL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 13:49:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86A0320F6;
 Mon, 23 Sep 2019 17:49:50 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-213.ams2.redhat.com
 [10.36.117.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72F6560F80;
 Mon, 23 Sep 2019 17:49:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	quintela@redhat.com,
	peterx@redhat.com
Subject: [PATCH] migration/postcopy: Recognise the recovery states as
 'in_postcopy'
Date: Mon, 23 Sep 2019 18:49:42 +0100
Message-Id: <20190923174942.12182-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 23 Sep 2019 17:49:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: thuth@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Various parts of the migration code do different things when they're
in postcopy mode; prior to this patch this has been 'postcopy-active'.
This patch extends 'in_postcopy' to include 'postcopy-paused' and
'postcopy-recover'.

In particular, when you set the max-postcopy-bandwidth parameter, this
only affects the current migration fd if we're 'in_postcopy';
this leads to a race in the postcopy recovery test where it increases
the speed from 4k/sec to unlimited, but that increase can get ignored
if the change is made between the point at which the reconnection
happens and it transitions back to active.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 01863a95f5..5f7e4d15e9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1659,7 +1659,14 @@ bool migration_in_postcopy(void)
 {
     MigrationState *s =3D migrate_get_current();
=20
-    return (s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        return true;
+    default:
+        return false;
+    }
 }
=20
 bool migration_in_postcopy_after_devices(MigrationState *s)
--=20
2.21.0


