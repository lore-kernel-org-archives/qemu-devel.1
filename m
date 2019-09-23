Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB026C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A425A20665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A425A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOcF-0000fD-Cq
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCOZu-0007JV-5H
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCOZt-0007Xz-3D
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCOZs-0007Xh-SD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 290EE30917AA;
 Mon, 23 Sep 2019 13:40:32 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A62E19C78;
 Mon, 23 Sep 2019 13:40:30 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 2/7] Acceptance test x86_cpu_model_versions: shutdown VMs
Date: Mon, 23 Sep 2019 09:40:14 -0400
Message-Id: <20190923134019.8548-3-crosa@redhat.com>
In-Reply-To: <20190923134019.8548-1-crosa@redhat.com>
References: <20190923134019.8548-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 23 Sep 2019 13:40:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This shuts down the VMs that won't be used any longer during the
remainder of the test.

It's debatable if the very last one should also be shutdown manually,
and my opinion is that it shouldn't because that's taken care by the
immediately following tearDown().

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190828193628.7687-2-crosa@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/x86_cpu_model_versions.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index 1c9fd6a56e..e6c76b0d4c 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -243,6 +243,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server should not =
have arch-capabilities')
+        vm.shutdown()
=20
         vm =3D self.get_vm()
         vm.add_args('-S')
@@ -251,6 +252,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server should not =
have arch-capabilities')
+        vm.shutdown()
=20
         # command line must override machine-type if CPU model is not ve=
rsioned:
         vm =3D self.get_vm()
@@ -260,6 +262,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabi=
lities should have arch-capabilities')
+        vm.shutdown()
=20
         vm =3D self.get_vm()
         vm.add_args('-S')
@@ -268,6 +271,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server,-arch-capab=
ilities should not have arch-capabilities')
+        vm.shutdown()
=20
         # versioned CPU model overrides machine-type:
         vm =3D self.get_vm()
@@ -277,6 +281,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server-v1 should n=
ot have arch-capabilities')
+        vm.shutdown()
=20
         vm =3D self.get_vm()
         vm.add_args('-S')
@@ -285,6 +290,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server-v1 should h=
ave arch-capabilities')
+        vm.shutdown()
=20
         # command line must override machine-type and versioned CPU mode=
l:
         vm =3D self.get_vm()
@@ -294,6 +300,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-ca=
pabilities should have arch-capabilities')
+        vm.shutdown()
=20
         vm =3D self.get_vm()
         vm.add_args('-S')
--=20
2.21.0


