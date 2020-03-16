Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C000E2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXBnqNUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C000E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnwa-0001Jl-8a
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jDn2j-00069Z-Ch
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jDn2i-0006Fv-2b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:32:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jDn2h-0006AZ-TO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584354739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I5e9z/RYaSlKBVT20zqlkjBIyMqasVu9eIlMIo6qUiM=;
 b=HXBnqNUQu5mpxp7QwOC0yKM3erkdEzsEKj4siLzNA/3tjwgx+SBDzNDr58EcRXhVKa4lJI
 +EZYICtIqlEeBzpaiCovk6UAvmTXgT318fDtqs3n17Qd5F3r0z7ePb8CM2D6bbsaTnXsHF
 0YDFcZf2RDL26z+1fnW67L0JjHXOrRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-PsGAWBcPPaS9br-dJMBVrg-1; Mon, 16 Mar 2020 06:32:18 -0400
X-MC-Unique: PsGAWBcPPaS9br-dJMBVrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26DB98E1D0D
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:32:17 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-205-24.brq.redhat.com [10.40.205.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 561BE1C2;
 Mon, 16 Mar 2020 10:32:05 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] python/qemu/qmp.py: QMP debug with VM label
Date: Mon, 16 Mar 2020 12:32:03 +0200
Message-Id: <20200316103203.10046-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
But it sometimes hard to read the output if we have requests to
more than one VM.
This patch adds a label to the logger in the debug mode.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
v2:
 - Instead of shown the label in the message it provides the label
   only in the debug logger information.
v3:
 - Fixes coding style problems.
v4:
 - Use a suffix method to get a children's logger process from the parent.
---
 python/qemu/machine.py | 3 ++-
 python/qemu/qmp.py     | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..f53abfa492 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -270,7 +270,8 @@ class QEMUMachine(object):
                 self._vm_monitor =3D os.path.join(self._sock_dir,
                                                 self._name + "-monitor.soc=
k")
                 self._remove_files.append(self._vm_monitor)
-            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, server=
=3DTrue)
+            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, server=
=3DTrue,
+                                                nickname=3Dself._name)
=20
     def _post_launch(self):
         if self._qmp:
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index f40586eedd..d6c9b2f4b1 100644
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
@@ -62,6 +62,9 @@ class QEMUMonitorProtocol:
         self.__address =3D address
         self.__sock =3D self.__get_sock()
         self.__sockfile =3D None
+        self._nickname =3D nickname
+        if self._nickname:
+            self.logger =3D logging.getLogger('QMP').getChild(self._nickna=
me)
         if server:
             self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR,=
 1)
             self.__sock.bind(self.__address)
--=20
2.21.1


