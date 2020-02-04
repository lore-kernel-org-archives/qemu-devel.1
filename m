Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B8C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01C52087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhcXbd6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01C52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyzP-0001as-4v
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyyvh-0004Qk-RT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyyvg-0003Hw-Qz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyyvg-0003Ev-M1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580825512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJY9D1M44o9wctAPTFwalgRtHn4l/+HNnLvKeOIovgQ=;
 b=YhcXbd6tE3HPyRtLTxQ+18GH68m46LW2jr3yRxvKtd5rt/Gm2t7mbqtYCqBdJd/qmB1VRg
 pFwBGEvAX9QINVPvhJveJE1daSxvaEssRzCbFy5Q+0bDsgIfhiDgD6Igp/XqAanmV7Nhvx
 An44cqM4GgULzdGNgOLtNmzSGzxlbPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-V15dktj3P4alV0bWA-cEzw-1; Tue, 04 Feb 2020 09:11:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85AFF800D5C
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 506DB7792B;
 Tue,  4 Feb 2020 14:11:43 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] python/qemu: qmp: Make QEMUMonitorProtocol a context
 manager
Date: Tue,  4 Feb 2020 11:11:10 -0300
Message-Id: <20200204141111.3207-5-wainersm@redhat.com>
In-Reply-To: <20200204141111.3207-1-wainersm@redhat.com>
References: <20200204141111.3207-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: V15dktj3P4alV0bWA-cEzw-1
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
Cc: jsnow@redhat.com, philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implement the __enter__ and __exit__ functions on
QEMUMonitorProtocol class so that it can be used on 'with'
statement and the resources will be free up on block end:

with QEMUMonitorProtocol(socket_path) as qmp:
    qmp.connect()
    qmp.command('query-status')

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
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
2.23.0


