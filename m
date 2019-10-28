Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B952214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgQF8wfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B952214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzdH-0000QJ-Da
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzZF-00031G-PG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzZE-0002c2-LL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzZE-0002bp-HU
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6N7zo2hMqV0TfAjlL0Z3VGYNiIu/FBYsCeEXTlXtkc=;
 b=IgQF8wfLvcMBgiOvpqZvrxGwTAixw2qyeydqZdEykw9WjSs+xkNRNEzR0AXDL4Fd9sAmg2
 MuFztSW6FinYzpyq6RclcVaqwZ/auXaB0RKiCxE0MBNv5ZP2/MGOMbSsX4R5/Q8dwJu2aC
 NgWTAmO4PjR4mD0GhJYAiA3rmNVMllQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Nht048q6Oemhvlqr9myiuA-1; Mon, 28 Oct 2019 03:35:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093F71800D7E;
 Mon, 28 Oct 2019 07:35:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCD9819C69;
 Mon, 28 Oct 2019 07:35:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/26] tests/acceptance: Make pick_default_qemu_bin() more
 generic
Date: Mon, 28 Oct 2019 08:34:22 +0100
Message-Id: <20191028073441.6448-8-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Nht048q6Oemhvlqr9myiuA-1
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
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make pick_default_qemu_bin() generic to find qemu-system or
qemu-user binaries.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index a2cc3d689b..d23681818d 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -24,7 +24,7 @@ def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
=20
=20
-def pick_default_qemu_bin(arch=3DNone):
+def pick_default_qemu_bin(path_fmt, bin_fmt, arch=3DNone):
     """
     Picks the path of a QEMU binary, starting either in the current workin=
g
     directory or in the source tree root directory.
@@ -43,8 +43,7 @@ def pick_default_qemu_bin(arch=3DNone):
     # qemu binary path does not match arch for powerpc, handle it
     if 'ppc64le' in arch:
         arch =3D 'ppc64'
-    qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
-                                          "qemu-system-%s" % arch)
+    qemu_bin_relative_path =3D os.path.join(path_fmt % arch, bin_fmt % arc=
h)
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
=20
@@ -99,14 +98,15 @@ def exec_command_and_wait_for_pattern(test, command,
=20
=20
 class Test(avocado.Test):
-    def setUp(self):
+    def base_setUp(self, path_fmt, bin_fmt):
         arches =3D self.tags.get('arch', [])
         if len(arches) =3D=3D 1:
             arch =3D arches.pop()
         else:
             arch =3D None
         self.arch =3D self.params.get('arch', default=3Darch)
-        default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
+        default_qemu_bin =3D pick_default_qemu_bin(path_fmt, bin_fmt,
+                                                 arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
         if self.qemu_bin is None:
@@ -116,7 +116,7 @@ class Test(avocado.Test):
 class MachineTest(Test):
     def setUp(self):
         self._vms =3D {}
-        super().setUp()
+        self.base_setUp("%s-softmmu", "qemu-system-%s")
=20
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin)
--=20
2.21.0


