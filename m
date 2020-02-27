Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C3C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A080246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKkatqTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A080246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7M6V-0006KN-Ki
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7M54-0004VS-Ej
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7M53-000357-Ck
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:32:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7M53-00034y-8H
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQDBNrecZ++ehAWaj148iqa/qkCuUZmbV37u4dgQJEQ=;
 b=NKkatqTLaoYE+r3vLEDno9na4wTKJ2JPWJzZrckja4LTYiqk+XVaiodS4frQ8iwhBMWSbs
 FZ044u21gnWb87U7YR9zBl6fM3KWMFpmL6k/J1RLpU5gYIw4i2b2/pM3cZSaHmHgdEv+0P
 nlwl386HAL8sFxxnAHaV1xtuomakDTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-CKf8VmUSOKCDrLXBSzYO3g-1; Thu, 27 Feb 2020 11:32:05 -0500
X-MC-Unique: CKf8VmUSOKCDrLXBSzYO3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14C3C802563;
 Thu, 27 Feb 2020 16:32:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F62A6E3EE;
 Thu, 27 Feb 2020 16:32:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] qga: Improve error report by calling error_setg_win32()
Date: Thu, 27 Feb 2020 17:31:01 +0100
Message-Id: <20200227163101.414-7-philmd@redhat.com>
In-Reply-To: <20200227163101.414-1-philmd@redhat.com>
References: <20200227163101.414-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>,
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/channel-win32.c  | 3 ++-
 qga/commands-win32.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 774205e017..4f04868a76 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -308,7 +308,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChannel=
Method method,
     }
=20
     if (method =3D=3D GA_CHANNEL_ISA_SERIAL && !SetCommTimeouts(c->handle,=
&comTimeOut)) {
-        g_critical("error setting timeout for com port: %lu",GetLastError(=
));
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        g_critical("error setting timeout for com port: %s", emsg);
         CloseHandle(c->handle);
         return false;
     }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2461fd19bf..8e1f32ea23 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -315,8 +315,7 @@ void qmp_guest_shutdown(bool has_mode, const char *mode=
, Error **errp)
     }
=20
     if (!ExitWindowsEx(shutdown_flag, SHTDN_REASON_FLAG_PLANNED)) {
-        slog("guest-shutdown failed: %lu", GetLastError());
-        error_setg(errp, QERR_UNDEFINED_ERROR);
+        error_setg_win32(errp, GetLastError(), "guest-shutdown failed");
     }
 }
=20
@@ -1319,7 +1318,8 @@ static DWORD WINAPI do_suspend(LPVOID opaque)
     DWORD ret =3D 0;
=20
     if (!SetSuspendState(*mode =3D=3D GUEST_SUSPEND_MODE_DISK, TRUE, TRUE)=
) {
-        slog("failed to suspend guest, %lu", GetLastError());
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        slog("failed to suspend guest: %s", emsg);
         ret =3D -1;
     }
     g_free(mode);
--=20
2.21.1


