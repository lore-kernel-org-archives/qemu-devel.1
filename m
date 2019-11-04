Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F9CCA9ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B2721744
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gddHoshC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B2721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34391 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRe58-0004Mb-4h
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iRe37-0002TV-DD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iRe35-0002bf-TU
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iRe35-0002bO-PD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572880423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DdcuhlA9O0EbX7K7tlwrtfLRI+kZIJiw9ryyNfVY2g=;
 b=gddHoshCIPMYNX9CSt8t8DlaMW550ye8FArr7fC4VcARkFbnkr0mu1qMz3hsPg9sdp7QKZ
 aJ0buwcNnZqa2Fr7/jYy8suLlmJVqlLUVEZTg5LuiAZIKHcbZdCRlh5khwDFBpQ/0N12qt
 Ea+ZAX2D8Axauuo1JxadtkygT63J/e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-KKjAaepYN3WTeNQMdYl28g-1; Mon, 04 Nov 2019 10:13:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B748017DD;
 Mon,  4 Nov 2019 15:13:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9508C5D6C5;
 Mon,  4 Nov 2019 15:13:34 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 1/8] Acceptance test x86_cpu_model_versions: use default vm
Date: Mon,  4 Nov 2019 10:13:16 -0500
Message-Id: <20191104151323.9883-2-crosa@redhat.com>
In-Reply-To: <20191104151323.9883-1-crosa@redhat.com>
References: <20191104151323.9883-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: KKjAaepYN3WTeNQMdYl28g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default vm provided by the test, available as self.vm, serves the
same purpose of the one obtained by self.get_vm(), but saves a line
and matches the style of other tests.

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


