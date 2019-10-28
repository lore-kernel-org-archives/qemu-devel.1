Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA06220650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/vIgrpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA06220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzwS-0006eV-Nv
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzaX-0005Vz-AZ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzaW-0003Ba-0O
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzaV-0003BQ-Sw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUG75H2spVNxXKyZ7ESRf9W2wg4FjIjlM9ygXXLckWM=;
 b=X/vIgrpB/uyEz/EGiOtdSO0MIuCieip8jWHTpXAUR8KwNOhhbI3QClm08ub/5T8S4+etU0
 0Pa0fT7g0KgYmCQ1mCM3G8raIMEf0AshM+aqHbKRyC3Bwg2gML12rHugS83KAY6oFblFcw
 RnHeriaeYNxVRMUWpPvJQuZJuMHvDaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-Vm82sYMkMT2VoywxBwY2OA-1; Mon, 28 Oct 2019 03:37:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46245800D41;
 Mon, 28 Oct 2019 07:37:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC9C819C69;
 Mon, 28 Oct 2019 07:37:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/26] tests/acceptance: Test Sandalfoot initrd on the PReP/40p
Date: Mon, 28 Oct 2019 08:34:31 +0100
Message-Id: <20191028073441.6448-17-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Vm82sYMkMT2VoywxBwY2OA-1
X-Mimecast-Spam-Score: 0
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
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Sandalfoot info:
http://www.juneau-lug.org/sandalfoot.php

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v3:
- use avocado_qemu.wait_for_console_pattern (Cleber)
- use exec_command_and_wait_for_pattern
- check getenv(AVOCADO_ALLOW_UNTRUSTED_CODE) (pm215)
---
 tests/acceptance/ppc_prep_40p.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index b4109a7af3..c5ecabf52f 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -11,6 +11,7 @@ import logging
 from avocado import skipIf
 from avocado import skipUnless
 from avocado_qemu import MachineTest
+from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
=20
=20
@@ -101,3 +102,33 @@ class IbmPrep40pMachine(MachineTest):
=20
         self.vm.launch()
         wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_sandalfoot_busybox(self):
+        """
+        :avocado: tags=3Darch:ppc
+        :avocado: tags=3Dmachine:40p
+        """
+        drive_url =3D ('http://www.juneau-lug.org/zImage.initrd.sandalfoot=
')
+        drive_hash =3D 'dacacfc4085ea51d34d99ef70e972b849e2c6949'
+        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Now booting the kernel')
+
+        msg =3D 'Please press Enter to activate this console.'
+        wait_for_console_pattern(self, msg)
+
+        version =3D 'BusyBox v0.60.0 (2001.08.19-09:26+0000) Built-in shel=
l (ash)'
+        exec_command_and_wait_for_pattern(self, '', version)
+
+        uname =3D 'Linux ppc 2.4.18 #5 Wed May 21 23:50:43 AKDT 2003 ppc u=
nknown'
+        exec_command_and_wait_for_pattern(self, 'uname -a', uname)
+
+        cpu =3D 'PReP IBM 6015/7020 (Sandalfoot/Sandalbow)'
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo', cpu)
--=20
2.21.0


