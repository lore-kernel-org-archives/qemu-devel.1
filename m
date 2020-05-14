Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E746C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1303F205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+TCzfxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6rd-0002YP-85
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6oz-0004Oj-F1
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6oy-0001a9-2n
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tufz5NcW8hH/9Kxk+oqLSNwizTGlEXnvJ0RCo1dFD+o=;
 b=T+TCzfxCY2PHo6MEC12CJ0zWCrBASYzCXhHbsxyPG4WwMkf17w4tp6aUufd0TLRKUmcEaj
 AFqlZzoLs4st0ku2mirVuToqknZrOUM2ubuwUs3LZKKdTOml/fasW2tJJC//LH8JC5i1tX
 Ds2T+87xgvKiUeNjxHQ/5/LVGZWkJOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-weucs0WqNSK_c1E-BPMwfQ-1; Thu, 14 May 2020 01:54:11 -0400
X-MC-Unique: weucs0WqNSK_c1E-BPMwfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2ECE108BD0A;
 Thu, 14 May 2020 05:54:10 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 434267D952;
 Thu, 14 May 2020 05:54:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 03/32] python//machine.py: remove bare except
Date: Thu, 14 May 2020 01:53:34 -0400
Message-Id: <20200514055403.18902-4-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Catch only the timeout error; if there are other problems, allow the
stack trace to be visible.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/machine.py | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index b9a98e2c86..e3ea523571 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -342,7 +342,26 @@ def wait(self):
         self._load_io_log()
         self._post_shutdown()
 
-    def shutdown(self, has_quit=False):
+    def _issue_shutdown(self, has_quit: bool = False) -> None:
+        """
+        Shutdown the VM.
+        """
+        if not self.is_running():
+            return
+
+        if self._qmp is not None:
+            if not has_quit:
+                self._qmp.cmd('quit')
+            self._qmp.close()
+
+            try:
+                self._popen.wait(timeout=3)
+            except subprocess.TimeoutExpired:
+                self._popen.kill()
+
+        self._popen.wait()
+
+    def shutdown(self, has_quit: bool = False) -> None:
         """
         Terminate the VM and clean up
         """
@@ -353,17 +372,7 @@ def shutdown(self, has_quit=False):
             self._console_socket.close()
             self._console_socket = None
 
-        if self.is_running():
-            if self._qmp:
-                try:
-                    if not has_quit:
-                        self._qmp.cmd('quit')
-                    self._qmp.close()
-                    self._popen.wait(timeout=3)
-                except:
-                    self._popen.kill()
-            self._popen.wait()
-
+        self._issue_shutdown(has_quit)
         self._load_io_log()
         self._post_shutdown()
 
-- 
2.21.1


