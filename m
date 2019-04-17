Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45922C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 00:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E8C20821
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 00:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="Y3orv1Uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E8C20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44823 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGYoH-0008FN-4S
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 20:52:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGYnT-0007tm-Qs
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGYnS-0000M9-Qb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:51:31 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:37057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGYnS-0000Lg-EW
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:51:30 -0400
Received: by mail-io1-xd44.google.com with SMTP id x7so19221169ioh.4
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 17:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HijM4yMTjQ1ZZzGdGKVOKt668jUCoXfBQGB/vyA6H3k=;
	b=Y3orv1Uqcv/W81V5SxxxMX7QBuJ3vc6BYLrlsROLh3O2EX26zA1Vr18dY9VG++XmWh
	PjbSp5EzOONUkO+k3644lrNxK3xQ7N3eg+LMQqyABvc6hqW92VqagtR/VgMrnbRLP2/Z
	p9XIOyaex167n+pD3ltVSsaQUbwsLpP9vwDNQVORA5VyAHZNf/QyzE48OLBvee+j7usj
	ZotvVqcjt3ESofWcMcNcjZZO4jQdhIdMy3qTYh4XBkM0NXHF9YZ65jzXrOw2MwRdS8UA
	WgWbQAkOEh2Rf22FS9i/YW0qfms4BJET834oG4g73XpiLUOgqxcdJzHW4GG7BqBZdfWn
	jxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HijM4yMTjQ1ZZzGdGKVOKt668jUCoXfBQGB/vyA6H3k=;
	b=Zo7fxz+DAyTYEUdteuVP++rw8gbj4OquEjpKuBQQTJdjLMFLoWILAt9fZm+HworlqJ
	Rdu2yYPtxVxeIDTPL4J2FQEoXbRSFCNHBF5+po25uZfEhd7GzTwEKrTB4+HMgDbsXfq9
	yt6KvUCtoxgnADSYn1O0JqGKiCWjuG7vasmDxwjohNZ7nbP9aZvOxP+R8SVw6xN2ahS0
	1DgBWBj2F3QXguF4YnxZ2vFCqgm2MSblSmcvDg0JcmlHkflANQTTDOWCxcm1fjptgdhl
	lhIeLgR+4AYoTj8a8zVN2OBUv2Tnsap0A/dP4a1g8Jn6AaHPapyGzJDthM+07ILK+ACn
	w+gQ==
X-Gm-Message-State: APjAAAWLhP5QHujQEFnG7VTIDJ4NjifXrujgWVZBN4c2JdcjauEiMKt5
	zbW/hWxZrWGuQZz3jiV0dxAMgw==
X-Google-Smtp-Source: APXvYqyrXzAehE74/FUSnTdXtkK+YusILGDJjP1r10QZghXexfEKUfUhzsvMXeLNkQrAouERZ9uCBw==
X-Received: by 2002:a6b:fd0f:: with SMTP id c15mr59343803ioi.132.1555462287582;
	Tue, 16 Apr 2019 17:51:27 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	136sm553791itk.28.2019.04.16.17.51.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 16 Apr 2019 17:51:26 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 16 Apr 2019 20:50:53 -0400
Message-Id: <20190417005053.885-1-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: [Qemu-devel] [PATCH v2] hw/char/escc: Lower irq when transmit
 buffer is filled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417005053.lKlcsz6wslMbd5Nv1TE8nUiVQm7znEwfZ0Ej144kgRE@z>

The SCC/ESCC will briefly stop asserting an interrupt when the
transmit FIFO is filled.

This code doesn't model the transmit FIFO/shift register so the
pending transmit interrupt is never deasserted which means that an
edge-triggered interrupt controller will never see the low-to-high
transition it needs to raise another interrupt. The practical
consequence of this is that guest firmware with an interrupt service
routine for the ESCC that does not send all of the data it has
immediately will stop sending data if the following sequence of
events occurs:
1. Disable processor interrupts
2. Write a character to the ESCC
3. Add additional characters to a buffer which is drained by the ISR
4. Enable processor interrupts

In this case, the first character will be sent, the interrupt will
fire and the ISR will output the second character. Since the pending
transmit interrupt remains asserted, no additional interrupts will
ever fire.

This fixes that situation by explicitly lowering the IRQ when a
character is written to the buffer and no other interrupts are currently
pending.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/char/escc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f81f7..c5b05a63f1 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         break;
     case SERIAL_DATA:
         trace_escc_mem_writeb_data(CHN_C(s), val);
+        /*
+         * Lower the irq when data is written to the Tx buffer and no other
+         * interrupts are currently pending. The irq will be raised again once
+         * the Tx buffer becomes empty below.
+         */
+        s->txint = 0;
+        escc_update_irq(s);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
             if (qemu_chr_fe_backend_connected(&s->chr)) {
-- 
2.20.1 (Apple Git-117)


