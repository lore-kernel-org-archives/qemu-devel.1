Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FF4C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17EF208A7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/eIXbhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17EF208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQvu-0002X0-0M
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jeQuB-0000Ml-2a
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:21:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jeQuA-0004gm-58
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590704497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlKzXzaxKdIc00dT0HjE4rtei8SOeWDN3csi9Jn8sMg=;
 b=L/eIXbhzBUfwusKsldO45mZIgTd4p2oohQ2xk7Zutj1Vf8t5h8yDpjkIAFlQVYjKjrGoiO
 Vo6ZbYBKpsNwG4cKbjeVY9TRD1sZY6g9J9QMwLUp9tZEJcLMCXNU+mgszU/V1gQgDdqvJ8
 wM/edz0IdSibzM4uYv1TzhfUfnWQGlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-dQQcxKW8NtKwcSM9cw3S7w-1; Thu, 28 May 2020 18:21:35 -0400
X-MC-Unique: dQQcxKW8NtKwcSM9cw3S7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C1F61005510
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 22:21:34 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 658875D9CD;
 Thu, 28 May 2020 22:21:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] python/machine.py: remove bare except
Date: Thu, 28 May 2020 18:21:27 -0400
Message-Id: <20200528222129.23826-3-jsnow@redhat.com>
In-Reply-To: <20200528222129.23826-1-jsnow@redhat.com>
References: <20200528222129.23826-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:42:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Catch only the timeout error; if there are other problems, allow the
stack trace to be visible.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index b9a98e2c862..e3ea5235713 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
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
2.21.3


