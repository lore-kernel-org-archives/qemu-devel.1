Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49D1206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El8iBew3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49D1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIHp-0005Mr-TF
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9O-00023w-RE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:41:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9M-0006UY-CR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KI4Lf/FaagIQuHMtuVrkntDd4A5CmoFR5x1U+oe+5VI=;
 b=El8iBew3jECyK1ocbnDiAOctpu52RK2qvLdtPTFxHb1b/zBxTfq/7Gx6tZJcKY6ST9Vj0F
 bpbiXTXPWgdJGfYv9qtgHAAfPW8pVG0/cEpKm+dARt+ktEA52edgKTfYfzZIejTVJ+xXwW
 sEORjkyr3OfxQAv9BWBXY/P2nM10qyM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-NMSxa-lpNaudnGsJHeKIEQ-1; Thu, 27 Aug 2020 09:41:04 -0400
X-MC-Unique: NMSxa-lpNaudnGsJHeKIEQ-1
Received: by mail-wm1-f71.google.com with SMTP id a5so2067726wmj.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KI4Lf/FaagIQuHMtuVrkntDd4A5CmoFR5x1U+oe+5VI=;
 b=LMlNEICBZE2HYB6ktvT1XYz0+f4tXJ0n33VM+n7nTNJ2wp9mO/an133lsxlQJvjYaI
 MWnu9SR/cHe6QUsENQ0nNWytVp9MTbqmfj9Hl4kiDRwuxo/yKJ9GHdBO0ukqxJrd7eez
 +zJ2veC32O1/x8vWvGRLBjY+LdZ28JQ1cDJymIlsCXhLL+unwXBqgGLHSDn3Rm/xCY55
 XaqszA3gcKQeMhpoaHFwi4Z3KdH8fvBusU0FfKz1gUMUkdimvvwQPipxSuTFxClLZ32F
 B3/5FlQlVLP7kVR/yzEn5Or26VqqRfTiUWNSr/ezBbLE/aoIoLI1J0AxouOdWXfeCVaz
 Pz1A==
X-Gm-Message-State: AOAM533UwTmi9TQvE+/ezxTsG0PgieZ/oaJj7WQVfxdkiUChSYYOWwyO
 f7tVxy0Igt/gTSi6MyI0sry2VaQNz3Lz7X53f+WBHsFGkKg17rxJWdW9WPGmGP7CTAV8ssR1qHF
 uDwwxdeVBvEFrT7s=
X-Received: by 2002:a1c:818e:: with SMTP id
 c136mr12402092wmd.170.1598535660291; 
 Thu, 27 Aug 2020 06:41:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUU6kiMw9xzNcEeTGEJWm8GRnVjYsTl/OIa8FCGlg4KHDd2K4kW9RoHObR++Cwk26AIo6xUA==
X-Received: by 2002:a1c:818e:: with SMTP id
 c136mr12402070wmd.170.1598535660007; 
 Thu, 27 Aug 2020 06:41:00 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id k11sm5981258wrq.85.2020.08.27.06.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:59 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] hw/smbios: add options for type 4 max-speed and
 current-speed
Message-ID: <20200827133954.2118749-13-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ying Fang <fangying1@huawei.com>, Peter Maydell <peter.maydell@linaro.org>,
 Heyi Guo <guoheyi@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ying Fang <fangying1@huawei.com>

Common VM users sometimes care about CPU speed, so we add two new
options to allow VM vendors to present CPU speed to their users.
Normally these information can be fetched from host smbios.

Strictly speaking, the "max speed" and "current speed" in type 4
are not really for the max speed and current speed of processor, for
"max speed" identifies a capability of the system, and "current speed"
identifies the processor's speed at boot (see smbios spec), but some
applications do not tell the differences.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Message-Id: <20200806035634.376-2-fangying1@huawei.com>
---
 hw/smbios/smbios.c | 36 ++++++++++++++++++++++++++++++++----
 qemu-options.hx    |  2 +-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index f560826904..7cc950b41c 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -92,9 +92,21 @@ static struct {
     const char *manufacturer, *version, *serial, *asset, *sku;
 } type3;
 
+/*
+ * SVVP requires max_speed and current_speed to be set and not being
+ * 0 which counts as unknown (SMBIOS 3.1.0/Table 21). Set the
+ * default value to 2000MHz as we did before.
+ */
+#define DEFAULT_CPU_SPEED 2000
+
 static struct {
     const char *sock_pfx, *manufacturer, *version, *serial, *asset, *part;
-} type4;
+    uint64_t max_speed;
+    uint64_t current_speed;
+} type4 = {
+    .max_speed = DEFAULT_CPU_SPEED,
+    .current_speed = DEFAULT_CPU_SPEED
+};
 
 static struct {
     size_t nvalues;
@@ -272,6 +284,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
         .name = "version",
         .type = QEMU_OPT_STRING,
         .help = "version number",
+    },{
+        .name = "max-speed",
+        .type = QEMU_OPT_NUMBER,
+        .help = "max speed in MHz",
+    },{
+        .name = "current-speed",
+        .type = QEMU_OPT_NUMBER,
+        .help = "speed at system boot in MHz",
     },{
         .name = "serial",
         .type = QEMU_OPT_STRING,
@@ -586,9 +606,8 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
     t->voltage = 0;
     t->external_clock = cpu_to_le16(0); /* Unknown */
-    /* SVVP requires max_speed and current_speed to not be unknown. */
-    t->max_speed = cpu_to_le16(2000); /* 2000 MHz */
-    t->current_speed = cpu_to_le16(2000); /* 2000 MHz */
+    t->max_speed = cpu_to_le16(type4.max_speed);
+    t->current_speed = cpu_to_le16(type4.current_speed);
     t->status = 0x41; /* Socket populated, CPU enabled */
     t->processor_upgrade = 0x01; /* Other */
     t->l1_cache_handle = cpu_to_le16(0xFFFF); /* N/A */
@@ -1116,6 +1135,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type4.serial, opts, "serial");
             save_opt(&type4.asset, opts, "asset");
             save_opt(&type4.part, opts, "part");
+            type4.max_speed = qemu_opt_get_number(opts, "max-speed",
+                                                  DEFAULT_CPU_SPEED);
+            type4.current_speed = qemu_opt_get_number(opts, "current-speed",
+                                                      DEFAULT_CPU_SPEED);
+            if (type4.max_speed > UINT16_MAX ||
+                type4.current_speed > UINT16_MAX) {
+                error_setg(errp, "SMBIOS CPU speed is too large (> %d)",
+                           UINT16_MAX);
+            }
             return;
         case 11:
             if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, errp)) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 708583b4ce..30019c4eca 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2294,7 +2294,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "              [,sku=str]\n"
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
-    "              [,asset=str][,part=str]\n"
+    "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str]\n"
     "               [,asset=str][,part=str][,speed=%d]\n"
-- 
MST


