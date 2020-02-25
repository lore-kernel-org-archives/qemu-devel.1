Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE89C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA362084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c00go9pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA362084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6e1q-0005bQ-Sc
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6dxX-0001OT-IU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6dxW-0008CC-7p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6dxW-0008Bc-3X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582651525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwOy7T6zNBV+JaHegxs0HatnwG/xt++Cu5QA75IMhb4=;
 b=c00go9ppn0c17DhVczQdY25iFNNQfH2/qkJjWik/9WHs2vrBurODggk1pRsMtrGf8gNxYJ
 gVhaGnPqkl0LyzmJBqYfK57z14J2YyByFW70K22/U1i2b5rb9oGMIpHwuVfJQD0vCYyQi6
 RaNS90QSD8udTxutQKqx/Tt1RPuZ/EA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-57o4NEeANhm5xs_CKFI0Rw-1; Tue, 25 Feb 2020 12:25:19 -0500
X-MC-Unique: 57o4NEeANhm5xs_CKFI0Rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD61477;
 Tue, 25 Feb 2020 17:25:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26ED161069;
 Tue, 25 Feb 2020 17:25:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] tests/acceptance: Extract boot_integratorcp() from
 test_integratorcp()
Date: Tue, 25 Feb 2020 18:25:00 +0100
Message-Id: <20200225172501.29609-4-philmd@redhat.com>
In-Reply-To: <20200225172501.29609-1-philmd@redhat.com>
References: <20200225172501.29609-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

As we want to re-use this code, extract it as a new function.
Since we are using the PL011 serial console, add a Avocado tag
to ease filtering of tests.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/acceptance/machine_arm_integratorcp.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptanc=
e/machine_arm_integratorcp.py
index d928ed79b4..22afd3b82a 100644
--- a/tests/acceptance/machine_arm_integratorcp.py
+++ b/tests/acceptance/machine_arm_integratorcp.py
@@ -18,13 +18,7 @@ class IntegratorMachine(Test):
=20
     timeout =3D 90
=20
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
-    def test_integratorcp_console(self):
-        """
-        Boots the Linux kernel and checks that the console is operational
-        :avocado: tags=3Darch:arm
-        :avocado: tags=3Dmachine:integratorcp
-        """
+    def boot_integratorcp(self):
         kernel_url =3D ('https://github.com/zayac/qemu-arm/raw/master/'
                       'arm-test/kernel/zImage.integrator')
         kernel_hash =3D '0d7adba893c503267c946a3cbdc63b4b54f25468'
@@ -40,4 +34,14 @@ def test_integratorcp_console(self):
                          '-initrd', initrd_path,
                          '-append', 'printk.time=3D0 console=3DttyAMA0')
         self.vm.launch()
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_integratorcp_console(self):
+        """
+        Boots the Linux kernel and checks that the console is operational
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:integratorcp
+        :avocado: tags=3Ddevice:pl011
+        """
+        self.boot_integratorcp()
         wait_for_console_pattern(self, 'Log in as root')
--=20
2.21.1


