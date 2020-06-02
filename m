Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CB3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2C82072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVBz8/CG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2C82072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgElK-0007KC-GS
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEj6-0004oa-Fg
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEj4-0008Ir-39
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GT6U2bxbUb9Mw2IcL8NNeCjQ97NYBIX3pDsA3BoritU=;
 b=WVBz8/CGTZQ94tLFDimvgK2eVPuArfI2lRNksbYN72DeQPMFx9FwNon9TQSY3gk23ajZbE
 29Ah4L3nUktNy6OLMYz0/Y23Y/uaz2SVqeos661X2thj1y55+vtvgnUR4bPsO9ISweCPny
 430dbcyNkMIA+y4ZRITAzDlmmNV3e6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-OYdNBhd1M4SsMqjiOc0a7g-1; Tue, 02 Jun 2020 17:45:35 -0400
X-MC-Unique: OYdNBhd1M4SsMqjiOc0a7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5BAE80B724;
 Tue,  2 Jun 2020 21:45:34 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7960660BE1;
 Tue,  2 Jun 2020 21:45:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/16] python/qmp.py: re-absorb MonitorResponseError
Date: Tue,  2 Jun 2020 17:45:15 -0400
Message-Id: <20200602214528.12107-4-jsnow@redhat.com>
In-Reply-To: <20200602214528.12107-1-jsnow@redhat.com>
References: <20200602214528.12107-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
---
 python/qemu/machine.py        | 15 +--------------
 python/qemu/qmp.py            | 17 +++++++++++++++--
 scripts/render_block_graph.py |  7 +++++--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a2abd2c35e3..b2b7ae9fbf9 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -48,19 +48,6 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
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
@@ -464,7 +451,7 @@ def command(self, cmd, conv_keys=True, **args):
         if reply is None:
             raise qmp.QMPError("Monitor is closed")
         if "error" in reply:
-            raise MonitorResponseError(reply)
+            raise qmp.QMPResponseError(reply)
         return reply["return"]
 
     def get_qmp_event(self, wait=False):
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 8388c7b6030..aa8a666b8ab 100644
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
index 409b4321f2e..da6acf050d1 100755
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


