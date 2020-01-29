Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B95C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5372F20702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLjUgWrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5372F20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuxM-0002jB-FF
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupN-0005vM-17
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupL-00016U-Nu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupL-00015p-Jy
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnD9aoRab6oQ9NaFbCYY9TrtYVXwppQtRDl4lv6JVKg=;
 b=bLjUgWrKwHg5xGaQaM+aZqC0oTuKv+G5UXFVtkj//PeskUmEzjP9cMeTt5em5+JjnsLLhg
 eXVGH0z8mgJLT++3a1mELK6Q8Hxn10qR9FPj8ROPZTWSeD0BV1dDqxlBYdIQFfFD8SxmUX
 ugwJJ2Do7MCA7rFJVeY8/8U/BqfzU0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-EL5qIPryPY67LZ2yqFtV8g-1; Wed, 29 Jan 2020 16:24:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1807E10054E3;
 Wed, 29 Jan 2020 21:24:42 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7A460BF3;
 Wed, 29 Jan 2020 21:24:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2 14/29] tests/acceptance: Use 'device' tags to check
 availability in QEMU binary
Date: Wed, 29 Jan 2020 22:23:30 +0100
Message-Id: <20200129212345.20547-15-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EL5qIPryPY67LZ2yqFtV8g-1
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already use the 'device' tag in Avocado tests.
If any of the requested device is not available in the QEMU binary,
the tests will be cancelled (skipped).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because I'm not certain, we might want to find bugs where
    a device is missing in the built binary...
---
 tests/acceptance/avocado_qemu/__init__.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 53ec8512d1..44062aea56 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), =
'..', '..', '..')
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
 from qemu.binutils import binary_get_arch
+from qemu.binutils import binary_get_devices
 from qemu.binutils import binary_get_machines
 from qemu.binutils import binary_get_version
 from qemu.machine import QEMUMachine
@@ -158,6 +159,16 @@ class Test(avocado.Test):
             if self.machine not in binary_get_machines(self.qemu_bin):
                 self.cancel(fmt.format(self.machine))
=20
+        # Verify devices
+        self.devices =3D self.tags.get('device', [])
+        bin_devices =3D binary_get_devices(self.qemu_bin)
+        logger.debug('devices: {}'.format(self.devices))
+        fmt =3D "Test expects device '{}' which is missing from QEMU binar=
y"
+        for dev in self.devices:
+            logger.debug(dev)
+            if dev not in bin_devices:
+                self.cancel(fmt.format(dev))
+
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
         if args:
--=20
2.21.1


