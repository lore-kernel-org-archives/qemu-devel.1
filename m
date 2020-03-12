Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C458C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFF820663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKJr27Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFF820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOU8-0002ob-4h
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jCOTU-00027r-J6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jCOTT-0005Rc-CZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:06:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26594
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jCOTT-0005Qh-8W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584021970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C5TsRRWkXJiQ9KBFLscpeg+ScJVo76aQiNPPPeS1ljQ=;
 b=eKJr27Mo+7Da7H5PbiSJinYYAq7xUXMZxpKDtrSWOn8RIY4ZmxbU88Z/fPNWIfw7Cqz2MY
 CIRDHL2VLKW4Wzg0nQzlhXG9WsynZk5V+KhCHR5wwDlGU2MFtvGsxcT4PXkHPZ3ophaw35
 1cEI0JaGLdP5YepyVzsL6ULyfe82dDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-xE1brCmKNMaANr1PA53FJA-1; Thu, 12 Mar 2020 10:05:54 -0400
X-MC-Unique: xE1brCmKNMaANr1PA53FJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C7B5801E72
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 14:05:53 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-246.ams2.redhat.com [10.36.117.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5AD65D9C5;
 Thu, 12 Mar 2020 14:05:48 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] python/qemu/qmp.py: QMP debug with VM label
Date: Thu, 12 Mar 2020 16:05:47 +0200
Message-Id: <20200312140547.20448-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ovoshcha@redhat.com, jsnow@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMUMachine writes some messages to the default logger.
But it sometimes hard to read the output if we have requests to
more than one VM.
This patch adds a label to the logger in the debug mode.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>

---
v2:
 - Instead of shown the label in the message it provides the label
   only in the debug logger information
---
 python/qemu/machine.py | 2 +-
 python/qemu/qmp.py     | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..d0aa774c1c 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -270,7 +270,7 @@ class QEMUMachine(object):
                 self._vm_monitor =3D os.path.join(self._sock_dir,
                                                 self._name + "-monitor.soc=
k")
                 self._remove_files.append(self._vm_monitor)
-            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, server=
=3DTrue)
+            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, server=
=3DTrue, nickname=3Dself._name)
=20
     def _post_launch(self):
         if self._qmp:
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index f40586eedd..d58b18c304 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -46,7 +46,7 @@ class QEMUMonitorProtocol:
     #: Logger object for debugging messages
     logger =3D logging.getLogger('QMP')
=20
-    def __init__(self, address, server=3DFalse):
+    def __init__(self, address, server=3DFalse, nickname=3DNone):
         """
         Create a QEMUMonitorProtocol class.
=20
@@ -62,6 +62,7 @@ class QEMUMonitorProtocol:
         self.__address =3D address
         self.__sock =3D self.__get_sock()
         self.__sockfile =3D None
+        self._nickname =3D nickname
         if server:
             self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR,=
 1)
             self.__sock.bind(self.__address)
@@ -188,6 +189,8 @@ class QEMUMonitorProtocol:
         @return QMP response as a Python dict or None if the connection ha=
s
                 been closed
         """
+        if self._nickname:
+            self.logger.name =3D 'QMP.{}'.format(self._nickname)
         self.logger.debug(">>> %s", qmp_cmd)
         try:
             self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
--=20
2.21.1


