Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557572072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo1g1w4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557572072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisjf-0002pC-IF
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLz-0002NK-K1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLy-0008Pi-Lk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7szwIaLeQ8ZLnLw2poVLDcD+YJimMkOHW+I2Lu0XpBE=;
 b=Wo1g1w4HfO1nwqeEuJP7KY3qU9510Whgd4GyLBXijW6o06ZAbuh92qOCLCTZMxeMGDNZlU
 UJqd4J3KEtxDCJJedUY5mOIhLl9y7C3FCMKEFIVD9yyv8pu0dBxgOTa2BICe3Kjv1gMzuZ
 HD0/cXutVnoso8HoNuEWzz6nKy7WqNY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-StNkUxa3OKOCcHsB-q76rw-1; Wed, 10 Jun 2020 00:28:40 -0400
X-MC-Unique: StNkUxa3OKOCcHsB-q76rw-1
Received: by mail-wr1-f69.google.com with SMTP id j16so492362wre.22
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7szwIaLeQ8ZLnLw2poVLDcD+YJimMkOHW+I2Lu0XpBE=;
 b=bYZro8xKEMc6ZifxMjNnyirEqqqTKmFRqq4o72/B4VydyY2vduAnvSl/5XgABnrhJs
 LdQIV9VNZJjmbiLUwypRMl/3OHiskbXyWSSAxylgTp0I2PSI0UDZYKTvY0/5RMw3r9wB
 8BbZyLMRTqOIFhi32JWcGWUNoyFidf5dsNSYjPSEc3WMwe3lbKGqYHXCAUs7iHSj1vEx
 H4wbys0+HBFfZCNEkbdYCVREaHqkoqoNoKPpUwnbnX+qX8BZeYB8bYrbdpidUB5sbkka
 swMnMUEEM+ZITCHe2UNqIVeDk1+KcmyS3/kvOhzUQtT5UphHAlWuovX+X3ihZnXQD0PG
 SzMw==
X-Gm-Message-State: AOAM532umGoNfc5P4PX6DwmLE0QLKzAb6hK0nOd4He92Zbpt918XJGgP
 BR/iVF/Kq3Y5xzXhtxhY/NzqhwwvOkdr/jyTIjvnYizrDn1z7FCWJH6uaVeJD63/D6XzpPar0zN
 50i1y3HTFyIAJSwQ=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr1424937wru.124.1591763318759; 
 Tue, 09 Jun 2020 21:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgQIPyIVId85yVuCOuShZRT5CBT60LaexPKRmminx3BoPijF7dKbSRONn3vHXZyIsvyLEMlA==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr1424920wru.124.1591763318588; 
 Tue, 09 Jun 2020 21:28:38 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id l17sm4969576wmi.3.2020.06.09.21.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:38 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/56] acpi: ged: rename event memory region
Message-ID: <20200610042613.1459309-56-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedow <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Rename memory region and callbacks and ops to carry "evt" in the name
because a second region will be added shortly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200520132003.9492-10-kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedow <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/generic_event_device.h |  2 +-
 hw/acpi/generic_event_device.c         | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 83917de024..90a9180db5 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -86,7 +86,7 @@
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 
 typedef struct GEDState {
-    MemoryRegion io;
+    MemoryRegion evt;
     uint32_t     sel;
 } GEDState;
 
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index b1cbdd86b6..1cb34111e5 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -142,7 +142,7 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
 }
 
 /* Memory read by the GED _EVT AML dynamic method */
-static uint64_t ged_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned size)
 {
     uint64_t val = 0;
     GEDState *ged_st = opaque;
@@ -161,14 +161,14 @@ static uint64_t ged_read(void *opaque, hwaddr addr, unsigned size)
 }
 
 /* Nothing is expected to be written to the GED memory region */
-static void ged_write(void *opaque, hwaddr addr, uint64_t data,
-                      unsigned int size)
+static void ged_evt_write(void *opaque, hwaddr addr, uint64_t data,
+                          unsigned int size)
 {
 }
 
-static const MemoryRegionOps ged_ops = {
-    .read = ged_read,
-    .write = ged_write,
+static const MemoryRegionOps ged_evt_ops = {
+    .read = ged_evt_read,
+    .write = ged_evt_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
@@ -287,9 +287,9 @@ static void acpi_ged_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     GEDState *ged_st = &s->ged_state;
 
-    memory_region_init_io(&ged_st->io, obj, &ged_ops, ged_st,
+    memory_region_init_io(&ged_st->evt, obj, &ged_evt_ops, ged_st,
                           TYPE_ACPI_GED, ACPI_GED_EVT_SEL_LEN);
-    sysbus_init_mmio(sbd, &ged_st->io);
+    sysbus_init_mmio(sbd, &ged_st->evt);
 
     sysbus_init_irq(sbd, &s->irq);
 
-- 
MST


