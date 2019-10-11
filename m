Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C71C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946E52084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946E52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0kg-0000mF-L3
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Po-0000hU-T7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Pn-0003zD-OL
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0Pn-0003yi-In
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF0CFC053B32;
 Fri, 11 Oct 2019 19:17:26 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3DAB5D6C8;
 Fri, 11 Oct 2019 19:17:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 16/21] migration/postcopy: check PostcopyState before setting
 to POSTCOPY_INCOMING_RUNNING
Date: Fri, 11 Oct 2019 20:16:41 +0100
Message-Id: <20191011191646.226814-17-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 11 Oct 2019 19:17:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Currently, we set PostcopyState blindly to RUNNING, even we found the
previous state is not LISTENING. This will lead to a corner case.

First let's look at the code flow:

qemu_loadvm_state_main()
    ret =3D loadvm_process_command()
        loadvm_postcopy_handle_run()
            return -1;
    if (ret < 0) {
        if (postcopy_state_get() =3D=3D POSTCOPY_INCOMING_RUNNING)
            ...
    }

>From above snippet, the corner case is loadvm_postcopy_handle_run()
always sets state to RUNNING. And then it checks the previous state. If
the previous state is not LISTENING, it will return -1. But at this
moment, PostcopyState is already been set to RUNNING.

Then ret is checked in qemu_loadvm_state_main(), when it is -1
PostcopyState is checked. Current logic would pause postcopy and retry
if PostcopyState is RUNNING. This is not what we expect, because
postcopy is not active yet.

This patch makes sure state is set to RUNNING only previous state is
LISTENING by checking the state first.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested by: Peter Xu <peterx@redhat.com>
Message-Id: <20191010011316.31363-3-richardw.yang@linux.intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 95574c4e9d..8d95e261f6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1933,7 +1933,7 @@ static void loadvm_postcopy_handle_run_bh(void *opa=
que)
 /* After all discards we can start running and asking for pages */
 static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 {
-    PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
+    PostcopyState ps =3D postcopy_state_get();
=20
     trace_loadvm_postcopy_handle_run();
     if (ps !=3D POSTCOPY_INCOMING_LISTENING) {
@@ -1941,6 +1941,7 @@ static int loadvm_postcopy_handle_run(MigrationInco=
mingState *mis)
         return -1;
     }
=20
+    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     mis->bh =3D qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
     qemu_bh_schedule(mis->bh);
=20
--=20
2.23.0


