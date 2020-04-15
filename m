Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE91C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DDB2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DDB2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWUG-0006QH-BW
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOx-0000ve-BV
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOv-000504-T0
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:38 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:48988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWOv-0004xx-Kz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:37 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 5BD0F30747C2; Wed, 15 Apr 2020 03:59:34 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 44546305B7A3;
 Wed, 15 Apr 2020 03:59:34 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 04/26] char-socket: add 'reconnecting' property
Date: Wed, 15 Apr 2020 03:59:16 +0300
Message-Id: <20200415005938.23895-5-alazar@bitdefender.com>
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

This is used by the VM introspection object to check if the connection
will be reestablished in case it disconnects from some reason.

The closing of the socket is used by any of the three parties involved,
KVM, the introspection tool and QEMU (eg. on force-reset), to signal
the other parties that the session is over. As such, it is very important
that the socket will reconnect.

CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 chardev/char-socket.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index fd0106ab85..22ab242748 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1492,6 +1492,13 @@ char_socket_get_connected(Object *obj, Error **err=
p)
     return s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
 }
=20
+static bool char_socket_get_reconnecting(Object *obj, Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(obj);
+
+    return s->reconnect_time > 0;
+}
+
 static int tcp_chr_reconnect_time(Chardev *chr, int secs)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
@@ -1528,6 +1535,10 @@ static void char_socket_class_init(ObjectClass *oc=
, void *data)
=20
     object_class_property_add_bool(oc, "connected", char_socket_get_conn=
ected,
                                    NULL, &error_abort);
+
+    object_class_property_add_bool(oc, "reconnecting",
+                                   char_socket_get_reconnecting,
+                                   NULL, &error_abort);
 }
=20
 static const TypeInfo char_socket_type_info =3D {

