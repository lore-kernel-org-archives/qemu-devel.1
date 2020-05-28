Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A284C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EEE2088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMHV9hVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EEE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGTg-0006fx-Fm
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLP-0005u0-6c
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57698
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLG-0006lK-7N
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYidYnDI2p3H7kKvYlxCHJA+V3LjwOLpkoIpU+UA0lU=;
 b=CMHV9hVz9di9rsVsDA6Lk2wnBDDszPHXEk83dH/h6iokxF1WcSYUtAu5tabqBi5iIBqVpq
 PwFFPCoPmiYmnb2+Zi1e7+u9NeTKUaeV2RxPz/sFLCrW60ndAPxfxkuzgwAOqHnTGlFbOO
 zr3BQdBU+9HMRdLgsWeZfI6NyPWe1k0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-sl6wnlhTMSWaWEUsoNA2Cw-1; Thu, 28 May 2020 07:04:48 -0400
X-MC-Unique: sl6wnlhTMSWaWEUsoNA2Cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB51D835B42;
 Thu, 28 May 2020 11:04:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DD060CD1;
 Thu, 28 May 2020 11:04:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D2B5611358C0; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
Date: Thu, 28 May 2020 13:04:29 +0200
Message-Id: <20200528110444.20456-10-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cuda_init() creates a "mos6522-cuda" device, but it's never realized.
Affects machines mac99 with via=cuda (default) and g3beige.

pmu_init() creates a "mos6522-pmu" device, but it's never realized.
Affects machine mac99 with via=pmu and via=pmu-adb,

In theory, a device becomes real only on realize.  In practice, the
transition from unreal to real is a fuzzy one.  The work to make a
device real can be spread between realize methods (fine),
instance_init methods (wrong), and board code wiring up the device
(fine as long as it effectively happens on realize).  Depending on
what exactly is done where, a device can work even when we neglect
to realize it.

These onetwo appear to work.  Nevertheless, it's a clear misuse of the
interface.  Even when it works today (more or less by chance), it can
break tomorrow.

Fix by realizing them in cuda_realize() and pmu_realize(),
respectively.

Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/macio/cuda.c | 10 +++++-----
 hw/misc/macio/pmu.c  | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index e0cc0aac5d..763a785f1a 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -33,6 +33,7 @@
 #include "hw/misc/macio/cuda.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -523,15 +524,14 @@ static void cuda_realize(DeviceState *dev, Error **errp)
 {
     CUDAState *s = CUDA(dev);
     SysBusDevice *sbd;
-    MOS6522State *ms;
-    DeviceState *d;
     struct tm tm;
 
+    object_property_set_bool(OBJECT(&s->mos6522_cuda), true, "realized",
+                             &error_abort);
+
     /* Pass IRQ from 6522 */
-    d = DEVICE(&s->mos6522_cuda);
-    ms = MOS6522(d);
     sbd = SYS_BUS_DEVICE(s);
-    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->mos6522_cuda));
 
     qemu_get_timedate(&tm, 0);
     s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 9a9cd427e1..4264779396 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -40,6 +40,7 @@
 #include "hw/misc/macio/pmu.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -740,15 +741,14 @@ static void pmu_realize(DeviceState *dev, Error **errp)
 {
     PMUState *s = VIA_PMU(dev);
     SysBusDevice *sbd;
-    MOS6522State *ms;
-    DeviceState *d;
     struct tm tm;
 
+    object_property_set_bool(OBJECT(&s->mos6522_pmu), true, "realized",
+                             &error_abort);
+
     /* Pass IRQ from 6522 */
-    d = DEVICE(&s->mos6522_pmu);
-    ms = MOS6522(d);
     sbd = SYS_BUS_DEVICE(s);
-    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->mos6522_pmu));
 
     qemu_get_timedate(&tm, 0);
     s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
-- 
2.21.3


