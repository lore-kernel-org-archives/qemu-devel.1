Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE500C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975772084C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqFPwnI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975772084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkRA-0005q9-OL
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkI0-0003bH-HZ
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHx-0008PC-S1
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T05aSWsXj6XqlyyRKFN7AiT8E00rxZAH7ivGzBAXguo=;
 b=fqFPwnI/niaIUFNl6cM1EH1O1EbAL0c0TEvzZDpkXQlwOm1h0pQPRSi/WHVADh6Tpb7PD5
 elV8EQyej2KALpvPXr/LlhtBJOEZG2JiEv050fUb5uJz7UaX7sdYwBSeXcOy3glq2ch0iV
 NX0Y9+mSpPpiMgEGc7daYhE7tMSAxo4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-UZlcotD5MMCXHybsVLeXPw-1; Sat, 04 Jul 2020 11:41:12 -0400
X-MC-Unique: UZlcotD5MMCXHybsVLeXPw-1
Received: by mail-wr1-f70.google.com with SMTP id i14so35800796wru.17
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T05aSWsXj6XqlyyRKFN7AiT8E00rxZAH7ivGzBAXguo=;
 b=jw4JM53EmStNhWZfs6SylleZXwZBDzHGvLhUYn++DAtlkn3F2ulMkO0cb1CEVGQXsa
 ki6X99gOd5+z6HHB79vDV3rJ1EIknhyDkkNdCTie9fqi+D4z/6PLSqY5vKw/yOKbvtAa
 ObakxMcEjUYefsO3nqGQVG12d0PH2IHUU+vXw79lYNig7p5lepgI+jvVntbyn1cOajvR
 bO2D0Yi/qUu/6BgIfDm0mydtmkKbOk22qhESpOqlrRiMrJxnPT+Z2MZtZjLCJXsnWNeE
 OMh8fqT2P42vzBJpNHbIP13XnveMDed1jdvALdkXmteXLeRaza3j02laL7ghh+9ItjFb
 N1jQ==
X-Gm-Message-State: AOAM531fgG7N1GFArCr6nQ/aes4dpj3cEs4OHDzJwxBqGHsFQM7ZByMR
 solG2663XBtHAlRkgXx1i2/gy6scdV5U+do2DxBNLUkznRj1nGGQqqvuDnuR5ZP6PFJ2k+YVJ3h
 2xNNNLT5eX2tZxXM=
X-Received: by 2002:a1c:398b:: with SMTP id g133mr40165702wma.76.1593877270491; 
 Sat, 04 Jul 2020 08:41:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY6jjMSQWiKHCzETU0E+/X0LPKuPCnnd4xVQP5+FKyucBMWp08OCApfnD7RL8JFbFT8AYF3A==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr40165682wma.76.1593877270343; 
 Sat, 04 Jul 2020 08:41:10 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm17134778wrw.62.2020.07.04.08.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:41:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 22/23] hw/usb/hcd-musb: Emit warning when old code is
 used
Date: Sat,  4 Jul 2020 17:39:07 +0200
Message-Id: <20200704153908.12118-23-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-musb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index 85f5ff5bd4..f09464ed5e 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -26,6 +26,7 @@
 #include "hw/usb/hcd-musb.h"
 #include "hw/irq.h"
 #include "hw/hw.h"
+#include "hw/qdev-deprecated.h"
 
 /* Common USB registers */
 #define MUSB_HDRC_FADDR		0x00	/* 8-bit */
@@ -378,6 +379,8 @@ struct MUSBState *musb_init(DeviceState *parent_device, int gpio_base)
     MUSBState *s = g_malloc0(sizeof(*s));
     int i;
 
+    qdev_warn_deprecated_function_used();
+
     for (i = 0; i < musb_irq_max; i++) {
         s->irqs[i] = qdev_get_gpio_in(parent_device, gpio_base + i);
     }
-- 
2.21.3


