Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C704C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0F32072D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0F32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWVr-0008Jg-Cj
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP3-000141-9n
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOw-00050L-0j
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:45 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:48994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWOv-0004y1-Kp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:37 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 074CD30747BE; Wed, 15 Apr 2020 03:59:34 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id DD216305B7A0;
 Wed, 15 Apr 2020 03:59:33 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 01/26] chardev: tcp: allow to change the reconnect timer
Date: Wed, 15 Apr 2020 03:59:13 +0300
Message-Id: <20200415005938.23895-2-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the introspected VM is paused/suspended/migrated, the introspection
tool removes its hooks from the guest and closes the connection.
This is detected by KVM, which in turn will clean the introspection
structures. Thanks to the reconnect parameter, the chardev will reconnect
with the introspection tool, which will try to hook the VM again,
assuming that the pause/suspend/migration operation has ended.

With this new feature, we can suspend the reconnection.

CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 chardev/char-fe.c         | 11 +++++++++++
 chardev/char-socket.c     | 14 ++++++++++++++
 include/chardev/char-fe.h |  7 +++++++
 include/chardev/char.h    |  1 +
 4 files changed, 33 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3530a90e6..ac83528078 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -384,3 +384,14 @@ void qemu_chr_fe_disconnect(CharBackend *be)
         CHARDEV_GET_CLASS(chr)->chr_disconnect(chr);
     }
 }
+
+int qemu_chr_fe_reconnect_time(CharBackend *be, int secs)
+{
+    Chardev *chr =3D be->chr;
+
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_reconnect_time) {
+        return CHARDEV_GET_CLASS(chr)->chr_reconnect_time(chr, secs);
+    }
+
+    return -1;
+}
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..bd966aace1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1471,6 +1471,19 @@ char_socket_get_connected(Object *obj, Error **err=
p)
     return s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
 }
=20
+static int tcp_chr_reconnect_time(Chardev *chr, int secs)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    int old =3D s->reconnect_time;
+
+    if (secs >=3D 0) {
+        s->reconnect_time =3D secs;
+    }
+
+    return old;
+}
+
 static void char_socket_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
@@ -1481,6 +1494,7 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
     cc->chr_write =3D tcp_chr_write;
     cc->chr_sync_read =3D tcp_chr_sync_read;
     cc->chr_disconnect =3D tcp_chr_disconnect;
+    cc->chr_reconnect_time =3D tcp_chr_reconnect_time;
     cc->get_msgfds =3D tcp_get_msgfds;
     cc->set_msgfds =3D tcp_set_msgfds;
     cc->chr_add_client =3D tcp_chr_add_client;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index a553843364..ff1897040a 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -135,6 +135,13 @@ void qemu_chr_fe_accept_input(CharBackend *be);
  */
 void qemu_chr_fe_disconnect(CharBackend *be);
=20
+/**
+ * qemu_chr_fe_reconnect_time:
+ *
+ * Change the reconnect time and return the old value.
+ */
+int qemu_chr_fe_reconnect_time(CharBackend *be, int secs);
+
 /**
  * qemu_chr_fe_wait_connected:
  *
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 00589a6025..80204d43ae 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -270,6 +270,7 @@ typedef struct ChardevClass {
     int (*chr_add_client)(Chardev *chr, int fd);
     int (*chr_wait_connected)(Chardev *chr, Error **errp);
     void (*chr_disconnect)(Chardev *chr);
+    int (*chr_reconnect_time)(Chardev *be, int secs);
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);

