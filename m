Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E610DC74A51
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1AB208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1AB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWnO-0001Kr-0m
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlWiR-0001xm-UP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlWiQ-0006u4-TU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlWiO-0006rF-Ud
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:54:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB4C9C0467E4;
 Thu, 11 Jul 2019 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B753B60600;
 Thu, 11 Jul 2019 10:44:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 12:43:57 +0200
Message-Id: <20190711104412.31233-5-quintela@redhat.com>
In-Reply-To: <20190711104412.31233-1-quintela@redhat.com>
References: <20190711104412.31233-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 11 Jul 2019 10:44:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/19] migration/multifd: call
 multifd_send_sync_main when sending RAM_SAVE_FLAG_EOS
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
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

On receiving RAM_SAVE_FLAG_EOS, multifd_recv_sync_main() is called to
synchronize receive threads. Current synchronization mechanism is to wait
for each channel's sem_sync semaphore. This semaphore is triggered by a
packet with MULTIFD_FLAG_SYNC flag. While in current implementation, we
don't do multifd_send_sync_main() to send such packet when
blk_mig_bulk_active() is true.

This will leads to the receive threads won't notify
multifd_recv_sync_main() by sem_sync. And multifd_recv_sync_main() will
always wait there.

[Note]: normal migration test works, while didn't test the
blk_mig_bulk_active() case. Since not sure how to produce this
situation.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190612014337.11255-1-richardw.yang@linux.intel.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 908517fc2b..74c9306c78 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3466,8 +3466,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
      */
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
=20
-    multifd_send_sync_main();
 out:
+    multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
     ram_counters.transferred +=3D 8;
--=20
2.21.0


