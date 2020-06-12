Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1934C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3C12081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHyzHfao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3C12081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlJD-0005Pc-Nb
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3Q-0001Ig-KK
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3O-0001f7-R9
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7szwIaLeQ8ZLnLw2poVLDcD+YJimMkOHW+I2Lu0XpBE=;
 b=eHyzHfaomNKNSea+mS256znwoBANxtHjBmRNURL87NsH9rKpB7p68c0RikHdeMWjDauPCS
 t5f1it00gTvs+7sDtYdbZTCQEjK9T5A4fnIwZhawiLsoGvjIyT7grrOtXm+3XcdSCjuYtL
 aCvtAex8LiNAtOCB9pyqgWipXHeVmbg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-efcmvOAJPoOZPhFmxCrVVw-1; Fri, 12 Jun 2020 10:53:06 -0400
X-MC-Unique: efcmvOAJPoOZPhFmxCrVVw-1
Received: by mail-wm1-f69.google.com with SMTP id b63so3878452wme.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7szwIaLeQ8ZLnLw2poVLDcD+YJimMkOHW+I2Lu0XpBE=;
 b=qVqW2KLnc29+2q3FhffjWD1p2ohvN7pfb8TqCl5Wqsr2IVwacLyLsmKJYS0StIqhB6
 UJJ7X9qat63zRGhE4O9HJnZNlFU6rvoA/x1AXN5Pa7SvZ1IR0cpoWRQRvkg4D6GgEx0A
 lGVqQrvjeAaL6RhSZjvb1k7Cr3D/qAFcz1KkdGh9Y1F9bEge1qno461WzI3juGlOhNdY
 xg4zSMtWRq0UQN5c13VAaSC7xA5jC4izoFulwwmcBj1CqM9Bd+jmgQrEpsbexbbVf5hI
 3uQlzZTVl+L8dDgUvclB7Z9spdJWrtS7FFdjvmiMNKSqijwuUjifvwzdmnFbLX8WoODO
 O41w==
X-Gm-Message-State: AOAM530Ixbz0XIHvNbtKRCNeWmrCb7yQ1doVdID6KCGAy01fDz1iqaCN
 fLwGb41ZS6QWRMl+XyH4GZ9hQh/9VHI5z7BjCmObTn+O+E/yqdo1uf4u1DGBjQD/SUTPKP88s/I
 EZWi3QWuu9Mfc1ao=
X-Received: by 2002:a5d:5092:: with SMTP id a18mr15274568wrt.42.1591973584872; 
 Fri, 12 Jun 2020 07:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa3FKBi+axwSWX+7/7m/yG2Mi06qHbaqCZm9dtzjBWj4ZkG396bwtpb9ll+MDJe6bFWblv/Q==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr15274549wrt.42.1591973584698; 
 Fri, 12 Jun 2020 07:53:04 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id 5sm14513623wrr.5.2020.06.12.07.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:53:04 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:53:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 55/58] acpi: ged: rename event memory region
Message-ID: <20200612141917.9446-56-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
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


