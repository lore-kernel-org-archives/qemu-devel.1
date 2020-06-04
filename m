Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8622C2067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISqS2WJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8622C2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwUt-0000l3-MC
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgwO9-0004R9-Ao
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26515
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgwO8-0005Xu-9R
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591302175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2F0M0Kxr4yi1TdKeym0zcdSZAKGBslQruOlqOtpQp4=;
 b=ISqS2WJleS9Rd2+6QM17ImzRSMW6UkHnkZz4KEImxs4IplNuaJClP4LFnpmrXFA3zbn/cN
 OMHwhR5QjfBWChqsikYPJRaLmMOLzkpovKhcNCaX6JOzJfIcAEUojQlz5gw2/9ItACHyxh
 dvkYIeIBtYQMN7CWO3JRh0FyqDp2bZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-hpI4ArjONpyo_OdJevTvgQ-1; Thu, 04 Jun 2020 16:22:51 -0400
X-MC-Unique: hpI4ArjONpyo_OdJevTvgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2BD8835B41;
 Thu,  4 Jun 2020 20:22:50 +0000 (UTC)
Received: from probe.redhat.com (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 243F45D9D3;
 Thu,  4 Jun 2020 20:22:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/16] python/machine.py: fix _popen access
Date: Thu,  4 Jun 2020 16:22:33 -0400
Message-Id: <20200604202236.25039-14-jsnow@redhat.com>
In-Reply-To: <20200604202236.25039-1-jsnow@redhat.com>
References: <20200604202236.25039-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As always, Optional[T] causes problems with unchecked access. Add a
helper that asserts the pipe is present before we attempt to talk with
it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a451f9000d6..a81a422b60e 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -114,7 +114,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         # Runstate
         self._qemu_log_path = None
         self._qemu_log_file = None
-        self._popen = None
+        self._popen: Optional['subprocess.Popen[bytes]'] = None
         self._events = []
         self._iolog = None
         self._qmp_set = True   # Enable QMP monitor by default.
@@ -227,6 +227,12 @@ def is_running(self):
         """Returns true if the VM is running."""
         return self._popen is not None and self._popen.poll() is None
 
+    @property
+    def _subp(self) -> 'subprocess.Popen[bytes]':
+        if self._popen is None:
+            raise QEMUMachineError('Subprocess pipe not present')
+        return self._popen
+
     def exitcode(self):
         """Returns the exit code if possible, or None."""
         if self._popen is None:
@@ -237,7 +243,7 @@ def get_pid(self):
         """Returns the PID of the running process, or None."""
         if not self.is_running():
             return None
-        return self._popen.pid
+        return self._subp.pid
 
     def _load_io_log(self):
         if self._qemu_log_path is not None:
@@ -369,7 +375,7 @@ def wait(self):
         """
         Wait for the VM to power off
         """
-        self._popen.wait()
+        self._subp.wait()
         if self._qmp:
             self._qmp.close()
         self._post_shutdown()
@@ -381,8 +387,8 @@ def _hard_shutdown(self) -> None:
         if not self.is_running():
             return
 
-        self._popen.kill()
-        self._popen.wait(timeout=60)
+        self._subp.kill()
+        self._subp.wait(timeout=60)
 
     def _soft_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
         """
@@ -399,7 +405,7 @@ def _soft_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
                 self._qmp.cmd('quit')
             self._qmp.close()
 
-        self._popen.wait(timeout=timeout)
+        self._subp.wait(timeout=timeout)
 
     def _do_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
         """
-- 
2.21.3


