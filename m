Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37743C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049B120727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dob72mqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049B120727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHrF-0007Cu-6v
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBHne-0003Li-G0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBHnd-0003kX-AT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBHnd-0003jJ-6B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583757984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8tKS53m/iCX/+e3eTiv7utNTL7Cedo93PaSY2b3hTE=;
 b=dob72mqr0k9JBq87yJUerHxWSN8ob8TL1r9XBg7WrDep6xHmMm/HPcVbj7t/kvfezJucf8
 OJB3Md+JZ4rDg59HTa0s+y26p7+fuXAreuMxi+tW94YYpkwfK7iXkHmxHMfSi8Y8vrq8eC
 Ipw+aGher+zQRpZQBheKJTbt9Q6ymLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-9OEzc6jDOLCG2LOoTIYPsw-1; Mon, 09 Mar 2020 08:46:23 -0400
X-MC-Unique: 9OEzc6jDOLCG2LOoTIYPsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463CA1084441
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 12:46:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAC4C91D84;
 Mon,  9 Mar 2020 12:46:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A3EE1138611; Mon,  9 Mar 2020 13:46:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] qga: Improve error report by calling error_setg_win32()
Date: Mon,  9 Mar 2020 13:46:15 +0100
Message-Id: <20200309124616.4372-4-armbru@redhat.com>
In-Reply-To: <20200309124616.4372-1-armbru@redhat.com>
References: <20200309124616.4372-1-armbru@redhat.com>
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Use error_setg_win32() which adds a hint similar to strerror(errno)).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200228100726.8414-4-philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/channel-win32.c  | 3 ++-
 qga/commands-win32.c | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index c86f4388db..99648c95b6 100644
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
index 2461fd19bf..9c744d6405 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -315,8 +315,9 @@ void qmp_guest_shutdown(bool has_mode, const char *mode=
, Error **errp)
     }
=20
     if (!ExitWindowsEx(shutdown_flag, SHTDN_REASON_FLAG_PLANNED)) {
-        slog("guest-shutdown failed: %lu", GetLastError());
-        error_setg(errp, QERR_UNDEFINED_ERROR);
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        slog("guest-shutdown failed: %s", emsg);
+        error_setg_win32(errp, GetLastError(), "guest-shutdown failed");
     }
 }
=20
@@ -1319,7 +1320,8 @@ static DWORD WINAPI do_suspend(LPVOID opaque)
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


