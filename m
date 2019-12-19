Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99B2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849B924650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVv07arB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849B924650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvRk-0007rn-V6
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihusE-0000pW-Ma
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihusC-00032H-CK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26423
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihusC-0002zs-12
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dnisNAPALhuQUK94jay98zcuPOipYD5w8C91vCkHsQ=;
 b=jVv07arB7g0fVzBeljJmzv+ujPaPrUnZkSNiFB1hJHAOtSACxQkU5fUkWzxsA/eocMdT0K
 HpL2jG+q3IDSYPHvQYO9jHbKExUFUKF6gJD/ls4m1n16sSS28A7UX1aspiL2dsWNjVKIgF
 +gEiiDYfw60n3Ah5LdIekE0bdoAsIK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-hiaZiwjCPF-cxiKWTSlCig-1; Thu, 19 Dec 2019 07:25:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01AA0DB62
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:40 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C973E60C18;
 Thu, 19 Dec 2019 12:25:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 129/132] meson: replace mostly useless pc-bios/Makefile
Date: Thu, 19 Dec 2019 13:23:49 +0100
Message-Id: <1576758232-12439-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hiaZiwjCPF-cxiKWTSlCig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 pc-bios/Makefile    | 19 -------------------
 pc-bios/meson.build | 12 ++++++++++++
 2 files changed, 12 insertions(+), 19 deletions(-)
 delete mode 100644 pc-bios/Makefile

diff --git a/pc-bios/Makefile b/pc-bios/Makefile
deleted file mode 100644
index 315288d..0000000
--- a/pc-bios/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# NOTE: only compilable with x86 cross compile tools
-#
-include ../config-host.mak
-
-DEFINES=3D
-
-TARGETS=3D
-
-all: $(TARGETS)
-
-%.o: %.S
-=09$(CC) $(DEFINES) -c -o $@ $<
-
-%.dtb: %.dts
-=09dtc -I dts -O dtb -o $@ $<
-
-clean:
-=09rm -f $(TARGETS) *.o *~
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 9a46a8c..def68a4 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -87,3 +87,15 @@ blobs =3D files(
 if install_blobs
   install_data(blobs, install_dir: config_host['qemu_datadir'])
 endif
+
+dtc =3D find_program('dtc', required: false)
+if dtc.found()
+  t =3D []
+  foreach f: ['bamboo.dts', 'canyonlands.dts']
+    t +=3D custom_target(f,
+                       input: f,
+                       output: '@BASENAME@' + '.dtb',
+                       command: [dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OU=
TPUT@', '@INPUT@'])
+  endforeach
+  alias_target('update-dtb', t)
+endif
--=20
1.8.3.1



