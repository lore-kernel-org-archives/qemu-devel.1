Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C78C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957A8205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK0y91Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957A8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idH3K-0003vS-RF
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idFED-00014t-0D
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idFEB-0000cA-K3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idFEB-0000al-Fi
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MV0fOidRF7C4EAztP9ZWauegvPnXcw1LymAIIRWE6Bk=;
 b=YK0y91UyMM5WnOveZWNVQdeQ3GBAhK96pPfJ/nqpfvp5cuZtg+GjKpU7QmtaUpQakooiG1
 aRQnZe45pDUcKQGAeeZqZfQZlDjAH7ywOFtMZURt6C8VQNY05VEpIkj5eHAUvIXM7nHLb6
 0E1Qprprpgb6We1ciZbQJOH2xzKdxHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-43DSfnp9NryNg402202AmQ-1; Fri, 06 Dec 2019 10:09:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52F6A100A174;
 Fri,  6 Dec 2019 15:09:03 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E73A5D6C8;
 Fri,  6 Dec 2019 15:09:00 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] tests/boot_linux_console: Fetch assets from Debian
 snapshot archives
Date: Fri,  6 Dec 2019 10:08:44 -0500
Message-Id: <20191206150844.20124-2-crosa@redhat.com>
In-Reply-To: <20191206150844.20124-1-crosa@redhat.com>
References: <20191206150844.20124-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 43DSfnp9NryNg402202AmQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The kernel packaged was fetched from an unstable repository.
Use the stable snapshot archive instead.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191126223810.20180-2-philmd@redhat.com>
Tested-by: Willian Rampazzo <wrampazz@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index 7e41cebd47..752f776f68 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -479,7 +479,8 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Darch:m68k
         :avocado: tags=3Dmachine:q800
         """
-        deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k/m=
ain'
+        deb_url =3D ('https://snapshot.debian.org/archive/debian-ports'
+                   '/20191021T083923Z/pool-m68k/main'
                    '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.ude=
b')
         deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
         try:
--=20
2.21.0


