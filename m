Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738E8C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486252070B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486252070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMJ6-0006Hj-F2
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFMGQ-0002wh-8q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFMGP-0000hO-4O
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFMGM-0000eq-LK; Tue, 01 Oct 2019 13:48:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE44C31CD6C;
 Tue,  1 Oct 2019 17:48:37 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED58C5D9C9;
 Tue,  1 Oct 2019 17:48:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests/262: Switch source/dest VM launch order
Date: Tue,  1 Oct 2019 19:48:27 +0200
Message-Id: <20191001174827.11081-3-mreitz@redhat.com>
In-Reply-To: <20191001174827.11081-1-mreitz@redhat.com>
References: <20191001174827.11081-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 01 Oct 2019 17:48:37 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Launching the destination VM before the source VM gives us a regression
test for HEAD^:

The guest device causes a read from the disk image through
guess_disk_lchs().  This will not work if the first sector (containing
the partition table) is yet unallocated, we use COR, and the node is
inactive.

By launching the source VM before the destination, however, the COR
filter on the source will allocate that area in the image shared between
both VMs, thus the problem will not become apparent.

Switching the launch order causes the sector to still be unallocated
when guess_disk_lchs() runs on the inactive node in the destination VM,
and thus we get our test case.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/262     | 12 ++++++------
 tests/qemu-iotests/262.out |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/262 b/tests/qemu-iotests/262
index 398f63587e..0963daa806 100755
--- a/tests/qemu-iotests/262
+++ b/tests/qemu-iotests/262
@@ -54,12 +54,6 @@ with iotests.FilePath('img') as img_path, \
=20
     os.mkfifo(fifo)
=20
-    iotests.log('Launching source VM...')
-    add_opts(vm_a)
-    vm_a.launch()
-
-    vm_a.enable_migration_events('A')
-
     iotests.log('Launching destination VM...')
     add_opts(vm_b)
     vm_b.add_incoming("exec: cat '%s'" % (fifo))
@@ -67,6 +61,12 @@ with iotests.FilePath('img') as img_path, \
=20
     vm_b.enable_migration_events('B')
=20
+    iotests.log('Launching source VM...')
+    add_opts(vm_a)
+    vm_a.launch()
+
+    vm_a.enable_migration_events('A')
+
     iotests.log('Starting migration to B...')
     iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo)))
     with iotests.Timeout(3, 'Migration does not complete'):
diff --git a/tests/qemu-iotests/262.out b/tests/qemu-iotests/262.out
index 5a58e5e9f8..8e04c496c4 100644
--- a/tests/qemu-iotests/262.out
+++ b/tests/qemu-iotests/262.out
@@ -1,9 +1,9 @@
-Launching source VM...
-Enabling migration QMP events on A...
-{"return": {}}
 Launching destination VM...
 Enabling migration QMP events on B...
 {"return": {}}
+Launching source VM...
+Enabling migration QMP events on A...
+{"return": {}}
 Starting migration to B...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
--=20
2.21.0


