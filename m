Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63532076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clXIh/5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63532076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbxm-0002Md-Ub
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbtC-0000ws-Oq
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbt8-0001A8-51
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=LPk/K8GrD/Jhym9VrAD6qN9aiQESE5af/q2mJvKNAes=;
 b=clXIh/5jcvY9nmOiW/1bgjpvgnLmIwJsKrNzpLwVLwDsz0239O/18xHITYnqDG6nDnOrqN
 wH7LymFShRydcaBseKkeTjxoXPJlQnQqkYD68y7aJ7LYX/CSyL3LzQbmZjeSlX4DdQgPBV
 DEI3D19XWxcHyi81iVT9FeeWiST3jH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-1qntiT8YMyWaLTag0reHbQ-1; Fri, 15 May 2020 11:04:33 -0400
X-MC-Unique: 1qntiT8YMyWaLTag0reHbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5BBA107ACF6;
 Fri, 15 May 2020 15:04:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 198F162491;
 Fri, 15 May 2020 15:04:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 095579D63; Fri, 15 May 2020 17:04:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/16] floppy: move cmos_get_fd_drive_type() from pc
Date: Fri, 15 May 2020 17:04:15 +0200
Message-Id: <20200515150421.25479-11-kraxel@redhat.com>
In-Reply-To: <20200515150421.25479-1-kraxel@redhat.com>
References: <20200515150421.25479-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

---
 include/hw/block/fdc.h |  1 +
 include/hw/i386/pc.h   |  1 -
 hw/block/fdc.c         | 26 +++++++++++++++++++++++++-
 hw/i386/pc.c           | 25 -------------------------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 5d71cf972268..479cebc0a330 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -16,5 +16,6 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc);
 
 FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
+int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8d764f965cd3..5e3b19ab78fc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -176,7 +176,6 @@ typedef void (*cpu_set_smm_t)(int smm, void *arg);
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 
 ISADevice *pc_find_fdc0(void);
-int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
 /* port92.c */
 #define PORT92_A20_LINE "a20"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 8024c822cea3..ea0fb8ee15b9 100644
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
@@ -2809,6 +2808,31 @@ static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
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
index 2128f3d6fe8b..c5db7be6d8b1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -385,31 +385,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
 
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
2.18.4


