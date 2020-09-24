Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6427AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FF6206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx9Nrx3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FF6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNjM-0006Kf-MD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTb-0000kY-Ox
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTY-000615-B0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnGuZPx+UAaBEgkFnO6bEawv0Wo31ZzE5F202qNrgbc=;
 b=Gx9Nrx3IhTwjhgWCwKTUTjeHQdjucQOXQnLXxWVQm/jWAPQORB0lj3Q3fOnC7zW+DqMlgy
 TeAqmuawmHs1UhhR4rfLMK9lQESdyRJ/0HNYgwNvHtFBC00xwF9P8VW4Cy6vyLo8TaX4WI
 pNTxKHJKGb5M1Ey3UUXdZrSHi6UUkuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-rbyClE7FOp2yzmKaXVCWLQ-1; Thu, 24 Sep 2020 05:23:34 -0400
X-MC-Unique: rbyClE7FOp2yzmKaXVCWLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DAB21007478;
 Thu, 24 Sep 2020 09:23:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DA549CBA;
 Thu, 24 Sep 2020 09:23:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/92] hw/char/serial: Assert serial_ioport_read/write offset
 fits 8 bytes
Date: Thu, 24 Sep 2020 05:22:01 -0400
Message-Id: <20200924092314.1722645-20-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

The serial device has 8 registers, each 8-bit. The MemoryRegionOps
'serial_io_ops' is initialized with max_access_size=1, and all
memory_region_init_io() callers correctly set the region size to
8 bytes:
- serial_io_realize
- serial_isa_realizefn
- serial_pci_realize
- multi_serial_pci_realize

It is safe to assert the offset argument of serial_ioport_read()
and serial_ioport_write() is always less than 8.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200907015535.827885-2-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index fd80ae5592..840da89de7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -344,7 +344,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
 {
     SerialState *s = opaque;
 
-    addr &= 7;
+    assert(size == 1 && addr < 8);
     trace_serial_ioport_write(addr, val);
     switch(addr) {
     default:
@@ -485,7 +485,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
     SerialState *s = opaque;
     uint32_t ret;
 
-    addr &= 7;
+    assert(size == 1 && addr < 8);
     switch(addr) {
     default:
     case 0:
-- 
2.26.2



