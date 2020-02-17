Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50548C34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263EC20801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263EC20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hyK-0001Ce-Bv
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvL-000443-ME
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvK-0007NL-8t
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:47432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvJ-0007LG-Vg
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:02 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvH-0007Zt-4m; Mon, 17 Feb 2020 18:02:59 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/22] python/qemu/machine: add kill() method
Date: Mon, 17 Feb 2020 18:02:42 +0300
Message-Id: <20200217150246.29180-19-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: vsementsov@virtuozzo.com, Eduardo Habkost <ehabkost@redhat.com>,
 quintela@redhat.com, dgilbert@redhat.com, Cleber Rosa <crosa@redhat.com>,
 andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add method to hard-kill vm, without any quit commands.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 python/qemu/machine.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..9918e0d8aa 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -341,7 +341,7 @@ class QEMUMachine(object):
         self._load_io_log()
         self._post_shutdown()
 
-    def shutdown(self, has_quit=False):
+    def shutdown(self, has_quit=False, hard=False):
         """
         Terminate the VM and clean up
         """
@@ -353,7 +353,9 @@ class QEMUMachine(object):
             self._console_socket = None
 
         if self.is_running():
-            if self._qmp:
+            if hard:
+                self._popen.kill()
+            elif self._qmp:
                 try:
                     if not has_quit:
                         self._qmp.cmd('quit')
@@ -366,7 +368,8 @@ class QEMUMachine(object):
         self._post_shutdown()
 
         exitcode = self.exitcode()
-        if exitcode is not None and exitcode < 0:
+        if exitcode is not None and exitcode < 0 and \
+                not (exitcode == -9 and hard):
             msg = 'qemu received signal %i: %s'
             if self._qemu_full_args:
                 command = ' '.join(self._qemu_full_args)
@@ -376,6 +379,9 @@ class QEMUMachine(object):
 
         self._launched = False
 
+    def kill(self):
+        self.shutdown(hard=True)
+
     def set_qmp_monitor(self, enabled=True):
         """
         Set the QMP monitor.
-- 
2.21.0


