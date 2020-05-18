Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDA9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773F7207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6GeDbyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773F7207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaY4n-00073b-L0
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwo-0008OY-Vc
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23632
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwm-0004LK-BW
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emXT/wmPpZzn/OIwnrOBOwLJv1UDO9e9ek3pHIpAiwc=;
 b=i6GeDbyir4gmUbHrUtObVl8Ak84f3PAj2meCGQSvGe2kC2FDV2ufIdpH08Ik/yr4Bo/Jjq
 1YliZ3bimSV1EmpQkMQkYg+eZYX7LTkmSiw+jfUwpdZJjTk4/1w4vIyuwcb/AyNyMMVuE9
 XTt53z8Nr5URsRixa6z6PluVcWYKyQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-E3IuQ-qoOUCx6RushafO5g-1; Mon, 18 May 2020 01:04:13 -0400
X-MC-Unique: E3IuQ-qoOUCx6RushafO5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44941107ACCD;
 Mon, 18 May 2020 05:04:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 317CF5D9DD;
 Mon, 18 May 2020 05:04:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3229211358C5; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/24] macio: Fix to realize "mos6522-cuda" and "mos6522-pmu"
 devices
Date: Mon, 18 May 2020 07:03:53 +0200
Message-Id: <20200518050408.4579-10-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

I wonder how this ever worked.  If the "device becomes real only on
realize" thing actually works, then we've always been missing these
devices, yet nobody noticed.

Fix by realizing them in cuda_realize() and pmu_realize(),
respectively.

Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/macio/cuda.c | 8 +++-----
 hw/misc/macio/pmu.c  | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index e0cc0aac5d..6d4d135f71 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -523,15 +523,13 @@ static void cuda_realize(DeviceState *dev, Error **errp)
 {
     CUDAState *s = CUDA(dev);
     SysBusDevice *sbd;
-    MOS6522State *ms;
-    DeviceState *d;
     struct tm tm;
 
+    qdev_init_nofail(DEVICE(&s->mos6522_cuda));
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
index 9a9cd427e1..e29ca5e6cc 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -740,15 +740,13 @@ static void pmu_realize(DeviceState *dev, Error **errp)
 {
     PMUState *s = VIA_PMU(dev);
     SysBusDevice *sbd;
-    MOS6522State *ms;
-    DeviceState *d;
     struct tm tm;
 
+    qdev_init_nofail(DEVICE(&s->mos6522_pmu));
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
2.21.1


