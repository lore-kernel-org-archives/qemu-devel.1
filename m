Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF4C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B565B20658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzH+JV/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B565B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTMi-0006Ah-VO
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJr-00018N-IM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJm-0004kS-Vb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxpPD25l94H6jH9waRJgbDvpErEb7UHCQOGbx0fD5YA=;
 b=NzH+JV/OeyOmDwfCMRFP6in31PtVI7IkeWspg1rMY5Htsujd/xDhixjIvWAoBLLFKRBldM
 5LJrQi/TE3KG7ve6ad9R9FZomwk/Qbg5GTIZwyj0GpArs/wmYMlRnAmeTBcgeXY8lp1wv+
 h4Q+FsrKHvEYhrwb5hQaqmPjWy1OtkM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-KkgddlGiPQC-_tDG0pLbDw-1; Tue, 14 Jul 2020 18:22:28 -0400
X-MC-Unique: KkgddlGiPQC-_tDG0pLbDw-1
Received: by mail-wr1-f69.google.com with SMTP id o25so18488wro.16
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fxpPD25l94H6jH9waRJgbDvpErEb7UHCQOGbx0fD5YA=;
 b=f1nu1Cz/NMljK7PDhGXAUOQclcthHm4aLlUezAW6U8RncBWBbJNxhiKTH9IusqMJFT
 M/+KVPhbhQeP+TszYEALExbU/VEddkpRFX5znkmyo+ImuJQY7PAnA9Gq4XQrezWuwJgD
 qhd9WNmsedkf2A5+KGMo9bVZCBEhJqhCmwFWON6XTGyDjAi1SAGOsSB/BWD2wWkCWSa5
 Vdz9Z5xmcxo4Y+xKTMpJjlyNNHbwRmpZKENyXHbSoXymqFKlrCyoFRyvqrCvqGAK/wq0
 6DUjk5bIQQovoVyDuzOuANWhWhfiSPCnFqQIAkyXqT7nvDI8cKcU7oUgxd2VF1E1wqWU
 g+Ng==
X-Gm-Message-State: AOAM530sd8ooIsb1NM5iZtHUNFE/84bLs4byfs/A5bsHJP6L3JSUGo84
 S8ezS+i+q30oF/dwtJ1vcALESRMgyVlontl+wBws3pK/TBX2zdwZ5dcvq5GAWQms2iZecaoaU50
 m8rjOjvZNwsFj8kY=
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr8264546wrq.263.1594765346765; 
 Tue, 14 Jul 2020 15:22:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwanRA/LIdrlHXnRYIrv61pWu7j68fnofevncVhh1VvW3D1TOPE3ae+3SWppY5GjxrIbmNkQ==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr8264521wrq.263.1594765346477; 
 Tue, 14 Jul 2020 15:22:26 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u10sm289156wml.29.2020.07.14.15.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/19] python/machine.py: split shutdown into hard and soft
 flavors
Date: Wed, 15 Jul 2020 00:21:24 +0200
Message-Id: <20200714222132.10815-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 18:21:58
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-11-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 98 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 15 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 3f0b873f58..a955e3f221 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -49,6 +49,12 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
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
@@ -376,6 +382,7 @@ def _early_cleanup(self) -> None:
         """
         Perform any cleanup that needs to happen before the VM exits.
 
+        May be invoked by both soft and hard shutdown in failover scenarios.
         Called additionally by _post_shutdown for comprehensive cleanup.
         """
         # If we keep the console socket open, we may deadlock waiting
@@ -385,32 +392,93 @@ def _early_cleanup(self) -> None:
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
+        If the VM has not yet been launched, or shutdown(), wait(), or kill()
+        have already been called, this method does nothing.
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


