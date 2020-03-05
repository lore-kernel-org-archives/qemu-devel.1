Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A90EC3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A31720870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6rJ0c+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A31720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41573 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9e98-0000MR-Cz
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9e70-0005He-9g
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9e6z-0003qX-7N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9e6z-0003pz-4N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583367096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orgTszhfV3dEbp+pu5KH9GxYNoUHEki++yMiFhha/vk=;
 b=H6rJ0c+w7dOADVAcITDIINm7EtB6GIthddSYMYO3jR3jv8oZzdJCQR4HeMPtRxsCGF5Az1
 S2G0cSgxdBgGtM0Mlr4QKf6KncSSYo3itc/DBfmudaYsCC5Cdl59wEmq0Orjp4NGxxMIZY
 NyAB81vOeGyezlP9RqlHGcWyvx9nlxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-17K1CqhaPSmQmW4YNo9Arg-1; Wed, 04 Mar 2020 19:11:33 -0500
X-MC-Unique: 17K1CqhaPSmQmW4YNo9Arg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A91801E5C;
 Thu,  5 Mar 2020 00:11:32 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28B455C1D4;
 Thu,  5 Mar 2020 00:11:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] iotests: modify test 040 to use JobRunner
Date: Wed,  4 Mar 2020 19:11:25 -0500
Message-Id: <20200305001125.27549-4-jsnow@redhat.com>
In-Reply-To: <20200305001125.27549-1-jsnow@redhat.com>
References: <20200305001125.27549-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of having somewhat reproduced it for itself.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/040 | 51 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 90b59081ff..e2ef3bb812 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -483,34 +483,33 @@ class TestErrorHandling(iotests.QMPTestCase):
                           file=3D('top-dbg' if top_debug else 'top-file'),
                           backing=3D'mid-fmt')
=20
+
+    class TestJobRunner(iotests.JobRunner):
+        expected_events =3D ('BLOCK_JOB_COMPLETED',
+                           'BLOCK_JOB_ERROR',
+                           'BLOCK_JOB_READY')
+
+        def __init__(self, *args, test, **kwargs):
+            super().__init__(*args, **kwargs)
+            self.log =3D []
+            self.test =3D test
+
+        def on_pause(self, event):
+            super().on_pause(event)
+            result =3D self._vm.qmp('block-job-resume', device=3Dself._id)
+            self.test.assert_qmp(result, 'return', {})
+
+        def on_block_job_event(self, event):
+            if event['event'] not in self.expected_events:
+                self.test.fail("Unexpected event: %s" % event)
+            super().on_block_job_event(event)
+            self.log.append(event)
+
     def run_job(self, expected_events, error_pauses_job=3DFalse):
-        match_device =3D {'data': {'device': 'job0'}}
-        events =3D {
-            'BLOCK_JOB_COMPLETED': match_device,
-            'BLOCK_JOB_CANCELLED': match_device,
-            'BLOCK_JOB_ERROR': match_device,
-            'BLOCK_JOB_READY': match_device,
-        }
-
-        completed =3D False
-        log =3D []
-        while not completed:
-            ev =3D self.vm.events_wait(events, timeout=3D5.0)
-            if ev['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
-                completed =3D True
-            elif ev['event'] =3D=3D 'BLOCK_JOB_ERROR':
-                if error_pauses_job:
-                    result =3D self.vm.qmp('block-job-resume', device=3D'j=
ob0')
-                    self.assert_qmp(result, 'return', {})
-            elif ev['event'] =3D=3D 'BLOCK_JOB_READY':
-                result =3D self.vm.qmp('block-job-complete', device=3D'job=
0')
-                self.assert_qmp(result, 'return', {})
-            else:
-                self.fail("Unexpected event: %s" % ev)
-            log.append(iotests.filter_qmp_event(ev))
-
+        job =3D self.TestJobRunner(self.vm, 'job0', test=3Dself)
+        job.run()
         self.maxDiff =3D None
-        self.assertEqual(expected_events, log)
+        self.assertEqual(expected_events, job.log)
=20
     def event_error(self, op, action):
         return {
--=20
2.21.1


