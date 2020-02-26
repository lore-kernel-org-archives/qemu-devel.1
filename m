Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832BC4BA09
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762BA222C2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZNSZ4Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762BA222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6kpu-0006gK-Mc
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 19:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6koZ-000557-9Y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6koY-0003v7-6h
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6koY-0003tT-3R
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582677877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMtK6Wcuc47GOtf9RLanCByUeI3Pg0Njk7/8ydfywak=;
 b=OZNSZ4Zd6TgA2SPaL5R/kx8bCUAmGOmMfma86YMBwViTOc5vrSdUuJRAi3yT2HN+xftkdl
 E9y1DnqNd8tPDiQougcUpX/Sw/Sn342Rf3KRnMnApFDVUa8d2dldFUP0xEL9iyPKPzAF/x
 dis9YjgDPhv3UfpQSRFtFP5hALUsTxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124--pQGCbREPoWvqUekZo_zWw-1; Tue, 25 Feb 2020 19:44:29 -0500
X-MC-Unique: -pQGCbREPoWvqUekZo_zWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 218A8800D5B;
 Wed, 26 Feb 2020 00:44:28 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AE1E8AC42;
 Wed, 26 Feb 2020 00:44:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] iotests: modify test 040 to use JobRunner
Date: Tue, 25 Feb 2020 19:44:25 -0500
Message-Id: <20200226004425.1303-3-jsnow@redhat.com>
In-Reply-To: <20200226004425.1303-1-jsnow@redhat.com>
References: <20200226004425.1303-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of having somewhat reproduced it for itself.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/040 | 51 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 90b59081ff..579dafc797 100755
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
+            result =3D self._vm.qmp('block-job-resume', device=3Dself._id)
+            self.test.assert_qmp(result, 'return', {})
+            super().on_pause(event)
+
+        def on_block_job_event(self, event):
+            if event['event'] not in self.expected_events:
+                self.test.fail("Unexpected event: %s" % event)
+            super().on_block_job_event(event)
+            self.log.append(iotests.filter_qmp_event(event))
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
+        job =3D self.TestJobRunner(self.vm, 'job0', use_log=3DFalse, test=
=3Dself)
+        job.run()
         self.maxDiff =3D None
-        self.assertEqual(expected_events, log)
+        self.assertEqual(expected_events, job.log)
=20
     def event_error(self, op, action):
         return {
--=20
2.21.1


