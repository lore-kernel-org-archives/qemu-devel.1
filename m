Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1B8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E5120838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrFGvprv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E5120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ByT-0005Ox-Nz
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 13:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1Bth-0001ic-W8
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:59:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1Btg-0007NF-42
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596128351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVg0BC65TTj2TNeSd+KdcP3tFF6Km2gCk+HmGtrYiQY=;
 b=PrFGvprvw8k5b5hK7E1oY2Ts9UbIPmnZQOZk7lA6D9ODZ/CN/LkwSD3fdiZpUcYAJ7Kpzn
 NmtxhtE4N0zrcoesDckCdH13UCXId2K2kDtsRIBn8XXCG6o1ZPUBxGV1yDlREE8X4lsBIj
 NBy2VTEq8POlEWpVIPTg6u3YRAdkm+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-rf_OS_-dP6imXNyGXSGopw-1; Thu, 30 Jul 2020 12:59:09 -0400
X-MC-Unique: rf_OS_-dP6imXNyGXSGopw-1
Received: by mail-wr1-f70.google.com with SMTP id 5so8119615wrc.17
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yVg0BC65TTj2TNeSd+KdcP3tFF6Km2gCk+HmGtrYiQY=;
 b=AN/TTvRI8Z8lcC4UvbhevCeJOQ53s94m6pwFRVDkztiTTwiKZ57c3LGEz6OZszQ3iH
 Q9RbIdyJ5UORq+60dlh8sB2f+7UDk/p9artAg+1P/KmWEpiVsJDptgeZq324jTBHgop4
 YsRUkndmmImSdsJM3jFQM0foNaPoyzQBnu5I5hOQtAEtZzjUKaGn6dehzLM2UY/+Sns2
 41w/cSSodA1qUmSgTGk1BpEtlH3hUa4e+7xjYo5Cj35nupTnVQwM19pDoIYUL4yCKpGF
 0vpuGSgWwCavU/pPCJGOzLxGM/TjbfeNNOaJmX8QgBbIOwkAtOP9xYYQpQRKG534Gvaz
 hDdA==
X-Gm-Message-State: AOAM532ECn6EL38ZOcsBOHwCmLW+kEbf3lan+quvmMifvBeEufzLrLwt
 kJaFngMcvWTbbBjk6Uvp1LH27rmpH3uUDhENjEbq0t8hzxQuYcZwt9nxZp9awOBVQTXo4dWcXXX
 IxdcRveR9sQFJbFw=
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr20141396wrw.311.1596128347627; 
 Thu, 30 Jul 2020 09:59:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0x7vfCTvc4VsBWnL8ygOJZHyTNQpY+1ekW+CiHl9rg0hUwVGwiseolnUN8zKOnfsisD7QXw==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr20141382wrw.311.1596128347454; 
 Thu, 30 Jul 2020 09:59:07 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id a3sm10085764wme.34.2020.07.30.09.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 09:59:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/2] hw/mips/mipssim: Use MMIO serial device on fake
 ISA I/O
Date: Thu, 30 Jul 2020 18:58:59 +0200
Message-Id: <20200730165900.7030-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730165900.7030-1-philmd@redhat.com>
References: <20200730165900.7030-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'mipssim' is not a real hardware, it is a simulator.

There is an ISA MMIO space mapped at 0x1fd00000, however
this is not a real ISA bus (no ISA IRQ). So can not use
the TYPE_ISA_SERIAL device...
Instead we have been using a plain MMIO device, but named
it IO.

TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, using
regshift=0 and endianness=DEVICE_LITTLE_ENDIAN.

Directly use the TYPE_SERIAL_MM device, enforcing the
regshift/endianness values. 'regshift' default is already
'0'. 'endianness' is meaningless for 8-bit accesses.

Note, there is no migration problem, because TYPE_SERIAL_IO
was not migrated.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/mips/mipssim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 1b3b762203..853bbaca58 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -216,9 +216,11 @@ mips_mipssim_init(MachineState *machine)
      * MIPS CPU INT2, which is interrupt 4.
      */
     if (serial_hd(0)) {
-        DeviceState *dev = qdev_new(TYPE_SERIAL_IO);
+        DeviceState *dev = qdev_new(TYPE_SERIAL_MM);
 
         qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+        qdev_prop_set_uint8(dev, "regshift", 0);
+        qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
         qdev_set_legacy_instance_id(dev, 0x3f8, 2);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
-- 
2.21.3


