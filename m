Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792A2C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434C32076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFZWO388"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434C32076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjt8-0004Iv-CE
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jOjs3-0002se-EI
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jOjs2-00028z-7P
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:35 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jOjs2-00028p-2M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:34 -0400
Received: by mail-ot1-x32d.google.com with SMTP id g14so227464otg.10
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KceTHV7pQV4klqcfJPr/8hOIvfOLjh6kumuldohc+h0=;
 b=mFZWO388M5tPoR70k5KxMVY6wdzTuIrvBaX6IPOc0MMD+J5lL+K/LptxMBsUFKmvKO
 xnLfAb2SacxLgYOfehGj+VUXdqzodyMnIuoJHLFMRyWXOTqsWbZcFtA1duCuzWOqYJNq
 9wWJ+gTaOIQIuXW+oz3lcBDiaradvvBZnvOSY5MF0J8+AVjNP3A6mUZZbuMD9NQTsMos
 9VMnAv2uC7C7MD0sEBw5gtvTlkYuRkHupLG+0UseHJNovx31n0kwKR+dhHm0usq2Z8tk
 FWP843MdCkP2DsaPc33PRF4YB4jnheXkGCa7GntkADMb+7fpcnh2hJe6r4YSAeVg9+NT
 +wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KceTHV7pQV4klqcfJPr/8hOIvfOLjh6kumuldohc+h0=;
 b=oSjUB85LyhWEWQ8+ANXrAUZTiaL6OZnextj42g5HTBm7UasbnIwzCnSZKOeR0bXJTD
 yz2mi+mks0UplCI7TaFMe0VXHKt1mTr6m58Sc28+pRtKdX+a8d/QoBo3v9karlE2nNlp
 QwOIvGWJHzX1cpKfHO4Hx+YZicN31a1yXZ6ogWQPKuEi0N7/0FSwVOHqRl1dDiLmLyY5
 vgLpfZ4nVkkjWdSgbi44OXvQSRjBH/ed5rI4qQ8/JXTLlkLUtQvj84lPYiPEI04KBIxD
 HBYhy4htoYJdGlceTbpRb6FXqC3fPMbRiCvevalSAGzjcls4W+lfJhr95l6hQT+5faAl
 a8nw==
X-Gm-Message-State: AGi0PubGLOUeMypIoIedvLjKF1g26g13XF0sbNQpyFpIqTmXp8BSDca4
 7sWvHBoGbw3ZDmNxiCzkaoUe0n6fdAA=
X-Google-Smtp-Source: APiQypK/NDLJUi/U09XM6MWR63nqpQvi7s/SsuzdGMMXf8pAq9bQMyzi6yryoQytTSB85lU03H6DLg==
X-Received: by 2002:a9d:1a6:: with SMTP id e35mr5915796ote.240.1586964152993; 
 Wed, 15 Apr 2020 08:22:32 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c13sm1902320otf.35.2020.04.15.08.22.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Apr 2020 08:22:32 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 3/4] qga: Extract qmp_guest_file_read() to common
 commands.c
Date: Wed, 15 Apr 2020 10:22:01 -0500
Message-Id: <20200415152202.14463-4-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
References: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Extract the common code shared by both POSIX/Win32 implementations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
 
 GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp);
 
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp);
+
 #endif
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index c59c32185c..a52af0315f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -461,29 +461,14 @@ void qmp_guest_file_close(int64_t handle, Error **errp)
     g_free(gfh);
 }
 
-struct GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
-                                          int64_t count, Error **errp)
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp)
 {
-    GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
     GuestFileRead *read_data = NULL;
     guchar *buf;
-    FILE *fh;
+    FILE *fh = gfh->fh;
     size_t read_count;
 
-    if (!gfh) {
-        return NULL;
-    }
-
-    if (!has_count) {
-        count = QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >= UINT32_MAX) {
-        error_setg(errp, "value '%" PRId64 "' is invalid for argument count",
-                   count);
-        return NULL;
-    }
-
-    fh = gfh->fh;
-
     /* explicitly flush when switching from writing to reading */
     if (gfh->state == RW_STATE_WRITING) {
         int ret = fflush(fh);
@@ -498,7 +483,6 @@ struct GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
     read_count = fread(buf, 1, count, fh);
     if (ferror(fh)) {
         error_setg_errno(errp, errno, "failed to read file");
-        slog("guest-file-read failed, handle: %" PRId64, handle);
     } else {
         buf[read_count] = 0;
         read_data = g_new0(GuestFileRead, 1);
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index cfaf6b84b8..9717a8d52d 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -322,33 +322,19 @@ void qmp_guest_shutdown(bool has_mode, const char *mode, Error **errp)
     }
 }
 
-GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
-                                   int64_t count, Error **errp)
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp)
 {
     GuestFileRead *read_data = NULL;
     guchar *buf;
-    HANDLE fh;
+    HANDLE fh = gfh->fh;
     bool is_ok;
     DWORD read_count;
-    GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
-
-    if (!gfh) {
-        return NULL;
-    }
-    if (!has_count) {
-        count = QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >= UINT32_MAX) {
-        error_setg(errp, "value '%" PRId64
-                   "' is invalid for argument count", count);
-        return NULL;
-    }
 
-    fh = gfh->fh;
     buf = g_malloc0(count + 1);
     is_ok = ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
-        slog("guest-file-read failed, handle %" PRId64, handle);
     } else {
         buf[read_count] = 0;
         read_data = g_new0(GuestFileRead, 1);
diff --git a/qga/commands.c b/qga/commands.c
index 4471a9f08d..5611117372 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -18,6 +18,7 @@
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 #include "qemu/atomic.h"
+#include "commands-common.h"
 
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
+    GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
+    GuestFileRead *read_data;
+
+    if (!gfh) {
+        return NULL;
+    }
+    if (!has_count) {
+        count = QGA_READ_COUNT_DEFAULT;
+    } else if (count < 0 || count >= UINT32_MAX) {
+        error_setg(errp, "value '%" PRId64 "' is invalid for argument count",
+                   count);
+        return NULL;
+    }
+
+    read_data = guest_file_read_unsafe(gfh, count, errp);
+    if (!read_data) {
+        slog("guest-file-write failed, handle: %" PRId64, handle);
+    }
+
+    return read_data;
+}
-- 
2.17.1


