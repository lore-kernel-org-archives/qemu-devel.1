Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B57C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C61205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y10lM/rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C61205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHu3-0002yF-Fa
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBHne-0003LY-DS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBHnc-0003ih-Mq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBHnb-0003gT-IJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583757983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghUUbHBLeJfPjhw9Xr3hpb5Q5fUdpl7pzHb43rVSMCE=;
 b=Y10lM/rgpVdoUViXmLfdu4yWasA/ejJQE0Jnw5udBnhgGdZ54Fux/9W51IsWFPDJVNvyoJ
 GPfJwZAiOg4k+hCvk08j+O9M0ZsUS24dmlnZ12zddHExMgmUuEnl18feH4i6B/QXIuczZx
 0e+C0GdxUPB/LXfiFP1k0lmuiMetuKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-MG2fgR2lOguZEz2VkmzmFA-1; Mon, 09 Mar 2020 08:46:21 -0400
X-MC-Unique: MG2fgR2lOguZEz2VkmzmFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740551084437
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 12:46:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D3760C87;
 Mon,  9 Mar 2020 12:46:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E37511385ED; Mon,  9 Mar 2020 13:46:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] chardev: Improve error report by calling error_setg_win32()
Date: Mon,  9 Mar 2020 13:46:13 +0100
Message-Id: <20200309124616.4372-2-armbru@redhat.com>
In-Reply-To: <20200309124616.4372-1-armbru@redhat.com>
References: <20200309124616.4372-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Use error_setg_win32() which adds a hint similar to strerror(errno)).

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200228100726.8414-2-philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


