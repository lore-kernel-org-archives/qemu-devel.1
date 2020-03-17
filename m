Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D594CC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FCE206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZWp6fKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FCE206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3ym-0007gn-S8
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE3wR-0004f2-Oh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE3wP-0000je-Fi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE3wP-0000f7-B5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584419697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orgTszhfV3dEbp+pu5KH9GxYNoUHEki++yMiFhha/vk=;
 b=eZWp6fKERn2FrZX8hkeUXfSuN0SNGGLRH23DkvLiQIttrs2TZIx+pHnAxcK11GjBwOAFl0
 1dzcwIMJYy1MJJah1GGFW7zPl2L7z2AkECMWUzJmuVgYcHvoXEy5c4pVNhNjOMTbxPlDdg
 8krDW9chpJwF1iYzRBxlr4KhlcP5bNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-w-MIqttdMTGzjxGeTiLrww-1; Tue, 17 Mar 2020 00:34:44 -0400
X-MC-Unique: w-MIqttdMTGzjxGeTiLrww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23F1D8017CC;
 Tue, 17 Mar 2020 04:34:43 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 259F35C1BB;
 Tue, 17 Mar 2020 04:34:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] iotests: modify test 040 to use JobRunner
Date: Tue, 17 Mar 2020 00:34:37 -0400
Message-Id: <20200317043437.19464-4-jsnow@redhat.com>
In-Reply-To: <20200317043437.19464-1-jsnow@redhat.com>
References: <20200317043437.19464-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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


