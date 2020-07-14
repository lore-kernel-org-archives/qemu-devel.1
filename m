Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36E5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC472072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiElOsVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC472072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTRj-0006cx-Vo
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKD-0001pr-Us
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKC-0004wP-2Z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=re7gKjIDIxjZ168y2pnh2vU3k4lXjSx5/GbYDUTFUY0=;
 b=EiElOsVK0YFoZXcpx7rZiFAfqMnKbuirxMOnHe10CFf4OlYadJlaeOqLUmPGpoLiC81FrG
 WAY/Z1UTcmHZH6m0IIxfFMuzXulJ3l3qIP4VsMkS0d9UB3ojHV+9hHvwqJU0WNRP4Azh+z
 ETWFpufeLKcAJOJ8gfbBgE4r+n7ed00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-lJDu1lPVMyyinQWGs2yLDw-1; Tue, 14 Jul 2020 18:22:52 -0400
X-MC-Unique: lJDu1lPVMyyinQWGs2yLDw-1
Received: by mail-wr1-f71.google.com with SMTP id b8so18420wro.19
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=re7gKjIDIxjZ168y2pnh2vU3k4lXjSx5/GbYDUTFUY0=;
 b=idLcoaqJoohO3r4AxODE7CP8+exwyt030AfDunqcr7Lh7w/5JhDbj4+khFV4OOeVL3
 P6fuOuurExlvbJ/YxwGz/1xR7T1vCoYN4eDJARAj+2ajV+hO7h83JRswSa5zT41f+dUZ
 S6KcxXVqS8j/AhRJ4ufVTWQGcMsIKPR9HaU5XQ7lTryAY8wMZrex/EUOTNZEPomSTvvI
 4+QxT+0Gh5nW0C6W/04K8XaPsC86MEc5By+Q1vpeOv0PzYJXoGneQroUF+0yzS0lLgvV
 L61NBRJ77jhVAf5dmjntdmfpGNGvn/iFFUOmxaQnLygTZ4ak0AH0Hv2FcCAnwZ5Lxfii
 Hcmg==
X-Gm-Message-State: AOAM532MU7uE5hR+ekawdFkophDJldBqyC1wrknoaztt1Q7d3Y/cJse3
 y7ud8rZljPjIyc01/9qcO0ymJyy/q0ruAEZTvRoclNgdTcwlsopsonZmewt2kXKzx0jbGQGBsDO
 zCDGBj8063AV+6UI=
X-Received: by 2002:adf:f350:: with SMTP id e16mr7854963wrp.43.1594765370841; 
 Tue, 14 Jul 2020 15:22:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXiNIgqK8oqPlJZrnbHoy0394nTkrzba7SHXIDy15Y4LpispKvRSNUA1ToUonH0lG38oBdSA==
X-Received: by 2002:adf:f350:: with SMTP id e16mr7854944wrp.43.1594765370596; 
 Tue, 14 Jul 2020 15:22:50 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y189sm386094wmd.27.2020.07.14.15.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] python/qmp.py: re-absorb MonitorResponseError
Date: Wed, 15 Jul 2020 00:21:29 +0200
Message-Id: <20200714222132.10815-17-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 John Snow <jsnow@redhat.com>, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

When I initially split this out, I considered this more of a machine
error than a QMP protocol error, but I think that's misguided.

Move this back to qmp.py and name it QMPResponseError. Convert
qmp.command() to use this exception type.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200710052220.3306-4-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py        | 15 +--------------
 python/qemu/qmp.py            | 17 +++++++++++++++--
 scripts/render_block_graph.py |  7 +++++--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 69055189bd..80c4d4a8b6 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -56,19 +56,6 @@ class AbnormalShutdown(QEMUMachineError):
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
@@ -533,7 +520,7 @@ def command(self, cmd, conv_keys=True, **args):
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


