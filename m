Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D89CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3B320708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/y7BHQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3B320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHqs-0005Ib-1x
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ixHcq-0005QS-SA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ixHco-0005I9-Jf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ixHco-0005AY-F4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfEAeEeoLYiuKThlyZdwC0vvP+j3sfH5+r9f+P/RhZI=;
 b=N/y7BHQalheFq/oPGw8IB+qnlM1ri4BiAzZ7w1elQo2sVM7drku0F4QTrUdwfLeCH7XjJU
 T5JWAaboEufChZuw7aY9hNbl+IoX7WNPV4jRd2yzm6Fz57IRwyZrS5ozgpnkHx3+8VlrWz
 uWZlOmkvy2K49IBY1kDEZs5edIf+WVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-TDRAxoGxPUW84OoBbdFwZg-1; Thu, 30 Jan 2020 16:45:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C51FF108C31D;
 Thu, 30 Jan 2020 21:45:15 +0000 (UTC)
Received: from localhost (ovpn-204-145.brq.redhat.com [10.40.204.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5376119488;
 Thu, 30 Jan 2020 21:45:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 17/21] iotests/041: Drop superfluous shutdowns
Date: Thu, 30 Jan 2020 22:44:27 +0100
Message-Id: <20200130214431.333510-18-mreitz@redhat.com>
In-Reply-To: <20200130214431.333510-1-mreitz@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TDRAxoGxPUW84OoBbdFwZg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All tearDowns in 041 shutdown the VM.  Thus, test cases do not need to
do it themselves (unless they need the VM to be down for some
post-operation check).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041 | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index a429281f61..20cfad1d2c 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -80,7 +80,6 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.cancel_and_wait(force=3DTrue)
         result =3D self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/file', test_img)
-        self.vm.shutdown()
=20
     def test_cancel_after_ready(self):
         self.assert_no_active_block_jobs()
@@ -201,8 +200,6 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/node-name', 'top')
         self.assert_qmp(result, 'return[0]/backing/node-name', 'base')
=20
-        self.vm.shutdown()
-
     def test_medium_not_found(self):
         if iotests.qemu_default_machine !=3D 'pc':
             return
@@ -455,7 +452,6 @@ new_state =3D "1"
                     self.assert_qmp(event, 'data/id', 'drive0')
=20
         self.assert_no_active_block_jobs()
-        self.vm.shutdown()
=20
     def test_ignore_read(self):
         self.assert_no_active_block_jobs()
@@ -475,7 +471,6 @@ new_state =3D "1"
         result =3D self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/paused', False)
         self.complete_and_wait()
-        self.vm.shutdown()
=20
     def test_large_cluster(self):
         self.assert_no_active_block_jobs()
@@ -540,7 +535,6 @@ new_state =3D "1"
=20
         self.complete_and_wait(wait_ready=3DFalse)
         self.assert_no_active_block_jobs()
-        self.vm.shutdown()
=20
 class TestWriteErrors(iotests.QMPTestCase):
     image_len =3D 2 * 1024 * 1024 # MB
@@ -614,7 +608,6 @@ new_state =3D "1"
                     completed =3D True
=20
         self.assert_no_active_block_jobs()
-        self.vm.shutdown()
=20
     def test_ignore_write(self):
         self.assert_no_active_block_jobs()
@@ -631,7 +624,6 @@ new_state =3D "1"
         result =3D self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/paused', False)
         self.complete_and_wait()
-        self.vm.shutdown()
=20
     def test_stop_write(self):
         self.assert_no_active_block_jobs()
@@ -667,7 +659,6 @@ new_state =3D "1"
=20
         self.complete_and_wait(wait_ready=3DFalse)
         self.assert_no_active_block_jobs()
-        self.vm.shutdown()
=20
 class TestSetSpeed(iotests.QMPTestCase):
     image_len =3D 80 * 1024 * 1024 # MB
@@ -936,7 +927,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         # here we check that the last registered quorum file has not been
         # swapped out and unref
         self.assert_has_block_node(None, quorum_img3)
-        self.vm.shutdown()
=20
     def test_cancel_after_ready(self):
         self.assert_no_active_block_jobs()
@@ -1043,7 +1033,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_has_block_node("repair0", quorum_repair_img)
         # TODO: a better test requiring some QEMU infrastructure will be a=
dded
         #       to check that this file is really driven by quorum
-        self.vm.shutdown()
=20
 # Test mirroring with a source that does not have any parents (not even a
 # BlockBackend)
--=20
2.24.1


