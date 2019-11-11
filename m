Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B9C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE3F20679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOwiC8h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE3F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCg0-0005J8-DR
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUCAF-0000RU-Ge
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUCA9-0003AB-TX
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUCA9-00039c-PB
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whUrYdJLhBASdpWCpuLFMfQuo3veDYHSDj2xi+Fnx2w=;
 b=jOwiC8h90pZhHFg1K21fLWxbjWtYzVJnp9H1uIO/oT3hMqDKRR3zNRVb6ayzM85kFLtsDx
 J6N99oNRfRjx8P7n6jrCEJtmAgcPJHYB3g4E9eXgEcRcXAUR9jvXtuALijsGCbKxzJqhmp
 rMnTeUVmRr4cveLxmbIbFYN3yVDiC5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-JvaqgvzvP0S0b2aKMOMFRg-1; Mon, 11 Nov 2019 11:03:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1A9107ACC5;
 Mon, 11 Nov 2019 16:03:30 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3BBA608FF;
 Mon, 11 Nov 2019 16:03:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 23/23] iotests: Mirror must not attempt to create
 loops
Date: Mon, 11 Nov 2019 17:02:16 +0100
Message-Id: <20191111160216.197086-24-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JvaqgvzvP0S0b2aKMOMFRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 235 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 237 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 9a00cf6f7b..0e43bb699d 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1246,6 +1246,241 @@ class TestReplaces(iotests.QMPTestCase):
=20
         self.vm.assert_block_path('filter0', '/file', 'target')
=20
+    """
+    See what happens when the @sync/@replaces configuration dictates
+    creating a loop.
+    """
+    @iotests.skip_if_unsupported(['throttle'])
+    def test_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 1024 * =
1024))
+
+        # Dummy group so we can create a NOP filter
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group', =
id=3D'tg0')
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
+        #   source[throttle] --file--> filtered[imgfmt] --file--> ...
+
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', device=
=3D'source',
+                             target=3Dtarget_img, format=3Diotests.imgfmt,
+                             node_name=3D'target', sync=3D'none',
+                             replaces=3D'filtered')
+
+        """
+        Block graph before mirror exits would be (ignoring mirror_top):
+          source[throttle] --file--> filtered[imgfmt] --file--> ...
+          target[imgfmt] --file--> ...
+
+        Then, because of sync=3Dnone and drive-mirror in absolute-paths mo=
de,
+        the source is attached to the target:
+          source[throttle] --file--> filtered[imgfmt] --file--> ...
+                 ^
+              backing
+                 |
+            target[imgfmt] --file--> ...
+
+        Replacing filtered by target would yield:
+          source[throttle] --file--> target[imgfmt] --file--> ...
+                 ^                        |
+                 +------- backing --------+
+
+        I.e., a loop.  bdrv_replace_node() detects this and simply
+        does not let source's file link point to target.  However,
+        that means that target cannot really replace source.
+
+        drive-mirror should detect this and not allow this case.
+        """
+
+        self.assert_qmp(result, 'error/desc',
+                        "Replacing 'filtered' by 'target' with this sync "=
 + \
+                        "mode would result in a loop, because the former "=
 + \
+                        "would be a child of the latter's backing file " +=
 \
+                        "('source') after the mirror job")
+
+    """
+    Test what happens when there would be no loop with the pre-mirror
+    configuration, but something changes during the mirror job that asks
+    for a loop to be created during completion.
+    """
+    @iotests.skip_if_unsupported(['copy-on-read', 'quorum'])
+    def test_loop_during_mirror(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 1024 * =
1024))
+
+        """
+        In this test, we are going to mirror from a node that is a
+        filter above some file "common-base".  The target is a quorum
+        node (with just an unrelated null-co child).
+
+        We will ask the mirror job to replace common-base by the
+        target upon completion.  That is a completely valid
+        configuration so far.
+
+        However, while the job is running, we add common-base as an
+        (indirect[1]) child to the target quorum node.  This way,
+        completing the job as requested would yield a loop, because
+        the target would be supposed to replace common-base -- which
+        is its own (indirect) child.
+
+        [1] It needs to be an indirect child, because if it were a
+        direct child, the mirror job would simply end by effectively
+        injecting the target above common-base.  This is the same
+        effect as when using sync=3Dnone: The target ends up above the
+        source.
+
+        So only loops that have a length of more than one node are
+        forbidden, which means common-base must be an indirect child
+        of the target.
+
+        (Furthermore, we are going to use x-blockdev-change to add
+        common-base as a child to the target.  This command only
+        allows doing so for nodes that have no parent yet.
+        common-base will have a parent already, though, namely the
+        source node.  Therefore, this is another reason why we need at
+        least one node above common-base, so this parent can become
+        target's child during the mirror.)
+        """
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
+        """
+        As explained above, we have to create a parent above
+        common-base.
+
+        We cannot use any parent that would forward the RESIZE
+        permission, because the job takes it on the target, but
+        unshares it on the source: After the x-blockdev-change
+        operation during the mirror job, this parent will be a child
+        of the target, so common-base will be an (indirect) child of
+        both the mirror's source and target.  Thus, the job would
+        conflict with itself.
+
+        Therefore, we make common-base a backing child of a $imgfmt
+        node.  Unfortunately, we cannot let the mirror job replace a
+        node that acts as a backing child somewhere (because of an op
+        blocker), so we put another raw node between the $imgfmt node
+        and common-base.
+        """
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': iotests.imgfmt,
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
+        """
+        Add a quorum node with a single child, we will add base-parent
+        to prepare a loop later.
+        (We do not care about this single child at all, but it is
+        impossible to create a quorum node without any children.  We
+        will ignore this child from now on.)
+        """
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': 'quorum',
+                                 'node-name': 'target',
+                                 'vote-threshold': 1,
+                                 'children': [
+                                     {
+                                         'driver': 'null-co',
+                                         'read-zeroes': True,
+                                         'size': 1 * 1024 * 1024
+                                     }
+                                 ]
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        """
+        Current block graph:
+
+        base-parent[$imgfmt] --backing--> [raw]
+                                            |
+                                           file
+                                            v
+              source[COR] --file--> common-base[null-co]
+
+        target[quorum]
+
+
+        The following blockdev-mirror asks for this graph post-mirror:
+
+        base-parent[$imgfmt] --backing--> [raw]
+                                            |
+                                           file
+                                            v
+                source[COR] --file--> target[quorum]
+
+        That would be a valid configuration without any loops.
+        """
+
+        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'mirror',
+                             device=3D'source', target=3D'target', sync=3D=
'full',
+                             replaces=3D'common-base')
+        self.assert_qmp(result, 'return', {})
+
+        """
+        However, now we will make base-parent a child of target.
+        Before the mirror job completes, that is still completely
+        valid:
+
+                                             source
+                                               |
+                                               v
+        target -> base-parent -> [raw] -> common-base
+        """
+
+        result =3D self.vm.qmp('x-blockdev-change',
+                             parent=3D'target', node=3D'base-parent')
+        self.assert_qmp(result, 'return', {})
+
+        """
+        However, post-mirror, we thus ask for a loop:
+
+        source -> target (replaced common-base) -> base-parent
+                                  ^                    |
+                                  |                    v
+                                  +----------------- [raw]
+
+        bdrv_replace_node() would not allow such a configuration, but
+        we should not pretend we can create it, so the mirror job
+        should fail during completion.
+        """
+
+        self.complete_and_wait('mirror',
+                               completion_error=3D'Operation not permitted=
')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
                  supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 877b76fd31..20a8158b99 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-..........................................................................=
....................
+..........................................................................=
......................
 ----------------------------------------------------------------------
-Ran 94 tests
+Ran 96 tests
=20
 OK
--=20
2.23.0


