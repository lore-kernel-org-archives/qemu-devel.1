Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A798F20774
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQEcU9q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKbe-00073h-Sf
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEk-00078u-1X
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEi-0007vb-FO
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Lcxf8cj+CxLJSf8aQEjLTWyUhOWt7SwLOi9PO4gCM4=;
 b=QQEcU9q05KiObLyNzcPOjqLxTuyITcFRNrwUzKbmyY8RyBAhlEqpsIgZ/yRYSRqEsHswAH
 u0eqYwf4DRfNv0xHwPzP683YC2PF7oGeqQvPFj3rDkW5pmUpWgrE7Qbu0eDSdnPVFTS2Oq
 XvRW+nSy4hdGHCtvBXLuOs9/E+j68WU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-eh51a96WM7SIC5BX2WPqjw-1; Mon, 08 Jun 2020 12:02:46 -0400
X-MC-Unique: eh51a96WM7SIC5BX2WPqjw-1
Received: by mail-wr1-f69.google.com with SMTP id s17so7305989wrt.7
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Lcxf8cj+CxLJSf8aQEjLTWyUhOWt7SwLOi9PO4gCM4=;
 b=kVgjUNs4Uc9AFhlEhGAwIqhMguW8LdWR5Y7a1XLPFuMapIor7cZNCiXnKvN8AtT5QS
 wV5kG35WeMOmEAdhZWZ8f9kqnTR08CzaxF/f945QQntO9yFH35Mku31FVeqx8LIoX1jW
 JBZFDexAFeTzPRpRJaeAzDof3wRGf0PV2f/SfdcF276xLtcPga/EhmnljA/UuehRUm/o
 7VOsQb8HvIoOlZ9N/HbNbCUqqTix5pYPSR9HkuH2tWgW9eiZR4DBVkN11gkN/nRfnKH9
 lV0RK8ASrXOz5hNBMvHoL8QcxHq0SH4sy0vJYgMSipLQv+mbsUVEHoaPSuSIoqg9UURA
 Z8aA==
X-Gm-Message-State: AOAM533BzhLrc4AiI6hwM0huBjhLD9hgXOTufcYekjRSexCV8PAhn1tF
 hLlib4VHj1TIobWO6/Nqr4jaoeKWnhFap5Qrf5OIKfDHH5sWZ9cUP0l+vV05H1H8YsKNsL7YGpa
 9tZFvBI39YFngCAQ=
X-Received: by 2002:a1c:6056:: with SMTP id u83mr60178wmb.138.1591632161698;
 Mon, 08 Jun 2020 09:02:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztIcOuKmMAnKpEQL/s7NO4XNCQYfWj4X6mQCPh85ejUPn/olQa6U5W1zctaCPlsras+JjNJA==
X-Received: by 2002:a1c:6056:: with SMTP id u83mr60154wmb.138.1591632161497;
 Mon, 08 Jun 2020 09:02:41 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a81sm19165wmd.25.2020.06.08.09.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:02:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 20/35] hw/intc/i8259: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:29 +0200
Message-Id: <20200608160044.15531-21-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 hw/intc/i8259.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 51b27f6a34..9d9609cdab 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -30,6 +30,7 @@
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
 #include "trace.h"
+#include "hw/qdev-deprecated.h"
 
 /* debug PIC */
 //#define DEBUG_PIC
@@ -414,6 +415,8 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq)
     ISADevice *isadev;
     int i;
 
+    qdev_warn_deprecated_function_used();
+
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, true);
-- 
2.21.3


