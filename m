Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE12C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6761B20658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJaRqSxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6761B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izofe-0002nN-H7
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoZj-0007jB-9E
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoZh-00025U-3N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoZg-000248-V9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3kRttvVY8RX76t8gfCzv8UyeTjNpvkz1nioLDE1jGk=;
 b=dJaRqSxVtP7HFZMKzpASEB59JYMpGot/IKE+H6nehO3Iv4p5syNSgBRVshr9u9DB/Pz0EP
 5oETzTI+UxmTISHW4WFC68aBAGfhAckBIUn//9pa/Hmwydab8EurDmK3kZRXQbkTUhSEr5
 DLFUE6ZnokvEQmcsJGkhMqhghpBZo14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-_rs_FnEHNVKnPqLtEBRxmg-1; Thu, 06 Feb 2020 16:20:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D81189F762;
 Thu,  6 Feb 2020 21:20:33 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AAD660BEC;
 Thu,  6 Feb 2020 21:20:31 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/46] python/qemu/machine: Allow to use other serial consoles
 than default
Date: Thu,  6 Feb 2020 22:18:59 +0100
Message-Id: <20200206211936.17098-10-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _rs_FnEHNVKnPqLtEBRxmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200120235159.18510-5-f4bug@amsat.org>
[PMD: zero-initialize _console_index in __init__()]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/machine.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 734efd8536..183d8f3d38 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -112,6 +112,7 @@ class QEMUMachine(object):
         self._sock_dir =3D sock_dir
         self._launched =3D False
         self._machine =3D None
+        self._console_index =3D 0
         self._console_set =3D False
         self._console_device_type =3D None
         self._console_address =3D None
@@ -241,6 +242,8 @@ class QEMUMachine(object):
                          'chardev=3Dmon,mode=3Dcontrol'])
         if self._machine is not None:
             args.extend(['-machine', self._machine])
+        for i in range(self._console_index):
+            args.extend(['-serial', 'null'])
         if self._console_set:
             self._console_address =3D os.path.join(self._sock_dir,
                                                  self._name + "-console.so=
ck")
@@ -527,7 +530,7 @@ class QEMUMachine(object):
         """
         self._machine =3D machine_type
=20
-    def set_console(self, device_type=3DNone):
+    def set_console(self, device_type=3DNone, console_index=3D0):
         """
         Sets the device type for a console device
=20
@@ -548,9 +551,14 @@ class QEMUMachine(object):
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
2.21.1


