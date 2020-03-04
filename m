Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3B2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946D920870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OujExTIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946D920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QvR-0006Rp-Nm
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j9QuU-0004js-GP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j9QuT-0007Q9-DC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:05:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j9QuT-0007Oj-9I
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583316348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yFZvnO7SRFkr/YoV0CZyxV0dNe3GFf/k4xW7rH3uqaA=;
 b=OujExTItlbbCTJElO7piGe6GZHxTinlUPFA9nC9vOTugfeH1ekZ2b+qEZoZb2fbdvMiEBT
 5Y+b/QrNHxh1K2uWJ7A9khoHFDAHMgHQ7U0AN9vBdP74t+42wEtfLoXSLp3WXFtJgeMttZ
 fS9brWiTa4UdDb53GNEZ0PrjEQtq2mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-A9ak0mhtOpe1IIWXq3dZWg-1; Wed, 04 Mar 2020 05:05:46 -0500
X-MC-Unique: A9ak0mhtOpe1IIWXq3dZWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D666189F77C
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2020 10:05:45 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-137.ams2.redhat.com [10.36.117.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 336A05C54A;
 Wed,  4 Mar 2020 10:05:37 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] python/qemu/qmp.py: QMP debug with VM label
Date: Wed,  4 Mar 2020 12:05:34 +0200
Message-Id: <20200304100534.13155-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: ovoshcha@redhat.com, ehabkost@redhat.com, wainersm@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMUMachine writes some messages to the default logger.
But it sometimes to hard the read the output if we have requested to
more than one VM.
This patch adds name in QMP command if it needs and labels with it in
debug mode.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 python/qemu/machine.py | 8 ++++----
 python/qemu/qmp.py     | 9 ++++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..060e68f06b 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -391,7 +391,7 @@ class QEMUMachine(object):
             self._qmp_set =3D False
             self._qmp =3D None
=20
-    def qmp(self, cmd, conv_keys=3DTrue, **args):
+    def qmp(self, cmd, conv_keys=3DTrue, vm_name=3DNone, **args):
         """
         Invoke a QMP command and return the response dict
         """
@@ -402,15 +402,15 @@ class QEMUMachine(object):
             else:
                 qmp_args[key] =3D value
=20
-        return self._qmp.cmd(cmd, args=3Dqmp_args)
+        return self._qmp.cmd(cmd, args=3Dqmp_args, vm_name=3Dvm_name)
=20
-    def command(self, cmd, conv_keys=3DTrue, **args):
+    def command(self, cmd, conv_keys=3DTrue, vm_name=3DNone, **args):
         """
         Invoke a QMP command.
         On success return the response dict.
         On failure raise an exception.
         """
-        reply =3D self.qmp(cmd, conv_keys, **args)
+        reply =3D self.qmp(cmd, conv_keys, vm_name, **args)
         if reply is None:
             raise qmp.QMPError("Monitor is closed")
         if "error" in reply:
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index f40586eedd..96b455b53f 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -180,11 +180,12 @@ class QEMUMonitorProtocol:
         self.__sockfile =3D self.__sock.makefile()
         return self.__negotiate_capabilities()
=20
-    def cmd_obj(self, qmp_cmd):
+    def cmd_obj(self, qmp_cmd, vm_name=3DNone):
         """
         Send a QMP command to the QMP Monitor.
=20
         @param qmp_cmd: QMP command to be sent as a Python dict
+        @param vm_name: name for the virtual machine (string)
         @return QMP response as a Python dict or None if the connection ha=
s
                 been closed
         """
@@ -196,10 +197,12 @@ class QEMUMonitorProtocol:
                 return None
             raise err
         resp =3D self.__json_read()
+        if vm_name:
+            self.logger.debug("<<< {'vm_name' : %s }",  vm_name)
         self.logger.debug("<<< %s", resp)
         return resp
=20
-    def cmd(self, name, args=3DNone, cmd_id=3DNone):
+    def cmd(self, name, args=3DNone, cmd_id=3DNone, vm_name=3DNone):
         """
         Build a QMP command and send it to the QMP Monitor.
=20
@@ -212,7 +215,7 @@ class QEMUMonitorProtocol:
             qmp_cmd['arguments'] =3D args
         if cmd_id:
             qmp_cmd['id'] =3D cmd_id
-        return self.cmd_obj(qmp_cmd)
+        return self.cmd_obj(qmp_cmd, vm_name)
=20
     def command(self, cmd, **kwds):
         """
--=20
2.21.1


