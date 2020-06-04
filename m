Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41442C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12091206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9CkCvbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12091206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgvyb-0004qv-Bw
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvvA-0000Su-NG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:53:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53099
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvv9-0008QG-LT
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591300378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/X2gLnAZOa7ALd+EaLAk+xI3ePG5eyBIqN/dHPyprBo=;
 b=O9CkCvbprCwNLZdxBhLsXTmVbX/zWFPdg9iWpAM54SG9s5ljakJMOdNx7mr3HZ5QSqWOEb
 dZjoQqd8kYap0xVSZW8mt7xuouEpbSzb45sy+PkYIqVOx0dNAmDWhVDOK7gPXg037gfI6W
 rKIZejqcirdQ2V5YRI2SN/99Hg2sea8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-NFv0dOnHOxqUHhE19cHYcA-1; Thu, 04 Jun 2020 15:52:57 -0400
X-MC-Unique: NFv0dOnHOxqUHhE19cHYcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7340F835B45
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 19:52:56 +0000 (UTC)
Received: from probe.redhat.com (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 662EC6ACF6;
 Thu,  4 Jun 2020 19:52:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] python/machine.py: refactor shutdown
Date: Thu,  4 Jun 2020 15:52:51 -0400
Message-Id: <20200604195252.20739-3-jsnow@redhat.com>
In-Reply-To: <20200604195252.20739-1-jsnow@redhat.com>
References: <20200604195252.20739-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, philmd@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is done primarily to avoid the 'bare except' pattern, which
suppresses ALL exceptions and not just ones that we are anticipating to
see.

Replace this with a pattern that isolates the different kind of shutdown
paradigms and a new fallback shutdown handler that gracefully attempts
one before the other.

Ensure that the main shutdown() function ALWAYS calls the post_shutdown
logic, no matter what kind of error we encountered. Subprocess wait
timeouts are considered expected, everything else is unexpected.

In cases where we encounter an expected error in the graceful shutdown
timeout, we will not re-raise an exception above shutdown(). Otherwise,
after post_shutdown cleanup, we will.

I anticipate that this WILL lead to additional bug reports filed against
this module, but that is unfortunately somewhat the point: This code
shouldn't be hiding failures that exist elsewhere within the python
code.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 68 ++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index f7e68191c28..a2abd2c35e3 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -359,9 +359,51 @@ def wait(self):
             self._qmp.close()
         self._post_shutdown()
 
-    def shutdown(self, has_quit=False, hard=False):
+    def _hard_shutdown(self) -> None:
         """
-        Terminate the VM and clean up
+        Kill the VM if it is running.
+        """
+        if not self.is_running():
+            return
+
+        self._popen.kill()
+        self._popen.wait(timeout=60)
+
+    def _soft_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
+        """
+        Attempt to shutdown the VM gracefully if it is running.
+
+        :param has_quit: When True, don't attempt to issue 'quit' QMP command
+        :param timeout: Timeout for graceful shutdown. Default 3 seconds.
+        """
+        if not self.is_running():
+            return
+
+        if self._qmp is not None:
+            if not has_quit:
+                self._qmp.cmd('quit')
+            self._qmp.close()
+
+        self._popen.wait(timeout=timeout)
+
+    def _do_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
+        """
+        Attempt to shutdown the VM gracefully; fallback to a hard shutdown.
+
+        :param has_quit: When True, don't attempt to issue 'quit' QMP command
+        :param timeout: Timeout for graceful shutdown. Default 3 seconds.
+        """
+        try:
+            self._soft_shutdown(has_quit, timeout)
+        except subprocess.TimeoutExpired:
+            self._hard_shutdown()
+        except:
+            self._hard_shutdown()
+            raise
+
+    def shutdown(self, has_quit: bool = False, hard: bool = False) -> None:
+        """
+        Terminate the VM (gracefully if possible) and perform cleanup.
         """
         # If we keep the console socket open, we may deadlock waiting
         # for QEMU to exit, while QEMU is waiting for the socket to
@@ -370,22 +412,18 @@ def shutdown(self, has_quit=False, hard=False):
             self._console_socket.close()
             self._console_socket = None
 
-        if self.is_running():
+        try:
             if hard:
-                self._popen.kill()
-            elif self._qmp:
-                try:
-                    if not has_quit:
-                        self._qmp.cmd('quit')
-                    self._qmp.close()
-                    self._popen.wait(timeout=3)
-                except:
-                    self._popen.kill()
-            self._popen.wait()
-
-        self._post_shutdown()
+                self._hard_shutdown()
+            else:
+                self._do_shutdown(has_quit)
+        finally:
+            self._post_shutdown()
 
     def kill(self):
+        """
+        Terminate the VM forcefully and perform cleanup.
+        """
         self.shutdown(hard=True)
 
     def set_qmp_monitor(self, enabled=True):
-- 
2.21.3


