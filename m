Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CBEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA89A20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9ZKYq9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA89A20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8h1-0000tY-5e
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cP-00023B-Mn
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cO-0002jQ-Fq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cO-0002ip-CS
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJuBfHMwEGp02SAr4dkBpu+8wDNXv0Qba2ws4MC9toU=;
 b=W9ZKYq9AMadX7+cl3ll2+R+QeAeoHAE9ljeXLMFxo48E97oUvrFy23wUgLJLXsl5F+Yx2C
 k5Dz3bZP5tOphTSJ78OiqjzxguQSQt8AaYvtOqQe4DE0mWDnuTWAZMJ6T3zf7x1QI+F198
 WFFfE6vd4g0i7tBo5ObKMfPa1HAOl7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-4xA8Ppo7OTKtT9dMynd0KQ-1; Mon, 27 Jan 2020 12:56:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9A3A107ACC4;
 Mon, 27 Jan 2020 17:56:06 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF505863C0;
 Mon, 27 Jan 2020 17:56:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/13] iotests.py: Let wait_migration wait even more
Date: Mon, 27 Jan 2020 18:55:47 +0100
Message-Id: <20200127175559.18173-2-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4xA8Ppo7OTKtT9dMynd0KQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

The "migration completed" event may be sent (on the source, to be
specific) before the migration is actually completed, so the VM runstate
will still be "finish-migrate" instead of "postmigrate".  So ask the
users of VM.wait_migration() to specify the final runstate they desire
and then poll the VM until it has reached that state.  (This should be
over very quickly, so busy polling is fine.)

Without this patch, I see intermittent failures in the new iotest 280
under high system load.  I have not yet seen such failures with other
iotests that use VM.wait_migration() and query-status afterwards, but
maybe they just occur even more rarely, or it is because they also wait
on the destination VM to be running.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 6 +++++-
 tests/qemu-iotests/234        | 8 ++++----
 tests/qemu-iotests/262        | 4 ++--
 tests/qemu-iotests/280        | 2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 13fd8b5cd2..0b62c42851 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -668,12 +668,16 @@ class VM(qtest.QEMUQtestMachine):
             }
         ]))
=20
-    def wait_migration(self):
+    def wait_migration(self, expect_runstate):
         while True:
             event =3D self.event_wait('MIGRATION')
             log(event, filters=3D[filter_qmp_event])
             if event['data']['status'] =3D=3D 'completed':
                 break
+        # The event may occur in finish-migrate, so wait for the expected
+        # post-migration runstate
+        while self.qmp('query-status')['return']['status'] !=3D expect_run=
state:
+            pass
=20
     def node_info(self, node_name):
         nodes =3D self.qmp('query-named-block-nodes')
diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index 34c818c485..59a7f949ec 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -69,9 +69,9 @@ with iotests.FilePath('img') as img_path, \
     iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_a)))
     with iotests.Timeout(3, 'Migration does not complete'):
         # Wait for the source first (which includes setup=3Dsetup)
-        vm_a.wait_migration()
+        vm_a.wait_migration('postmigrate')
         # Wait for the destination second (which does not)
-        vm_b.wait_migration()
+        vm_b.wait_migration('running')
=20
     iotests.log(vm_a.qmp('query-migrate')['return']['status'])
     iotests.log(vm_b.qmp('query-migrate')['return']['status'])
@@ -98,9 +98,9 @@ with iotests.FilePath('img') as img_path, \
     iotests.log(vm_b.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_b)))
     with iotests.Timeout(3, 'Migration does not complete'):
         # Wait for the source first (which includes setup=3Dsetup)
-        vm_b.wait_migration()
+        vm_b.wait_migration('postmigrate')
         # Wait for the destination second (which does not)
-        vm_a.wait_migration()
+        vm_a.wait_migration('running')
=20
     iotests.log(vm_a.qmp('query-migrate')['return']['status'])
     iotests.log(vm_b.qmp('query-migrate')['return']['status'])
diff --git a/tests/qemu-iotests/262 b/tests/qemu-iotests/262
index 0963daa806..bbcb5260a6 100755
--- a/tests/qemu-iotests/262
+++ b/tests/qemu-iotests/262
@@ -71,9 +71,9 @@ with iotests.FilePath('img') as img_path, \
     iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo)))
     with iotests.Timeout(3, 'Migration does not complete'):
         # Wait for the source first (which includes setup=3Dsetup)
-        vm_a.wait_migration()
+        vm_a.wait_migration('postmigrate')
         # Wait for the destination second (which does not)
-        vm_b.wait_migration()
+        vm_b.wait_migration('running')
=20
     iotests.log(vm_a.qmp('query-migrate')['return']['status'])
     iotests.log(vm_b.qmp('query-migrate')['return']['status'])
diff --git a/tests/qemu-iotests/280 b/tests/qemu-iotests/280
index 0b1fa8e1d8..85e9114c5e 100755
--- a/tests/qemu-iotests/280
+++ b/tests/qemu-iotests/280
@@ -45,7 +45,7 @@ with iotests.FilePath('base') as base_path , \
     vm.qmp_log('migrate', uri=3D'exec:cat > /dev/null')
=20
     with iotests.Timeout(3, 'Migration does not complete'):
-        vm.wait_migration()
+        vm.wait_migration('postmigrate')
=20
     iotests.log('\nVM is now stopped:')
     iotests.log(vm.qmp('query-migrate')['return']['status'])
--=20
2.20.1


