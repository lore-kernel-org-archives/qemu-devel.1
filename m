Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95962C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607462077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHoUntGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607462077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ior9Z-00010i-Dr
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioqq3-0002Vs-C9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioqq2-0005Df-4I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioqq2-0005DG-0M
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578411129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqcC4iwRjZk2Pipwg+1qbHsQTWsG8okjQZj1OF4QkHE=;
 b=jHoUntGIiYexnTC9KOETmwP0QiUZmWCQh6q78Wn5+DhlnvVNy+gtr9JpHwiQDVSD6EOXgM
 jbmPZGyiDhW3LfT48czka1R9cYJ7EFueKPr+ttmJtXn5+1JVD/Gc5+Mx+/OTg0i1RtYqgv
 bOk9l3KAnoG3BEc6JSe26hbkEAeKppQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-zXzfzP3LMh-3Z6Lnxf4dtQ-1; Tue, 07 Jan 2020 10:32:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CDAE8C6E0F;
 Tue,  7 Jan 2020 15:32:03 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-222.brq.redhat.com [10.40.204.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A9D85D9CA;
 Tue,  7 Jan 2020 15:32:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] roms/edk2-funcs: Force softfloat ARM toolchain prefix
 on Debian
Date: Tue,  7 Jan 2020 16:31:52 +0100
Message-Id: <20200107153154.21401-2-philmd@redhat.com>
In-Reply-To: <20200107153154.21401-1-philmd@redhat.com>
References: <20200107153154.21401-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: zXzfzP3LMh-3Z6Lnxf4dtQ-1
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Debian (based) distributions currently provides 2 ARM
toolchains, documented as [1]:

* The ARM EABI (armel) port targets a range of older 32-bit ARM
  devices, particularly those used in NAS hardware and a variety
  of *plug computers.
* The newer ARM hard-float (armhf) port supports newer, more
  powerful 32-bit devices using version 7 of the ARM architecture
  specification.

For various reasons documented in [2], the EDK2 project suggests
to use the softfloat toolchain (named 'armel' by Debian).

Force the softfloat cross toolchain prefix on Debian distributions.

[1] https://www.debian.org/ports/arm/#status
[2] https://github.com/tianocore/edk2/commit/41203b9a

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: fixed s/float/soft/ typo (Laszlo)
---
 roms/edk2-funcs.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 3f4485b201..cd6e4f2c82 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
      ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); th=
en
     # no cross-compiler needed
     :
+  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); then
+    # force soft-float cross-compiler on Debian
+    printf 'arm-linux-gnueabi-'
   else
     printf '%s-linux-gnu-\n' "$gcc_arch"
   fi
--=20
2.21.1


