Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33492C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8CD21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8CD21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho59J-0000uP-95
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 08:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ho597-0000Ud-G8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ho596-0003NM-8w
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ho596-0003Lg-3T
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:04:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A3443082AEF
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 12:04:21 +0000 (UTC)
Received: from localhost (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06DBD1001B03;
 Thu, 18 Jul 2019 12:04:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 16:04:13 +0400
Message-Id: <20190718120413.27678-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 18 Jul 2019 12:04:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] build-sys: do no support modules on Windows
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our module system does not support Windows, because it relies on
resolving symbols from the main executable.

If there is enough interest in supporting modules on Windows, we could
generate an import library for the executable and link with it:
https://stackoverflow.com/questions/15454968/dll-plugin-that-uses-functio=
ns-defined-in-the-main-executable

However, there is a small chicken egg problem, since the executable
link and exports extra symbols needed by the library...

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index eb635c3b9a..2833402844 100755
--- a/configure
+++ b/configure
@@ -1751,7 +1751,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   guest-agent     build the QEMU Guest Agent
   guest-agent-msi build guest agent Windows MSI installation package
   pie             Position Independent Executables
-  modules         modules support
+  modules         modules support (non-Windows)
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
   sparse          sparse checker
@@ -2006,6 +2006,11 @@ else
   QEMU_CFLAGS=3D"$QEMU_CFLAGS -Wno-missing-braces"
 fi
=20
+# Our module code doesn't support Windows
+if test "$modules" =3D "yes" && test "$mingw32" =3D "yes" ; then
+  error_exit "Modules are not available for Windows"
+fi
+
 # Static linking is not possible with modules or PIE
 if test "$static" =3D "yes" ; then
   if test "$modules" =3D "yes" ; then
--=20
2.22.0.428.g6d5b264208


