Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36956C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C25206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I28ykuJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C25206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCuo-0001XL-7j
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgCu4-0000iL-Ba
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:48:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgCu3-0001Wy-9o
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591127330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhgS+VypqX8QJVMO7omhr2+aVFOu2bacOpeOb8X4PDQ=;
 b=I28ykuJ42q4Iee4wGT5XVHUbKMxdciNNVwhcBS6hj8xDmV4axkW7aHVLyCLEhCkoMiYTiM
 RCfyEaz4fM2e1BWG8u5hcKIfuY084Nl3jUHlABt7tkDGFTP4JoS5WY4w1/ZguvxR7YffdG
 xOuiSpzQA39OAKwDxFhVrbwIYwuAbec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-bTyQIBxaO4i6BjVym90o0Q-1; Tue, 02 Jun 2020 15:48:48 -0400
X-MC-Unique: bTyQIBxaO4i6BjVym90o0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A99A2107B0E1
 for <qemu-devel@nongnu.org>; Tue,  2 Jun 2020 19:48:47 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69F5878EFE;
 Tue,  2 Jun 2020 19:48:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] python/machine.py: refactor shutdown
Date: Tue,  2 Jun 2020 15:48:44 -0400
Message-Id: <20200602194844.15258-2-jsnow@redhat.com>
In-Reply-To: <20200602194844.15258-1-jsnow@redhat.com>
References: <20200602194844.15258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Move all of the post-shutdown code into _post_shutdown, and adjust the
main shutdown() function to ALWAYS call the post_shutdown logic no
matter what kind of error we encountered: An expected one (subprocess
wait timeout) or an unexpected one (Everything else).

In cases where we encounter an expected error in the graceful shutdown
timeout, we will not re-raise an exception above shutdown(). Otherwise,
after post_shutdown cleanup, we will.

I anticipate that this WILL lead to additional bug reports filed against
this module, but that is unfortunately somewhat the point: This code
shouldn't be hiding failures that exist elsewhere within the python
code.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 93 +++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 041c615052e..a2abd2c35e3 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -283,6 +283,8 @@ def _post_launch(self):
             self._qmp.accept()
 
     def _post_shutdown(self):
+        self._load_io_log()
+
         if self._qemu_log_file is not None:
             self._qemu_log_file.close()
             self._qemu_log_file = None
@@ -296,6 +298,17 @@ def _post_shutdown(self):
         while len(self._remove_files) > 0:
             self._remove_if_exists(self._remove_files.pop())
 
+        exitcode = self.exitcode()
+        if exitcode is not None and exitcode < 0:
+            msg = 'qemu received signal %i; command: "%s"'
+            if self._qemu_full_args:
+                command = ' '.join(self._qemu_full_args)
+            else:
+                command = ''
+            LOG.warning(msg, -int(exitcode), command)
+
+        self._launched = False
+
     def launch(self):
         """
         Launch the VM and make sure we cleanup and expose the
@@ -344,12 +357,53 @@ def wait(self):
         self._popen.wait()
         if self._qmp:
             self._qmp.close()
-        self._load_io_log()
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
@@ -358,35 +412,18 @@ def shutdown(self, has_quit=False, hard=False):
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
-        self._load_io_log()
-        self._post_shutdown()
-
-        exitcode = self.exitcode()
-        if exitcode is not None and exitcode < 0 and \
-                not (exitcode == -9 and hard):
-            msg = 'qemu received signal %i: %s'
-            if self._qemu_full_args:
-                command = ' '.join(self._qemu_full_args)
+                self._hard_shutdown()
             else:
-                command = ''
-            LOG.warning(msg, -int(exitcode), command)
-
-        self._launched = False
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


