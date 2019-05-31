Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FF2C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAC226C3F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAC226C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkWV-0001Ux-FI
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:36:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRt-0006lz-Uu
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRs-0008Ci-G8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:57240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRs-0008Ae-6u; Fri, 31 May 2019 12:32:08 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRn-0006Lb-FF; Fri, 31 May 2019 19:32:03 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 31 May 2019 19:31:55 +0300
Message-Id: <20190531163202.162543-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190531163202.162543-1-vsementsov@virtuozzo.com>
References: <20190531163202.162543-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 2/9] python/qemu: improve event_wait method
 of vm
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Support several names to wait for, which useful, when we don't sure
which event will we get. For example when mirror fails we get
BLOCK_JOB_COMPLETE otherwise we get BLOCK_JOB_READY (and only then,
after completing block-job we get BLOCK_JOB_COMPLETE).

Also, add filtered version for convenient use.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 python/qemu/__init__.py       | 9 ++++++---
 tests/qemu-iotests/iotests.py | 5 +++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index 81d9657ec0..5e517025b9 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -402,7 +402,7 @@ class QEMUMachine(object):
         self._qmp.clear_events()
         return events
 
-    def event_wait(self, name, timeout=60.0, match=None):
+    def event_wait(self, names, timeout=60.0, match=None):
         """
         Wait for specified timeout on named event in QMP; optionally filter
         results by match.
@@ -412,6 +412,9 @@ class QEMUMachine(object):
            {"foo": {"bar": 1}} matches {"foo": None}
            {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
         """
+        if not isinstance(names, list):
+            names = [names]
+
         def event_match(event, match=None):
             if match is None:
                 return True
@@ -430,14 +433,14 @@ class QEMUMachine(object):
 
         # Search cached events
         for event in self._events:
-            if (event['event'] == name) and event_match(event, match):
+            if (event['event'] in names) and event_match(event, match):
                 self._events.remove(event)
                 return event
 
         # Poll for new events
         while True:
             event = self._qmp.pull_event(wait=timeout)
-            if (event['event'] == name) and event_match(event, match):
+            if (event['event'] in names) and event_match(event, match):
                 return event
             self._events.append(event)
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7bde380d96..4218fc908b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -532,6 +532,11 @@ class VM(qtest.QEMUQtestMachine):
         log(result, filters, indent=indent)
         return result
 
+    def event_wait_log(self, names, **kwargs):
+        event = self.event_wait(names, **kwargs)
+        log(event, filters=[filter_qmp_event])
+        return event
+
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
         error = None
-- 
2.18.0


