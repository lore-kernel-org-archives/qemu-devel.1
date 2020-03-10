Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB30C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97B724677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP/gqadt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97B724677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaLC-0006NB-Sd
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBaJQ-0004jL-Ak
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBaJP-0003hT-2g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBaJO-0003gJ-Tv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRD6a3P4nr7j+WbXmGylLPfycG/bMaTgxM1cs6Eg84c=;
 b=OP/gqadtD/dqOf8okBQ2w501LmqVH4zoZx/GAYPwoSGHiQyQ+UCDTByK/aF+QtZQyx1dpt
 ejdlWhMfcKK7Ovb8PNrSs8pW0ti8IEdjzfL6KLxfV7o8kSbK3zWIaEKKb7g5ZAPuLFPiwY
 mIO1sM2NcCnycJJsRCblqdTgZsYiP/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-w0JnbOLZPNSwLp75GdgF3g-1; Tue, 10 Mar 2020 04:32:23 -0400
X-MC-Unique: w0JnbOLZPNSwLp75GdgF3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0710B107ACC7;
 Tue, 10 Mar 2020 08:32:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5A1B5DA66;
 Tue, 10 Mar 2020 08:32:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 371549D25; Tue, 10 Mar 2020 09:32:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] tests/vm: move vga setup
Date: Tue, 10 Mar 2020 09:32:16 +0100
Message-Id: <20200310083218.26355-3-kraxel@redhat.com>
In-Reply-To: <20200310083218.26355-1-kraxel@redhat.com>
References: <20200310083218.26355-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move '-device VGA' from basevm.py to the guests, so they have
the chance to opt out and run without display device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/basevm.py   | 1 -
 tests/vm/fedora      | 1 +
 tests/vm/freebsd     | 1 +
 tests/vm/netbsd      | 1 +
 tests/vm/openbsd     | 1 +
 tests/vm/ubuntu.i386 | 5 ++++-
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c53fd354d955..cffe7c4600ed 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -179,7 +179,6 @@ class BaseVM(object):
=20
     def boot(self, img, extra_args=3D[]):
         args =3D self._args + [
-            "-device", "VGA",
             "-drive", "file=3D%s,if=3Dnone,id=3Ddrive0,cache=3Dwriteback" =
% img,
             "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
         args +=3D self._data_args + extra_args
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 4843b4175e07..bd9c6cf295c1 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -82,6 +82,7 @@ class FedoraVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args =3D [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=3Doff",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init(300)
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 86770878b67b..58166766d915 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -92,6 +92,7 @@ class FreeBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args =3D [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=3Doff",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 55590f460152..f3257bc245a3 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -86,6 +86,7 @@ class NetBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args =3D [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=3Doff",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index ab6abbedab57..0b705f494527 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -82,6 +82,7 @@ class OpenBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args =3D [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=3Doff",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3266038fbde5..157077533532 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -36,7 +36,10 @@ class UbuntuX86VM(basevm.BaseVM):
         img_tmp =3D img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args =3D ["-cdrom", self.gen_cloud_init_i=
so()])
+        self.boot(img_tmp, extra_args =3D [
+            "-device", "VGA",
+            "-cdrom", self.gen_cloud_init_iso()
+        ])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("apt-get update")
--=20
2.18.2


