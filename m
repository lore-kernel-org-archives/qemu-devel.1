Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB319C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E4D206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9TvVTXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E4D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFTb-0000tH-IU
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iVFOh-0005Kl-CZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iVFOf-0002xw-Iv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:42:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iVFOf-0002wp-DX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573738972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQnqCIJ+e9ZzmO5qQmS/9NiQJKqB0JsSt74DPmUryTU=;
 b=V9TvVTXnQaglYploeN8bl9PuNJbQ3mUXbqLpkLjd0HZMysHZIB6k6ycmtbDwOOo1epusJA
 d0UiSLRZuVXOA5Ys/Uj0ufMxUbc/Y1flLqKjMtpU2A6BxLMg9otobT00GIO11vYaAaICv3
 ZYdwlKIAm61m2r/jxgKLo1+d/NVBbKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-lo-_0UTzP7uTtvNu88h4Vw-1; Thu, 14 Nov 2019 08:42:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52C9B1005500;
 Thu, 14 Nov 2019 13:42:50 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C105D60BEC;
 Thu, 14 Nov 2019 13:42:49 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] tests/vm: Allow to set qemu-img path
Date: Thu, 14 Nov 2019 08:42:46 -0500
Message-Id: <20191114134246.12073-2-wainersm@redhat.com>
In-Reply-To: <20191114134246.12073-1-wainersm@redhat.com>
References: <20191114134246.12073-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: lo-_0UTzP7uTtvNu88h4Vw-1
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By default VM build test use qemu-img from system's PATH to
create the image disk. Due the lack of qemu-img on the system
or the desire to simply use a version built with QEMU, it would
be nice to allow one to set its path. So this patch makes that
possible by reading the path to qemu-img from QEMU_IMG if set,
otherwise it fallback to default behavior.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 docs/devel/testing.rst    | 6 ++++--
 tests/vm/Makefile.include | 1 +
 tests/vm/basevm.py        | 5 +++++
 tests/vm/centos           | 2 +-
 tests/vm/fedora           | 4 +---
 tests/vm/freebsd          | 3 +--
 tests/vm/netbsd           | 3 +--
 tests/vm/openbsd          | 3 +--
 tests/vm/ubuntu.i386      | 2 +-
 9 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 8e981e062d..9be6cd4410 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -418,13 +418,15 @@ access, so they SHOULD NOT be exposed to external int=
erfaces if you are
 concerned about attackers taking control of the guest and potentially
 exploiting a QEMU security bug to compromise the host.
=20
-QEMU binary
------------
+QEMU binaries
+-------------
=20
 By default, qemu-system-x86_64 is searched in $PATH to run the guest. If t=
here
 isn't one, or if it is older than 2.10, the test won't work. In this case,
 provide the QEMU binary in env var: ``QEMU=3D/path/to/qemu-2.10+``.
=20
+Likewise the path to qemu-img can be set in QEMU_IMG environment variable.
+
 Make jobs
 ---------
=20
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index fea348e845..9e7c46a473 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -34,6 +34,7 @@ vm-help vm-test:
 =09@echo "    DEBUG=3D1              =09 - Enable verbose output on host a=
nd interactive debugging"
 =09@echo "    V=3D1=09=09=09=09 - Enable verbose ouput on host and guest c=
ommands"
 =09@echo "    QEMU=3D/path/to/qemu=09=09 - Change path to QEMU binary"
+=09@echo "    QEMU_IMG=3D/path/to/qemu-img=09 - Change path to qemu-img to=
ol"
=20
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
=20
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 91a9226026..d1efeb3646 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -152,6 +152,11 @@ class BaseVM(object):
     def build_image(self, img):
         raise NotImplementedError
=20
+    def exec_qemu_img(self, *args):
+        cmd =3D [os.environ.get("QEMU_IMG", "qemu-img")]
+        cmd.extend(list(args))
+        subprocess.check_call(cmd)
+
     def add_source_dir(self, src_dir):
         name =3D "data-" + hashlib.sha1(src_dir.encode("utf-8")).hexdigest=
()[:5]
         tarfile =3D os.path.join(self._tmpdir, name + ".tar")
diff --git a/tests/vm/centos b/tests/vm/centos
index 53976f1c4c..eac07dacd6 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -68,7 +68,7 @@ class CentosVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
-        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
+        self.exec_qemu_img("resize", img_tmp, "50G")
         self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_init_=
iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 7fec1479fb..8e270fc0f0 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -74,9 +74,7 @@ class FedoraVM(basevm.BaseVM):
=20
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["cp", "-f", cimg, iso])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
-
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args =3D [
             "-bios", "pc-bios/bios-256k.bin",
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 2a19461a90..1825cc5821 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -82,8 +82,7 @@ class FreeBSDVM(basevm.BaseVM):
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["cp", "-f", cimg, iso_xz])
         subprocess.check_call(["xz", "-dvf", iso_xz])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
=20
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args =3D [
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 611e6cc5b5..ec6f3563b2 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -77,8 +77,7 @@ class NetBSDVM(basevm.BaseVM):
=20
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["ln", "-f", cimg, iso])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
=20
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args =3D [
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index b92c39f89a..6df5162dbf 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -73,8 +73,7 @@ class OpenBSDVM(basevm.BaseVM):
=20
         self.print_step("Preparing iso and disk image")
         subprocess.check_call(["cp", "-f", cimg, iso])
-        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
-                               img_tmp, self.size])
+        self.exec_qemu_img("create", "-f", "qcow2", img_tmp, self.size)
=20
         self.print_step("Booting installer")
         self.boot(img_tmp, extra_args =3D [
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 38f740eabf..39bbe9cc21 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -70,7 +70,7 @@ class UbuntuX86VM(basevm.BaseVM):
             sha256sum=3D"e30091144c73483822b7c27193e9d47346dd1064229da577c=
3fedcf943f7cfcc")
         img_tmp =3D img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
-        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
+        self.exec_qemu_img("resize", img_tmp, "50G")
         self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_init_=
iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
--=20
2.18.1


