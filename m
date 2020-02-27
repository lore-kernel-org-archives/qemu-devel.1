Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF816C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F48C24687
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj/f8n7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F48C24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7G3q-0005uZ-OY
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7G0X-0001cv-I2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7G0V-0002Vm-Dd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:03:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53415
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7G0V-0002UN-94
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582797782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kw98pB1tWPGUjfZgZz7G2e/0ArOYvHoL2Mljit+/yGw=;
 b=Vj/f8n7GQhlbCaefFWdD+BYzNX9znSRJRY5Q9ej2scyJceydkxTm7v4CHf/keLIGXzBrhe
 FVYwrpyCIAnhag341zUbthKIkQvcyrQIJWRI5qFEXITm+dIVpW0FUSUVk4jMXEO5ddDmQ2
 UvU82QTajlevIate2PzQFkdtbQEzw9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-vn8IZvRvOS-S3RIbMPaKUw-1; Thu, 27 Feb 2020 05:03:01 -0500
X-MC-Unique: vn8IZvRvOS-S3RIbMPaKUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4159913F6;
 Thu, 27 Feb 2020 10:03:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B0948B779;
 Thu, 27 Feb 2020 10:02:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] chardev: Improve error report by calling
 error_setg_win32()
Date: Thu, 27 Feb 2020 11:02:49 +0100
Message-Id: <20200227100250.20514-2-philmd@redhat.com>
In-Reply-To: <20200227100250.20514-1-philmd@redhat.com>
References: <20200227100250.20514-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 chardev/char-pipe.c | 2 +-
 chardev/char-win.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 94d714ffcd..fd12c9e63b 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -70,7 +70,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *fi=
lename,
                               MAXCONNECT, NSENDBUF, NRECVBUF, NTIMEOUT, NU=
LL);
     g_free(openname);
     if (s->file =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError());
+        error_setg_win32(errp, GetLastError(), "Failed CreateNamedPipe");
         s->file =3D NULL;
         goto fail;
     }
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 34825f683d..d4fb44c4dc 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -96,7 +96,7 @@ int win_chr_serial_init(Chardev *chr, const char *filenam=
e, Error **errp)
     s->file =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NULL=
,
                       OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
     if (s->file =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
+        error_setg_win32(errp, GetLastError(), "Failed CreateFile");
         s->file =3D NULL;
         goto fail;
     }
--=20
2.21.1


