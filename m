Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E826C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA62020720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSwnUW6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA62020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlZ7-0000cJ-4n
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUZ-0007OM-L7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUY-0008Dt-08
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wP4LFX/0gcJwxqvf0SL4qgNKSCoBFyojS/IqLf5vTxE=;
 b=CSwnUW6islwd7wqqbpoH1AOYIxMjGc7fBWToYNP8uXbm2TMoxNRbZYKbaJUWSiL0pd7G0S
 8GbOHW061ZM9LSYnDJ7ZXO2DZRDfXGcy0+93BS4lFKpRkhtKvhkDzSvZFR9i2P0/E6w91j
 sHBBHzmJClSIpfxyOCf0E6vRZC++1Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-HTLTiBh5PMiL8I0WoeU8gQ-1; Fri, 10 Jul 2020 01:22:31 -0400
X-MC-Unique: HTLTiBh5PMiL8I0WoeU8gQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71634800EB6;
 Fri, 10 Jul 2020 05:22:30 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 702AA920CA;
 Fri, 10 Jul 2020 05:22:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/16] python/machine.py: Fix monitor address typing
Date: Fri, 10 Jul 2020 01:22:11 -0400
Message-Id: <20200710052220.3306-8-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:55:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Prior to this, it's difficult for mypy to intuit what the concrete type
of the monitor address is; it has difficulty inferring the type across
two variables.

Create _monitor_address as a property that always returns a valid
address to simplify static type analysis.

To preserve our ability to clean up, use a simple boolean to indicate
whether or not we should try to clean up the sock file after execution.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 45 +++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 8ca3d508df..bab1b1921f 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -25,10 +25,14 @@
 import signal
 import socket
 import tempfile
-from typing import Optional, Type
+from typing import (
+    Optional,
+    Type,
+)
 from types import TracebackType
 
 from . import qmp
+from .qmp import SocketAddrT
 
 LOG = logging.getLogger(__name__)
 
@@ -68,7 +72,8 @@ class QEMUMachine:
     """
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
-                 test_dir="/var/tmp", monitor_address=None,
+                 test_dir="/var/tmp",
+                 monitor_address: Optional[SocketAddrT] = None,
                  socket_scm_helper=None, sock_dir=None):
         '''
         Initialize a QEMUMachine
@@ -91,8 +96,14 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         if sock_dir is None:
             sock_dir = test_dir
         self._name = name
-        self._monitor_address = monitor_address
-        self._vm_monitor = None
+        if monitor_address is not None:
+            self._monitor_address = monitor_address
+            self._remove_monitor_sockfile = False
+        else:
+            self._monitor_address = os.path.join(
+                sock_dir, f"{name}-monitor.sock"
+            )
+            self._remove_monitor_sockfile = True
         self._qemu_log_path = None
         self._qemu_log_file = None
         self._popen = None
@@ -231,15 +242,17 @@ def _load_io_log(self):
 
     def _base_args(self):
         args = ['-display', 'none', '-vga', 'none']
+
         if self._qmp_set:
             if isinstance(self._monitor_address, tuple):
-                moncdev = "socket,id=mon,host=%s,port=%s" % (
-                    self._monitor_address[0],
-                    self._monitor_address[1])
+                moncdev = "socket,id=mon,host={},port={}".format(
+                    *self._monitor_address
+                )
             else:
-                moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
+                moncdev = f"socket,id=mon,path={self._monitor_address}"
             args.extend(['-chardev', moncdev, '-mon',
                          'chardev=mon,mode=control'])
+
         if self._machine is not None:
             args.extend(['-machine', self._machine])
         for _ in range(self._console_index):
@@ -264,14 +277,14 @@ def _pre_launch(self):
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
 
         if self._qmp_set:
-            if self._monitor_address is not None:
-                self._vm_monitor = self._monitor_address
-            else:
-                self._vm_monitor = os.path.join(self._sock_dir,
-                                                self._name + "-monitor.sock")
-                self._remove_files.append(self._vm_monitor)
-            self._qmp = qmp.QEMUMonitorProtocol(self._vm_monitor, server=True,
-                                                nickname=self._name)
+            if self._remove_monitor_sockfile:
+                assert isinstance(self._monitor_address, str)
+                self._remove_files.append(self._monitor_address)
+            self._qmp = qmp.QEMUMonitorProtocol(
+                self._monitor_address,
+                server=True,
+                nickname=self._name
+            )
 
     def _post_launch(self):
         if self._qmp:
-- 
2.21.3


