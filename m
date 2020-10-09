Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B90C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5B122261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeKKINqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5B122261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQqlH-0008B6-9t
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 07:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kQqji-0006xj-50
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 07:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kQqjg-0002vb-HK
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 07:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602243535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmtaFGBBD9kx7zPOiiuXAOzBlxm5zZEjKDsygjdRty0=;
 b=OeKKINquY8jZFrEBToiAqHhH0amrEEYOt0AEOmJ+6Wfh8Ii42c7ifBETPz5nyivFunMsrf
 Uhq8EyCPhpG+G/6OpQFbLC6gVsE4HIiGIoXGr1h1qXH10nArIyxAeiZcXAznkXx8BGMgQz
 QpFcJlw4ZowJsxmtkrQaLs2maDsHFEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-gVnWMQQeMMewGMZGupT0yQ-1; Fri, 09 Oct 2020 07:38:52 -0400
X-MC-Unique: gVnWMQQeMMewGMZGupT0yQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A24001030938;
 Fri,  9 Oct 2020 11:38:50 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-115-120.ams2.redhat.com
 [10.36.115.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C68255760;
 Fri,  9 Oct 2020 11:38:47 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] goldfish_rtc: change MemoryRegionOps endianness to
 DEVICE_NATIVE_ENDIAN
Date: Fri,  9 Oct 2020 13:38:43 +0200
Message-Id: <20201009113843.60995-2-lvivier@redhat.com>
In-Reply-To: <20201009113843.60995-1-lvivier@redhat.com>
References: <20201009113843.60995-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-riscv@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Anup.Patel@wdc.com, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The doc [1] doesn't define the endianness, but the kernel driver
uses readl() to access the registers, so we can guess it depends
on the architecture endianness.

As riscv architecture endianness is little it might not change anything
for it.

Moreover, android implementation uses DEVICE_NATIVE_ENDIAN [2]

[1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
[2] https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/timer/goldfish_timer.c#177

Fixes: 9a5b40b84279 ("hw: rtc: Add Goldfish RTC device")
Cc: Anup.Patel@wdc.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/rtc/goldfish_rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 6ddd45cce039..0f4e8185a796 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -217,7 +217,7 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
 static const MemoryRegionOps goldfish_rtc_ops = {
     .read = goldfish_rtc_read,
     .write = goldfish_rtc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
-- 
2.26.2


