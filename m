Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5083CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C93214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzYIStu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C93214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzeO-0002tt-JK
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzZq-0004EJ-PL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzZo-0002uz-6S
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzZn-0002td-TA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBZhMOiZkXyInSD5BwU922z+hmF15P6tzDy5UfaGL3w=;
 b=VzYIStu0FE8K1ON8utwrDq0AkcAffPlq2e3ddyCBfgkgQ+byF5V1FmlOkdDbeBlonUr6lY
 2/KWwHFwyXCXOxJ7PWCNTNTbUEykawSS/0LSoZWi+zvSmWR7gfZyPRIBdA9VG3HlmXs1lI
 EpaNw76Gfmf6Ercq3c+LZgEOYDUTzjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-zyi9TTNNOr6h5ZQG0SWFLw-1; Mon, 28 Oct 2019 03:36:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD1A1005510;
 Mon, 28 Oct 2019 07:36:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61FA619C69;
 Mon, 28 Oct 2019 07:36:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/26] tests/acceptance: Add test that boots Linux up to
 BusyBox on Leon3
Date: Mon, 28 Oct 2019 08:34:26 +0100
Message-Id: <20191028073441.6448-12-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zyi9TTNNOr6h5ZQG0SWFLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Gaisler provides convenient images:
https://www.gaisler.com/index.php/downloads/linux

HOWTO build:
https://www.gaisler.com/index.php/products/operating-systems/linux

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/acceptance/machine_sparc_leon3.py | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/mac=
hine_sparc_leon3.py
index a1394ba8ad..1172fd5da0 100644
--- a/tests/acceptance/machine_sparc_leon3.py
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -10,6 +10,8 @@ import logging
=20
 from avocado import skipIf
 from avocado_qemu import MachineTest
+from avocado_qemu import wait_for_console_pattern
+from avocado_qemu import exec_command_and_wait_for_pattern
=20
=20
 class Leon3Machine(MachineTest):
@@ -35,3 +37,29 @@ class Leon3Machine(MachineTest):
=20
         wait_for_console_pattern(self,'Copyright (c) 2001-2014 HelenOS pro=
ject')
         wait_for_console_pattern(self,'Booting the kernel ...')
+
+    def test_leon3_linux_kernel_4_9_busybox(self):
+        """
+        :avocado: tags=3Darch:sparc
+        :avocado: tags=3Dmachine:leon3
+        """
+        kernel_url =3D ('https://www.gaisler.com/anonftp/linux/linux-4/ima=
ges/'
+                     'leon-linux-4.9/leon-linux-4.9-1.0/up/image.ram')
+        kernel_hash =3D '289bd1bcca10cda76d0ef2264a8657adc251f5f5'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
+
+        self.vm.set_machine('leon3_generic')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'TYPE: Leon3 System-on-a-Chip')
+
+        wait_for_console_pattern(self, 'Welcome to Buildroot')
+
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        uname =3D 'Linux buildroot 4.9.54-00018-g62dab2c #2 ' \
+                'Wed Oct 18 09:45:51 CEST 2017 sparc GNU/Linux'
+        exec_command_and_wait_for_pattern(self, 'uname -a', uname)
--=20
2.21.0


