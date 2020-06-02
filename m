Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E512C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47EAF206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5zBAijR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EAF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEvL-0005BT-Ir
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjP-0005Gv-Ad
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjO-0008SX-2y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rScsdZiWSfPPTJL0UGkB6AtAaEGgD4vNhN/UdNeA2U=;
 b=J5zBAijR2F6B7X7zQATuDwGNx8qJycT1+cU8YzncodfItf4o12sMzVtsWy+jvDcLwOoG78
 sYpqDyBEOogoGh5BEVCquIZUa9z60v3ZB0RPNiVNjHFCK7ar+4ngyr1CJTuvByMI6pad6X
 pvq5RTLuN8lk+Jhi2WIu20lL+J/t2LA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-40lmcYYjPua1M-Q6LBeKgQ-1; Tue, 02 Jun 2020 17:45:53 -0400
X-MC-Unique: 40lmcYYjPua1M-Q6LBeKgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52424107ACCA;
 Tue,  2 Jun 2020 21:45:52 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18FF661987;
 Tue,  2 Jun 2020 21:45:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/16] python/machine.py: use qmp.command
Date: Tue,  2 Jun 2020 17:45:23 -0400
Message-Id: <20200602214528.12107-12-jsnow@redhat.com>
In-Reply-To: <20200602214528.12107-1-jsnow@redhat.com>
References: <20200602214528.12107-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:45:34
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

machine.py and qmp.py both do the same thing here; refactor machine.py
to use qmp.py's functionality more directly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a835b7550da..5add7a28eaf 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -25,6 +25,8 @@
 import socket
 import tempfile
 from typing import (
+    Any,
+    Dict,
     List,
     Optional,
     Type,
@@ -450,17 +452,23 @@ def set_qmp_monitor(self, enabled=True):
             self._qmp_set = False
             self._qmp = None
 
-    def qmp(self, cmd, conv_keys=True, **args):
-        """
-        Invoke a QMP command and return the response dict
-        """
+    @classmethod
+    def _qmp_args(cls, _conv_keys: bool = True, **args: Any) -> Dict[str, Any]:
         qmp_args = dict()
         for key, value in args.items():
-            if conv_keys:
+            if _conv_keys:
                 qmp_args[key.replace('_', '-')] = value
             else:
                 qmp_args[key] = value
+        return qmp_args
 
+    def qmp(self, cmd: str,
+            conv_keys: bool = True,
+            **args: Any) -> QMPMessage:
+        """
+        Invoke a QMP command and return the response dict
+        """
+        qmp_args = self._qmp_args(conv_keys, **args)
         return self._qmp.cmd(cmd, args=qmp_args)
 
     def command(self, cmd, conv_keys=True, **args):
@@ -469,12 +477,8 @@ def command(self, cmd, conv_keys=True, **args):
         On success return the response dict.
         On failure raise an exception.
         """
-        reply = self.qmp(cmd, conv_keys, **args)
-        if reply is None:
-            raise qmp.QMPError("Monitor is closed")
-        if "error" in reply:
-            raise qmp.QMPResponseError(reply)
-        return reply["return"]
+        qmp_args = self._qmp_args(conv_keys, **args)
+        return self._qmp.command(cmd, **qmp_args)
 
     def get_qmp_event(self, wait=False):
         """
-- 
2.21.3


