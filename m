Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58A221655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qA2Nbbnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58A221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHW0-0002fr-Ro
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAu-0000jj-RM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAt-0001Q9-39
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:32 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiHAs-0001M9-Oa
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:30 -0500
Received: by mail-wm1-x343.google.com with SMTP id c127so1632092wme.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oMQw6t6tRzlw6HQPCH1hJECHMvald9wcRxGqG3qpIY0=;
 b=qA2Nbbnkf7t7LSKkmijtFigfij9EhBRtlf6+zLdSkH420XupqFUbMgVl9WcotKQEir
 fQYZXiwOwqXHl89D5VpT2YUiZK23e1DYjanfr7ZN4N2+JIOLltDI2tEx+Hel7HmfOakt
 ngHiiPj1zFQx5T8UFC9WvVXxphsrCHps0FzUznXpSsTf2DUPXut5jBeQQoZMB4i9ELGh
 rDLF6ELs8bZObKdDbNrU21jjHbV0Bkwjm2Vn36a1zANq2zbvk2xcbraG4XxL5GHhGZyQ
 Hv1ZiF3c2ReAx3O/Gbi9duUuFjpeaEFKa+ccTVpAPzWlM14mh7zUFzU3ak5iQEW7icOI
 kNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oMQw6t6tRzlw6HQPCH1hJECHMvald9wcRxGqG3qpIY0=;
 b=hXMRQuLQ3FOCB5cdbII9D2bV4o41R+MUwV/L7ZRWLapFUbNrrUkQpZHAsvYv5g+vcy
 8buCAuNLLbx4Z6Ql/JlHKYJzcChiqOWMz+s2bZJYZh4ScnEDb7xSkMV4wNoet55GDnDZ
 oKgvgu/QiotzTqSsgoFuXKG7M+iOfdELz3nHjYgQJLukv8kmwM4Od4w3iwqal7b8Cgtn
 emk6DeQdePYYYnTcgtqJi8Uadgx2CsOt2KwhIKPMWPWgcyybWnezNgnd6NYUGC4M/QVG
 pJrFa+aZqCV5BPGA/XdNPz3Yv8O7f8lyEiNDHdi7ppop4Cu2s65Mqrsbaj3T2n8LQYHF
 b8Vw==
X-Gm-Message-State: APjAAAW7tfzy1CtDDcVN1XRtbAvruNf8xvAlsE3uY3DrxDAC/4od7Bo7
 I7ZLqQW9nVmfWhWsR7B4z/opaA==
X-Google-Smtp-Source: APXvYqz2KFWAVDMx6rIGJxR4Rpz3GK8a75aRWcEmmGM3w2lvzgLhn+N1hOmT4VT+K0VgSWJYqvZr7A==
X-Received: by 2002:a7b:cd0a:: with SMTP id f10mr16703426wmj.56.1576844069376; 
 Fri, 20 Dec 2019 04:14:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm9517124wrw.12.2019.12.20.04.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:14:25 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 00A021FFAA;
 Fri, 20 Dec 2019 12:04:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 20/21] gdbstub: change GDBState.last_packet to GByteArray
Date: Fri, 20 Dec 2019 12:04:37 +0000
Message-Id: <20191220120438.16114-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: damien.hedde@greensocs.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

Remove the packet size upper limit by using a GByteArray
instead of a statically allocated array for last_packet.
Thus we can now send big packets.

Also remove the last_packet_len field and use last_packet->len
instead.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191211160514.58373-2-damien.hedde@greensocs.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 287d0535b12..49e760283db 100644
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
     gdbserver_state.init = true;
     gdbserver_state.str_buf = g_string_new(NULL);
     gdbserver_state.mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
+    gdbserver_state.last_packet = g_byte_array_sized_new(MAX_PACKET_LENGTH + 4);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -626,28 +626,29 @@ static void hexdump(const char *buf, int len,
 static int put_packet_binary(const char *buf, int len, bool dump)
 {
     int csum, i;
-    uint8_t *p;
-    uint8_t *ps = &gdbserver_state.last_packet[0];
+    uint8_t footer[3];
 
     if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYREPLY)) {
         hexdump(buf, len, trace_gdbstub_io_binaryreply);
     }
 
     for(;;) {
-        p = ps;
-        *(p++) = '$';
-        memcpy(p, buf, len);
-        p += len;
+        g_byte_array_set_size(gdbserver_state.last_packet, 0);
+        g_byte_array_append(gdbserver_state.last_packet,
+                            (const uint8_t *) "$", 1);
+        g_byte_array_append(gdbserver_state.last_packet,
+                            (const uint8_t *) buf, len);
         csum = 0;
         for(i = 0; i < len; i++) {
             csum += buf[i];
         }
-        *(p++) = '#';
-        *(p++) = tohex((csum >> 4) & 0xf);
-        *(p++) = tohex((csum) & 0xf);
+        footer[0] = '#';
+        footer[1] = tohex((csum >> 4) & 0xf);
+        footer[2] = tohex((csum) & 0xf);
+        g_byte_array_append(gdbserver_state.last_packet, footer, 3);
 
-        gdbserver_state.last_packet_len = p - ps;
-        put_buffer(ps, gdbserver_state.last_packet_len);
+        put_buffer(gdbserver_state.last_packet->data,
+                   gdbserver_state.last_packet->len);
 
 #ifdef CONFIG_USER_ONLY
         i = get_char();
@@ -2812,20 +2813,22 @@ static void gdb_read_byte(uint8_t ch)
     uint8_t reply;
 
 #ifndef CONFIG_USER_ONLY
-    if (gdbserver_state.last_packet_len) {
+    if (gdbserver_state.last_packet->len) {
         /* Waiting for a response to the last packet.  If we see the start
            of a new command then abandon the previous response.  */
         if (ch == '-') {
             trace_gdbstub_err_got_nack();
-            put_buffer((uint8_t *)gdbserver_state.last_packet, gdbserver_state.last_packet_len);
+            put_buffer(gdbserver_state.last_packet->data,
+                       gdbserver_state.last_packet->len);
         } else if (ch == '+') {
             trace_gdbstub_io_got_ack();
         } else {
             trace_gdbstub_io_got_unexpected(ch);
         }
 
-        if (ch == '+' || ch == '$')
-            gdbserver_state.last_packet_len = 0;
+        if (ch == '+' || ch == '$') {
+            g_byte_array_set_size(gdbserver_state.last_packet, 0);
+        }
         if (ch != '$')
             return;
     }
@@ -3209,7 +3212,7 @@ static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
     const char *p = (const char *)buf;
     int max_sz;
 
-    max_sz = (sizeof(gdbserver_state.last_packet) - 2) / 2;
+    max_sz = (MAX_PACKET_LENGTH / 2) + 1;
     for (;;) {
         if (len <= max_sz) {
             gdb_monitor_output(p, len);
-- 
2.20.1


