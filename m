Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE4EC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE04F246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhgehElv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE04F246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7M9h-0001py-N0
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7M50-0004NX-RI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7M4z-00033M-T8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:32:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7M4z-00032s-5d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P74SiNUxpKL8ZPS0To1187cVvGqPWjuWELUewBJjUJo=;
 b=BhgehElveBWPfI8QmiVjfH5eqq376b5cA+aRNHHGnGcBAfPmrGP8GYAzd1x5rc2/2yhtxO
 6WCnin1S0p+JNaD2zkzBDmcbUeu0Nrc8EXW30dnOvlsrBpk0YAwEpq4Gh004CyYWpT4ROO
 DNmKHUXXqIdcTWcxAHAZW6lxgwAzXTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-wTJ4Is98OBWftlPy7j-zKQ-1; Thu, 27 Feb 2020 11:31:58 -0500
X-MC-Unique: wTJ4Is98OBWftlPy7j-zKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBB0C802560;
 Thu, 27 Feb 2020 16:31:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F1C6E3EE;
 Thu, 27 Feb 2020 16:31:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] util/osdep: Improve error report by calling
 error_setg_win32()
Date: Thu, 27 Feb 2020 17:30:59 +0100
Message-Id: <20200227163101.414-5-philmd@redhat.com>
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
 util/osdep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index ef40ae512a..144e217cb9 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -82,8 +82,8 @@ static int qemu_mprotect__osdep(void *addr, size_t size, =
int prot)
     DWORD old_protect;
=20
     if (!VirtualProtect(addr, size, prot, &old_protect)) {
-        error_report("%s: VirtualProtect failed with error code %ld",
-                     __func__, GetLastError());
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        error_report("%s: VirtualProtect failed: %s", __func__, emsg);
         return -1;
     }
     return 0;
@@ -506,12 +506,12 @@ int socket_init(void)
 {
 #ifdef _WIN32
     WSADATA Data;
-    int ret, err;
+    int ret;
=20
     ret =3D WSAStartup(MAKEWORD(2, 2), &Data);
     if (ret !=3D 0) {
-        err =3D WSAGetLastError();
-        error_report("WSAStartup: %d", err);
+        g_autofree gchar *emsg =3D g_win32_error_message(WSAGetLastError()=
);
+        error_report("WSAStartup: %s", emsg);
         return -1;
     }
     atexit(socket_cleanup);
--=20
2.21.1


