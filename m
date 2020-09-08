Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A51FC2BC11
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF66C208FE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRLQSrMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF66C208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjz2-0005iU-1N
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoc-0001Tu-HU
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoY-0004Nn-RK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xnb1n7yJ5m6vxonSKwHghna0clPhBkqsEN/zaTo5Ouk=;
 b=SRLQSrMZE8go8dHPkWTj+16PlGIPYSsNLoltcGk1NQy+ml9WdQE5Kid6prMMMD+TEI3B3+
 /n1V3kFqOIetV47o40jIM9/tv50GDFSu2DAWUoduiVea92XoIGh85vQ6YBjXALhol6Z33W
 ZQGIa2FxxnSE/BaIaNigD79uIolCAmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-obflSZosM72M9co1FwICoA-1; Tue, 08 Sep 2020 16:01:48 -0400
X-MC-Unique: obflSZosM72M9co1FwICoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D6318B9ED3;
 Tue,  8 Sep 2020 20:01:47 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C433D838AD;
 Tue,  8 Sep 2020 20:01:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 15/34] chardev: Rename TYPE_CHARDEV_* to TYPE_*_CHARDEV
Date: Tue,  8 Sep 2020 16:01:04 -0400
Message-Id: <20200908200123.3402311-16-ehabkost@redhat.com>
In-Reply-To: <20200908200123.3402311-1-ehabkost@redhat.com>
References: <20200908200123.3402311-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the TYPE_* constants consistent with the name of
most type checking macros we have today.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200902224311.1321159-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 chardev/chardev-internal.h       |  4 ++--
 include/chardev/char-fd.h        |  4 ++--
 include/chardev/char-win-stdio.h |  2 +-
 include/chardev/char-win.h       |  4 ++--
 include/chardev/char.h           | 30 +++++++++++++++---------------
 include/chardev/spice.h          |  8 ++++----
 chardev/baum.c                   |  6 +++---
 chardev/char-console.c           |  4 ++--
 chardev/char-fd.c                |  2 +-
 chardev/char-file.c              |  6 +++---
 chardev/char-mux.c               |  2 +-
 chardev/char-null.c              |  2 +-
 chardev/char-parallel.c          |  4 ++--
 chardev/char-pipe.c              |  6 +++---
 chardev/char-pty.c               |  4 ++--
 chardev/char-ringbuf.c           |  8 ++++----
 chardev/char-serial.c            |  6 +++---
 chardev/char-socket.c            |  4 ++--
 chardev/char-stdio.c             |  6 +++---
 chardev/char-udp.c               |  4 ++--
 chardev/char-win-stdio.c         |  4 ++--
 chardev/char-win.c               |  2 +-
 chardev/char.c                   |  2 +-
 chardev/msmouse.c                |  6 +++---
 chardev/spice.c                  | 10 +++++-----
 chardev/testdev.c                |  6 +++---
 chardev/wctablet.c               |  6 +++---
 gdbstub.c                        |  6 +++---
 hw/display/vhost-user-gpu.c      |  2 +-
 tests/test-char.c                |  4 ++--
 ui/console.c                     |  8 ++++----
 ui/gtk.c                         |  6 +++---
 ui/spice-app.c                   | 10 +++++-----
 33 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index aba0240759..832dc10a95 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -55,9 +55,9 @@ struct MuxChardev {
 typedef struct MuxChardev MuxChardev;
 
 DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
-                         TYPE_CHARDEV_MUX)
+                         TYPE_MUX_CHARDEV)
 #define CHARDEV_IS_MUX(chr)                             \
-    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
+    object_dynamic_cast(OBJECT(chr), TYPE_MUX_CHARDEV)
 
 void mux_set_focus(Chardev *chr, int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
index 9de0e440de..14c664fc83 100644
--- a/include/chardev/char-fd.h
+++ b/include/chardev/char-fd.h
@@ -36,10 +36,10 @@ struct FDChardev {
 };
 typedef struct FDChardev FDChardev;
 
-#define TYPE_CHARDEV_FD "chardev-fd"
+#define TYPE_FD_CHARDEV "chardev-fd"
 
 DECLARE_INSTANCE_CHECKER(FDChardev, FD_CHARDEV,
-                         TYPE_CHARDEV_FD)
+                         TYPE_FD_CHARDEV)
 
 void qemu_chr_open_fd(Chardev *chr, int fd_in, int fd_out);
 int qmp_chardev_open_file_source(char *src, int flags, Error **errp);
diff --git a/include/chardev/char-win-stdio.h b/include/chardev/char-win-stdio.h
index d7314f734d..139dfbe92f 100644
--- a/include/chardev/char-win-stdio.h
+++ b/include/chardev/char-win-stdio.h
@@ -24,6 +24,6 @@
 #ifndef CHAR_WIN_STDIO_H
 #define CHAR_WIN_STDIO_H
 
-#define TYPE_CHARDEV_WIN_STDIO "chardev-win-stdio"
+#define TYPE_WIN_STDIO_CHARDEV "chardev-win-stdio"
 
 #endif /* CHAR_WIN_STDIO_H */
diff --git a/include/chardev/char-win.h b/include/chardev/char-win.h
index 485521469c..a1745ba267 100644
--- a/include/chardev/char-win.h
+++ b/include/chardev/char-win.h
@@ -43,9 +43,9 @@ typedef struct WinChardev WinChardev;
 #define NSENDBUF 2048
 #define NRECVBUF 2048
 
-#define TYPE_CHARDEV_WIN "chardev-win"
+#define TYPE_WIN_CHARDEV "chardev-win"
 DECLARE_INSTANCE_CHECKER(WinChardev, WIN_CHARDEV,
-                         TYPE_CHARDEV_WIN)
+                         TYPE_WIN_CHARDEV)
 
 void win_chr_set_file(Chardev *chr, HANDLE file, bool keep_open);
 int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp);
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 5874de57ea..0f358a4eee 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -230,24 +230,24 @@ typedef struct ChardevClass ChardevClass;
 DECLARE_OBJ_CHECKERS(Chardev, ChardevClass,
                      CHARDEV, TYPE_CHARDEV)
 
-#define TYPE_CHARDEV_NULL "chardev-null"
-#define TYPE_CHARDEV_MUX "chardev-mux"
-#define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
-#define TYPE_CHARDEV_PTY "chardev-pty"
-#define TYPE_CHARDEV_CONSOLE "chardev-console"
-#define TYPE_CHARDEV_STDIO "chardev-stdio"
-#define TYPE_CHARDEV_PIPE "chardev-pipe"
-#define TYPE_CHARDEV_MEMORY "chardev-memory"
-#define TYPE_CHARDEV_PARALLEL "chardev-parallel"
-#define TYPE_CHARDEV_FILE "chardev-file"
-#define TYPE_CHARDEV_SERIAL "chardev-serial"
-#define TYPE_CHARDEV_SOCKET "chardev-socket"
-#define TYPE_CHARDEV_UDP "chardev-udp"
+#define TYPE_NULL_CHARDEV "chardev-null"
+#define TYPE_MUX_CHARDEV "chardev-mux"
+#define TYPE_RINGBUF_CHARDEV "chardev-ringbuf"
+#define TYPE_PTY_CHARDEV "chardev-pty"
+#define TYPE_CONSOLE_CHARDEV "chardev-console"
+#define TYPE_STDIO_CHARDEV "chardev-stdio"
+#define TYPE_PIPE_CHARDEV "chardev-pipe"
+#define TYPE_MEMORY_CHARDEV "chardev-memory"
+#define TYPE_PARALLEL_CHARDEV "chardev-parallel"
+#define TYPE_FILE_CHARDEV "chardev-file"
+#define TYPE_SERIAL_CHARDEV "chardev-serial"
+#define TYPE_SOCKET_CHARDEV "chardev-socket"
+#define TYPE_UDP_CHARDEV "chardev-udp"
 
 #define CHARDEV_IS_RINGBUF(chr) \
-    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
+    object_dynamic_cast(OBJECT(chr), TYPE_RINGBUF_CHARDEV)
 #define CHARDEV_IS_PTY(chr) \
-    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_PTY)
+    object_dynamic_cast(OBJECT(chr), TYPE_PTY_CHARDEV)
 
 struct ChardevClass {
     ObjectClass parent_class;
diff --git a/include/chardev/spice.h b/include/chardev/spice.h
index 99f26aedde..302573b582 100644
--- a/include/chardev/spice.h
+++ b/include/chardev/spice.h
@@ -17,12 +17,12 @@ struct SpiceChardev {
 };
 typedef struct SpiceChardev SpiceChardev;
 
-#define TYPE_CHARDEV_SPICE "chardev-spice"
-#define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
-#define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"
+#define TYPE_SPICE_CHARDEV "chardev-spice"
+#define TYPE_SPICEVMC_CHARDEV "chardev-spicevmc"
+#define TYPE_SPICEPORT_CHARDEV "chardev-spiceport"
 
 DECLARE_INSTANCE_CHECKER(SpiceChardev, SPICE_CHARDEV,
-                         TYPE_CHARDEV_SPICE)
+                         TYPE_SPICE_CHARDEV)
 
 void qemu_chr_open_spice_port(Chardev *chr, ChardevBackend *backend,
                               bool *be_opened, Error **errp);
diff --git a/chardev/baum.c b/chardev/baum.c
index 5deca778bc..d6c9f698c1 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -104,9 +104,9 @@ struct BaumChardev {
 };
 typedef struct BaumChardev BaumChardev;
 
-#define TYPE_CHARDEV_BRAILLE "chardev-braille"
+#define TYPE_BRAILLE_CHARDEV "chardev-braille"
 DECLARE_INSTANCE_CHECKER(BaumChardev, BAUM_CHARDEV,
-                         TYPE_CHARDEV_BRAILLE)
+                         TYPE_BRAILLE_CHARDEV)
 
 /* Let's assume NABCC by default */
 enum way {
@@ -674,7 +674,7 @@ static void char_braille_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_braille_type_info = {
-    .name = TYPE_CHARDEV_BRAILLE,
+    .name = TYPE_BRAILLE_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(BaumChardev),
     .instance_finalize = char_braille_finalize,
diff --git a/chardev/char-console.c b/chardev/char-console.c
index 6c4ce5dbce..5d175389fd 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -42,8 +42,8 @@ static void char_console_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_console_type_info = {
-    .name = TYPE_CHARDEV_CONSOLE,
-    .parent = TYPE_CHARDEV_WIN,
+    .name = TYPE_CONSOLE_CHARDEV,
+    .parent = TYPE_WIN_CHARDEV,
     .class_init = char_console_class_init,
 };
 
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index c2d8101106..031fe2a2d6 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -154,7 +154,7 @@ static void char_fd_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_fd_type_info = {
-    .name = TYPE_CHARDEV_FD,
+    .name = TYPE_FD_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(FDChardev),
     .instance_finalize = char_fd_finalize,
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 2fd80707e5..fc53bdb4aa 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -124,11 +124,11 @@ static void char_file_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_file_type_info = {
-    .name = TYPE_CHARDEV_FILE,
+    .name = TYPE_FILE_CHARDEV,
 #ifdef _WIN32
-    .parent = TYPE_CHARDEV_WIN,
+    .parent = TYPE_WIN_CHARDEV,
 #else
-    .parent = TYPE_CHARDEV_FD,
+    .parent = TYPE_FD_CHARDEV,
 #endif
     .class_init = char_file_class_init,
 };
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6f980bb836..8930b4d5e8 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -388,7 +388,7 @@ static void char_mux_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_mux_type_info = {
-    .name = TYPE_CHARDEV_MUX,
+    .name = TYPE_MUX_CHARDEV,
     .parent = TYPE_CHARDEV,
     .class_init = char_mux_class_init,
     .instance_size = sizeof(MuxChardev),
diff --git a/chardev/char-null.c b/chardev/char-null.c
index 1c6a2900f9..fcddd33452 100644
--- a/chardev/char-null.c
+++ b/chardev/char-null.c
@@ -42,7 +42,7 @@ static void char_null_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_null_type_info = {
-    .name = TYPE_CHARDEV_NULL,
+    .name = TYPE_NULL_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(Chardev),
     .class_init = char_null_class_init,
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 66e4589b2b..289c1b002c 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -58,7 +58,7 @@ struct ParallelChardev {
 typedef struct ParallelChardev ParallelChardev;
 
 DECLARE_INSTANCE_CHECKER(ParallelChardev, PARALLEL_CHARDEV,
-                         TYPE_CHARDEV_PARALLEL)
+                         TYPE_PARALLEL_CHARDEV)
 
 static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 {
@@ -303,7 +303,7 @@ static void char_parallel_finalize(Object *obj)
 }
 
 static const TypeInfo char_parallel_type_info = {
-    .name = TYPE_CHARDEV_PARALLEL,
+    .name = TYPE_PARALLEL_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(ParallelChardev),
     .instance_finalize = char_parallel_finalize,
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index fd12c9e63b..7458433256 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -179,11 +179,11 @@ static void char_pipe_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_pipe_type_info = {
-    .name = TYPE_CHARDEV_PIPE,
+    .name = TYPE_PIPE_CHARDEV,
 #ifdef _WIN32
-    .parent = TYPE_CHARDEV_WIN,
+    .parent = TYPE_WIN_CHARDEV,
 #else
-    .parent = TYPE_CHARDEV_FD,
+    .parent = TYPE_FD_CHARDEV,
 #endif
     .class_init = char_pipe_class_init,
 };
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index a2d1e7c985..9cf77596d2 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -46,7 +46,7 @@ struct PtyChardev {
 typedef struct PtyChardev PtyChardev;
 
 DECLARE_INSTANCE_CHECKER(PtyChardev, PTY_CHARDEV,
-                         TYPE_CHARDEV_PTY)
+                         TYPE_PTY_CHARDEV)
 
 static void pty_chr_state(Chardev *chr, int connected);
 
@@ -240,7 +240,7 @@ static void char_pty_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_pty_type_info = {
-    .name = TYPE_CHARDEV_PTY,
+    .name = TYPE_PTY_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(PtyChardev),
     .instance_finalize = char_pty_finalize,
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index d40d21d3cf..edeb7daeae 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -43,7 +43,7 @@ struct RingBufChardev {
 typedef struct RingBufChardev RingBufChardev;
 
 DECLARE_INSTANCE_CHECKER(RingBufChardev, RINGBUF_CHARDEV,
-                         TYPE_CHARDEV_RINGBUF)
+                         TYPE_RINGBUF_CHARDEV)
 
 static size_t ringbuf_count(const Chardev *chr)
 {
@@ -233,7 +233,7 @@ static void char_ringbuf_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_ringbuf_type_info = {
-    .name = TYPE_CHARDEV_RINGBUF,
+    .name = TYPE_RINGBUF_CHARDEV,
     .parent = TYPE_CHARDEV,
     .class_init = char_ringbuf_class_init,
     .instance_size = sizeof(RingBufChardev),
@@ -242,8 +242,8 @@ static const TypeInfo char_ringbuf_type_info = {
 
 /* Bug-compatibility: */
 static const TypeInfo char_memory_type_info = {
-    .name = TYPE_CHARDEV_MEMORY,
-    .parent = TYPE_CHARDEV_RINGBUF,
+    .name = TYPE_MEMORY_CHARDEV,
+    .parent = TYPE_RINGBUF_CHARDEV,
 };
 
 static void register_types(void)
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 7c3d84ae24..381107bd89 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -308,11 +308,11 @@ static void char_serial_class_init(ObjectClass *oc, void *data)
 
 
 static const TypeInfo char_serial_type_info = {
-    .name = TYPE_CHARDEV_SERIAL,
+    .name = TYPE_SERIAL_CHARDEV,
 #ifdef _WIN32
-    .parent = TYPE_CHARDEV_WIN,
+    .parent = TYPE_WIN_CHARDEV,
 #else
-    .parent = TYPE_CHARDEV_FD,
+    .parent = TYPE_FD_CHARDEV,
 #endif
     .class_init = char_serial_class_init,
 };
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 95e45812d5..bb5ddc586c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -89,7 +89,7 @@ struct SocketChardev {
 typedef struct SocketChardev SocketChardev;
 
 DECLARE_INSTANCE_CHECKER(SocketChardev, SOCKET_CHARDEV,
-                         TYPE_CHARDEV_SOCKET)
+                         TYPE_SOCKET_CHARDEV)
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
 static void tcp_chr_telnet_init(Chardev *chr);
@@ -1506,7 +1506,7 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_socket_type_info = {
-    .name = TYPE_CHARDEV_SOCKET,
+    .name = TYPE_SOCKET_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(SocketChardev),
     .instance_finalize = char_socket_finalize,
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 82eaebc1db..fb28eaeb87 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -150,11 +150,11 @@ static void char_stdio_finalize(Object *obj)
 }
 
 static const TypeInfo char_stdio_type_info = {
-    .name = TYPE_CHARDEV_STDIO,
+    .name = TYPE_STDIO_CHARDEV,
 #ifdef _WIN32
-    .parent = TYPE_CHARDEV_WIN_STDIO,
+    .parent = TYPE_WIN_STDIO_CHARDEV,
 #else
-    .parent = TYPE_CHARDEV_FD,
+    .parent = TYPE_FD_CHARDEV,
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 16b5dbce58..6d7b9d2805 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -46,7 +46,7 @@ struct UdpChardev {
 typedef struct UdpChardev UdpChardev;
 
 DECLARE_INSTANCE_CHECKER(UdpChardev, UDP_CHARDEV,
-                         TYPE_CHARDEV_UDP)
+                         TYPE_UDP_CHARDEV)
 
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
@@ -231,7 +231,7 @@ static void char_udp_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_udp_type_info = {
-    .name = TYPE_CHARDEV_UDP,
+    .name = TYPE_UDP_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(UdpChardev),
     .instance_finalize = char_udp_finalize,
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index a4771ab82e..f333b8cedc 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -41,7 +41,7 @@ struct WinStdioChardev {
 typedef struct WinStdioChardev WinStdioChardev;
 
 DECLARE_INSTANCE_CHECKER(WinStdioChardev, WIN_STDIO_CHARDEV,
-                         TYPE_CHARDEV_WIN_STDIO)
+                         TYPE_WIN_STDIO_CHARDEV)
 
 static void win_stdio_wait_func(void *opaque)
 {
@@ -255,7 +255,7 @@ static void char_win_stdio_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_win_stdio_type_info = {
-    .name = TYPE_CHARDEV_WIN_STDIO,
+    .name = TYPE_WIN_STDIO_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(WinStdioChardev),
     .instance_finalize = char_win_stdio_finalize,
diff --git a/chardev/char-win.c b/chardev/char-win.c
index d4fb44c4dc..69dcf48873 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -228,7 +228,7 @@ static void char_win_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_win_type_info = {
-    .name = TYPE_CHARDEV_WIN,
+    .name = TYPE_WIN_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(WinChardev),
     .instance_finalize = char_win_finalize,
diff --git a/chardev/char.c b/chardev/char.c
index 77e7ec814f..afebdc345e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -674,7 +674,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
         backend->type = CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data = g_new0(ChardevMux, 1);
         backend->u.mux.data->chardev = g_strdup(bid);
-        mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context, errp);
+        mux = qemu_chardev_new(id, TYPE_MUX_CHARDEV, backend, context, errp);
         if (mux == NULL) {
             object_unparent(OBJECT(chr));
             chr = NULL;
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index eb9231dcdb..4033ca714d 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -44,9 +44,9 @@ struct MouseChardev {
 };
 typedef struct MouseChardev MouseChardev;
 
-#define TYPE_CHARDEV_MSMOUSE "chardev-msmouse"
+#define TYPE_MSMOUSE_CHARDEV "chardev-msmouse"
 DECLARE_INSTANCE_CHECKER(MouseChardev, MOUSE_CHARDEV,
-                         TYPE_CHARDEV_MSMOUSE)
+                         TYPE_MSMOUSE_CHARDEV)
 
 static void msmouse_chr_accept_input(Chardev *chr)
 {
@@ -178,7 +178,7 @@ static void char_msmouse_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_msmouse_type_info = {
-    .name = TYPE_CHARDEV_MSMOUSE,
+    .name = TYPE_MSMOUSE_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(MouseChardev),
     .instance_finalize = char_msmouse_finalize,
diff --git a/chardev/spice.c b/chardev/spice.c
index bf7ea1e294..7423001b71 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -376,7 +376,7 @@ static void char_spice_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_spice_type_info = {
-    .name = TYPE_CHARDEV_SPICE,
+    .name = TYPE_SPICE_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(SpiceChardev),
     .instance_finalize = char_spice_finalize,
@@ -394,8 +394,8 @@ static void char_spicevmc_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_spicevmc_type_info = {
-    .name = TYPE_CHARDEV_SPICEVMC,
-    .parent = TYPE_CHARDEV_SPICE,
+    .name = TYPE_SPICEVMC_CHARDEV,
+    .parent = TYPE_SPICE_CHARDEV,
     .class_init = char_spicevmc_class_init,
 };
 
@@ -409,8 +409,8 @@ static void char_spiceport_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_spiceport_type_info = {
-    .name = TYPE_CHARDEV_SPICEPORT,
-    .parent = TYPE_CHARDEV_SPICE,
+    .name = TYPE_SPICEPORT_CHARDEV,
+    .parent = TYPE_SPICE_CHARDEV,
     .class_init = char_spiceport_class_init,
 };
 
diff --git a/chardev/testdev.c b/chardev/testdev.c
index a92caca3c3..5ef9a59817 100644
--- a/chardev/testdev.c
+++ b/chardev/testdev.c
@@ -39,9 +39,9 @@ struct TestdevChardev {
 };
 typedef struct TestdevChardev TestdevChardev;
 
-#define TYPE_CHARDEV_TESTDEV "chardev-testdev"
+#define TYPE_TESTDEV_CHARDEV "chardev-testdev"
 DECLARE_INSTANCE_CHECKER(TestdevChardev, TESTDEV_CHARDEV,
-                         TYPE_CHARDEV_TESTDEV)
+                         TYPE_TESTDEV_CHARDEV)
 
 /* Try to interpret a whole incoming packet */
 static int testdev_eat_packet(TestdevChardev *testdev)
@@ -118,7 +118,7 @@ static void char_testdev_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_testdev_type_info = {
-    .name = TYPE_CHARDEV_TESTDEV,
+    .name = TYPE_TESTDEV_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(TestdevChardev),
     .class_init = char_testdev_class_init,
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 95e005f5a5..2cc018efb3 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -85,9 +85,9 @@ struct TabletChardev {
 };
 typedef struct TabletChardev TabletChardev;
 
-#define TYPE_CHARDEV_WCTABLET "chardev-wctablet"
+#define TYPE_WCTABLET_CHARDEV "chardev-wctablet"
 DECLARE_INSTANCE_CHECKER(TabletChardev, WCTABLET_CHARDEV,
-                         TYPE_CHARDEV_WCTABLET)
+                         TYPE_WCTABLET_CHARDEV)
 
 
 static void wctablet_chr_accept_input(Chardev *chr);
@@ -352,7 +352,7 @@ static void wctablet_chr_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo wctablet_type_info = {
-    .name = TYPE_CHARDEV_WCTABLET,
+    .name = TYPE_WCTABLET_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(TabletChardev),
     .instance_finalize = wctablet_chr_finalize,
diff --git a/gdbstub.c b/gdbstub.c
index 9dfb6e4142..7afdcf0f37 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3301,10 +3301,10 @@ static void char_gdb_class_init(ObjectClass *oc, void *data)
     cc->chr_write = gdb_monitor_write;
 }
 
-#define TYPE_CHARDEV_GDB "chardev-gdb"
+#define TYPE_GDB_CHARDEV "chardev-gdb"
 
 static const TypeInfo char_gdb_type_info = {
-    .name = TYPE_CHARDEV_GDB,
+    .name = TYPE_GDB_CHARDEV,
     .parent = TYPE_CHARDEV,
     .class_init = char_gdb_class_init,
 };
@@ -3409,7 +3409,7 @@ int gdbserver_start(const char *device)
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
         /* Initialize a monitor terminal for gdb */
-        mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
+        mon_chr = qemu_chardev_new(NULL, TYPE_GDB_CHARDEV,
                                    NULL, NULL, &error_abort);
         monitor_init_hmp(mon_chr, false, &error_abort);
     } else {
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 51f1747c4a..f656fb38a7 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -388,7 +388,7 @@ vhost_user_gpu_do_set_socket(VhostUserGPU *g, Error **errp)
         return false;
     }
 
-    chr = CHARDEV(object_new(TYPE_CHARDEV_SOCKET));
+    chr = CHARDEV(object_new(TYPE_SOCKET_CHARDEV));
     if (!chr || qemu_chr_add_client(chr, sv[0]) == -1) {
         error_setg(errp, "Failed to make socket chardev");
         goto err;
diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc..2b2135ec77 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1232,7 +1232,7 @@ static void char_file_fifo_test(void)
     ret = write(fd, "fifo-in", 8);
     g_assert_cmpint(ret, ==, 8);
 
-    chr = qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
+    chr = qemu_chardev_new("label-file", TYPE_FILE_CHARDEV, &backend,
                            NULL, &error_abort);
 
     qemu_chr_fe_init(&be, chr, &error_abort);
@@ -1286,7 +1286,7 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
     } else {
         out = g_build_filename(tmp_path, "out", NULL);
         file.out = out;
-        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+        chr = qemu_chardev_new(NULL, TYPE_FILE_CHARDEV, &backend,
                                NULL, &error_abort);
     }
     ret = qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
diff --git a/ui/console.c b/ui/console.c
index f8d7643fe4..965f01e804 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1089,9 +1089,9 @@ struct VCChardev {
 };
 typedef struct VCChardev VCChardev;
 
-#define TYPE_CHARDEV_VC "chardev-vc"
+#define TYPE_VC_CHARDEV "chardev-vc"
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
-                         TYPE_CHARDEV_VC)
+                         TYPE_VC_CHARDEV)
 
 static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
@@ -2403,7 +2403,7 @@ static void char_vc_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_vc_type_info = {
-    .name = TYPE_CHARDEV_VC,
+    .name = TYPE_VC_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VCChardev),
     .class_init = char_vc_class_init,
@@ -2412,7 +2412,7 @@ static const TypeInfo char_vc_type_info = {
 void qemu_console_early_init(void)
 {
     /* set the default vc driver */
-    if (!object_class_by_name(TYPE_CHARDEV_VC)) {
+    if (!object_class_by_name(TYPE_VC_CHARDEV)) {
         type_register(&char_vc_type_info);
     }
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index 1c59de2af4..2734f88e78 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -178,9 +178,9 @@ struct VCChardev {
 };
 typedef struct VCChardev VCChardev;
 
-#define TYPE_CHARDEV_VC "chardev-vc"
+#define TYPE_VC_CHARDEV "chardev-vc"
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
-                         TYPE_CHARDEV_VC)
+                         TYPE_VC_CHARDEV)
 
 bool gtk_use_gl_area;
 
@@ -1743,7 +1743,7 @@ static void char_gd_vc_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_gd_vc_type_info = {
-    .name = TYPE_CHARDEV_VC,
+    .name = TYPE_VC_CHARDEV,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VCChardev),
     .class_init = char_gd_vc_class_init,
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 93e105c6ee..e69dc21c78 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -46,9 +46,9 @@ struct VCChardev {
 };
 typedef struct VCChardev VCChardev;
 
-#define TYPE_CHARDEV_VC "chardev-vc"
+#define TYPE_VC_CHARDEV "chardev-vc"
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
-                         TYPE_CHARDEV_VC)
+                         TYPE_VC_CHARDEV)
 
 static ChardevBackend *
 chr_spice_backend_new(void)
@@ -99,8 +99,8 @@ static void char_vc_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_vc_type_info = {
-    .name = TYPE_CHARDEV_VC,
-    .parent = TYPE_CHARDEV_SPICEPORT,
+    .name = TYPE_VC_CHARDEV,
+    .parent = TYPE_SPICEPORT_CHARDEV,
     .instance_size = sizeof(VCChardev),
     .class_init = char_vc_class_init,
 };
@@ -166,7 +166,7 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     display_opengl = opts->has_gl;
 #endif
     be->u.spiceport.data->fqdn = g_strdup("org.qemu.monitor.qmp.0");
-    qemu_chardev_new("org.qemu.monitor.qmp", TYPE_CHARDEV_SPICEPORT,
+    qemu_chardev_new("org.qemu.monitor.qmp", TYPE_SPICEPORT_CHARDEV,
                      be, NULL, &error_abort);
     qopts = qemu_opts_create(qemu_find_opts("mon"),
                              NULL, 0, &error_fatal);
-- 
2.26.2


