Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A5FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF872245A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIwFiHjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF872245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3Yl-0008PM-8q
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tw-0002d2-Al
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tu-0003NN-A3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT3Tu-0003Lx-69
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573216512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iRXBeYbPgaEfj/hVtcYPHZ7N1p+uz1h0cMBVchlZWA=;
 b=OIwFiHjF0J1H6vAzkilNZQ8iQJKqwmVdG4rlzJzG7X6V2dC+G7UYcA/uZQvCQIfW28Sfq4
 iZr7b1/Z2odkb2LU17GKBvzX5b9p+5uc113PdW7umSsYl6XddH6VSb0pZXruX0P/x55kEh
 cYW0Sftu6CvpbrmWJi6an2spCTd9sWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-9v3l84txOsyoAA0Hd5SCoA-1; Fri, 08 Nov 2019 07:35:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E0FA107ACC3;
 Fri,  8 Nov 2019 12:35:06 +0000 (UTC)
Received: from localhost (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 254CA5C290;
 Fri,  8 Nov 2019 12:35:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v4 4/5] iotests: Add @error to wait_until_completed
Date: Fri,  8 Nov 2019 13:34:54 +0100
Message-Id: <20191108123455.39445-5-mreitz@redhat.com>
In-Reply-To: <20191108123455.39445-1-mreitz@redhat.com>
References: <20191108123455.39445-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 9v3l84txOsyoAA0Hd5SCoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

Callers can use this new parameter to expect failure during the
completion process.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 075f4739da..2010b71d4b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -783,15 +783,20 @@ class QMPTestCase(unittest.TestCase):
         self.assert_no_active_block_jobs()
         return result
=20
-    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue, =
wait=3D60.0):
+    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue, =
wait=3D60.0,
+                             error=3DNone):
         '''Wait for a block job to finish, returning the event'''
         while True:
             for event in self.vm.get_qmp_events(wait=3Dwait):
                 if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
                     self.assert_qmp(event, 'data/device', drive)
-                    self.assert_qmp_absent(event, 'data/error')
-                    if check_offset:
-                        self.assert_qmp(event, 'data/offset', event['data'=
]['len'])
+                    if error is None:
+                        self.assert_qmp_absent(event, 'data/error')
+                        if check_offset:
+                            self.assert_qmp(event, 'data/offset',
+                                            event['data']['len'])
+                    else:
+                        self.assert_qmp(event, 'data/error', error)
                     self.assert_no_active_block_jobs()
                     return event
                 elif event['event'] =3D=3D 'JOB_STATUS_CHANGE':
@@ -809,7 +814,8 @@ class QMPTestCase(unittest.TestCase):
         self.assert_qmp(event, 'data/type', 'mirror')
         self.assert_qmp(event, 'data/offset', event['data']['len'])
=20
-    def complete_and_wait(self, drive=3D'drive0', wait_ready=3DTrue):
+    def complete_and_wait(self, drive=3D'drive0', wait_ready=3DTrue,
+                          completion_error=3DNone):
         '''Complete a block job and wait for it to finish'''
         if wait_ready:
             self.wait_ready(drive=3Ddrive)
@@ -817,7 +823,7 @@ class QMPTestCase(unittest.TestCase):
         result =3D self.vm.qmp('block-job-complete', device=3Ddrive)
         self.assert_qmp(result, 'return', {})
=20
-        event =3D self.wait_until_completed(drive=3Ddrive)
+        event =3D self.wait_until_completed(drive=3Ddrive, error=3Dcomplet=
ion_error)
         self.assert_qmp(event, 'data/type', 'mirror')
=20
     def pause_wait(self, job_id=3D'job0'):
--=20
2.23.0


