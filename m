Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB17C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFDA20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT3OVhiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFDA20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb0e-0005md-1R
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazh-0004Ad-DZ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazf-0005tC-Pj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazf-0005se-MF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6/LVvVdvTBXToTqtH5+/eNKJXXvrIEAC/8NKwBkjNk=;
 b=bT3OVhiRNr3ePv6+jyXDId6VTKDsyiIC8O6fomW3J2QmTbjdyJKv46TqblXYnrpq4PRmhl
 EJ2bK62wZ+EAZccV33DdNKQVP1x89Et59+GxGZ1QHU/T5dkmZmId3ZyoJ5WnJA7oHSh8sF
 2HIoxHLaa029kMGm3XmQj1nZeMro7eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-TmwnHpnqM92Rha7sSYz3_g-1; Mon, 03 Feb 2020 07:38:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC462100550E;
 Mon,  3 Feb 2020 12:38:17 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8565196BD;
 Mon,  3 Feb 2020 12:38:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/13] test-logging: Fix -Werror=maybe-uninitialized warning
Date: Mon,  3 Feb 2020 13:37:59 +0100
Message-Id: <20200203123811.8651-2-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TmwnHpnqM92Rha7sSYz3_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miroslav Rezanina <mrezanin@redhat.com>

Checking for uninitialized variables raises warning for file path
variables in test_logfile_write and test_logfile_lock functions.

To suppress this warning, initialize varibles to NULL. This is safe
change as result of g_build_filename is stored to them before any usage.

Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
Message-Id: <63b0fcedf7dfe799c8210b113e5dccf32414a89d.1579598240.git.mrezan=
in@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-logging.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 1e646f045d..6387e4933f 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -114,8 +114,8 @@ static void test_logfile_write(gconstpointer data)
     QemuLogFile *logfile2;
     gchar const *dir =3D data;
     Error *err =3D NULL;
-    g_autofree gchar *file_path;
-    g_autofree gchar *file_path1;
+    g_autofree gchar *file_path =3D NULL;
+    g_autofree gchar *file_path1 =3D NULL;
     FILE *orig_fd;
=20
     /*
@@ -157,7 +157,7 @@ static void test_logfile_lock(gconstpointer data)
     FILE *logfile;
     gchar const *dir =3D data;
     Error *err =3D NULL;
-    g_autofree gchar *file_path;
+    g_autofree gchar *file_path =3D NULL;
=20
     file_path =3D g_build_filename(dir, "qemu_test_logfile_lock0.log", NUL=
L);
=20
--=20
2.18.1


