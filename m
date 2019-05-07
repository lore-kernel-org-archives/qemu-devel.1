Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B284C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD4220578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD4220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1fV-0007qZ-I5
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:06:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bZ-0004zX-FW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bY-0002Sx-AX
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hO1bV-0002RV-R5; Tue, 07 May 2019 11:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22E8F30832C3;
	Tue,  7 May 2019 15:02:01 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 786E25C2E1;
	Tue,  7 May 2019 15:01:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:01:53 -0500
Message-Id: <20190507150153.26859-6-eblake@redhat.com>
In-Reply-To: <20190507150153.26859-1-eblake@redhat.com>
References: <20190507150153.26859-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 07 May 2019 15:02:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/5] iotests: Make 182 do without device_add
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	"Danilo C . L . de Paula" <ddepaula@redhat.com>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

182 fails if qemu has no support for hotplugging of a virtio-blk device.
Using an NBD server instead works just as well for the test, even on
qemus without hotplugging support.

Fixes: 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963
Reported-by: Danilo C. L. de Paula <ddepaula@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20190417153005.30096-1-mreitz@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/182     | 22 +++++++++++++++++-----
 tests/qemu-iotests/182.out |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index ff3d7e7ec1b..38959bf276a 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -31,6 +31,7 @@ _cleanup()
 {
     _cleanup_test_img
     rm -f "$TEST_IMG.overlay"
+    rm -f "$TEST_DIR/nbd.socket"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15

@@ -126,15 +127,26 @@ success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE =
\
     'return' \
     'error'

-# Now we attach the image to a virtio-blk device.  This device does
-# require some permissions (at least WRITE and READ_CONSISTENT), so if
+# Start an NBD server to which we can attach node1
+success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'nbd-server-start',
+      'arguments': {
+          'addr': {
+              'type': 'unix',
+              'data': {
+                  'path': '$TEST_DIR/nbd.socket'
+              } } } }" \
+    'return' \
+    'error'
+
+# Now we attach the image to the NBD server.  This server does require
+# some permissions (at least WRITE and READ_CONSISTENT), so if
 # reopening node0 unshared any (which it should not have), this will
 # fail (but it should not).
 success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
-    "{'execute': 'device_add',
+    "{'execute': 'nbd-server-add',
       'arguments': {
-          'driver': 'virtio-blk',
-          'drive': 'node1'
+          'device': 'node1'
       } }" \
     'return' \
     'error'
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index af501ca3f3c..33d41eea915 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -14,4 +14,5 @@ Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=
=3D197120 backing_file=3DTEST_D
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"return": {}}
 *** done
--=20
2.20.1


