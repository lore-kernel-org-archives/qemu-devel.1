Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A847C433F8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8352072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7M8REck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8352072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjv5-0001CJ-4S
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpp-0001fu-AG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpl-0007hw-4n
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592922212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6+SXKHm2YJJ94V216e5x2QAVQmPP4XEKgLli7B7ET0=;
 b=Z7M8REckMkKRVOk5a+RZ+ByiY3EQoxV7AGzeRcEFfiohX6nurYwbpnoGuM+PCZKLMGVF4j
 AJKy9ZrOsU80iWtlC+xd6wXq7z3AQWm2btPC/hKDTVM1+l8ky0z7iBN8uUDKSdHayUvQ6i
 1EKvx4fdgZsPc4hNT1L1Dgr7/xXUswc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-6Q5DdsPTN1KsTWlTXXv30A-1; Tue, 23 Jun 2020 10:23:30 -0400
X-MC-Unique: 6Q5DdsPTN1KsTWlTXXv30A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E4E0107BEF8
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 580871002393;
 Tue, 23 Jun 2020 14:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 480511138473; Tue, 23 Jun 2020 16:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] fdc: Open-code fdctrl_init_isa()
Date: Tue, 23 Jun 2020 16:23:15 +0200
Message-Id: <20200623142326.2349416-6-armbru@redhat.com>
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
References: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Helper function fdctrl_init_isa() is less than helpful: one of three
places creating "isa-fdc" devices use it.  Open-code it there, and
drop the function.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200622094227.1271650-6-armbru@redhat.com>
---
 include/hw/block/fdc.h |  1 -
 hw/block/fdc.c         | 14 --------------
 hw/i386/pc.c           |  8 ++++++--
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 8855d3476c..d232d3fa1e 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -10,7 +10,6 @@
 #define TYPE_ISA_FDC "isa-fdc"
 
 void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds);
-ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds);
 void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
                         hwaddr mmio_base, DriveInfo **fds);
 void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2650dcb0df..d1f7722cff 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2565,20 +2565,6 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
     }
 }
 
-ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds)
-{
-    ISADevice *isadev;
-
-    isadev = isa_try_new(TYPE_ISA_FDC);
-    if (!isadev) {
-        return NULL;
-    }
-    isa_realize_and_unref(isadev, bus, &error_fatal);
-
-    isa_fdc_init_drives(isadev, fds);
-    return isadev;
-}
-
 void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
                         hwaddr mmio_base, DriveInfo **fds)
 {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d103b8c0ab..f670bcd6e6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1142,7 +1142,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
     int i;
     DriveInfo *fd[MAX_FD];
     qemu_irq *a20_line;
-    ISADevice *i8042, *port92, *vmmouse;
+    ISADevice *fdc, *i8042, *port92, *vmmouse;
 
     serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
@@ -1152,7 +1152,11 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
         create_fdctrl |= !!fd[i];
     }
     if (create_fdctrl) {
-        fdctrl_init_isa(isa_bus, fd);
+        fdc = isa_new(TYPE_ISA_FDC);
+        if (fdc) {
+            isa_realize_and_unref(fdc, isa_bus, &error_fatal);
+            isa_fdc_init_drives(fdc, fd);
+        }
     }
 
     i8042 = isa_create_simple(isa_bus, "i8042");
-- 
2.26.2


