Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334232054F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REvqimc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334232054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzbQ-0006dC-E2
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzYT-00010X-8W
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzYS-0001ya-4o
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49262
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzYS-0001yD-16
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yvw2J3ollyMphZf82vDph7Fzyi7IG8VsyilfeuEc+RI=;
 b=REvqimc7HS0JSk/hZ7SoTGmrHK4aAPkoKm6H+d6lMCbt5Zifj8vOQKVdbkV8ZblrXnP9BL
 EJmIhLTbpU99rq1NLI7NzrmxgEskORUJ1Y1h+A1vAV8gy4vbHdloTOTM75VqCCtNmSCc4f
 WUFfWwb1l4F5QqIZf3nXHeT6oL9lbGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-BRlYsK8HOcqhInEkyZH1nA-1; Mon, 28 Oct 2019 03:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D0480183E;
 Mon, 28 Oct 2019 07:35:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8AAD19C69;
 Mon, 28 Oct 2019 07:34:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/26] python/qemu/machine: Allow to use other serial consoles
 than default
Date: Mon, 28 Oct 2019 08:34:16 +0100
Message-Id: <20191028073441.6448-2-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BRlYsK8HOcqhInEkyZH1nA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Currently the QEMU Python module limits the QEMUMachine class to
use the first serial console.

Some machines/guest might use another console than the first one as
the 'boot console'. For example the Raspberry Pi uses the second
(AUX) console.

To be able to use the Nth console as default, we simply need to
connect all the N - 1 consoles to the null chardev.

Add an index argument, so we can use a specific serial console as
default.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2:
- renamed 'console_index', added docstring (Cleber)
- reworded description (pm215)
---
 python/qemu/machine.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 128a3d1dc2..6fa68fa35a 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -235,6 +235,8 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
         if self._machine is not None:
             args.extend(['-machine', self._machine])
+        for i in range(self._console_index):
+            args.extend(['-serial', 'null'])
         if self._console_set:
             self._console_address =3D os.path.join(self._temp_dir,
                                                  self._name + "-console.so=
ck")
@@ -495,7 +497,7 @@ class QEMUMachine(object):
         """
         self._machine =3D machine_type
=20
-    def set_console(self, device_type=3DNone):
+    def set_console(self, device_type=3DNone, console_index=3D0):
         """
         Sets the device type for a console device
=20
@@ -516,9 +518,14 @@ class QEMUMachine(object):
                             chardev:console" command line argument will
                             be used instead, resorting to the machine's
                             default device type.
+        @param console_index: the index of the console device to use.
+                              If not zero, the command line will create
+                              'index - 1' consoles and connect them to
+                              the 'null' backing character device.
         """
         self._console_set =3D True
         self._console_device_type =3D device_type
+        self._console_index =3D console_index
=20
     @property
     def console_socket(self):
--=20
2.21.0


