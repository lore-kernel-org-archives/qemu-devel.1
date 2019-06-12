Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4316C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF70620896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF70620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBSY-0007O7-Go
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBQR-0005ln-N4
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBQP-0006We-MS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBQK-0006RD-CG; Wed, 12 Jun 2019 18:08:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD85A30860B9;
 Wed, 12 Jun 2019 22:08:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69E261710F;
 Wed, 12 Jun 2019 22:08:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:08:39 +0200
Message-Id: <20190612220839.1374-3-mreitz@redhat.com>
In-Reply-To: <20190612220839.1374-1-mreitz@redhat.com>
References: <20190612220839.1374-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 12 Jun 2019 22:08:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] iotests: Test quitting with job on
 throttled node
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When qemu quits, all throttling should be ignored.  That means, if there
is a mirror job running from a throttled node, it should be cancelled
immediately and qemu close without blocking.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/218     | 55 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/218.out |  4 +++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
index 92c331b6fb..2554d84581 100755
--- a/tests/qemu-iotests/218
+++ b/tests/qemu-iotests/218
@@ -27,9 +27,9 @@
 # Creator/Owner: Max Reitz <mreitz@redhat.com>
=20
 import iotests
-from iotests import log
+from iotests import log, qemu_img, qemu_io_silent
=20
-iotests.verify_platform(['linux'])
+iotests.verify_image_format(supported_fmts=3D['qcow2', 'raw'])
=20
=20
 # Launches the VM, adds two null-co nodes (source and target), and
@@ -136,3 +136,54 @@ with iotests.VM() as vm:
=20
     log(vm.event_wait('BLOCK_JOB_CANCELLED'),
         filters=3D[iotests.filter_qmp_event])
+
+log('')
+log('=3D=3D=3D Cancel mirror job from throttled node by quitting =3D=3D=3D=
')
+log('')
+
+with iotests.VM() as vm, \
+     iotests.FilePath('src.img') as src_img_path:
+
+    assert qemu_img('create', '-f', iotests.imgfmt, src_img_path, '64M')=
 =3D=3D 0
+    assert qemu_io_silent('-f', iotests.imgfmt, src_img_path,
+                          '-c', 'write -P 42 0M 64M') =3D=3D 0
+
+    vm.launch()
+
+    ret =3D vm.qmp('object-add', qom_type=3D'throttle-group', id=3D'tg',
+                 props=3D{'x-bps-read': 4096})
+    assert ret['return'] =3D=3D {}
+
+    ret =3D vm.qmp('blockdev-add',
+                 node_name=3D'source',
+                 driver=3Diotests.imgfmt,
+                 file=3D{
+                     'driver': 'file',
+                     'filename': src_img_path
+                 })
+    assert ret['return'] =3D=3D {}
+
+    ret =3D vm.qmp('blockdev-add',
+                 node_name=3D'throttled-source',
+                 driver=3D'throttle',
+                 throttle_group=3D'tg',
+                 file=3D'source')
+    assert ret['return'] =3D=3D {}
+
+    ret =3D vm.qmp('blockdev-add',
+                 node_name=3D'target',
+                 driver=3D'null-co',
+                 size=3D(64 * 1048576))
+    assert ret['return'] =3D=3D {}
+
+    ret =3D vm.qmp('blockdev-mirror',
+                 job_id=3D'mirror',
+                 device=3D'throttled-source',
+                 target=3D'target',
+                 sync=3D'full')
+    assert ret['return'] =3D=3D {}
+
+    log(vm.qmp('quit'))
+
+    with iotests.Timeout(5, 'Timeout waiting for VM to quit'):
+        vm.shutdown(has_quit=3DTrue)
diff --git a/tests/qemu-iotests/218.out b/tests/qemu-iotests/218.out
index 825a657081..5a86a97550 100644
--- a/tests/qemu-iotests/218.out
+++ b/tests/qemu-iotests/218.out
@@ -28,3 +28,7 @@ Cancelling job
 Cancelling job
 {"return": {}}
 {"data": {"device": "mirror", "len": 1048576, "offset": 1048576, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+
+=3D=3D=3D Cancel mirror job from throttled node by quitting =3D=3D=3D
+
+{"return": {}}
--=20
2.21.0


