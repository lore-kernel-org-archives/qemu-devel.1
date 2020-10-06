Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5600C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1E22054F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBLkFXux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1E22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPwx2-0005kr-AT
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqx-0007v3-Iw
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqs-0002KL-ET
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FO0jEg0I+s+8GacxuFA2gFC2mh6kToiUL7H5gdtJav0=;
 b=YBLkFXuxL0HUexxv03RfZMBdvky4eUdzerYXhGZdK1qsE4WSqOToZdCzp3RsF6Leks2o+k
 Y+1QYNA/TG4kLbcW0WBSTTuIFrohOudLAjZgj6u7WDtsD4kaU7St5K6s6G6+dyXkyPLYnJ
 1rZf9ay/fTb5TZazySh+6b10KpoPxwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-uy_O1xTlMFWeSDElAlTLxA-1; Tue, 06 Oct 2020 19:58:35 -0400
X-MC-Unique: uy_O1xTlMFWeSDElAlTLxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B916F106F8E1;
 Tue,  6 Oct 2020 23:58:34 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8069160BFA;
 Tue,  6 Oct 2020 23:58:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/20] python/qemu: make 'args' style arguments immutable
Date: Tue,  6 Oct 2020 19:58:06 -0400
Message-Id: <20201006235817.3280413-10-jsnow@redhat.com>
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

These arguments don't need to be mutable and aren't really used as
such. Clarify their types as immutable and adjust code to match where
necessary.

In general, It's probably best not to accept a user-defined mutable
object and store it as internal object state unless there's a strong
justification for doing so. Instead, try to use generic types as input
with empty tuples as the default, and coerce to list where necessary.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 30 +++++++++++++++++-------------
 python/qemu/qtest.py   | 22 +++++++++++++++++-----
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 4e762fcd529..e599cb7439b 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -18,6 +18,7 @@
 #
 
 import errno
+from itertools import chain
 import logging
 import os
 import shutil
@@ -30,6 +31,8 @@
     Dict,
     List,
     Optional,
+    Sequence,
+    Tuple,
     Type,
 )
 
@@ -74,8 +77,12 @@ class QEMUMachine:
         # vm is guaranteed to be shut down here
     """
 
-    def __init__(self, binary, args=None, wrapper=None, name=None,
-                 test_dir="/var/tmp",
+    def __init__(self,
+                 binary: str,
+                 args: Sequence[str] = (),
+                 wrapper: Sequence[str] = (),
+                 name: Optional[str] = None,
+                 test_dir: str = "/var/tmp",
                  monitor_address: Optional[SocketAddrT] = None,
                  socket_scm_helper=None, sock_dir=None,
                  drain_console=False, console_log=None):
@@ -97,14 +104,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         # Direct user configuration
 
         self._binary = binary
-
-        if args is None:
-            args = []
-        # Copy mutable input: we will be modifying our copy
         self._args = list(args)
-
-        if wrapper is None:
-            wrapper = []
         self._wrapper = wrapper
 
         self._name = name or "qemu-%d" % os.getpid()
@@ -136,7 +136,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._iolog = None
         self._qmp_set = True   # Enable QMP monitor by default.
         self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] = None
-        self._qemu_full_args = None
+        self._qemu_full_args: Tuple[str, ...] = ()
         self._temp_dir = None
         self._launched = False
         self._machine = None
@@ -368,7 +368,7 @@ def launch(self):
             raise QEMUMachineError('VM already launched')
 
         self._iolog = None
-        self._qemu_full_args = None
+        self._qemu_full_args = ()
         try:
             self._launch()
             self._launched = True
@@ -388,8 +388,12 @@ def _launch(self):
         """
         devnull = open(os.path.devnull, 'rb')
         self._pre_launch()
-        self._qemu_full_args = (self._wrapper + [self._binary] +
-                                self._base_args + self._args)
+        self._qemu_full_args = tuple(
+            chain(self._wrapper,
+                  [self._binary],
+                  self._base_args,
+                  self._args)
+        )
         LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
         self._popen = subprocess.Popen(self._qemu_full_args,
                                        stdin=devnull,
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 7fde2565a0a..675310d8dfe 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -19,7 +19,12 @@
 
 import os
 import socket
-from typing import List, Optional, TextIO
+from typing import (
+    List,
+    Optional,
+    Sequence,
+    TextIO,
+)
 
 from .machine import QEMUMachine
 
@@ -99,8 +104,13 @@ class QEMUQtestMachine(QEMUMachine):
     A QEMU VM, with a qtest socket available.
     """
 
-    def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
-                 socket_scm_helper=None, sock_dir=None):
+    def __init__(self,
+                 binary: str,
+                 args: Sequence[str] = (),
+                 name: Optional[str] = None,
+                 test_dir: str = "/var/tmp",
+                 socket_scm_helper: Optional[str] = None,
+                 sock_dir: Optional[str] = None):
         if name is None:
             name = "qemu-%d" % os.getpid()
         if sock_dir is None:
@@ -114,8 +124,10 @@ def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
     @property
     def _base_args(self) -> List[str]:
         args = super()._base_args
-        args.extend(['-qtest', 'unix:path=' + self._qtest_path,
-                     '-accel', 'qtest'])
+        args.extend([
+            '-qtest', f"unix:path={self._qtest_path}",
+            '-accel', 'qtest'
+        ])
         return args
 
     def _pre_launch(self):
-- 
2.26.2


