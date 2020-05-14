Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C305C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 02:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464E920671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 02:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0EaGMCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464E920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ3aL-0001Qn-EI
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 22:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ3ZL-0008Sm-Gn
 for qemu-devel@nongnu.org; Wed, 13 May 2020 22:25:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ3ZK-00034F-LI
 for qemu-devel@nongnu.org; Wed, 13 May 2020 22:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589423153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfYl0TwQMc5ZPBZYeuBGsbh0WVxyzZyrT23KcuRjoBI=;
 b=R0EaGMCSQzo45S+I2xPvIdMf7Poe1/h+QP5kkE+PMJynZNXZX0G5sBVr7aQdLsnt7LXgbD
 RAHswK7GVpCKX1iZxhtS6FVJcL6obgl/tqL4BT4flgcUSQMJbCbYo98ayV+lIezJTa7asV
 qWWTGHc5zkapNXr7s/uiWYjoSaWYPbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-cFFc1vafPAaVioojmmk4nA-1; Wed, 13 May 2020 22:25:46 -0400
X-MC-Unique: cFFc1vafPAaVioojmmk4nA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CE211005512;
 Thu, 14 May 2020 02:25:45 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4406B8C2;
 Thu, 14 May 2020 02:25:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] iotests: modify test 040 to use JobRunner
Date: Wed, 13 May 2020 22:25:36 -0400
Message-Id: <20200514022536.2568-4-jsnow@redhat.com>
In-Reply-To: <20200514022536.2568-1-jsnow@redhat.com>
References: <20200514022536.2568-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
                           file=('top-dbg' if top_debug else 'top-file'),
                           backing='mid-fmt')
 
+
+    class TestJobRunner(iotests.JobRunner):
+        expected_events = ('BLOCK_JOB_COMPLETED',
+                           'BLOCK_JOB_ERROR',
+                           'BLOCK_JOB_READY')
+
+        def __init__(self, *args, test, **kwargs):
+            super().__init__(*args, **kwargs)
+            self.log = []
+            self.test = test
+
+        def on_pause(self, event):
+            super().on_pause(event)
+            result = self._vm.qmp('block-job-resume', device=self._id)
+            self.test.assert_qmp(result, 'return', {})
+
+        def on_block_job_event(self, event):
+            if event['event'] not in self.expected_events:
+                self.test.fail("Unexpected event: %s" % event)
+            super().on_block_job_event(event)
+            self.log.append(event)
+
     def run_job(self, expected_events, error_pauses_job=False):
-        match_device = {'data': {'device': 'job0'}}
-        events = {
-            'BLOCK_JOB_COMPLETED': match_device,
-            'BLOCK_JOB_CANCELLED': match_device,
-            'BLOCK_JOB_ERROR': match_device,
-            'BLOCK_JOB_READY': match_device,
-        }
-
-        completed = False
-        log = []
-        while not completed:
-            ev = self.vm.events_wait(events, timeout=5.0)
-            if ev['event'] == 'BLOCK_JOB_COMPLETED':
-                completed = True
-            elif ev['event'] == 'BLOCK_JOB_ERROR':
-                if error_pauses_job:
-                    result = self.vm.qmp('block-job-resume', device='job0')
-                    self.assert_qmp(result, 'return', {})
-            elif ev['event'] == 'BLOCK_JOB_READY':
-                result = self.vm.qmp('block-job-complete', device='job0')
-                self.assert_qmp(result, 'return', {})
-            else:
-                self.fail("Unexpected event: %s" % ev)
-            log.append(iotests.filter_qmp_event(ev))
-
+        job = self.TestJobRunner(self.vm, 'job0', test=self)
+        job.run()
         self.maxDiff = None
-        self.assertEqual(expected_events, log)
+        self.assertEqual(expected_events, job.log)
 
     def event_error(self, op, action):
         return {
-- 
2.21.1


