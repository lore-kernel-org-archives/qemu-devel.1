Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F65C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA8921582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrAQ9F8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihiib-0000ZG-Nc
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 18:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihih1-0007CZ-Ji
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihigy-0003Ze-Mv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55594
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihigy-0003Z2-Iy
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576711519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsIGFqbdWELPUdKkJ0RdM0GqpnaKBuEs67bNMNVth7Y=;
 b=NrAQ9F8arLofPigyAAm6P5G1zzZGxMRBja/ypeU0nwv+BYykbydOO/wEspNfZpEVbB8gOL
 D3O5evUwY2mdIZsOt7c+FyUYEmSI6oGbR162h9t+5bDOStw/DS9oQ3Dac2ln9pkuljQzbo
 z9xYTVLQHCpvG3pXOcxQgoH/upPtYac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-7s0LT2qfONuSDzlk4m4zmw-1; Wed, 18 Dec 2019 18:25:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29AB0107ACE6;
 Wed, 18 Dec 2019 23:25:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E29E61036D00;
 Wed, 18 Dec 2019 23:25:12 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 1/4] Acceptance tests: introduce BLD_DIR,
 SRC_DIR and LNK_DIR
Date: Wed, 18 Dec 2019 18:24:57 -0500
Message-Id: <20191218232500.23530-2-crosa@redhat.com>
In-Reply-To: <20191218232500.23530-1-crosa@redhat.com>
References: <20191218232500.23530-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7s0LT2qfONuSDzlk4m4zmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some tests may benefit from using resources from a build directory.
This introduces three variables that can help tests find resources in
those directories.

First, a BLD_DIR is assumed to exist, given that the primary form of
running the acceptance tests is from a build directory (which may or
may not be the same as the source tree, that is, the SRC_DIR).

If the directory containing the acceptance tests happens to be a link
to a directory (kept as LNK_DIR), it's assumed to it points to the
source tree (SRC_DIR), which is the behavior defined on the QEMU
Makefiles.  If the directory containing the acceptance tests is not a
link, then a in-tree build is assumed, and the BLD_DIR and SRC_DIR are
the same and LNK_DIR is set None.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 27 ++++++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 6618ea67c1..ac7597f7fe 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -16,8 +16,23 @@ import tempfile
=20
 import avocado
=20
-SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..')
-sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
+#: The QEMU build root directory.  It may also be the source directory
+#: if building from the source dir, but it's safer to use BLD_DIR for
+#: that purpose.  Be aware that if this code is moved outside of a source
+#: and build tree, it will not be accurate.
+BLD_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirnam=
e(__file__))))
+
+if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
+    #: The link to the acceptance tests dir in the source code directory. =
 If
+    #: build dir is the same as the source dir, this is set to None
+    LNK_DIR =3D os.path.dirname(os.path.dirname(__file__))
+    #: The QEMU root source directory
+    SRC_DIR =3D os.path.dirname(os.path.dirname(os.readlink(LNK_DIR)))
+else:
+    LNK_DIR =3D None
+    SRC_DIR =3D BLD_DIR
+
+sys.path.append(os.path.join(SRC_DIR, 'python'))
=20
 from qemu.machine import QEMUMachine
=20
@@ -49,10 +64,10 @@ def pick_default_qemu_bin(arch=3DNone):
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
=20
-    qemu_bin_from_src_dir_path =3D os.path.join(SRC_ROOT_DIR,
+    qemu_bin_from_bld_dir_path =3D os.path.join(BLD_DIR,
                                               qemu_bin_relative_path)
-    if is_readable_executable_file(qemu_bin_from_src_dir_path):
-        return qemu_bin_from_src_dir_path
+    if is_readable_executable_file(qemu_bin_from_bld_dir_path):
+        return qemu_bin_from_bld_dir_path
=20
=20
 def wait_for_console_pattern(test, success_message, failure_message=3DNone=
):
@@ -122,7 +137,7 @@ class Test(avocado.Test):
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
2.21.0


