Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163942075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy/QUUmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163942075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbuN-00035Y-4i
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbtA-0000sT-SI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbt6-00019L-Qs
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=PP70rU/BGptGCs6yePlBOsP+gLuIij5QaqW5e7shzno=;
 b=Cy/QUUmC6zppXe8tv5gyE8hvqLhtxJbOh70cAb053XFnTduFRwiRkHro1H7qRtZklA7JGf
 EqShSIxGQwO+I2lFikBlne8sWJ08egMvYXpA1uKA65Dd8nXf6H4xvxfGz8Q4+87cRD8ZXj
 8b2FogROl9XQ7Z2UplO9Sy4b54So0+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-04uq-N0jOH6ZpGK4ronnhA-1; Fri, 15 May 2020 11:04:32 -0400
X-MC-Unique: 04uq-N0jOH6ZpGK4ronnhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D381C1009440;
 Fri, 15 May 2020 15:04:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5C36247E;
 Fri, 15 May 2020 15:04:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B04469D57; Fri, 15 May 2020 17:04:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/16] acpi: rtc: use a single crs range
Date: Fri, 15 May 2020 17:04:08 +0200
Message-Id: <20200515150421.25479-4-kraxel@redhat.com>
In-Reply-To: <20200515150421.25479-1-kraxel@redhat.com>
References: <20200515150421.25479-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a single io range for _CRS instead of two,
following what real hardware does.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/rtc/mc146818rtc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index fe05a4488e43..1e9fa0f33fed 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -1013,12 +1013,14 @@ static void rtc_build_aml(ISADevice *isadev, Aml *scope)
     Aml *dev;
     Aml *crs;
 
+    /*
+     * Reserving 8 io ports here, following what physical hardware
+     * does, even though qemu only responds to the first two ports.
+     */
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
-                           0x10, 0x02));
+                           0x01, 0x08));
     aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
-    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE + 2, RTC_ISA_BASE + 2,
-                           0x02, 0x06));
 
     dev = aml_device("RTC");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
-- 
2.18.4


