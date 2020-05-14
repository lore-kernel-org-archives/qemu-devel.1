Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F765C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD6D205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4L8GZyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD6D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6uz-0001hX-CD
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6ph-0005ty-4W
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:55:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pg-0001k8-78
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uumDVo9FnEv61j8m5KShndosRNbqze6oP9Q3Z3/w+KU=;
 b=U4L8GZykgwxFi/ZbByDLLy+3wEcI98SYUq3HFGiZmlFFq61QXJ+d9hgFNDt3wT4bMokSnZ
 RB2ATg2jdWqBbR/H+cYciu+mhiBA1IULi8LmRAEH7wn+z2jBAY4R4G373ypTuMD/j86X/B
 0v8q4udhOy5QzL7OczFVHfEC4iZ0EAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-r54TSQmtPPWggm9pg6Bk8w-1; Thu, 14 May 2020 01:54:56 -0400
X-MC-Unique: r54TSQmtPPWggm9pg6Bk8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BE91BFC2;
 Thu, 14 May 2020 05:54:55 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF9DE7D951;
 Thu, 14 May 2020 05:54:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 26/32] python//machine.py: use qmp.command
Date: Thu, 14 May 2020 01:53:57 -0400
Message-Id: <20200514055403.18902-27-jsnow@redhat.com>
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

machine.py and qmp.py both do the same thing here; refactor machine.py
to use qmp.py's functionality more directly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/machine.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index 61ee3a0e81..34e6b6f9e9 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -25,6 +25,8 @@
 import socket
 import tempfile
 from typing import (
+    Any,
+    Dict,
     List,
     Optional,
     Type,
@@ -416,17 +418,23 @@ def set_qmp_monitor(self, enabled=True):
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
@@ -435,12 +443,8 @@ def command(self, cmd, conv_keys=True, **args):
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
2.21.1


