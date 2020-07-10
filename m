Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B9920663
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyjNqONq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B9920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlI9-00057N-U5
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFa-0008Od-Pi
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFZ-0006WX-9b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594357624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9v80O3fWqGNBt/FomJzB2cVwGtaWrYQoqftjGdBjHXA=;
 b=EyjNqONqIlWxZEdNhygcSkgwbhPnKwNhrdjRroUVuwzWB+Fq0XDsPxBALW3XIC9oXizK7s
 w7DhiFBnaQStEVOw9L2UfCjKuaiWrLi+U5uwy7Unozj30WG2rbAzieO2FCuTFiLx/Balka
 8dTj1aPfEBz+OFFlKuHdhHftfq+GuJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-cqD7cpcuP6ODUZ-CaN0Tfw-1; Fri, 10 Jul 2020 01:07:02 -0400
X-MC-Unique: cqD7cpcuP6ODUZ-CaN0Tfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5154391C941;
 Fri, 10 Jul 2020 05:07:01 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C64CB100EBA9;
 Fri, 10 Jul 2020 05:06:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/12] python/machine.py: Prohibit multiple shutdown() calls
Date: Fri, 10 Jul 2020 01:06:42 -0400
Message-Id: <20200710050649.32434-6-jsnow@redhat.com>
In-Reply-To: <20200710050649.32434-1-jsnow@redhat.com>
References: <20200710050649.32434-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

If the VM is not launched, don't try to shut it down. As a change,
_post_shutdown now unconditionally also calls _early_cleanup in order to
offer comprehensive object cleanup in failure cases.

As a courtesy, treat it as a NOP instead of rejecting it as an
error. This is slightly nicer for acceptance tests where vm.shutdown()
is issued unconditionally in tearDown callbacks.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index cac466fbe6..e66a7d66dd 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -283,6 +283,13 @@ def _post_launch(self):
             self._qmp.accept()
 
     def _post_shutdown(self):
+        """
+        Called to cleanup the VM instance after the process has exited.
+        May also be called after a failed launch.
+        """
+        # Comprehensive reset for the failed launch case:
+        self._early_cleanup()
+
         if self._qmp:
             self._qmp.close()
             self._qmp = None
@@ -328,7 +335,7 @@ def launch(self):
             self._launch()
             self._launched = True
         except:
-            self.shutdown()
+            self._post_shutdown()
 
             LOG.debug('Error launching VM')
             if self._qemu_full_args:
@@ -357,6 +364,8 @@ def _launch(self):
     def _early_cleanup(self) -> None:
         """
         Perform any cleanup that needs to happen before the VM exits.
+
+        Called additionally by _post_shutdown for comprehensive cleanup.
         """
         # If we keep the console socket open, we may deadlock waiting
         # for QEMU to exit, while QEMU is waiting for the socket to
@@ -377,6 +386,9 @@ def shutdown(self, has_quit=False, hard=False):
         """
         Terminate the VM and clean up
         """
+        if not self._launched:
+            return
+
         self._early_cleanup()
 
         if self.is_running():
-- 
2.21.3


