Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ADDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D19206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0N5MQM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D19206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ70k-0005aN-Vs
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pc-0005ja-Uc
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pb-0001hY-5O
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRLuNsUV4q6lrwdDP4dnHXeBvVF8C22HGPdVkR9yFzg=;
 b=M0N5MQM+saDU7MCNPYUb5Jht6rDK55Qq2hpgRO7tR2K6PD8Pv8C89acNCiwUStWjMNSDhA
 /xtbBIF2ZJO9glvgksfaiEoPa6EpkKiJEf4YBWHl3iE8Ub+yHC+0xQMSW3+xsxtZYBMYJV
 p1bvUB4yMBpGIEzf+QnN3czbv1FIRMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-MyrWZbVGOUWYjjTJXVQDiw-1; Thu, 14 May 2020 01:54:34 -0400
X-MC-Unique: MyrWZbVGOUWYjjTJXVQDiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCE7F107ACCD;
 Thu, 14 May 2020 05:54:32 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5C6F6A977;
 Thu, 14 May 2020 05:54:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 12/32] python/qemu/lib: fix socket.makefile() typing
Date: Thu, 14 May 2020 01:53:43 -0400
Message-Id: <20200514055403.18902-13-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
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

Note:

A bug in typeshed (https://github.com/python/typeshed/issues/3977)
misinterprets the type of makefile(). Work around this by explicitly
stating that we are opening a text-mode file.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/qmp.py   | 10 +++++++---
 python/qemu/lib/qtest.py | 12 ++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
index 6ae7693965..73d49050ed 100644
--- a/python/qemu/lib/qmp.py
+++ b/python/qemu/lib/qmp.py
@@ -11,6 +11,10 @@
 import errno
 import socket
 import logging
+from typing import (
+    Optional,
+    TextIO,
+)
 
 
 class QMPError(Exception):
@@ -61,7 +65,7 @@ def __init__(self, address, server=False, nickname=None):
         self.__events = []
         self.__address = address
         self.__sock = self.__get_sock()
-        self.__sockfile = None
+        self.__sockfile: Optional[TextIO] = None
         self._nickname = nickname
         if self._nickname:
             self.logger = logging.getLogger('QMP').getChild(self._nickname)
@@ -157,7 +161,7 @@ def connect(self, negotiate=True):
         @raise QMPCapabilitiesError if fails to negotiate capabilities
         """
         self.__sock.connect(self.__address)
-        self.__sockfile = self.__sock.makefile()
+        self.__sockfile = self.__sock.makefile(mode='r')
         if negotiate:
             return self.__negotiate_capabilities()
         return None
@@ -180,7 +184,7 @@ def accept(self, timeout=15.0):
         """
         self.__sock.settimeout(timeout)
         self.__sock, _ = self.__sock.accept()
-        self.__sockfile = self.__sock.makefile()
+        self.__sockfile = self.__sock.makefile(mode='r')
         return self.__negotiate_capabilities()
 
     def cmd_obj(self, qmp_cmd):
diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
index 7943487c2b..4c88590eb0 100644
--- a/python/qemu/lib/qtest.py
+++ b/python/qemu/lib/qtest.py
@@ -19,6 +19,7 @@
 
 import socket
 import os
+from typing import Optional, TextIO
 
 from .machine import QEMUMachine
 
@@ -40,7 +41,7 @@ class QEMUQtestProtocol:
     def __init__(self, address, server=False):
         self._address = address
         self._sock = self._get_sock()
-        self._sockfile = None
+        self._sockfile: Optional[TextIO] = None
         if server:
             self._sock.bind(self._address)
             self._sock.listen(1)
@@ -59,7 +60,7 @@ def connect(self):
         @raise socket.error on socket connection errors
         """
         self._sock.connect(self._address)
-        self._sockfile = self._sock.makefile()
+        self._sockfile = self._sock.makefile(mode='r')
 
     def accept(self):
         """
@@ -68,7 +69,7 @@ def accept(self):
         @raise socket.error on socket connection errors
         """
         self._sock, _ = self._sock.accept()
-        self._sockfile = self._sock.makefile()
+        self._sockfile = self._sock.makefile(mode='r')
 
     def cmd(self, qtest_cmd):
         """
@@ -76,6 +77,7 @@ def cmd(self, qtest_cmd):
 
         @param qtest_cmd: qtest command text to be sent
         """
+        assert self._sockfile is not None
         self._sock.sendall((qtest_cmd + "\n").encode('utf-8'))
         resp = self._sockfile.readline()
         return resp
@@ -83,7 +85,9 @@ def cmd(self, qtest_cmd):
     def close(self):
         """Close this socket."""
         self._sock.close()
-        self._sockfile.close()
+        if self._sockfile:
+            self._sockfile.close()
+            self._sockfile = None
 
     def settimeout(self, timeout):
         """Set a timeout, in seconds."""
-- 
2.21.1


