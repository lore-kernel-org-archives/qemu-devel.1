Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18162C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D521424680
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR9KM0qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D521424680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7G2a-0004CQ-Uf
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7G0a-0001iY-Mt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7G0Z-0002kB-Od
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:03:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7G0Z-0002ip-L0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582797787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7MUcizcjT8mmfm7wQjzBurTyv6zocr1z5HIlwjNKTE=;
 b=bR9KM0qqmTzhueA94zqY5sR3aMF3JJXGMHbdX5f0n3xCbZcGZIELnwq0vydRFS+//RfxVg
 BAqEWW0pU+Js2LTJ4FA1xq4OhqQo8FpU9epevjBW0yzIjMJsWMbdB0P2za6zj7lxdBgQr8
 b3NjnTfyuFTxLUab4gpT2+r+HizyEPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Nf4PoOHZM6W4LhubDij_Kw-1; Thu, 27 Feb 2020 05:03:03 -0500
X-MC-Unique: Nf4PoOHZM6W4LhubDij_Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1726189F760;
 Thu, 27 Feb 2020 10:03:02 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5D9C8B779;
 Thu, 27 Feb 2020 10:03:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] util/oslib-win32: Improve error report by calling
 error_setg_win32()
Date: Thu, 27 Feb 2020 11:02:50 +0100
Message-Id: <20200227100250.20514-3-philmd@redhat.com>
In-Reply-To: <20200227100250.20514-1-philmd@redhat.com>
References: <20200227100250.20514-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use error_setg_win32() which adds a hint similar to strerror(errno)).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/oslib-win32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e9b14ab178..d2fca1808d 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -46,7 +46,8 @@
 void *qemu_oom_check(void *ptr)
 {
     if (ptr =3D=3D NULL) {
-        fprintf(stderr, "Failed to allocate memory: %lu\n", GetLastError()=
);
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        fprintf(stderr, "Failed to allocate memory: %s\n", emsg);
         abort();
     }
     return ptr;
--=20
2.21.1


