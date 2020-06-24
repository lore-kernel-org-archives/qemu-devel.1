Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA87C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4F0206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7R12VcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4F0206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEXk-00072J-Im
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETi-0008LS-TC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETg-0001O1-Qe
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sy5UuEMEVgAtCPDE5daNRSt9ncB2ZYgss6jFaBLRUiw=;
 b=E7R12VcACOxbBqqtPELa1fssAVsTvh2wDoFHKD9L7pbzWUJzxYzTsw1EkqSPARRxxmKcHX
 LLNQGJ3Yi98gbjBWPTkwX01TPtjRuaMiSOWIMrE1KNh80/SfeSbgs2c3DVPpftv7jDrvvg
 ZMWo4JuKmFSVkoMEZAIAMwr9BX06/QM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-V1XBCWGUM5aXMp3j8xoF-w-1; Wed, 24 Jun 2020 19:06:45 -0400
X-MC-Unique: V1XBCWGUM5aXMp3j8xoF-w-1
Received: by mail-wm1-f70.google.com with SMTP id g187so4665986wme.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Sy5UuEMEVgAtCPDE5daNRSt9ncB2ZYgss6jFaBLRUiw=;
 b=mxq0rNLMS0tvpbJFscYNwK9E40/5xQqTNDbv/Y/fVhK7ycnQrvgJmmRObbgMqjs2BB
 Xsph0+ZjJcWJUYeLqT95lihGJjHBF/w803Mn8UIb468pHu5RAOB8112TTMBHf0AvDW++
 CRWYtrSqdbHOe0P+IFGrFoXhSfgY0aqnUMaIJQAMRWlInO108kRsBT2HeCs5c2VlpLyf
 EGTZfqdGPgovOSSMIP5xvtalMnx5yug8GRojtTlMRcID9aKRvVhfDrmYsqpmQlIkb30P
 rCtC9BoJLjsBL7OQCwDR5/sSTN+JHxCjwK7O17ySeeYcDthSQizeYUlFr984H5b6PDHc
 e/Nw==
X-Gm-Message-State: AOAM533cW6pzSBZsytx/ClUCHFZLXMdohZtj8+ExhkBrJXFVi38hrzu5
 O0lwFXTmIwFwREgExsgwmHa/UTPZmEmD789juMGpFa+bF1BgmhUGl1GNQEieLrxe/lhH91uqZT5
 5Va0QFJrx41BDPPA=
X-Received: by 2002:a1c:acc3:: with SMTP id v186mr102486wme.79.1593040004057; 
 Wed, 24 Jun 2020 16:06:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZJsRmhkq89lNyMezMk+RsoqHPeMFLjdH/DVpMtpEz8LXw0DS7Bn93WxjX7yey8cHhti4iVg==
X-Received: by 2002:a1c:acc3:: with SMTP id v186mr102459wme.79.1593040003809; 
 Wed, 24 Jun 2020 16:06:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id 1sm9718686wmf.0.2020.06.24.16.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:43 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] floppy: move cmos_get_fd_drive_type() from pc
Message-ID: <20200624230609.703104-6-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Message-Id: <20200619091905.21676-6-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/block/fdc.h |  1 +
 include/hw/i386/pc.h   |  1 -
 hw/block/fdc.c         | 26 +++++++++++++++++++++++++-
 hw/i386/pc.c           | 25 -------------------------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 5d71cf9722..479cebc0a3 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -16,5 +16,6 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc);
 
 FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
+int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e6135c34d6..dce1273c7d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -178,7 +178,6 @@ typedef void (*cpu_set_smm_t)(int smm, void *arg);
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 
 ISADevice *pc_find_fdc0(void);
-int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
 /* port92.c */
 #define PORT92_A20_LINE "a20"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index f1da83f08e..4f0921298b 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -32,7 +32,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
-#include "hw/i386/pc.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
@@ -2812,6 +2811,31 @@ static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
     return dev;
 }
 
+int cmos_get_fd_drive_type(FloppyDriveType fd0)
+{
+    int val;
+
+    switch (fd0) {
+    case FLOPPY_DRIVE_TYPE_144:
+        /* 1.44 Mb 3"5 drive */
+        val = 4;
+        break;
+    case FLOPPY_DRIVE_TYPE_288:
+        /* 2.88 Mb 3"5 drive */
+        val = 5;
+        break;
+    case FLOPPY_DRIVE_TYPE_120:
+        /* 1.2 Mb 5"5 drive */
+        val = 2;
+        break;
+    case FLOPPY_DRIVE_TYPE_NONE:
+    default:
+        val = 0;
+        break;
+    }
+    return val;
+}
+
 static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
 {
     Aml *dev;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d103b8c0ab..e78e32b41b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -386,31 +386,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
 
 #define REG_EQUIPMENT_BYTE          0x14
 
-int cmos_get_fd_drive_type(FloppyDriveType fd0)
-{
-    int val;
-
-    switch (fd0) {
-    case FLOPPY_DRIVE_TYPE_144:
-        /* 1.44 Mb 3"5 drive */
-        val = 4;
-        break;
-    case FLOPPY_DRIVE_TYPE_288:
-        /* 2.88 Mb 3"5 drive */
-        val = 5;
-        break;
-    case FLOPPY_DRIVE_TYPE_120:
-        /* 1.2 Mb 5"5 drive */
-        val = 2;
-        break;
-    case FLOPPY_DRIVE_TYPE_NONE:
-    default:
-        val = 0;
-        break;
-    }
-    return val;
-}
-
 static void cmos_init_hd(ISADevice *s, int type_ofs, int info_ofs,
                          int16_t cylinders, int8_t heads, int8_t sectors)
 {
-- 
MST


