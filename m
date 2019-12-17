Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B6BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F1720733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WU0h4Wll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F1720733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5j9-0007mW-Go
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5DY-0003j1-Fb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5DW-0003q9-Ud
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28131
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5DW-0003pU-QX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQwK+2ggju9MLRI5wSEJQ1PDIjvpWcu6KEuH5srydJc=;
 b=WU0h4WllAlYIA5kZeyCZ9YAuiHid9w6k2/aSYigv1ux8siyWT1SEtKF/FN9DUZN08pyrzm
 hkhR7OcBA7F1BUFtr+hXNtR2QssOm2fh0SBipnwC6zeynx0Yd499K8oH7brjDB2Jr1Rgo6
 cyVhCKSNwIFiyfl0KAekm3PApSbHNX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-VM2EWkGgM9qzCb6xGn4qqQ-1; Tue, 17 Dec 2019 00:16:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 049BC107ACC4;
 Tue, 17 Dec 2019 05:16:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D31519C4F;
 Tue, 17 Dec 2019 05:16:05 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/15] Acceptance test x86_cpu_model_versions: use default vm
Date: Tue, 17 Dec 2019 00:15:13 -0500
Message-Id: <20191217051521.1239-8-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
References: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: VM2EWkGgM9qzCb6xGn4qqQ-1
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default vm provided by the test, available as self.vm, serves the
same purpose of the one obtained by self.get_vm(), but saves a line
and matches the style of other tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190924194501.9303-2-crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/x86_cpu_model_versions.py | 100 ++++++++++-----------
 1 file changed, 46 insertions(+), 54 deletions(-)

diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/=
x86_cpu_model_versions.py
index 5fc9ca4bc6..6eb977954d 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -25,10 +25,6 @@
 import avocado_qemu
 import re
=20
-def get_cpu_prop(vm, prop):
-    cpu_path =3D vm.command('query-cpus')[0].get('qom_path')
-    return vm.command('qom-get', path=3Dcpu_path, property=3Dprop)
-
 class X86CPUModelAliases(avocado_qemu.Test):
     """
     Validation of PC CPU model versions and CPU model aliases
@@ -241,78 +237,74 @@ class CascadelakeArchCapabilities(avocado_qemu.Test):
=20
     :avocado: tags=3Darch:x86_64
     """
+    def get_cpu_prop(self, prop):
+        cpu_path =3D self.vm.command('query-cpus')[0].get('qom_path')
+        return self.vm.command('qom-get', path=3Dcpu_path, property=3Dprop=
)
+
     def test_4_1(self):
         # machine-type only:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.1')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,chec=
k=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server should not ha=
ve arch-capabilities')
=20
     def test_4_0(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,chec=
k=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server should not ha=
ve arch-capabilities')
=20
     def test_set_4_0(self):
         # command line must override machine-type if CPU model is not vers=
ioned:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,chec=
k=3Doff,enforce=3Doff,+arch-capabilities')
-        vm.launch()
-        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff,+arch-capabilities')
+        self.vm.launch()
+        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabili=
ties should have arch-capabilities')
=20
     def test_unset_4_1(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.1')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,chec=
k=3Doff,enforce=3Doff,-arch-capabilities')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff,-arch-capabilities')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server,-arch-capabil=
ities should not have arch-capabilities')
=20
     def test_v1_4_0(self):
         # versioned CPU model overrides machine-type:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3Don,c=
heck=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1 should not=
 have arch-capabilities')
=20
     def test_v2_4_0(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3Don,c=
heck=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server-v2 should hav=
e arch-capabilities')
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
+                        'pc-i440fx-4.0 + Cascadelake-Server-v2 should have=
 arch-capabilities')
=20
     def test_v1_set_4_0(self):
         # command line must override machine-type and versioned CPU model:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3Don,c=
heck=3Doff,enforce=3Doff,+arch-capabilities')
-        vm.launch()
-        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capa=
bilities should have arch-capabilities')
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff,+arch-capabilities')
+        self.vm.launch()
+        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
+                        'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capab=
ilities should have arch-capabilities')
=20
     def test_v2_unset_4_1(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.1')
-        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3Don,c=
heck=3Doff,enforce=3Doff,-arch-capabilities')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff,-arch-capabilities')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-capa=
bilities should not have arch-capabilities')
--=20
2.21.0


