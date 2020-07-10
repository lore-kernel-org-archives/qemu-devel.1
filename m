Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D32220720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQoL3e6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D32220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlXu-0005qb-O6
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUh-0007oB-Lt
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUe-0008FU-S0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl5vFWH4094e0AZLI5uZbAlUAySRH88xV55lX5j5Z14=;
 b=NQoL3e6z4bI49ayjlqL0yfKgDzbR6dyRCLTwPTesQvZ9VHhHcVf1P+cyRyvpQGb6zR4ulz
 UiFSU8s0aJZYDhfEep2w/Qn87dQbOtAA5i+lMPZKK2A13Q3snLHmb2XxOS5Eh9meC6MKZs
 PY7rIB0zbcrx3aQVARy38p9XngGyELc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-AP8L-UyEPTCJgs5KjmBe_Q-1; Fri, 10 Jul 2020 01:22:38 -0400
X-MC-Unique: AP8L-UyEPTCJgs5KjmBe_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1A19100A614;
 Fri, 10 Jul 2020 05:22:37 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFBC5920C2;
 Fri, 10 Jul 2020 05:22:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/16] python/machine.py: fix _popen access
Date: Fri, 10 Jul 2020 01:22:17 -0400
Message-Id: <20200710052220.3306-14-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 python/qemu/machine.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 9760a2badb..2ba5e3134e 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -120,7 +120,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         # Runstate
         self._qemu_log_path = None
         self._qemu_log_file = None
-        self._popen = None
+        self._popen: Optional['subprocess.Popen[bytes]'] = None
         self._events = []
         self._iolog = None
         self._qmp_set = True   # Enable QMP monitor by default.
@@ -233,6 +233,12 @@ def is_running(self):
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
@@ -243,7 +249,7 @@ def get_pid(self):
         """Returns the PID of the running process, or None."""
         if not self.is_running():
             return None
-        return self._popen.pid
+        return self._subp.pid
 
     def _load_io_log(self):
         if self._qemu_log_path is not None:
@@ -404,8 +410,8 @@ def _hard_shutdown(self) -> None:
             waiting for the QEMU process to terminate.
         """
         self._early_cleanup()
-        self._popen.kill()
-        self._popen.wait(timeout=60)
+        self._subp.kill()
+        self._subp.wait(timeout=60)
 
     def _soft_shutdown(self, has_quit: bool = False,
                        timeout: Optional[int] = 3) -> None:
@@ -429,7 +435,7 @@ def _soft_shutdown(self, has_quit: bool = False,
                 self._qmp.cmd('quit')
 
         # May raise subprocess.TimeoutExpired
-        self._popen.wait(timeout=timeout)
+        self._subp.wait(timeout=timeout)
 
     def _do_shutdown(self, has_quit: bool = False,
                      timeout: Optional[int] = 3) -> None:
-- 
2.21.3


