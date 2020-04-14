Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BEAC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218A2206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+z8zGhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218A2206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPJN-0001dk-8s
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOP1e-0008FZ-JF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOP1d-00076A-91
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:07:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLej-0008ED-Qk
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fu0f7k/a61zvNy9hTYFT7tcEyV8paFWKyShaFKjjtn0=;
 b=D+z8zGhIrmamczMqNdV/rE21HF4Y0sok3V6GrenWazy7hsU3m92aqUM50up6ou9pVFOP0x
 7i7dEvur8rn0XpYvRP7UVFOl28EfXDBmjADzPZnXY/Guj7kpm/LKo1U3R4Lreg+c1YdyTp
 XWhqlGy/YHcOIH1NVgnqnYuLDCDqwvk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-f6PJAjffOq-Itmu9i8do_Q-1; Tue, 14 Apr 2020 09:31:12 -0400
X-MC-Unique: f6PJAjffOq-Itmu9i8do_Q-1
Received: by mail-wr1-f69.google.com with SMTP id q10so2142193wrv.10
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eFub0oIWRGuMfBgpHGkeKThVa6ZfWPB3Vt4l4sK5QOw=;
 b=mfT7AEsB9x/MRUAo/w1tttsi6Jmuv/8+nKrjlhuMmc0bi8vWie6eLYur5QTVbpvERy
 haiCsaKuwg7eXMU6PlVxDfllWLsyfZyCtf4lXox7qQVMqZSuizhnND8IS32d6Dfkrfz3
 tsQWfly+fiaiF+8yxNBdI7KBBAz9uIPBsGqZLIEUHhw/tqoH6eJqaMtsVm2pw+OLqzcK
 7AlndTpDqZAOLTSAdSAV+xmrSgCQzQ+fr4azfz2sQYiXLh908aWhcLWW8OV+kNmRFxEj
 DvxrG8yfqfzib8mT/38O2jGyqBPpaBuUlUp8EkyPuulV3HFeo1VKwIJFqM0ofCIwqY91
 qVwg==
X-Gm-Message-State: AGi0PuYCcZCmQN6W3yZdcLMgDamo1eXk4RMErXcag21PuKSCzFgTjWi1
 MElk6f/F9HfLqoZm6W+psbF6MfdGLCyWCUv/oUWrXk76isK0Bp3JfWmaHbFmixXJbXkk8/xcegB
 r/87wT37kgG8o+b4=
X-Received: by 2002:a05:600c:2645:: with SMTP id
 5mr23428262wmy.168.1586871070896; 
 Tue, 14 Apr 2020 06:31:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUj1wcW67mAnc4eU4lfYsdaLbjNF0Qypi6FeeefagAzYyw4C2DE9SKNXLI4ZaMY1tuRtaf6A==
X-Received: by 2002:a05:600c:2645:: with SMTP id
 5mr23428234wmy.168.1586871070661; 
 Tue, 14 Apr 2020 06:31:10 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id g186sm19354552wme.7.2020.04.14.06.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 03/12] qga: Extract qmp_guest_file_read() to common
 commands.c
Date: Tue, 14 Apr 2020 15:30:43 +0200
Message-Id: <20200414133052.13712-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the common code shared by both POSIX/Win32 implementations.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/commands-common.h |  3 +++
 qga/commands-posix.c  | 22 +++-------------------
 qga/commands-win32.c  | 20 +++-----------------
 qga/commands.c        | 26 ++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/qga/commands-common.h b/qga/commands-common.h
index af90e5481e..90785ed4bb 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -15,4 +15,7 @@ typedef struct GuestFileHandle GuestFileHandle;
=20
 GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp);
=20
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp);
+
 #endif
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index c59c32185c..a52af0315f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -461,29 +461,14 @@ void qmp_guest_file_close(int64_t handle, Error **err=
p)
     g_free(gfh);
 }
=20
-struct GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
-                                          int64_t count, Error **errp)
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp)
 {
-    GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
     GuestFileRead *read_data =3D NULL;
     guchar *buf;
-    FILE *fh;
+    FILE *fh =3D gfh->fh;
     size_t read_count;
=20
-    if (!gfh) {
-        return NULL;
-    }
-
-    if (!has_count) {
-        count =3D QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >=3D UINT32_MAX) {
-        error_setg(errp, "value '%" PRId64 "' is invalid for argument coun=
t",
-                   count);
-        return NULL;
-    }
-
-    fh =3D gfh->fh;
-
     /* explicitly flush when switching from writing to reading */
     if (gfh->state =3D=3D RW_STATE_WRITING) {
         int ret =3D fflush(fh);
@@ -498,7 +483,6 @@ struct GuestFileRead *qmp_guest_file_read(int64_t handl=
e, bool has_count,
     read_count =3D fread(buf, 1, count, fh);
     if (ferror(fh)) {
         error_setg_errno(errp, errno, "failed to read file");
-        slog("guest-file-read failed, handle: %" PRId64, handle);
     } else {
         buf[read_count] =3D 0;
         read_data =3D g_new0(GuestFileRead, 1);
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index cfaf6b84b8..9717a8d52d 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -322,33 +322,19 @@ void qmp_guest_shutdown(bool has_mode, const char *mo=
de, Error **errp)
     }
 }
=20
-GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
-                                   int64_t count, Error **errp)
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp)
 {
     GuestFileRead *read_data =3D NULL;
     guchar *buf;
-    HANDLE fh;
+    HANDLE fh =3D gfh->fh;
     bool is_ok;
     DWORD read_count;
-    GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
=20
-    if (!gfh) {
-        return NULL;
-    }
-    if (!has_count) {
-        count =3D QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >=3D UINT32_MAX) {
-        error_setg(errp, "value '%" PRId64
-                   "' is invalid for argument count", count);
-        return NULL;
-    }
-
-    fh =3D gfh->fh;
     buf =3D g_malloc0(count + 1);
     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
-        slog("guest-file-read failed, handle %" PRId64, handle);
     } else {
         buf[read_count] =3D 0;
         read_data =3D g_new0(GuestFileRead, 1);
diff --git a/qga/commands.c b/qga/commands.c
index 4471a9f08d..5611117372 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -18,6 +18,7 @@
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 #include "qemu/atomic.h"
+#include "commands-common.h"
=20
 /* Maximum captured guest-exec out_data/err_data - 16MB */
 #define GUEST_EXEC_MAX_OUTPUT (16*1024*1024)
@@ -547,3 +548,28 @@ error:
     g_free(info);
     return NULL;
 }
+
+GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
+                                   int64_t count, Error **errp)
+{
+    GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
+    GuestFileRead *read_data;
+
+    if (!gfh) {
+        return NULL;
+    }
+    if (!has_count) {
+        count =3D QGA_READ_COUNT_DEFAULT;
+    } else if (count < 0 || count >=3D UINT32_MAX) {
+        error_setg(errp, "value '%" PRId64 "' is invalid for argument coun=
t",
+                   count);
+        return NULL;
+    }
+
+    read_data =3D guest_file_read_unsafe(gfh, count, errp);
+    if (!read_data) {
+        slog("guest-file-write failed, handle: %" PRId64, handle);
+    }
+
+    return read_data;
+}
--=20
2.21.1


