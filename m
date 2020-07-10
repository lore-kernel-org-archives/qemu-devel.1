Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1080BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F92206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/M8YvRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F92206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlMN-0003eb-2n
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFo-0000bW-Qf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFm-0006Xp-Vz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594357638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I70VbcP6dOpkYtvyRK9WoQWdPqZxvM5GBeySNkN7lS0=;
 b=f/M8YvRMEhl25ms7BFXag5qJYtljKaVmz92V+1Q1qPLeqMntEv8/DmznJ/0784rSGUBPqa
 nFkbFv312yiD4DXVOoYKH7O9uUXamPxInmNDTTJccKyPAbUQzA47sBMaNxzDWhNNYBoFdO
 El0ef/7R0AF7GP+UAHmk2ByKCmh+7CA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-l6IdUtaPMSKpLSCNGPJ6oQ-1; Fri, 10 Jul 2020 01:07:15 -0400
X-MC-Unique: l6IdUtaPMSKpLSCNGPJ6oQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0247A10067B7;
 Fri, 10 Jul 2020 05:07:14 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C212B10098A1;
 Fri, 10 Jul 2020 05:07:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/12] python/machine.py: split shutdown into hard and soft
 flavors
Date: Fri, 10 Jul 2020 01:06:47 -0400
Message-Id: <20200710050649.32434-11-jsnow@redhat.com>
In-Reply-To: <20200710050649.32434-1-jsnow@redhat.com>
References: <20200710050649.32434-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is done primarily to avoid the 'bare except' pattern, which
suppresses all exceptions during shutdown and can obscure errors.

Replace this with a pattern that isolates the different kind of shutdown
paradigms (_hard_shutdown and _soft_shutdown), and a new fallback shutdown
handler (_do_shutdown) that gracefully attempts one before the other.

This split now also ensures that no matter what happens,
_post_shutdown() is always invoked.

shutdown() changes in behavior such that if it attempts to do a graceful
shutdown and is unable to, it will now always raise an exception to
indicate this. This can be avoided by the test writer in three ways:

1. If the VM is expected to have already exited or is in the process of
exiting, wait() can be used instead of shutdown() to clean up resources
instead. This helps avoid race conditions in shutdown.

2. If a test writer is expecting graceful shutdown to fail, shutdown
should be called in a try...except block.

3. If the test writer has no interest in performing a graceful shutdown
at all, kill() can be used instead.


Handling shutdown in this way makes it much more explicit which type of
shutdown we want and allows the library to report problems with this
process.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 95 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 15 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index aaa173f046..b24ce8a268 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -48,6 +48,12 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
     """
 
 
+class AbnormalShutdown(QEMUMachineError):
+    """
+    Exception raised when a graceful shutdown was requested, but not performed.
+    """
+
+
 class MonitorResponseError(qmp.QMPError):
     """
     Represents erroneous QMP monitor reply
@@ -365,6 +371,7 @@ def _early_cleanup(self) -> None:
         """
         Perform any cleanup that needs to happen before the VM exits.
 
+        May be invoked by both soft and hard shutdown in failover scenarios.
         Called additionally by _post_shutdown for comprehensive cleanup.
         """
         # If we keep the console socket open, we may deadlock waiting
@@ -374,32 +381,90 @@ def _early_cleanup(self) -> None:
             self._console_socket.close()
             self._console_socket = None
 
+    def _hard_shutdown(self) -> None:
+        """
+        Perform early cleanup, kill the VM, and wait for it to terminate.
+
+        :raise subprocess.Timeout: When timeout is exceeds 60 seconds
+            waiting for the QEMU process to terminate.
+        """
+        self._early_cleanup()
+        self._popen.kill()
+        self._popen.wait(timeout=60)
+
+    def _soft_shutdown(self, has_quit: bool = False,
+                       timeout: Optional[int] = 3) -> None:
+        """
+        Perform early cleanup, attempt to gracefully shut down the VM, and wait
+        for it to terminate.
+
+        :param has_quit: When True, don't attempt to issue 'quit' QMP command
+        :param timeout: Optional timeout in seconds for graceful shutdown.
+                        Default 3 seconds, A value of None is an infinite wait.
+
+        :raise ConnectionReset: On QMP communication errors
+        :raise subprocess.TimeoutExpired: When timeout is exceeded waiting for
+            the QEMU process to terminate.
+        """
+        self._early_cleanup()
+
+        if self._qmp is not None:
+            if not has_quit:
+                # Might raise ConnectionReset
+                self._qmp.cmd('quit')
+
+        # May raise subprocess.TimeoutExpired
+        self._popen.wait(timeout=timeout)
+
+    def _do_shutdown(self, has_quit: bool = False,
+                     timeout: Optional[int] = 3) -> None:
+        """
+        Attempt to shutdown the VM gracefully; fallback to a hard shutdown.
+
+        :param has_quit: When True, don't attempt to issue 'quit' QMP command
+        :param timeout: Optional timeout in seconds for graceful shutdown.
+                        Default 3 seconds, A value of None is an infinite wait.
+
+        :raise AbnormalShutdown: When the VM could not be shut down gracefully.
+            The inner exception will likely be ConnectionReset or
+            subprocess.TimeoutExpired. In rare cases, non-graceful termination
+            may result in its own exceptions, likely subprocess.TimeoutExpired.
+        """
+        try:
+            self._soft_shutdown(has_quit, timeout)
+        except Exception as exc:
+            self._hard_shutdown()
+            raise AbnormalShutdown("Could not perform graceful shutdown") \
+                from exc
+
     def shutdown(self, has_quit: bool = False,
                  hard: bool = False,
                  timeout: Optional[int] = 3) -> None:
         """
-        Terminate the VM and clean up
+        Terminate the VM (gracefully if possible) and perform cleanup.
+        Cleanup will always be performed.
+
+        :param has_quit: When true, do not attempt to issue 'quit' QMP command.
+        :param hard: When true, do not attempt graceful shutdown, and
+                     suppress the SIGKILL warning log message.
+        :param timeout: Optional timeout in seconds for graceful shutdown.
+                        Default 3 seconds, A value of None is an infinite wait.
         """
         if not self._launched:
             return
 
-        self._early_cleanup()
-
-        if self.is_running():
+        try:
             if hard:
-                self._popen.kill()
-            elif self._qmp:
-                try:
-                    if not has_quit:
-                        self._qmp.cmd('quit')
-                    self._popen.wait(timeout=timeout)
-                except:
-                    self._popen.kill()
-            self._popen.wait(timeout=timeout)
-
-        self._post_shutdown()
+                self._hard_shutdown()
+            else:
+                self._do_shutdown(has_quit, timeout=timeout)
+        finally:
+            self._post_shutdown()
 
     def kill(self):
+        """
+        Terminate the VM forcefully, wait for it to exit, and perform cleanup.
+        """
         self.shutdown(hard=True)
 
     def wait(self, timeout: Optional[int] = None) -> None:
-- 
2.21.3


