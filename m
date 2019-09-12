Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD3C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94DB2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94DB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Q01-0001Jj-BU
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8Pam-0006pE-Dd
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8Pak-0006Sw-EH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8Pai-0006Rq-Ae; Thu, 12 Sep 2019 09:56:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A36D61DAC;
 Thu, 12 Sep 2019 13:56:55 +0000 (UTC)
Received: from localhost (unknown [10.40.205.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF17860C5D;
 Thu, 12 Sep 2019 13:56:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:56:31 +0200
Message-Id: <20190912135632.13925-4-mreitz@redhat.com>
In-Reply-To: <20190912135632.13925-1-mreitz@redhat.com>
References: <20190912135632.13925-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 12 Sep 2019 13:56:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] iotests: Add @error to wait_until_completed
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Callers can use this new parameter to expect failure during the
completion process.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b26271187c..300347c7c8 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -745,15 +745,20 @@ class QMPTestCase(unittest.TestCase):
         self.assert_no_active_block_jobs()
         return result
=20
-    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
, wait=3D60.0):
+    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
, wait=3D60.0,
+                             error=3DNone):
         '''Wait for a block job to finish, returning the event'''
         while True:
             for event in self.vm.get_qmp_events(wait=3Dwait):
                 if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
                     self.assert_qmp(event, 'data/device', drive)
-                    self.assert_qmp_absent(event, 'data/error')
-                    if check_offset:
-                        self.assert_qmp(event, 'data/offset', event['dat=
a']['len'])
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
@@ -771,7 +776,8 @@ class QMPTestCase(unittest.TestCase):
         self.assert_qmp(event, 'data/type', 'mirror')
         self.assert_qmp(event, 'data/offset', event['data']['len'])
=20
-    def complete_and_wait(self, drive=3D'drive0', wait_ready=3DTrue):
+    def complete_and_wait(self, drive=3D'drive0', wait_ready=3DTrue,
+                          completion_error=3DNone):
         '''Complete a block job and wait for it to finish'''
         if wait_ready:
             self.wait_ready(drive=3Ddrive)
@@ -779,7 +785,7 @@ class QMPTestCase(unittest.TestCase):
         result =3D self.vm.qmp('block-job-complete', device=3Ddrive)
         self.assert_qmp(result, 'return', {})
=20
-        event =3D self.wait_until_completed(drive=3Ddrive)
+        event =3D self.wait_until_completed(drive=3Ddrive, error=3Dcompl=
etion_error)
         self.assert_qmp(event, 'data/type', 'mirror')
=20
     def pause_wait(self, job_id=3D'job0'):
--=20
2.21.0


