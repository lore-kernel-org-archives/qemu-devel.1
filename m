Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3DCC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA02421783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTD74spj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA02421783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUTo-0003Ki-Qo
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUUOc-0006m5-Mb
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUUOb-00013W-MH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUUOb-00013E-8E
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LGBVIQ/R/42vB7yC5tkdK8vF6kJeXx+rZ4aMMk6u34=;
 b=VTD74spjRrETWa0JMPz4Ns633jGe9MecXpqQV/gc/0zy6caO4Vb7nGeHVqeok07a541LqA
 KDGd7QSU5co3VbZxlQWTJk4VopDnIxwUJlIUnqwfGkxGkFTWiTmkFZg3Z7tGydggNe2t9+
 cwS1fn7WxBGJHzX96FBCS84AbLUKY64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-F7qM-4elPfC_Y0Rn68TwmQ-1; Tue, 12 Nov 2019 06:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 857AA801FD2;
 Tue, 12 Nov 2019 11:30:27 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B43EB60600;
 Tue, 12 Nov 2019 11:30:23 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] blockdev: change qmp_drive_backup to make use of
 transactions
Date: Tue, 12 Nov 2019 12:30:08 +0100
Message-Id: <20191112113012.71136-5-slp@redhat.com>
In-Reply-To: <20191112113012.71136-1-slp@redhat.com>
References: <20191112113012.71136-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: F7qM-4elPfC_Y0Rn68TwmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change qmp_drive_backup() to create and start a transaction instead of
calling do_drive_backup directly.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index b32855f702..5e85fc042e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3676,14 +3676,13 @@ static BlockJob *do_backup_common(BackupCommon *bac=
kup,
     return job;
 }
=20
-void qmp_drive_backup(DriveBackup *arg, Error **errp)
+void qmp_drive_backup(DriveBackup *backup, Error **errp)
 {
-
-    BlockJob *job;
-    job =3D do_drive_backup(arg, NULL, errp);
-    if (job) {
-        job_start(&job->job);
-    }
+    TransactionAction action =3D {
+        .type =3D TRANSACTION_ACTION_KIND_DRIVE_BACKUP,
+        .u.drive_backup.data =3D backup,
+    };
+    blockdev_do_action(&action, errp);
 }
=20
 BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
--=20
2.23.0


