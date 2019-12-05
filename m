Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCCC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFF42464F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6Clc6jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFF42464F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvht-00068I-05
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icvZ9-0006uL-Gu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icvZ5-0007n9-NQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:09:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55794
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icvZ5-0007io-9h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575569362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OjyaI8O7SmbMvhSVlPQtDMl8MgJOeJ/4LUngnzRxRNA=;
 b=H6Clc6jQJMC0mHdjaBmhycB/cKcxSWocH2ZqOc7L/SLmMM55iJPcJo3ZbkBia5epydy/l/
 t1tUzlYNR4M/Yi1rK5JgsU/O0rUKOCcjvE515mV+lB1/MO21hL6nUdsPNigkkIaBZQmfTR
 fq5wLDpoB5Hx1WYpZ6xNN5elqjbjV8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-bJ7fdi0oOgG4aBBJfRgKfQ-1; Thu, 05 Dec 2019 13:09:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6DEC593A0;
 Thu,  5 Dec 2019 18:09:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-76.brq.redhat.com [10.40.205.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B739419488;
 Thu,  5 Dec 2019 18:09:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] roms/edk2-funcs: Force armhf toolchain prefix on
 Debian
Date: Thu,  5 Dec 2019 19:09:13 +0100
Message-Id: <20191205180913.15263-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bJ7fdi0oOgG4aBBJfRgKfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Debian (based) distributions historically provides 2 ARM
toolchains, documented as [1]:

* The ARM EABI (armel) port targets a range of older 32-bit ARM
  devices, particularly those used in NAS hardware and a variety
  of *plug computers.
* The newer ARM hard-float (armhf) port supports newer, more
  powerful 32-bit devices using version 7 of the ARM architecture
  specification.

The EDK2 documentation suggests to use the hard-float toolchain.

Force the armhf cross toolchain prefix on Debian distributions.

[1] https://www.debian.org/ports/arm/#status
[2] https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-cr=
oss-compiling

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/edk2-funcs.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 3f4485b201..a546aa1d11 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
      ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); th=
en
     # no cross-compiler needed
     :
+  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); then
+    # force hard-float cross-compiler on Debian
+    printf 'arm-linux-gnueabihf-'
   else
     printf '%s-linux-gnu-\n' "$gcc_arch"
   fi
--=20
2.21.0


