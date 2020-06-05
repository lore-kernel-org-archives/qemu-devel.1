Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC9A2065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gjki+Ps2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC9A2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDmn-0005y6-Kq
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlp-0003lV-9Z
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlo-0007TD-57
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591368991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUdVh67sTfjl/72Ut3/PpNVoa1OJlZV6J+orOzszels=;
 b=Gjki+Ps2C6JmgDb71zR0txKxw/mk2smFfxq685FQDxXi464SD4t5t4FKbkkbDNJ+3Pk1Ct
 tg1lrNIYjbhk9TN1SkRUkpzCFPa5JVCUpFkFB2Xk0FbMSHjoVYLsbtbU5Sai5JyCQ4bvuw
 9R1Tp1zA8MiqEqGzoByllgSON+0PhP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-oIkXqbI3O6C38V5CEuey-w-1; Fri, 05 Jun 2020 10:56:29 -0400
X-MC-Unique: oIkXqbI3O6C38V5CEuey-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD9F5100A61D;
 Fri,  5 Jun 2020 14:56:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A96A79CA0;
 Fri,  5 Jun 2020 14:56:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB40C11384A0; Fri,  5 Jun 2020 16:56:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] fdc: Open-code fdctrl_init_isa()
Date: Fri,  5 Jun 2020 16:56:14 +0200
Message-Id: <20200605145625.2920920-6-armbru@redhat.com>
In-Reply-To: <20200605145625.2920920-1-armbru@redhat.com>
References: <20200605145625.2920920-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Helper function fdctrl_init_isa() is less than helpful: one of three
places creating "isa-fdc" devices use it.  Open-code it there, and
drop the function.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
index 8c2d0edd48..35e734b6fb 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2562,20 +2562,6 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
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
index 0cffb67c2f..25c9577c15 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1141,7 +1141,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
     int i;
     DriveInfo *fd[MAX_FD];
     qemu_irq *a20_line;
-    ISADevice *i8042, *port92, *vmmouse;
+    ISADevice *fdc, *i8042, *port92, *vmmouse;
 
     serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
@@ -1151,7 +1151,11 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
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


