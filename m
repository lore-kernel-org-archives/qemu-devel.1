Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBAC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5727C24670
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4z1iUtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5727C24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7G6L-0007ph-Ib
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7G3s-0006FW-Vv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7G3r-0002Oo-Sc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:06:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7G3r-0002OS-Om
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582797991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RnfOC7xcAjw65er0wBfO7g8gW20zUjV4ojYZ17BV+64=;
 b=H4z1iUtce2EwaQG9W1/9ZvFLkrswJQX9CMLw56ulZ18eMj5DznmDIRJOtlGacLXhscDjCb
 C9J/j/dINS+s8mA/drl4v6ELBpIPgvubfiybvIVx9YNLSRPsT2oGTzbSGtLV4sqyOlKhHK
 O70xn08KLtmledvD8P1UjzAekKXrMnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-F789DM6_PDWklkwrG9Oz8Q-1; Thu, 27 Feb 2020 05:06:29 -0500
X-MC-Unique: F789DM6_PDWklkwrG9Oz8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8656800D48;
 Thu, 27 Feb 2020 10:06:28 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 312BB1001B09;
 Thu, 27 Feb 2020 10:06:23 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] linux-user/syscall: Use g_file_open_tmp()
Date: Thu, 27 Feb 2020 11:06:21 +0100
Message-Id: <20200227100621.21844-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, "Daniel P . Berrange" <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use GLib g_file_open_tmp() instead of getenv + snprintf + mkstemp.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because I'm not sure g_autoptr(GError) works this way.

 linux-user/syscall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d10807..0e44969e16 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7282,17 +7282,14 @@ static int do_openat(void *cpu_env, int dirfd, cons=
t char *pathname, int flags,
     }
=20
     if (fake_open->filename) {
-        const char *tmpdir;
-        char filename[PATH_MAX];
+        g_autoptr(GError) gerr =3D NULL;
+        g_autofree gchar *filename =3D NULL;
         int fd, r;
=20
         /* create temporary file to map stat to */
-        tmpdir =3D getenv("TMPDIR");
-        if (!tmpdir)
-            tmpdir =3D "/tmp";
-        snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmpdir=
);
-        fd =3D mkstemp(filename);
+        fd =3D g_file_open_tmp("qemu-open.XXXXXX", &filename, &gerr);
         if (fd < 0) {
+            fprintf(stderr, "Error opening %s: %s\n", filename, gerr->mess=
age);
             return fd;
         }
         unlink(filename);
--=20
2.21.1


