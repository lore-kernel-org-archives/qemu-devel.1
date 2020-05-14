Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94255C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8F5205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZlhAIZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8F5205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6zM-0002PU-GU
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pc-0005iP-Gt
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pa-0001hK-BO
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTvCcLEcSSKlj034fIBunHGure74nzejEqOKq7vVirQ=;
 b=MZlhAIZe+VoOQ5Dz21rdvdMStAPfuPhcXGqqsPliqcSmovvwCnFcbRD4RR3l31qfYEZ1iA
 1JSwUJoAew8VdFq63XIeL/wqUlTwhJNL2Pa4i7JRMwKnIU1YHIFAhWOW2uHO0Nz8BvaCZ1
 XPO4iunMekMxKXRrdYamxgo/1q5TIS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-PKBE1P-WMBO_g13yVzEkTg-1; Thu, 14 May 2020 01:54:50 -0400
X-MC-Unique: PKBE1P-WMBO_g13yVzEkTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0335380058A;
 Thu, 14 May 2020 05:54:49 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C5936A977;
 Thu, 14 May 2020 05:54:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 22/32] python//machine.py: Fix monitor address typing
Date: Thu, 14 May 2020 01:53:53 -0400
Message-Id: <20200514055403.18902-23-jsnow@redhat.com>
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

Prior to this, it's difficult for mypy to intuit what the concrete type
of the monitor address is; it has difficulty inferring the type across
two variables.

Create _monitor_address as a property that always returns a valid
address to simply static type analysis.

To preserve our ability to clean up, use a simple boolean to indicate
whether or not we should try to clean up the sock file after execution.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/machine.py | 45 ++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index e92afe8649..6a4aea7725 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -24,10 +24,14 @@
 import shutil
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
 
@@ -61,7 +65,8 @@ class QEMUMachine:
     """
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
-                 test_dir="/var/tmp", monitor_address=None,
+                 test_dir="/var/tmp",
+                 monitor_address: Optional[SocketAddrT] = None,
                  socket_scm_helper=None, sock_dir=None):
         '''
         Initialize a QEMUMachine
@@ -84,8 +89,14 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
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
@@ -223,15 +234,17 @@ def _load_io_log(self):
 
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
@@ -256,14 +269,14 @@ def _pre_launch(self):
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
2.21.1


