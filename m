Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9088CC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E36246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT3pF2oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E36246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7M7r-0007jh-CQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7M4K-0003gG-9p
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7M4J-0002dI-81
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:31:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7M4J-0002cs-4M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yT/3v5xc8MjkoVGOOK8X+qbWZgR0VaRsSfKEBOzcIOk=;
 b=iT3pF2oVsa+KoITqO0PQ2kdbOaZBWFUga2NIXuQIMO823gAkWzTzS0ziXPeksNRowkGG3/
 mGpb0K3SBn7grCt2QPCmqF+fob7eCKWbMwqarJaQXmbXMSIdlHF83LT/NfqiP/ZlZaL6Dc
 3RImPDqGD78eyIuwdo6P6l8KVOhaJFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-ZwpIfXPdNg-KBE8BvP3VSw-1; Thu, 27 Feb 2020 11:31:20 -0500
X-MC-Unique: ZwpIfXPdNg-KBE8BvP3VSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01FC68010F0;
 Thu, 27 Feb 2020 16:31:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7056E3EE;
 Thu, 27 Feb 2020 16:31:12 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] chardev: Improve error report by calling
 error_setg_win32()
Date: Thu, 27 Feb 2020 17:30:56 +0100
Message-Id: <20200227163101.414-2-philmd@redhat.com>
In-Reply-To: <20200227163101.414-1-philmd@redhat.com>
References: <20200227163101.414-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use error_setg_win32() which adds a hint similar to strerror(errno)).

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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


