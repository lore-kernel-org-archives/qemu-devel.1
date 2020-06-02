Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC915C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C43206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmyHK7hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C43206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEqQ-0006XD-It
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjW-0005Se-IG
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:46:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjV-0008Uh-D7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYyZQxaNvqDH/hr1wmR0qZCpuu1PPwy8ELRv1oSawx8=;
 b=LmyHK7hfI76oAZSbo10BtvopG8ZPB3W6B1Nin7IjVpw4DQ1f9kHVUA3ba2Z1tc4QMrPeN0
 PJHuKAaj3GKs4plU4dyrunlw08hOmeRxFFurFOpDMEcBPpxH/vSF70x783TzlZ2HZ6DwDd
 L3vCrGJNiZ/pXX/UTqWDlsuDfGG/F98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-H-ApTCLVOL2XoD5eVemT0g-1; Tue, 02 Jun 2020 17:45:59 -0400
X-MC-Unique: H-ApTCLVOL2XoD5eVemT0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA41835B41;
 Tue,  2 Jun 2020 21:45:58 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6F5261984;
 Tue,  2 Jun 2020 21:45:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/16] python/qemu: make 'args' style arguments immutable
Date: Tue,  2 Jun 2020 17:45:26 -0400
Message-Id: <20200602214528.12107-15-jsnow@redhat.com>
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

These arguments don't need to be mutable and aren't really used as
such. Clarify their types as immutable and adjust code to match where
necessary.

In general, It's probably best not to accept a user-defined mutable
object and store it as internal object state unless there's a strong
justification for doing so. Instead, try to use generic types as input
with empty tuples as the default, and coerce to list where necessary.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 30 +++++++++++++++++-------------
 python/qemu/qtest.py   | 16 ++++++++++++----
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 64197fc8492..d32e5599ce3 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -18,6 +18,7 @@
 #
 
 import errno
+from itertools import chain
 import logging
 import os
 import subprocess
@@ -29,6 +30,8 @@
     Dict,
     List,
     Optional,
+    Sequence,
+    Tuple,
     Type,
 )
 from types import TracebackType
@@ -67,8 +70,12 @@ class QEMUMachine:
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
                  socket_scm_helper=None, sock_dir=None):
         '''
@@ -86,14 +93,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
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
@@ -118,7 +118,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._iolog = None
         self._qmp_set = True   # Enable QMP monitor by default.
         self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] = None
-        self._qemu_full_args = None
+        self._qemu_full_args: Tuple[str, ...] = ()
         self._temp_dir = None
         self._launched = False
         self._machine = None
@@ -336,7 +336,7 @@ def launch(self):
             raise QEMUMachineError('VM already launched')
 
         self._iolog = None
-        self._qemu_full_args = None
+        self._qemu_full_args = ()
         try:
             self._launch()
             self._launched = True
@@ -356,8 +356,12 @@ def _launch(self):
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
index 05c63a1d583..ae4661d4d3e 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -22,6 +22,7 @@
 from typing import (
     List,
     Optional,
+    Sequence,
     TextIO,
 )
 
@@ -103,8 +104,13 @@ class QEMUQtestMachine(QEMUMachine):
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
@@ -118,8 +124,10 @@ def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
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
2.21.3


