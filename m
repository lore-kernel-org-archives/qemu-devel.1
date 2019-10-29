Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00306CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB0E2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVpMG5Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPari-0007Hg-TH
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPaq1-0005ay-H5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPapw-0000bO-MM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPaps-0000Rw-Sk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572391414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwH9hP9h5JMyZy5bHZ9zCUIlNUkMalcmhJ8CtfXMGyE=;
 b=HVpMG5LqJnsETxe73aadl4MKLZdo0jvBGagb4zRRSfNP7kt0wyNlcjRq7ccLN191bPbMB8
 gc40pyJrZ92UdgVigKym3p5gPnMPkFcn/0o14fnfx+QAU6dgZCgSbtBX69w50UX//Jui8C
 IrUU6ngSYpJMUC32/VY1i6/3YGaf8ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-5KrxV8thOM-OpFv-Ve8vUg-1; Tue, 29 Oct 2019 19:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3355800C80;
 Tue, 29 Oct 2019 23:23:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 898795D9C3;
 Tue, 29 Oct 2019 23:23:28 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] Acceptance test: cancel test if m68k kernel packages goes
 missing
Date: Tue, 29 Oct 2019 19:23:19 -0400
Message-Id: <20191029232320.12419-2-crosa@redhat.com>
In-Reply-To: <20191029232320.12419-1-crosa@redhat.com>
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5KrxV8thOM-OpFv-Ve8vUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Willian Rampazzo <wrampazz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel that is extracted from a Debian package for the q800
machine test is hosted on a "pool" location.  AFAICT, it gets updated
without too much ceremony, and I don't see any archival location that
is stable enough.

For now, to avoid test errors, let's cancel the test if fetching the
package fails.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index df27813c78..c439fd90fc 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -387,7 +387,10 @@ class BootLinuxConsole(Test):
         deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k/m=
ain'
                    '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.ude=
b')
         deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
-        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        try:
+            deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        except OSError as exp:
+            self.cancel(exp)
         kernel_path =3D self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-5.2.0-2-m68k')
=20
--=20
2.21.0


