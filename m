Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B85E2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ud58ojQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B85E2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlVq-0000zO-Pe
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUX-0007ID-KQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUW-0008DD-30
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G6lYDMDML75Gjj0qFiqI+XPtpp1YQeLwcWxPKSlt5U=;
 b=Ud58ojQLLKlyEx+za8mJvLUoHWsf59xAwNL33+bkcEiEE1Jb8CnqdD/h5cXzQVGXqX/Sj6
 GkGbHaTxjD0Kj01aoVbahxNa84x9NPGQZDVMXCIDUColvH+r3Sho6YZfgIPgJnnBWP32li
 M633glyx7SXxdbjbVq5LY/JbWRMDHfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-h40SkHSZMxGIe2XPQOfLvg-1; Fri, 10 Jul 2020 01:22:26 -0400
X-MC-Unique: h40SkHSZMxGIe2XPQOfLvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B08D08027E7;
 Fri, 10 Jul 2020 05:22:25 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEBF0920CA;
 Fri, 10 Jul 2020 05:22:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/16] python/qmp.py: re-absorb MonitorResponseError
Date: Fri, 10 Jul 2020 01:22:07 -0400
Message-Id: <20200710052220.3306-4-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

When I initially split this out, I considered this more of a machine
error than a QMP protocol error, but I think that's misguided.

Move this back to qmp.py and name it QMPResponseError. Convert
qmp.command() to use this exception type.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py        | 15 +--------------
 python/qemu/qmp.py            | 17 +++++++++++++++--
 scripts/render_block_graph.py |  7 +++++--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index d08a8e4a6e..8ca3d508df 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -55,19 +55,6 @@ class AbnormalShutdown(QEMUMachineError):
     """
 
 
-class MonitorResponseError(qmp.QMPError):
-    """
-    Represents erroneous QMP monitor reply
-    """
-    def __init__(self, reply):
-        try:
-            desc = reply["error"]["desc"]
-        except KeyError:
-            desc = reply
-        super().__init__(desc)
-        self.reply = reply
-
-
 class QEMUMachine:
     """
     A QEMU VM
@@ -519,7 +506,7 @@ def command(self, cmd, conv_keys=True, **args):
         if reply is None:
             raise qmp.QMPError("Monitor is closed")
         if "error" in reply:
-            raise MonitorResponseError(reply)
+            raise qmp.QMPResponseError(reply)
         return reply["return"]
 
     def get_qmp_event(self, wait=False):
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 8388c7b603..aa8a666b8a 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -61,6 +61,19 @@ class QMPTimeoutError(QMPError):
     """
 
 
+class QMPResponseError(QMPError):
+    """
+    Represents erroneous QMP monitor reply
+    """
+    def __init__(self, reply: QMPMessage):
+        try:
+            desc = reply['error']['desc']
+        except KeyError:
+            desc = reply
+        super().__init__(desc)
+        self.reply = reply
+
+
 class QEMUMonitorProtocol:
     """
     Provide an API to connect to QEMU via QEMU Monitor Protocol (QMP) and then
@@ -251,8 +264,8 @@ def command(self, cmd, **kwds):
         Build and send a QMP command to the monitor, report errors if any
         """
         ret = self.cmd(cmd, kwds)
-        if "error" in ret:
-            raise Exception(ret['error']['desc'])
+        if 'error' in ret:
+            raise QMPResponseError(ret)
         return ret['return']
 
     def pull_event(self, wait=False):
diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 409b4321f2..da6acf050d 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -25,7 +25,10 @@
 from graphviz import Digraph
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
-from qemu.machine import MonitorResponseError
+from qemu.qmp import (
+    QEMUMonitorProtocol,
+    QMPResponseError,
+)
 
 
 def perm(arr):
@@ -102,7 +105,7 @@ def command(self, cmd):
         reply = json.loads(subprocess.check_output(ar))
 
         if 'error' in reply:
-            raise MonitorResponseError(reply)
+            raise QMPResponseError(reply)
 
         return reply['return']
 
-- 
2.21.3


