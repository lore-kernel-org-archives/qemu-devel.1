Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F8C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15B72070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15B72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60511 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMLG-0007Lp-W3
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:46:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGp-0003YK-Tt
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGo-0006kG-LV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMGo-0006jq-Dd
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B469658E5B;
	Fri,  3 May 2019 00:41:45 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4984F10027BA;
	Fri,  3 May 2019 00:41:45 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu,  2 May 2019 21:41:15 -0300
Message-Id: <20190503004130.8285-5-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 03 May 2019 00:41:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/19] tests/acceptance: introduce arch
 parameter and attribute
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503004115.aY1g0JEyEiE3YiJbsa6vjsXGUYRIcJiVoJzaRqBOq5Q@z>

From: Cleber Rosa <crosa@redhat.com>

It's useful to define the architecture that should be used in
situations such as:
 * the intended target of the QEMU binary to be used on tests
 * the architecture of code to be run within the QEMU binary, such
   as a kernel image or a full blown guest OS image

This commit introduces both a test parameter and a test instance
attribute, that will contain such a value.

Now, when the "arch" test parameter is given, it will influence the
selection of the default QEMU binary, if one is not given explicitly
by means of the "qemu_img" parameter.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-5-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/testing.rst                    | 28 +++++++++++++++++++++++
 tests/acceptance/avocado_qemu/__init__.py | 14 +++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 7c1b199323..83bf9f09ac 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -727,6 +727,21 @@ vm
 A QEMUMachine instance, initially configured according to the given
 ``qemu_bin`` parameter.
=20
+arch
+~~~~
+
+The architecture can be used on different levels of the stack, e.g. by
+the framework or by the test itself.  At the framework level, it will
+currently influence the selection of a QEMU binary (when one is not
+explicitly given).
+
+Tests are also free to use this attribute value, for their own needs.
+A test may, for instance, use the same value when selecting the
+architecture of a kernel or disk image to boot a VM with.
+
+The ``arch`` attribute will be set to the test parameter of the same
+name, and if one is not given explicitly, it will be set to ``None``.
+
 qemu_bin
 ~~~~~~~~
=20
@@ -749,6 +764,19 @@ like the following:
=20
   PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-system=
-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
=20
+arch
+~~~~
+
+The architecture that will influence the selection of a QEMU binary
+(when one is not explicitly given).
+
+Tests are also free to use this parameter value, for their own needs.
+A test may, for instance, use the same value when selecting the
+architecture of a kernel or disk image to boot a VM with.
+
+This parameter has a direct relation with the ``arch`` attribute.  If
+not given, it will default to None.
+
 qemu_bin
 ~~~~~~~~
=20
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index b7c5d598d8..688a0746a2 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -23,16 +23,22 @@ def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
=20
=20
-def pick_default_qemu_bin():
+def pick_default_qemu_bin(arch=3DNone):
     """
     Picks the path of a QEMU binary, starting either in the current work=
ing
     directory or in the source tree root directory.
=20
+    :param arch: the arch to use when looking for a QEMU binary (the tar=
get
+                 will match the arch given).  If None (the default), arc=
h
+                 will be the current host system arch (as given by
+                 :func:`os.uname`).
+    :type arch: str
     :returns: the path to the default QEMU binary or None if one could n=
ot
               be found
     :rtype: str or None
     """
-    arch =3D os.uname()[4]
+    if arch is None:
+        arch =3D os.uname()[4]
     qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
                                           "qemu-system-%s" % arch)
     if is_readable_executable_file(qemu_bin_relative_path):
@@ -47,8 +53,10 @@ def pick_default_qemu_bin():
 class Test(avocado.Test):
     def setUp(self):
         self._vms =3D {}
+        self.arch =3D self.params.get('arch')
+        default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
-                                        default=3Dpick_default_qemu_bin(=
))
+                                        default=3Ddefault_qemu_bin)
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source t=
ree")
=20
--=20
2.18.0.rc1.1.g3f1ff2140


