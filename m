Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20875C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EEE20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKxWD8oE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EEE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxNy-0002vv-R2
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHH-00031U-Oe
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHG-0002gT-9p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHG-0002cM-4Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY9UYpkZpqX4mfvmY/RqqrdkZCQ7roAxViM/kJBm9Bg=;
 b=JKxWD8oEGfvJ2LbUI3wX4xMEfyG9lzLu64M7RiJV6rcuKnUOMwV73yOCUgPE8aqPURak+t
 eJuUXI///LPH+TFm7BuKXpgxaGeufSmFDcF8nQ8CMDcb/CiHh7CzeVx1OiU2F/eG1NgZIX
 TuI0j5hRAMDURH/CqXtD0JaeBiLo55A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348--kjMsyyvPD-rVqF7rEju1Q-1; Mon, 16 Mar 2020 17:27:58 -0400
X-MC-Unique: -kjMsyyvPD-rVqF7rEju1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 132321804547;
 Mon, 16 Mar 2020 21:27:57 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2E1C19C4F;
 Mon, 16 Mar 2020 21:27:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/61] configure: Fix building with SASL on Windows
Date: Mon, 16 Mar 2020 22:26:41 +0100
Message-Id: <1584394048-44994-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Alexey Pavlov <alexpux@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Biswapriyo Nath <nathbappai@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The Simple Authentication and Security Layer (SASL) library
re-defines the struct iovec on Win32 [*]. QEMU also re-defines
it in "qemu/osdep.h". The two definitions then clash on a MinGW
build.
We can avoid the SASL definition by defining STRUCT_IOVEC_DEFINED.
Since QEMU already defines 'struct iovec' if it is missing, add
the definition to vnc_sasl_cflags to avoid SASL re-defining it.

[*] https://github.com/cyrusimap/cyrus-sasl/blob/cyrus-sasl-2.1.27/include/=
sasl.h#L187

Cc: Alexey Pavlov <alexpux@gmail.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>
Reported-by: Youry Metlitsky <winaes@yandex.ru>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200309122454.22551-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index a7f2c3e..44a70cf 100755
--- a/configure
+++ b/configure
@@ -3367,7 +3367,9 @@ if test "$vnc" =3D "yes" && test "$vnc_sasl" !=3D "no=
" ; then
 int main(void) { sasl_server_init(NULL, "qemu"); return 0; }
 EOF
   # Assuming Cyrus-SASL installed in /usr prefix
-  vnc_sasl_cflags=3D""
+  # QEMU defines struct iovec in "qemu/osdep.h",
+  # we don't want libsasl to redefine it in <sasl/sasl.h>.
+  vnc_sasl_cflags=3D"-DSTRUCT_IOVEC_DEFINED"
   vnc_sasl_libs=3D"-lsasl2"
   if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
     vnc_sasl=3Dyes
--=20
1.8.3.1



