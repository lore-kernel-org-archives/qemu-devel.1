Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF464C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAD720663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrgXtLlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAD720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEMSX-0005f6-Rw
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 20:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jEMR1-00042D-OX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jEMR0-0006Kf-Lo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jEMR0-0006IP-IR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584490786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HR6pju1FpXZiyx2s7FtbvNbGXjaMb1iuZa39/jLotBU=;
 b=QrgXtLlHvUjpW/u8nj4kT24szUOF5bBLRzlNXnMpfq3qbOayrHMw6ZG5x5la2CJyEsMVLF
 QO+H4ikgO7Sk6+htOgwQgEHhCs+XRRTCaaQO2V65E6/iNmCSEo3AUJMKAvxVvqCv2C6RqF
 QWh9Ek1yoCMFIkTRK9KEDsUnorLKtVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-eksbqT1-MamMsCkxnnD2Xg-1; Tue, 17 Mar 2020 20:19:44 -0400
X-MC-Unique: eksbqT1-MamMsCkxnnD2Xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66CEB8017DF;
 Wed, 18 Mar 2020 00:19:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-2.rdu2.redhat.com
 [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0138D1001B07;
 Wed, 18 Mar 2020 00:19:39 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/6] python/qemu/qmp.py: QMP debug with VM label
Date: Tue, 17 Mar 2020 20:19:27 -0400
Message-Id: <20200318001932.180617-2-crosa@redhat.com>
In-Reply-To: <20200318001932.180617-1-crosa@redhat.com>
References: <20200318001932.180617-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Oksana Vohchana <ovoshcha@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 John Snow <jsnow@redhat.com>, KONRAD Frederic <frederic.konrad@adacore.com>,
 qemu-ppc@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Oksana Vohchana <ovoshcha@redhat.com>

QEMUMachine writes some messages to the default logger.
But it sometimes hard to read the output if we have requests to
more than one VM.
This patch adds a label to the logger in the debug mode.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200316103203.10046-1-ovoshcha@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
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
2.25.1


