Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE87C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256EE20663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8hnP0gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256EE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEMSc-0005mm-Ah
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 20:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jEMR6-00048t-N8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jEMR5-0007BX-Dq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jEMR5-00076h-86
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584490790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bj5Qs3g5aOxqwH63FL3Y0rfKKyCVCNqczX8nCRdvjLc=;
 b=H8hnP0gwh0iun/fEp/Ngan35steGVGj+RfBFWKoMERydHEmMMc2OAncSLdLLc/ZOilWqW5
 sEIvPiPZK5bC+Fb7+d0jw54G9M4UcCSaB/DggHWQ7pVRiuNDxs8NuG4sfgj2kHgCIY6Tn+
 26CMJ1egdf1qtb7wsi1wMEze4YV1NU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-c0WNrO7COAWHFlDPMhlGQw-1; Tue, 17 Mar 2020 20:19:49 -0400
X-MC-Unique: c0WNrO7COAWHFlDPMhlGQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9795D1857BE0;
 Wed, 18 Mar 2020 00:19:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-2.rdu2.redhat.com
 [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE7710027A3;
 Wed, 18 Mar 2020 00:19:42 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] Acceptance tests: introduce BUILD_DIR and SOURCE_DIR
Date: Tue, 17 Mar 2020 20:19:28 -0400
Message-Id: <20200318001932.180617-3-crosa@redhat.com>
In-Reply-To: <20200318001932.180617-1-crosa@redhat.com>
References: <20200318001932.180617-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Fabien Chouteau <chouteau@adacore.com>, Willian Rampazzo <willianr@redhat.com>,
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

Some tests may benefit from using resources from a build directory.
This introduces three variables that can help tests find resources in
those directories.

First, a BUILD_DIR is assumed to exist, given that the primary form of
running the acceptance tests is from a build directory (which may or
may not be the same as the source tree, that is, the SOURCE_DIR).

If the directory containing the acceptance tests happens to be a link
to a directory, it's assumed to it points to the source tree
(SOURCE_DIR), which is the behavior defined on the QEMU Makefiles.  If
the directory containing the acceptance tests is not a link, then a
in-tree build is assumed, and the BUILD_DIR and SOURCE_DIR have the
same value.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Tested-by: Willian Rampazzo <willianr@redhat.com>
Message-Id: <20200317141654.29355-2-crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index d4358eb431..59e7b4f763 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -16,8 +16,21 @@ import tempfile
=20
 import avocado
=20
-SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..')
-sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
+#: The QEMU build root directory.  It may also be the source directory
+#: if building from the source dir, but it's safer to use BUILD_DIR for
+#: that purpose.  Be aware that if this code is moved outside of a source
+#: and build tree, it will not be accurate.
+BUILD_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirn=
ame(__file__))))
+
+if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
+    # The link to the acceptance tests dir in the source code directory
+    lnk =3D os.path.dirname(os.path.dirname(__file__))
+    #: The QEMU root source directory
+    SOURCE_DIR =3D os.path.dirname(os.path.dirname(os.readlink(lnk)))
+else:
+    SOURCE_DIR =3D BUILD_DIR
+
+sys.path.append(os.path.join(SOURCE_DIR, 'python'))
=20
 from qemu.machine import QEMUMachine
=20
@@ -49,10 +62,10 @@ def pick_default_qemu_bin(arch=3DNone):
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
=20
-    qemu_bin_from_src_dir_path =3D os.path.join(SRC_ROOT_DIR,
+    qemu_bin_from_bld_dir_path =3D os.path.join(BUILD_DIR,
                                               qemu_bin_relative_path)
-    if is_readable_executable_file(qemu_bin_from_src_dir_path):
-        return qemu_bin_from_src_dir_path
+    if is_readable_executable_file(qemu_bin_from_bld_dir_path):
+        return qemu_bin_from_bld_dir_path
=20
=20
 def _console_interaction(test, success_message, failure_message,
@@ -153,7 +166,7 @@ class Test(avocado.Test):
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
         if self.qemu_bin is None:
-            self.cancel("No QEMU binary defined or found in the source tre=
e")
+            self.cancel("No QEMU binary defined or found in the build tree=
")
=20
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
--=20
2.25.1


