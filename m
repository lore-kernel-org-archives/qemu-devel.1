Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC953C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD86320661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+Ix4zLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD86320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyywz-0006X2-Ib
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyyvs-0004mQ-N5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyyvr-0004Ve-Do
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyyvr-0004Qi-96
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580825522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=636WZS6nu8LPjvMeEyhXKmDiaWYQN2+N9JeCFGjJTuM=;
 b=F+Ix4zLY/4+NPN+ZK+0GqzkG5noAdcYKZ7R+s8NH6D6DYLs9ImJN7YONOzbc7i15lwdM5N
 WJcaSH6hmrMiMkLo8woQAJ0SUEmPIS46AIYz6QgYOvhJ/DpnToC2Q0zI54CBQbY1devv0I
 6UffXx6t3w3lskbqfrq5M6I8YILAaB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-e2ozRJS0N1WO63VWwEPGdQ-1; Tue, 04 Feb 2020 09:11:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B2AB805730
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EBB47792B;
 Tue,  4 Feb 2020 14:11:34 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] python/qemu: qmp: Make accept()'s timeout configurable
Date: Tue,  4 Feb 2020 11:11:09 -0300
Message-Id: <20200204141111.3207-4-wainersm@redhat.com>
In-Reply-To: <20200204141111.3207-1-wainersm@redhat.com>
References: <20200204141111.3207-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: e2ozRJS0N1WO63VWwEPGdQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: jsnow@redhat.com, philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the timeout of QEMUMonitorProtocol.accept() is
hard-coded to 15.0 seconds. This added the parameter `timeout`
so the value can be configured by the user.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/qmp.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index f4e04a6683..0e07d80e2a 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -154,16 +154,23 @@ class QEMUMonitorProtocol:
             return self.__negotiate_capabilities()
         return None
=20
-    def accept(self):
+    def accept(self, timeout=3D15.0):
         """
         Await connection from QMP Monitor and perform capabilities negotia=
tion.
=20
+        @param timeout: timeout in seconds (nonnegative float number, or
+                        None). The value passed will set the behavior of t=
he
+                        underneath QMP socket as described in [1]. Default=
 value
+                        is set to 15.0.
         @return QMP greeting dict
         @raise OSError on socket connection errors
         @raise QMPConnectError if the greeting is not received
         @raise QMPCapabilitiesError if fails to negotiate capabilities
+
+        [1]
+        https://docs.python.org/3/library/socket.html#socket.socket.settim=
eout
         """
-        self.__sock.settimeout(15)
+        self.__sock.settimeout(timeout)
         self.__sock, _ =3D self.__sock.accept()
         self.__sockfile =3D self.__sock.makefile()
         return self.__negotiate_capabilities()
--=20
2.23.0


