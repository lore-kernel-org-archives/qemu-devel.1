Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A02C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7085A2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYGld0+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7085A2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaNs-000344-Kr
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBaJe-0004ve-FH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBaJd-0004Cr-5B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBaJc-0004BO-Sc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umJLVabTlxfOYRdcqqJPgQHpfKmMGvR8MmZg0s3LCOY=;
 b=ZYGld0+RYuji3HpDpv2iZlaT7Dm7BgDrqfiaWyC5BNoJDkYN65K2V941ZLUKypqySFZ3gy
 47O+u0m3PAXY9ccJRiYl2rAlD5uDznC+yRJMk3Ld7ZSBTM6MiCXGVcZ4Mo4qUrxBrIBnpQ
 iCjR0DDQ6Z96vTBHyJUOYWyrTJLw0eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-swIc5mRaMLKyaIn18emcJQ-1; Tue, 10 Mar 2020 04:32:23 -0400
X-MC-Unique: swIc5mRaMLKyaIn18emcJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AD911005513;
 Tue, 10 Mar 2020 08:32:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F305391D6E;
 Tue, 10 Mar 2020 08:32:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 47EE09D3C; Tue, 10 Mar 2020 09:32:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tests/vm: update NetBSD to 9.0
Date: Tue, 10 Mar 2020 09:32:18 +0100
Message-Id: <20200310083218.26355-5-kraxel@redhat.com>
In-Reply-To: <20200310083218.26355-1-kraxel@redhat.com>
References: <20200310083218.26355-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

The installer supports GPT now, so the install workflow has changed a
bit.  Also: run without VGA device.  This works around a bug in the
seabios sercon code and makes the bootloader menu show up on the serial
line, so we can drop the quirk for that.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/netbsd | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index f3257bc245a3..b10c9d429ded 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -22,8 +22,8 @@ class NetBSDVM(basevm.BaseVM):
     name =3D "netbsd"
     arch =3D "x86_64"
=20
-    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/NetBSD-8=
.1-amd64.iso"
-    csum =3D "718f275b7e0879599bdac95630c5e3f2184700032fdb6cdebf3bdd636878=
98c48ff3f08f57b89f4437a86cdd8ea07c01a39d432dbb37e1e4b008f4985f98da3f"
+    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9=
.0-amd64.iso"
+    csum =3D "34da4882ee61bdbf69f241195a8933dc800949d30b43fc6988da853d57fc=
2b8cac50cf97a0d2adaf93250b4e329d189c1a8b83c33bd515226f37745d50c33369"
     size =3D "20G"
     pkgs =3D [
         # tools
@@ -86,42 +86,31 @@ class NetBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args =3D [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=3Doff",
-            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
-        self.console_wait("Primary Bootstrap")
-
-        # serial console boot menu output doesn't work for some
-        # reason, so we have to fly blind ...
-        for char in list("5consdev com0\n"):
-            time.sleep(0.2)
-            self.console_send(char)
-            self.console_consume()
+        self.console_wait_send("3. Drop to boot prompt", "3")
+        self.console_wait_send("> ", "consdev com0\n")
         self.console_wait_send("> ", "boot\n")
=20
         self.console_wait_send("Terminal type",            "xterm\n")
         self.console_wait_send("a: Installation messages", "a\n")
-        self.console_wait_send("b: US-English",            "b\n")
         self.console_wait_send("a: Install NetBSD",        "a\n")
         self.console_wait("Shall we continue?")
         self.console_wait_send("b: Yes",                   "b\n")
=20
         self.console_wait_send("a: ld0",                   "a\n")
+        self.console_wait_send("a: Guid Partition Table",  "a\n")
         self.console_wait_send("a: This is the correct",   "a\n")
-        self.console_wait_send("b: Use the entire disk",   "b\n")
-        self.console_wait("NetBSD bootcode")
-        self.console_wait_send("a: Yes",                   "a\n")
-        self.console_wait_send("b: Use existing part",     "b\n")
+        self.console_wait_send("b: Use default part",      "b\n")
         self.console_wait_send("x: Partition sizes ok",    "x\n")
-        self.console_wait_send("for your NetBSD disk",     "\n")
         self.console_wait("Shall we continue?")
         self.console_wait_send("b: Yes",                   "b\n")
=20
         self.console_wait_send("b: Use serial port com0",  "b\n")
         self.console_wait_send("f: Set serial baud rate",  "f\n")
         self.console_wait_send("a: 9600",                  "a\n")
-        self.console_wait_send("x: Exit",                  "x\n")
+        self.console_wait_send("x: Continue",              "x\n")
=20
         self.console_wait_send("a: Full installation",     "a\n")
         self.console_wait_send("a: CD-ROM",                "a\n")
--=20
2.18.2


