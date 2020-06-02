Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BAAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E392206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKaLUHeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E392206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEqK-0006I8-EU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjL-0005B6-33
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjI-0008P9-M4
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hBfPgbWRlmnr3gHoNTn2l2v14/i4J/v9qsZPyjpOJU=;
 b=SKaLUHeA1qO+hlgHKuLgZ/cYnbbM2mMLFtXSZFqwebw9OBu+qJvX/y/p7st1Ltmxb1vJxZ
 ES0EGr1uCRZIRi1AzVyNKOZSmXCprTlcDkwVUxgy03/m5GMXodiohbbVasyi8PDQJr2v9S
 fMKCtHbdLGB7yYM4YP276UStiaJHuGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-D0ONXUufNeu_QBIiovIMeQ-1; Tue, 02 Jun 2020 17:45:50 -0400
X-MC-Unique: D0ONXUufNeu_QBIiovIMeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 658C9107ACF3;
 Tue,  2 Jun 2020 21:45:49 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F25261984;
 Tue,  2 Jun 2020 21:45:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/16] python/machine.py: Don't modify state in _base_args()
Date: Tue,  2 Jun 2020 17:45:21 -0400
Message-Id: <20200602214528.12107-10-jsnow@redhat.com>
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

Don't append to the _remove_files list during _base_args; instead do so
during _launch. Rework _base_args as a @property to help facilitate
this impression.

This has the additional benefit of making the type of _console_address
easier to analyze statically.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 16 ++++++++++------
 python/qemu/qtest.py   | 11 ++++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 6b7d188b951..2f12cebde40 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -25,6 +25,7 @@
 import socket
 import tempfile
 from typing import (
+    List,
     Optional,
     Type,
 )
@@ -122,7 +123,9 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._console_index = 0
         self._console_set = False
         self._console_device_type = None
-        self._console_address = None
+        self._console_address = os.path.join(
+            self._sock_dir, f"{self._name}-console.sock"
+        )
         self._console_socket = None
         self._remove_files = []
 
@@ -237,7 +240,8 @@ def _load_io_log(self):
             with open(self._qemu_log_path, "r") as iolog:
                 self._iolog = iolog.read()
 
-    def _base_args(self):
+    @property
+    def _base_args(self) -> List[str]:
         args = ['-display', 'none', '-vga', 'none']
 
         if self._qmp_set:
@@ -255,9 +259,6 @@ def _base_args(self):
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
-            self._console_address = os.path.join(self._sock_dir,
-                                                 self._name + "-console.sock")
-            self._remove_files.append(self._console_address)
             chardev = ('socket,id=console,path=%s,server,nowait' %
                        self._console_address)
             args.extend(['-chardev', chardev])
@@ -273,6 +274,9 @@ def _pre_launch(self):
         self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
 
+        if self._console_set:
+            self._remove_files.append(self._console_address)
+
         if self._qmp_set:
             if self._remove_monitor_sockfile:
                 assert isinstance(self._monitor_address, str)
@@ -345,7 +349,7 @@ def _launch(self):
         devnull = open(os.path.devnull, 'rb')
         self._pre_launch()
         self._qemu_full_args = (self._wrapper + [self._binary] +
-                                self._base_args() + self._args)
+                                self._base_args + self._args)
         LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
         self._popen = subprocess.Popen(self._qemu_full_args,
                                        stdin=devnull,
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 888c8bd2f60..05c63a1d583 100644
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


