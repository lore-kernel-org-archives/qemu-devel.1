Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31199C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02581206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02581206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyJ1l-0000Pm-2a
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk9-0003Ke-7u
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk3-0003XS-JF
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIk3-0003X3-EQ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB7E54FCCE;
 Thu, 15 Aug 2019 16:36:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EE31BAAC;
 Thu, 15 Aug 2019 16:36:45 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:35:00 +0100
Message-Id: <20190815163504.18937-30-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 15 Aug 2019 16:36:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 29/33] migration/postcopy: use mis->bh instead
 of allocating a QEMUBH
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

For migration incoming side, it either quit in precopy or postcopy. It
is safe to use the mis->bh for both instead of allocating a dedicated
QEMUBH for postcopy.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Message-Id: <20190805053146.32326-1-richardw.yang@linux.intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1ac15301ad..6369a4ff7a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1866,16 +1866,10 @@ static int loadvm_postcopy_handle_listen(Migratio=
nIncomingState *mis)
     return 0;
 }
=20
-
-typedef struct {
-    QEMUBH *bh;
-} HandleRunBhData;
-
 static void loadvm_postcopy_handle_run_bh(void *opaque)
 {
     Error *local_err =3D NULL;
-    HandleRunBhData *data =3D opaque;
-    MigrationIncomingState *mis =3D migration_incoming_get_current();
+    MigrationIncomingState *mis =3D opaque;
=20
     /* TODO we should move all of this lot into postcopy_ram.c or a shar=
ed code
      * in migration.c
@@ -1907,15 +1901,13 @@ static void loadvm_postcopy_handle_run_bh(void *o=
paque)
         runstate_set(RUN_STATE_PAUSED);
     }
=20
-    qemu_bh_delete(data->bh);
-    g_free(data);
+    qemu_bh_delete(mis->bh);
 }
=20
 /* After all discards we can start running and asking for pages */
 static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 {
     PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
-    HandleRunBhData *data;
=20
     trace_loadvm_postcopy_handle_run();
     if (ps !=3D POSTCOPY_INCOMING_LISTENING) {
@@ -1923,9 +1915,8 @@ static int loadvm_postcopy_handle_run(MigrationInco=
mingState *mis)
         return -1;
     }
=20
-    data =3D g_new(HandleRunBhData, 1);
-    data->bh =3D qemu_bh_new(loadvm_postcopy_handle_run_bh, data);
-    qemu_bh_schedule(data->bh);
+    mis->bh =3D qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
+    qemu_bh_schedule(mis->bh);
=20
     /* We need to finish reading the stream from the package
      * and also stop reading anything more from the stream that loaded t=
he
--=20
2.21.0


