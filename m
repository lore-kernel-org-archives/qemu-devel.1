Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33B6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897992086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897992086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLGx-00080B-Rz
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKqG-0001Io-HF
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKqF-0004nz-0B
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:29:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKqB-0004lZ-0M; Fri, 20 Sep 2019 11:28:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 509148980EA;
 Fri, 20 Sep 2019 15:28:58 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B25255D9C3;
 Fri, 20 Sep 2019 15:28:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 22/22] iotests: Mirror must not attempt to create loops
Date: Fri, 20 Sep 2019 17:28:04 +0200
Message-Id: <20190920152804.12875-23-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 20 Sep 2019 15:28:58 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 152 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index e4cc829fe2..6ea4764ae8 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1265,6 +1265,158 @@ class TestReplaces(iotests.QMPTestCase):
=20
         self.vm.assert_block_path('filter0/file', 'target')
=20
+    '''
+    See what happens when the @sync/@replaces configuration dictates
+    creating a loop.
+    '''
+    def test_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 1024 =
* 1024))
+
+        # Dummy group so we can create a NOP filter
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg0')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': 'throttle',
+                                 'node-name': 'source',
+                                 'throttle-group': 'tg0',
+                                 'file': {
+                                     'driver': iotests.imgfmt,
+                                     'node-name': 'filtered',
+                                     'file': {
+                                         'driver': 'file',
+                                         'filename': test_img
+                                     }
+                                 }
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        # Block graph is now:
+        #   source[throttle] --file--> filtered[qcow2] --file--> ...
+
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', device=
=3D'source',
+                             target=3Dtarget_img, format=3Diotests.imgfm=
t,
+                             node_name=3D'target', sync=3D'none',
+                             replaces=3D'filtered')
+
+        '''
+        Block graph before mirror exits would be (ignoring mirror_top):
+          source[throttle] --file--> filtered[qcow2] --file--> ...
+          target[qcow2] --file--> ...
+
+        Then, because of sync=3Dnone and drive-mirror in absolute-paths =
mode,
+        the source is attached to the target:
+          source[throttle] --file--> filtered[qcow2] --file--> ...
+                 ^
+              backing
+                 |
+            target[qcow2] --file--> ...
+
+        Replacing filtered by target would yield:
+          source[throttle] --file--> target[qcow2] --file--> ...
+                 ^                        |
+                 +------- backing --------+
+
+        I.e., a loop.  bdrv_replace_node() detects this and simply
+        does not let source's file link point to target.  However,
+        that means that target cannot really replace source.
+
+        drive-mirror should detect this and not allow this case.
+        '''
+
+        self.assert_qmp(result, 'error/desc',
+                        "Replacing 'filtered' by 'target' with this sync=
 " + \
+                        "mode would result in a loop, because the former=
 " + \
+                        "would be a child of the latter's backing file "=
 + \
+                        "('source') after the mirror job")
+
+    '''
+    Test what happens when there would be no loop with the pre-mirror
+    configuration, but something changes during the mirror job that asks
+    for a loop to be created during completion.
+    '''
+    def test_loop_during_mirror(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 1024 =
* 1024))
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': 'null-co',
+                                 'node-name': 'common-base',
+                                 'read-zeroes': True,
+                                 'size': 1 * 1024 * 1024
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': 'copy-on-read',
+                                 'node-name': 'source',
+                                 'file': 'common-base'
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        '''
+        x-blockdev-change can only add children to a quorum node that
+        have no parent yet, so we need an intermediate node between
+        target and common-base that has no parents other than target.
+        We cannot use any parent that would forward the RESIZE
+        permission (because the job takes it, but unshares it on the
+        source), so we make it a backing child of a qcow2 node.
+        Unfortunately, we cannot add backing files to Quorum nodes
+        (because of an op blocker), so we put another raw node between
+        the qcow2 node and common-base.
+        '''
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': 'qcow2',
+                                 'node-name': 'base-parent',
+                                 'file': {
+                                     'driver': 'file',
+                                     'filename': test_img
+                                 },
+                                 'backing': {
+                                     'driver': 'raw',
+                                     'file': 'common-base'
+                                 }
+                             })
+
+        # Add a quorum node with a single child, we will add
+        # base-parent to prepare a loop later
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': 'quorum',
+                                 'node-name': 'target',
+                                 'vote-threshold': 1,
+                                 'children': [
+                                     {
+                                         'driver': 'null-co',
+                                         'read-zeroes': True
+                                     }
+                                 ]
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'mirror',
+                             device=3D'source', target=3D'target', sync=3D=
'full',
+                             replaces=3D'common-base')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('x-blockdev-change',
+                             parent=3D'target', node=3D'base-parent')
+        self.assert_qmp(result, 'return', {})
+
+        '''
+        This asks for this configuration post-mirror:
+
+        source -> target (replaced common-base) -> base-parent
+                                  ^                    |
+                                  |                    v
+                                  +----------------- [raw]
+
+        bdrv_replace_node() would not allow such a configuration, but
+        we should not pretend we can create it, so the mirror job
+        should fail during completion.
+        '''
+
+        self.complete_and_wait('mirror',
+                               completion_error=3D'Operation not permitt=
ed')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
                  supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 877b76fd31..20a8158b99 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-........................................................................=
......................
+........................................................................=
........................
 ----------------------------------------------------------------------
-Ran 94 tests
+Ran 96 tests
=20
 OK
--=20
2.21.0


