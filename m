Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C9C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A864B20679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A864B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQuc-0006QZ-Uv
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hbPSH-0003XT-EI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hbPSF-0006Go-UF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hbPSF-0006G0-J0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCEA580B3F;
 Thu, 13 Jun 2019 13:07:31 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09C9F4128;
 Thu, 13 Jun 2019 13:07:29 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 09:07:15 -0400
Message-Id: <20190613130718.3763-2-crosa@redhat.com>
In-Reply-To: <20190613130718.3763-1-crosa@redhat.com>
References: <20190613130718.3763-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 13 Jun 2019 13:07:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] tests/vm: avoid extra compressed image copy
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
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The image copy is only really needed because xz doesn't know to
properly decompress a file not named properly.  Instead of
decompressing to stdout, and having to rely on a shell, let's just
create a link instead of copying the file.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/vm/centos  | 4 ++--
 tests/vm/freebsd | 4 ++--
 tests/vm/netbsd  | 4 ++--
 tests/vm/openbsd | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index ba133ea429..466fa59fec 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -66,8 +66,8 @@ class CentosVM(basevm.BaseVM):
         cimg =3D self._download_with_cache("https://cloud.centos.org/cen=
tos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
         img_tmp =3D img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
-        subprocess.check_call(["xz", "-dvf", img_tmp + ".xz"])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
         self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_ini=
t_iso()])
         self.wait_ssh()
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b0066017a6..5575c23a6f 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -34,8 +34,8 @@ class FreeBSDVM(basevm.BaseVM):
         img_tmp_xz =3D img + ".tmp.xz"
         img_tmp =3D img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 4c6624ea5e..d0508f4465 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -34,8 +34,8 @@ class NetBSDVM(basevm.BaseVM):
         img_tmp_xz =3D img + ".tmp.xz"
         img_tmp =3D img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2105c01a26..87ec982489 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -36,8 +36,8 @@ class OpenBSDVM(basevm.BaseVM):
         img_tmp_xz =3D img + ".tmp.xz"
         img_tmp =3D img + ".tmp"
         sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
--=20
2.21.0


