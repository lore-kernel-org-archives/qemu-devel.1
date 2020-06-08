Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE72C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD2F2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azhV8+nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD2F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKf1-0004LZ-Sj
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFx-00089T-Gm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:04:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFv-0008HS-I5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YHmjQuhKrVQhVboVAQhCqKWsJQjJvIRsihRuyQB5QA=;
 b=azhV8+nqZYNRIe//txgnsYcjhvqFe0DrKoRN3XRLcd4Bu7j+iY1CuUiPAi3iYPirOu5/K9
 N9SD1gAVlfUPYR4xzCASlWjQk+c6NQjJ0Q8KvzrELdABD8pppSvxt+hQx2zy/WGtGkGoKG
 2QMnMBz5eCm0z/v3z4UTp4XrmEaSSGs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-wnrGQVfTNj6WDQDpS-M9ig-1; Mon, 08 Jun 2020 12:04:06 -0400
X-MC-Unique: wnrGQVfTNj6WDQDpS-M9ig-1
Received: by mail-wm1-f70.google.com with SMTP id j128so8670wmj.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1YHmjQuhKrVQhVboVAQhCqKWsJQjJvIRsihRuyQB5QA=;
 b=EURwtq6qyTvg4EIGOeW0sBnaHPlcvRGCc7Ir3MUR8s5cELj/kLPTnSCVL+QFw1zAKl
 j1f2Vk7kmw28x4vQf+l6z8gyB+WgJMg4MLDbe70MnKzMohQka/RsZ8BaOeovsYGDAXho
 MlA18r3kbeFAdX3EVa9y/icKvEsAqQggBZiOtH8RlxSKb9IPuQ+k/zKK/PPXMNDqT7cf
 Vzx/+UIvbNq9sw94mG9e7dV4N0DCV9Qh9rtJNGCWhmBk2TiLhgqrpUet0kqfagV5OEb0
 dGQSUkLNQDP3MWKgy+B6W+FF2+s9EvWsrc1z1TT3SlhabLXZYraXdlNlS5PLYErLh3n5
 70mQ==
X-Gm-Message-State: AOAM530fT0iQ7Y/G/verma058gxWUPv1Z7WLeYjGL0DO4eWndkdiQAf5
 5faz7d7h/7ncufGCpjza9MUOxCyquAexqNdPboR4FDjG8ABZZ3mjh+OIwqgINB687g8dKtL4yM7
 oxoLaOtmV8Cmzz88=
X-Received: by 2002:adf:e68a:: with SMTP id r10mr23902508wrm.384.1591632244560; 
 Mon, 08 Jun 2020 09:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU7/QCokRt2M0EtovQUdkQHNPZYj9jN1RqUTvUD0f6M2vtgvgHtmb2W1P0W/noN9Fx2nTHYQ==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr23902460wrm.384.1591632244335; 
 Mon, 08 Jun 2020 09:04:04 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k17sm177411wrl.54.2020.06.08.09.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:04:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 34/35] hw/usb/hcd-musb: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:43 +0200
Message-Id: <20200608160044.15531-35-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-musb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index c29fbef6fc..9b3cf1ca8f 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -25,6 +25,7 @@
 #include "hw/usb.h"
 #include "hw/irq.h"
 #include "hw/hw.h"
+#include "hw/qdev-deprecated.h"
 
 /* Common USB registers */
 #define MUSB_HDRC_FADDR		0x00	/* 8-bit */
@@ -377,6 +378,8 @@ struct MUSBState *musb_init(DeviceState *parent_device, int gpio_base)
     MUSBState *s = g_malloc0(sizeof(*s));
     int i;
 
+    qdev_warn_deprecated_function_used();
+
     for (i = 0; i < musb_irq_max; i++) {
         s->irqs[i] = qdev_get_gpio_in(parent_device, gpio_base + i);
     }
-- 
2.21.3


