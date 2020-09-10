Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DDBC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0AB208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmCLHJb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0AB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGScM-00011m-Ac
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZl-0003vO-21
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZj-0000bC-AB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jZLnLTQJNdWJTI+v3xFFNgHXfxyVCGfTNuu+LgRjlk=;
 b=LmCLHJb3B66Ytv2uWltUH/bseXWvvmPOQsWG6iJX1vDWgDOj0MbI0uyHzb3KdQ+uoDyBlB
 ShbHJc2rlX5S1Jn13wIqb5FzUQRNvs24+Zcu+oWjKWoOPkAbROm91JqQrvfkYPXPKKtOEw
 gOVa0jz79EjdQfA1EMFWqfgMgEB15mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-HEo0YXVhPIG2tGypR0Kb3g-1; Thu, 10 Sep 2020 15:49:40 -0400
X-MC-Unique: HEo0YXVhPIG2tGypR0Kb3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF160801AF2;
 Thu, 10 Sep 2020 19:49:39 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 968E97E8F9;
 Thu, 10 Sep 2020 19:49:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/18] chardev: Rename FD_CHARDEV to CHARDEV_FD
Date: Thu, 10 Sep 2020 15:48:51 -0400
Message-Id: <20200910194903.4104696-7-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename instance and class type checkers to match the
TYPE_CHARDEV_* constant names and the QOM type name strings
("chardev-*").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/chardev/char-fd.h |  2 +-
 chardev/char-fd.c         | 14 +++++++-------
 chardev/char-serial.c     |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
index 9de0e440de..707f7f1700 100644
--- a/include/chardev/char-fd.h
+++ b/include/chardev/char-fd.h
@@ -38,7 +38,7 @@ typedef struct FDChardev FDChardev;
 
 #define TYPE_CHARDEV_FD "chardev-fd"
 
-DECLARE_INSTANCE_CHECKER(FDChardev, FD_CHARDEV,
+DECLARE_INSTANCE_CHECKER(FDChardev, CHARDEV_FD,
                          TYPE_CHARDEV_FD)
 
 void qemu_chr_open_fd(Chardev *chr, int fd_in, int fd_out);
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index c2d8101106..b1701c4e4a 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -36,7 +36,7 @@
 /* Called with chr_write_lock held.  */
 static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    FDChardev *s = FD_CHARDEV(chr);
+    FDChardev *s = CHARDEV_FD(chr);
 
     return io_channel_send(s->ioc_out, buf, len);
 }
@@ -44,7 +44,7 @@ static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
 static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    FDChardev *s = FD_CHARDEV(opaque);
+    FDChardev *s = CHARDEV_FD(opaque);
     int len;
     uint8_t buf[CHR_READ_BUF_LEN];
     ssize_t ret;
@@ -74,7 +74,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 static int fd_chr_read_poll(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    FDChardev *s = FD_CHARDEV(opaque);
+    FDChardev *s = CHARDEV_FD(opaque);
 
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -82,13 +82,13 @@ static int fd_chr_read_poll(void *opaque)
 
 static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    FDChardev *s = FD_CHARDEV(chr);
+    FDChardev *s = CHARDEV_FD(chr);
     return qio_channel_create_watch(s->ioc_out, cond);
 }
 
 static void fd_chr_update_read_handler(Chardev *chr)
 {
-    FDChardev *s = FD_CHARDEV(chr);
+    FDChardev *s = CHARDEV_FD(chr);
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -102,7 +102,7 @@ static void fd_chr_update_read_handler(Chardev *chr)
 static void char_fd_finalize(Object *obj)
 {
     Chardev *chr = CHARDEV(obj);
-    FDChardev *s = FD_CHARDEV(obj);
+    FDChardev *s = CHARDEV_FD(obj);
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -130,7 +130,7 @@ int qmp_chardev_open_file_source(char *src, int flags, Error **errp)
 void qemu_chr_open_fd(Chardev *chr,
                       int fd_in, int fd_out)
 {
-    FDChardev *s = FD_CHARDEV(chr);
+    FDChardev *s = CHARDEV_FD(chr);
     char *name;
 
     s->ioc_in = QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 7c3d84ae24..de1705d2a8 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -178,7 +178,7 @@ static void tty_serial_init(int fd, int speed,
 
 static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    FDChardev *s = FD_CHARDEV(chr);
+    FDChardev *s = CHARDEV_FD(chr);
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc_in);
 
     switch (cmd) {
-- 
2.26.2


