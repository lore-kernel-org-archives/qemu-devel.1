Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D96C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9D02072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUDzOswP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9D02072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRRI-000695-Na
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1izRMF-0006nL-1W
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1izRM9-0004Qp-He
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1izRM9-0004NL-Dg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580934784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZzZagDMAIa73gHlbhHDi/KoiEhZ9DhGVYUeUAQzSr4=;
 b=dUDzOswPr84xaKhmKjW4XgRQjWYVyA0d8+o64oURB02rWGay5hyKu1cNFqiUSL4w6J/w3f
 k0HuCsFqNtT/vTF8MCxcsjqCWPtcWlxwfwwzy6jmveUo4mBRTTbEw2yLzfYlS+lwyXTLqY
 3QMNzQZ5R1OE06Hh2BhdS3w7nOYmb60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-OKidnxS7P1akqN6WFxMK4A-1; Wed, 05 Feb 2020 15:32:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92A1EDB23;
 Wed,  5 Feb 2020 20:32:56 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA35A10013A1;
 Wed,  5 Feb 2020 20:32:55 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/8] tests/acceptance: boot_linux_console: Add boot
 Linux/aarch64 with KVM
Date: Wed,  5 Feb 2020 15:32:45 -0500
Message-Id: <20200205203250.30526-4-wainersm@redhat.com>
In-Reply-To: <20200205203250.30526-1-wainersm@redhat.com>
References: <20200205203250.30526-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: OKidnxS7P1akqN6WFxMK4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: drjones@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 thuth@redhat.com, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This split in two the boot Linux test for aarch64: one that uses
KVM acceleration and another with TCG. It changes -cpu to 'max'
which is a common match between kvm and tcg.

Note: on kvm test, even though it is tagged with 'machine:virt', it later
has the value overwritten to pass the GIC version. The reason for that
is an Avocado limitation, which is unable to parse correctly a
tag containing ',' (this char being a tag delimiter). Keep the
'machine:virt' tag is still useful since it can be used on tests
filtering.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index fc72cdde0d..76a66ee533 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -270,11 +270,7 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
         self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
=20
-    def test_aarch64_virt(self):
-        """
-        :avocado: tags=3Darch:aarch64
-        :avocado: tags=3Dmachine:virt
-        """
+    def do_test_aarch64_virt(self):
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/fe=
dora'
                       '/linux/releases/29/Everything/aarch64/os/images/pxe=
boot'
                       '/vmlinuz')
@@ -284,13 +280,30 @@ class BootLinuxConsole(Test):
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=3DttyAMA0')
-        self.vm.add_args('-cpu', 'cortex-a53',
+        self.vm.add_args('-cpu', 'max',
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_aarch64_virt_kvm(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Daccel:kvm
+        """
+        self.vm.set_machine('virt,gic-version=3Dmax')
+        self.do_test_aarch64_virt()
+
+    def test_aarch64_virt_tcg(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Daccel:tcg
+        """
+        self.do_test_aarch64_virt()
+
     def test_arm_virt(self):
         """
         :avocado: tags=3Darch:arm
--=20
2.24.1


