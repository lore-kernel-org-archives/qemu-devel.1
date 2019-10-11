Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26DEC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9017E2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9017E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0ho-0005uk-Cw
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Pi-0000Vb-5i
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Pg-0003vl-VJ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0Pg-0003vD-Ps
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 098A210C0930;
 Fri, 11 Oct 2019 19:17:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4BE55D6C8;
 Fri, 11 Oct 2019 19:17:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 13/21] migration/postcopy: mis->have_listen_thread check will
 never be touched
Date: Fri, 11 Oct 2019 20:16:38 +0100
Message-Id: <20191011191646.226814-14-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 11 Oct 2019 19:17:20 +0000 (UTC)
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

If mis->have_listen_thread is true, this means current PostcopyState
must be LISTENING or RUNNING. While the check at the beginning of the
function makes sure the state transaction happens when its previous
PostcopyState is ADVISE or DISCARD.

This means we would never touch this check.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20191006000249.29926-2-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 241c5dd097..c62687afef 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1878,11 +1878,6 @@ static int loadvm_postcopy_handle_listen(Migration=
IncomingState *mis)
         return -1;
     }
=20
-    if (mis->have_listen_thread) {
-        error_report("CMD_POSTCOPY_RAM_LISTEN already has a listen threa=
d");
-        return -1;
-    }
-
     mis->have_listen_thread =3D true;
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
--=20
2.23.0


