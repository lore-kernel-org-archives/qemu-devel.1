Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD29AECE596
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C79A2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C79A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0jj-0008EQ-L9
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Pm-0000cQ-2P
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Pk-0003xk-Rv
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0Pk-0003xK-ML
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8AC78AC6FD;
 Fri, 11 Oct 2019 19:17:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5463E5D713;
 Fri, 11 Oct 2019 19:17:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 14/21] migration/postcopy: postpone setting PostcopyState to END
Date: Fri, 11 Oct 2019 20:16:39 +0100
Message-Id: <20191011191646.226814-15-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 11 Oct 2019 19:17:23 +0000 (UTC)
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

There are two places to call function postcopy_ram_incoming_cleanup()

    postcopy_ram_listen_thread on migration success
    loadvm_postcopy_handle_listen one setup failure

On success, the vm will never accept another migration. On failure,
PostcopyState is transited from LISTENING to END and would be checked in
qemu_loadvm_state_main(). If PostcopyState is RUNNING, migration would
be paused and retried.

Currently PostcopyState is set to END in function
postcopy_ram_incoming_cleanup(). With above analysis, we can take this
step out and postpone this till the end of listen thread to indicate the
listen thread is done.

This is a preparation patch for later cleanup.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20191006000249.29926-3-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fixed up in merge to the 1 parameter postcopy_state_set
---
 migration/postcopy-ram.c | 2 --
 migration/savevm.c       | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3a72f7b4fe..a793bad477 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -577,8 +577,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingSt=
ate *mis)
         }
     }
=20
-    postcopy_state_set(POSTCOPY_INCOMING_END);
-
     if (mis->postcopy_tmp_page) {
         munmap(mis->postcopy_tmp_page, mis->largest_page_size);
         mis->postcopy_tmp_page =3D NULL;
diff --git a/migration/savevm.c b/migration/savevm.c
index c62687afef..bf3da58ecc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1837,6 +1837,8 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
=20
     rcu_unregister_thread();
     mis->have_listen_thread =3D false;
+    postcopy_state_set(POSTCOPY_INCOMING_END);
+
     return NULL;
 }
=20
--=20
2.23.0


