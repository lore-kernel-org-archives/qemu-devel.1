Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EBC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF27F2054F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmwacviE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF27F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPwwm-0005Lz-Ox
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqw-0007tR-Cx
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqs-0002Jo-3D
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2l4JO+5gQp+SBGBAr/pLt0X3eyA5bOSsj9z+ljUrjso=;
 b=EmwacviE3li15EDpfFyd0O2/2AR6TdJlqM/+vSYjNHpO09hQSxbdrVW83Dyxp1WjgW6YRK
 exrnC/AbXJijemfNAvuw/qLDJL+9mgLFrxp/73WeBqlBfUa9abMWUxNIg8s6ymWQVzf8SI
 G5lm2n2OeGUfvPOtKY6dmd7pQYLUy10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-1ChF47WsNiq0w0MeKfdiKQ-1; Tue, 06 Oct 2020 19:58:32 -0400
X-MC-Unique: 1ChF47WsNiq0w0MeKfdiKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9178070F7;
 Tue,  6 Oct 2020 23:58:31 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 435CD9F54;
 Tue,  6 Oct 2020 23:58:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/20] python/machine.py: use qmp.command
Date: Tue,  6 Oct 2020 19:58:03 -0400
Message-Id: <20201006235817.3280413-7-jsnow@redhat.com>
In-Reply-To: <20201006235817.3280413-1-jsnow@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

machine.py and qmp.py both do the same thing here; refactor machine.py
to use qmp.py's functionality more directly.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index aebfa09e9de..d788e8aba8c 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -25,7 +25,13 @@
 import subprocess
 import tempfile
 from types import TracebackType
-from typing import List, Optional, Type
+from typing import (
+    Any,
+    Dict,
+    List,
+    Optional,
+    Type,
+)
 
 from . import console_socket, qmp
 from .qmp import QMPMessage, SocketAddrT
@@ -515,17 +521,23 @@ def set_qmp_monitor(self, enabled=True):
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
@@ -534,12 +546,8 @@ def command(self, cmd, conv_keys=True, **args):
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
2.26.2


