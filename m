Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46159C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA04E2068D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHybzHQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA04E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNeM-0007wN-Io
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTY-0000hF-KS
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTW-00060n-4Q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+le3lP7gYc7i3+Ijw4dcFNRy9gmYL3hLtq9QkowOK4=;
 b=NHybzHQZsy3nDpL0nN2uMj83WAhJgxDjSWI+CkPGcYSmAIpo/cpmEsua0+LgMAcl/AZz8x
 W1jJeBUJOt8znsEs1ko2LE0HbC5wOiUJ3no8hYyix0gillRkpbDianY6XP0fc9bsNskrAR
 6E0+SOqEwUoGZQM4lHtkOpFm/YPbkC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-uPRUgtBTN_6luvpDOy0lRg-1; Thu, 24 Sep 2020 05:23:35 -0400
X-MC-Unique: uPRUgtBTN_6luvpDOy0lRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F52564142;
 Thu, 24 Sep 2020 09:23:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F103573662;
 Thu, 24 Sep 2020 09:23:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/92] hw/char/serial: Replace commented DPRINTF() by trace
 event
Date: Thu, 24 Sep 2020 05:22:02 -0400
Message-Id: <20200924092314.1722645-21-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Convert the old debug PRINTF() call to display the UART
baudrate to a trace event.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200907015535.827885-3-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c     | 4 +---
 hw/char/trace-events | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 840da89de7..e8029f840a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -187,9 +187,7 @@ static void serial_update_parameters(SerialState *s)
     ssp.stop_bits = stop_bits;
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
-
-    DPRINTF("speed=%.2f parity=%c data=%d stop=%d\n",
-           speed, parity, data_bits, stop_bits);
+    trace_serial_update_parameters(speed, parity, data_bits, stop_bits);
 }
 
 static void serial_update_msl(SerialState *s)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 2442a9f7d5..17304bef26 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -7,6 +7,7 @@ parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s
 # serial.c
 serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
 serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
+serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
 
 # virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
-- 
2.26.2



