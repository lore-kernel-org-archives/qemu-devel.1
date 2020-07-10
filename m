Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F5BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415832076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPCYjNwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415832076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlaI-0003SH-9O
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUd-0007bx-P6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUb-0008Ep-WD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEogPXCWLrpgZnMZdCF+mYgMrJtigxDrv96rOE8k97Q=;
 b=bPCYjNwbDaqFNLfNvoFVpYoM04t9ufcQ/GnLoV04sieBSnDqGZiBpsmQhUzOTsRFecqk+D
 dMh3qHIFXQqC6RkhIS7vixTJ4kBZ0brD7USJXsXnmg2sk8ahG9jaCI+ripKGFzAx7+i9YD
 8aF+QoeZ7AIOGDC/751dgYT/YfLiIas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-elWNbItLMpm4Jl1pLa92Ag-1; Fri, 10 Jul 2020 01:22:33 -0400
X-MC-Unique: elWNbItLMpm4Jl1pLa92Ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B0B19057A0;
 Fri, 10 Jul 2020 05:22:32 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6E0E920C3;
 Fri, 10 Jul 2020 05:22:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/16] python/machine.py: Don't modify state in _base_args()
Date: Fri, 10 Jul 2020 01:22:13 -0400
Message-Id: <20200710052220.3306-10-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

Don't append to the _remove_files list during _base_args; instead do so
during _launch. Rework _base_args as a @property to help facilitate
this impression.

This has the additional benefit of making the type of _console_address
easier to analyze statically.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 16 ++++++++++------
 python/qemu/qtest.py   | 11 ++++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 0f7ec095cb..37e859f6d2 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -26,6 +26,7 @@
 import socket
 import tempfile
 from typing import (
+    List,
     Optional,
     Type,
 )
@@ -129,7 +130,9 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._console_index = 0
         self._console_set = False
         self._console_device_type = None
-        self._console_address = None
+        self._console_address = os.path.join(
+            self._sock_dir, f"{self._name}-console.sock"
+        )
         self._console_socket = None
         self._remove_files = []
         self._user_killed = False
@@ -245,7 +248,8 @@ def _load_io_log(self):
             with open(self._qemu_log_path, "r") as iolog:
                 self._iolog = iolog.read()
 
-    def _base_args(self):
+    @property
+    def _base_args(self) -> List[str]:
         args = ['-display', 'none', '-vga', 'none']
 
         if self._qmp_set:
@@ -263,9 +267,6 @@ def _base_args(self):
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
-            self._console_address = os.path.join(self._sock_dir,
-                                                 self._name + "-console.sock")
-            self._remove_files.append(self._console_address)
             chardev = ('socket,id=console,path=%s,server,nowait' %
                        self._console_address)
             args.extend(['-chardev', chardev])
@@ -281,6 +282,9 @@ def _pre_launch(self):
         self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
 
+        if self._console_set:
+            self._remove_files.append(self._console_address)
+
         if self._qmp_set:
             if self._remove_monitor_sockfile:
                 assert isinstance(self._monitor_address, str)
@@ -366,7 +370,7 @@ def _launch(self):
         devnull = open(os.path.devnull, 'rb')
         self._pre_launch()
         self._qemu_full_args = (self._wrapper + [self._binary] +
-                                self._base_args() + self._args)
+                                self._base_args + self._args)
         LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
         self._popen = subprocess.Popen(self._qemu_full_args,
                                        stdin=devnull,
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 888c8bd2f6..05c63a1d58 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -19,7 +19,11 @@
 
 import socket
 import os
-from typing import Optional, TextIO
+from typing import (
+    List,
+    Optional,
+    TextIO,
+)
 
 from .machine import QEMUMachine
 
@@ -111,8 +115,9 @@ def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
         self._qtest = None
         self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
 
-    def _base_args(self):
-        args = super()._base_args()
+    @property
+    def _base_args(self) -> List[str]:
+        args = super()._base_args
         args.extend(['-qtest', 'unix:path=' + self._qtest_path,
                      '-accel', 'qtest'])
         return args
-- 
2.21.3


