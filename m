Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D2C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3700212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONIZVTmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3700212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPwt7-0001Ti-UP
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqm-0007nU-RU
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqf-0002Hy-Ba
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kn888XOGJoWD2QFt78fuRBExMTFaJ1fF2Lgz5K7oy8E=;
 b=ONIZVTmRewiUZG8d0m8dXF1nGkhQhrgFexYmkuhePEL+WdfgBFB230Ytd+gQPiqiKyuw5y
 gSl4nzhF8FmKE3SfPg48yPF2MkCeJV+tcPD+kLutEsJI0ecTVP+LsL6s970lvnesi7Fg5b
 SmqNyXt7Ify5EQqzKsTsISZMNzura38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-fQcLtrLzMeiv_MgJxhk0ZA-1; Tue, 06 Oct 2020 19:58:22 -0400
X-MC-Unique: fQcLtrLzMeiv_MgJxhk0ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 225AF64097;
 Tue,  6 Oct 2020 23:58:21 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63602610F3;
 Tue,  6 Oct 2020 23:58:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/20] python/machine.py: Fix monitor address typing
Date: Tue,  6 Oct 2020 19:57:59 -0400
Message-Id: <20201006235817.3280413-3-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 python/qemu/machine.py | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index bc83f399c1b..3017ec072df 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -28,6 +28,7 @@
 from typing import Optional, Type
 
 from . import console_socket, qmp
+from .qmp import SocketAddrT
 
 
 LOG = logging.getLogger(__name__)
@@ -68,7 +69,8 @@ class QEMUMachine:
     """
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
-                 test_dir="/var/tmp", monitor_address=None,
+                 test_dir="/var/tmp",
+                 monitor_address: Optional[SocketAddrT] = None,
                  socket_scm_helper=None, sock_dir=None,
                  drain_console=False, console_log=None):
         '''
@@ -95,8 +97,14 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
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
@@ -241,15 +249,17 @@ def _load_io_log(self):
 
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
@@ -274,14 +284,14 @@ def _pre_launch(self):
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
2.26.2


