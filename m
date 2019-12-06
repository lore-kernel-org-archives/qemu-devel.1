Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A955BC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F2424673
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="a0uail9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F2424673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEyo-0006xU-2X
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1idEUt-00088R-Sw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1idEUs-0003Jg-DK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:19 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:39272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1idEUr-0003AK-Qp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:18 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id AD13A96EF0;
 Fri,  6 Dec 2019 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575639748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TBW7+cT58E+tpStNNfLAaBdbfCiVU8gjkh1T28tyR3k=;
 b=a0uail9iVXByj0ettLGJu+EE5QfuZsAV8O6UP/9h2yYFtjelFfxKuZf/1H8da2VzFdw0LT
 JzI64etG1WrtTsrYZ7KXcieBt68FLnTXCRXm33/vBjufxo6G1ZYh/8xGgB1xZjbu+RkAZz
 JEG5ZrfBB85vJAidY/DyvltRcJuyYMA=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] gdbstub: change GDBState.last_packet to GByteArray
Date: Fri,  6 Dec 2019 14:42:03 +0100
Message-Id: <20191206134203.77385-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575639748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TBW7+cT58E+tpStNNfLAaBdbfCiVU8gjkh1T28tyR3k=;
 b=CekJuR5KB3wIIXQJy5C2jL2ivcsPZ48opNT6AXqBDrLLDMvKoNrCrcaHrxehKbw3IdAjiB
 +PH/bAkeIZG5L4NUT+SWHohrE69AQtQgyItLcEj32SjecgWCnLaJIAUlRpD0cKl1+C5QIk
 HBO91gebMiSNqkWOOc24SGn6ui5AemM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575639748; a=rsa-sha256; cv=none;
 b=GdCJd4bLl7Lbfux1s2jXGq8AUD0tXkzwiu+00vB9ambn4uuvdKbc0NkNIn/H3NdLVZgenN
 xJKj7hUcj0WPVkG+0cpi5/VNnCZMCTJQYu2oFahEJV0141klqpzcydWTbO2vkYSuAFOmEb
 VOUP0BfZdAZSRjaZ9YTiZ+bwCF+OFBM=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, philmd@redhat.com,
 alex.bennee@linaro.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the packet size upper limit by using a GByteArray
instead of a statically allocated array for last_packet.
Thus we can now send big packets.

Also remove the last_packet_len field and use last_packet->len
instead.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

This patch is a follow-up of Alex's series about sve registers
which introduces some GbyteArray/Gstring in the gdbstub.
It removes the remaining barrier to send big packets.

Based-on <20191130084602.10818-1-alex.bennee@linaro.org>
---
 gdbstub.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 7b695bdebe..022edd6bdb 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -351,8 +351,7 @@ typedef struct GDBState {
     int line_buf_index;
     int line_sum; /* running checksum */
     int line_csum; /* checksum at the end of the packet */
-    uint8_t last_packet[MAX_PACKET_LENGTH + 4];
-    int last_packet_len;
+    GByteArray *last_packet;
     int signal;
 #ifdef CONFIG_USER_ONLY
     int fd;
@@ -384,6 +383,7 @@ static void init_gdbserver_state(void)
     gdbserver_state.init =3D true;
     gdbserver_state.str_buf =3D g_string_new(NULL);
     gdbserver_state.mem_buf =3D g_byte_array_sized_new(MAX_PACKET_LENGTH=
);
+    gdbserver_state.last_packet =3D g_byte_array_sized_new(MAX_PACKET_LE=
NGTH + 4);
 }
=20
 #ifndef CONFIG_USER_ONLY
@@ -626,28 +626,29 @@ static void hexdump(const char *buf, int len,
 static int put_packet_binary(const char *buf, int len, bool dump)
 {
     int csum, i;
-    uint8_t *p;
-    uint8_t *ps =3D &gdbserver_state.last_packet[0];
+    uint8_t footer[3];
=20
     if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYRE=
PLY)) {
         hexdump(buf, len, trace_gdbstub_io_binaryreply);
     }
=20
     for(;;) {
-        p =3D ps;
-        *(p++) =3D '$';
-        memcpy(p, buf, len);
-        p +=3D len;
+        g_byte_array_set_size(gdbserver_state.last_packet, 0);
+        g_byte_array_append(gdbserver_state.last_packet,
+                            (const uint8_t *) "$", 1);
+        g_byte_array_append(gdbserver_state.last_packet,
+                            (const uint8_t *) buf, len);
         csum =3D 0;
         for(i =3D 0; i < len; i++) {
             csum +=3D buf[i];
         }
-        *(p++) =3D '#';
-        *(p++) =3D tohex((csum >> 4) & 0xf);
-        *(p++) =3D tohex((csum) & 0xf);
+        footer[0] =3D '#';
+        footer[1] =3D tohex((csum >> 4) & 0xf);
+        footer[2] =3D tohex((csum) & 0xf);
+        g_byte_array_append(gdbserver_state.last_packet, footer, 3);
=20
-        gdbserver_state.last_packet_len =3D p - ps;
-        put_buffer(ps, gdbserver_state.last_packet_len);
+        put_buffer(gdbserver_state.last_packet->data,
+                   gdbserver_state.last_packet->len);
=20
 #ifdef CONFIG_USER_ONLY
         i =3D get_char();
@@ -2812,20 +2813,22 @@ static void gdb_read_byte(GDBState *s, uint8_t ch=
)
     uint8_t reply;
=20
 #ifndef CONFIG_USER_ONLY
-    if (gdbserver_state.last_packet_len) {
+    if (gdbserver_state.last_packet->len) {
         /* Waiting for a response to the last packet.  If we see the sta=
rt
            of a new command then abandon the previous response.  */
         if (ch =3D=3D '-') {
             trace_gdbstub_err_got_nack();
-            put_buffer((uint8_t *)gdbserver_state.last_packet, gdbserver=
_state.last_packet_len);
+            put_buffer(gdbserver_state.last_packet->data,
+                       gdbserver_state.last_packet->len);
         } else if (ch =3D=3D '+') {
             trace_gdbstub_io_got_ack();
         } else {
             trace_gdbstub_io_got_unexpected(ch);
         }
=20
-        if (ch =3D=3D '+' || ch =3D=3D '$')
-            gdbserver_state.last_packet_len =3D 0;
+        if (ch =3D=3D '+' || ch =3D=3D '$') {
+            g_byte_array_set_size(gdbserver_state.last_packet, 0);
+        }
         if (ch !=3D '$')
             return;
     }
@@ -3209,7 +3212,7 @@ static int gdb_monitor_write(Chardev *chr, const ui=
nt8_t *buf, int len)
     const char *p =3D (const char *)buf;
     int max_sz;
=20
-    max_sz =3D (sizeof(gdbserver_state.last_packet) - 2) / 2;
+    max_sz =3D MAX_PACKET_LENGTH / 2;
     for (;;) {
         if (len <=3D max_sz) {
             gdb_monitor_output(&gdbserver_state, p, len);
--=20
2.24.0


