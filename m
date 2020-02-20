Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D244FC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC6F2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IouBvzK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6F2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4euV-0005Tm-Q9
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 01:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j4eto-0004oT-NT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j4etn-0002hm-8D
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:01:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j4etn-0002hb-54
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582178482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UcmGmhawV5bGRFE7RaCRGF/3Tx0kPvxDecpGECUdhFI=;
 b=IouBvzK+qH3C7R8BVIMo2fJoYqDafbdvKkEtUZrguTJFyfAEWG1K7G17hPoEp+U7b4cfFr
 23Vs6qhoPL/2XPA8Gs6DlFWIpyWzaJAkg7kdaIt+RuvHcyNJJFRz5qy1DnNsnnbBIPVan5
 LSZiPM6boNAKFny1+yWdabV6KDCcsds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-fCCiIVQJNcONjmJmKHcFXQ-1; Thu, 20 Feb 2020 01:01:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E51B8018A7;
 Thu, 20 Feb 2020 06:01:14 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-80.bne.redhat.com
 [10.64.54.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7123819C58;
 Thu, 20 Feb 2020 06:01:12 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH] hw/char/pl011: Output characters using best-effort mode
Date: Thu, 20 Feb 2020 17:01:08 +1100
Message-Id: <20200220060108.143668-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: fCCiIVQJNcONjmJmKHcFXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, shan.gavin@gmail.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, PL011 is used by ARM virt board by default. It's possible to
block the system from booting. With below parameters in command line, the
backend could run into endless attempts of transmitting packets, which
can't succeed because of running out of sending buffer. The socket might
be not accepted n server side. It's not correct because disconnected
serial port shouldn't stop the system from booting.

   -machine virt,gic-version=3D3 -cpu max -m 4096
   -monitor none -serial tcp:127.0.0.1:50900

The issue can be reproduced by starting a program which listens on TCP
port 50900 and then sleep without accepting any incoming connections. On
the other hand, a VM is started with above parameters and modified qemu
where the PL011 is flooded with 5000K data after it's created. Eventually,
the flooding won't proceed and stops after transmitting 2574K data. It's
basically to simulate tons of output from EDK-II and demonstrates how the
tons of output can block the system from booting.

This fixes the issue by using newly added API qemu_chr_fe_try_write_all(),
which provides another type of service (best-effort). It's different from
qemu_chr_fe_write_all() as the data will be dropped if the backend has
been running into so-called broken state or 50 attempts of transmissions.
The broken state is cleared if the data is transmitted at once.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 chardev/char-fe.c         | 15 +++++++++++++--
 chardev/char.c            | 20 ++++++++++++++------
 hw/char/pl011.c           |  5 +----
 include/chardev/char-fe.h | 14 ++++++++++++++
 include/chardev/char.h    |  6 ++++--
 5 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3530a90e6..6558fcfb94 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -39,7 +39,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf=
, int len)
         return 0;
     }
=20
-    return qemu_chr_write(s, buf, len, false);
+    return qemu_chr_write(s, buf, len, false, false);
 }
=20
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
@@ -50,7 +50,18 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t=
 *buf, int len)
         return 0;
     }
=20
-    return qemu_chr_write(s, buf, len, true);
+    return qemu_chr_write(s, buf, len, true, false);
+}
+
+int qemu_chr_fe_try_write_all(CharBackend *be, const uint8_t *buf, int len=
)
+{
+    Chardev *s =3D be->chr;
+
+    if (!s) {
+        return 0;
+    }
+
+    return qemu_chr_write(s, buf, len, true, true);
 }
=20
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
diff --git a/chardev/char.c b/chardev/char.c
index 87237568df..cd17fac123 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -106,9 +106,8 @@ static void qemu_chr_write_log(Chardev *s, const uint8_=
t *buf, size_t len)
     }
 }
=20
-static int qemu_chr_write_buffer(Chardev *s,
-                                 const uint8_t *buf, int len,
-                                 int *offset, bool write_all)
+static int qemu_chr_write_buffer(Chardev *s, const uint8_t *buf, int len,
+                                 int *offset, bool write_all, bool best_ef=
fort)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
     int res =3D 0;
@@ -119,7 +118,14 @@ static int qemu_chr_write_buffer(Chardev *s,
     retry:
         res =3D cc->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno =3D=3D EAGAIN && write_all) {
+            if (best_effort && s->retries > 50) {
+                break;
+            }
+
             g_usleep(100);
+            if (best_effort) {
+                s->retries++;
+            }
             goto retry;
         }
=20
@@ -127,6 +133,7 @@ static int qemu_chr_write_buffer(Chardev *s,
             break;
         }
=20
+        s->retries =3D 0;
         *offset +=3D res;
         if (!write_all) {
             break;
@@ -140,7 +147,8 @@ static int qemu_chr_write_buffer(Chardev *s,
     return res;
 }
=20
-int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all=
)
+int qemu_chr_write(Chardev *s, const uint8_t *buf, int len,
+                   bool write_all, bool best_effort)
 {
     int offset =3D 0;
     int res;
@@ -148,11 +156,11 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, in=
t len, bool write_all)
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
         replay_char_write_event_load(&res, &offset);
         assert(offset <=3D len);
-        qemu_chr_write_buffer(s, buf, offset, &offset, true);
+        qemu_chr_write_buffer(s, buf, offset, &offset, true, false);
         return res;
     }
=20
-    res =3D qemu_chr_write_buffer(s, buf, len, &offset, write_all);
+    res =3D qemu_chr_write_buffer(s, buf, len, &offset, write_all, best_ef=
fort);
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 13e784f9d9..348188f49e 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -179,11 +179,8 @@ static void pl011_write(void *opaque, hwaddr offset,
=20
     switch (offset >> 2) {
     case 0: /* UARTDR */
-        /* ??? Check if transmitter is enabled.  */
         ch =3D value;
-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        qemu_chr_fe_try_write_all(&s->chr, &ch, 1);
         s->int_level |=3D PL011_INT_TX;
         pl011_update(s);
         break;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index a553843364..18281ccfca 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -220,6 +220,20 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *=
buf, int len);
  */
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
=20
+/**
+ * qemu_chr_fe_try_write_all:
+ * @buf: the data
+ * @len: the number of bytes to send
+ *
+ * Write data to a character backend from the front end.  This function wi=
ll
+ * send data from the front end to the back end. It provides function as t=
o
+ * @qemu_chr_fe_write_all, except the data will be dropped after 50 attemp=
ts
+ * of transmissions are done.
+ *
+ * Returns: the number of bytes consumed (0 if no associated Chardev)
+ */
+int qemu_chr_fe_try_write_all(CharBackend *be, const uint8_t *buf, int len=
);
+
 /**
  * qemu_chr_fe_read_all:
  * @buf: the data buffer
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 00589a6025..425a007a0a 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -65,6 +65,7 @@ struct Chardev {
     char *filename;
     int logfd;
     int be_open;
+    int retries;
     GSource *gsource;
     GMainContext *gcontext;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
@@ -221,8 +222,9 @@ void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon);
-int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all=
);
-#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
+int qemu_chr_write(Chardev *s, const uint8_t *buf, int len,
+                   bool write_all, bool best_effort);
+#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true, =
false)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
=20
 #define TYPE_CHARDEV "chardev"
--=20
2.23.0


