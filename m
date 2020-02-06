Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A21EC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E424421741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHJB0BUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E424421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoc5-0003JX-4X
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoZO-00078J-LX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoZN-0001Da-HR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoZN-0001B0-CO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oc1uBvCvK1e8hQOTPzcGk42rYpgD9Zj+Mmy/e6BauhA=;
 b=RHJB0BUPi0NbdyoOOEZyUYux1JGkW0B3ZB5+SrwoY3SmKFeZIKHj+Qq+gChw3ro7y/AA5E
 G13bou9qUt8HpVZvNtIIGk86IT1XYycutMRvOl815mKJps4r14goVr9SosuMA6AybKmZSE
 5CX2OUnNy1izMwW8FGnhgqamQlBMn5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-ziPQtzz7MAy0U9YS60XMMg-1; Thu, 06 Feb 2020 16:20:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FAB9189F762
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:20:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8194860BEC;
 Thu,  6 Feb 2020 21:20:12 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/46] python/qemu: qmp: Make QEMUMonitorProtocol a context
 manager
Date: Thu,  6 Feb 2020 22:18:54 +0100
Message-Id: <20200206211936.17098-5-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ziPQtzz7MAy0U9YS60XMMg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

This implement the __enter__ and __exit__ functions on
QEMUMonitorProtocol class so that it can be used on 'with'
statement and the resources will be free up on block end:

with QEMUMonitorProtocol(socket_path) as qmp:
    qmp.connect()
    qmp.command('query-status')

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20200204141111.3207-5-wainersm@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/qmp.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 0e07d80e2a..486a566da0 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -139,6 +139,15 @@ class QEMUMonitorProtocol:
                 raise QMPConnectError("Error while reading from socket")
             self.__sock.settimeout(None)
=20
+    def __enter__(self):
+        # Implement context manager enter function.
+        return self
+
+    def __exit__(self, exc_type, exc_value, exc_traceback):
+        # Implement context manager exit function.
+        self.close()
+        return False
+
     def connect(self, negotiate=3DTrue):
         """
         Connect to the QMP Monitor and perform capabilities negotiation.
@@ -265,8 +274,10 @@ class QEMUMonitorProtocol:
         """
         Close the socket and socket file.
         """
-        self.__sock.close()
-        self.__sockfile.close()
+        if self.__sock:
+            self.__sock.close()
+        if self.__sockfile:
+            self.__sockfile.close()
=20
     def settimeout(self, timeout):
         """
--=20
2.21.1


