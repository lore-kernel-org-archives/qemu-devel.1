Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE6AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D60206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoNCfsSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D60206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8kW-00047C-P6
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jd8jg-0003Cx-Ej
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jd8je-0006Rh-NH
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590396325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yx60i0P+Y5+yL9Gfm4qdTuySFgAk/O7/ZnCKS/1J1OU=;
 b=LoNCfsSE7agP5MUMWuqiXkuaMOWlyTQp5zykqxaRyIXnJZSrh/oKijlqU9vjb2+OqpeRFO
 fF2lDR1oV87DD0HD0sfJVFpu1WDKVc78ugbNZ2n5El79Ya1Dp+ebx+9/sowZcEsFTFVEVz
 MaKKEZXM+86/HzPUwo2xFBPpNzw7IQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-dmip5IV0P9maGeV_BwLQeQ-1; Mon, 25 May 2020 04:45:21 -0400
X-MC-Unique: dmip5IV0P9maGeV_BwLQeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C705C108BD0A;
 Mon, 25 May 2020 08:45:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-237.ams2.redhat.com [10.36.113.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 006975D9C5;
 Mon, 25 May 2020 08:45:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on all
 buses
Date: Mon, 25 May 2020 10:45:11 +0200
Message-Id: <20200525084511.51379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:54:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

E.g., with "pc-q35-4.2", trying to coldplug a virtio-pmem-pci devices
results in
    "virtio-pmem-pci not supported on this bus"

Reasons is, that the bus does not support hotplug and, therefore, does
not have a hotplug handler. Let's allow coldplugging virtio-pmem devices
on such buses. The hotplug order is only relevant for virtio-pmem-pci
when the guest is already alive and the device is visible before
memory_device_plug() wired up the memory device bits.

Hotplug attempts will still fail with:
    "Error: Bus 'pcie.0' does not support hotplugging"

Hotunplug attempts will still fail with:
    "Error: Bus 'pcie.0' does not support hotplugging"

Reported-by: Vivek Goyal <vgoyal@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2128f3d6fe..c740495eb6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1663,13 +1663,13 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
     HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
     Error *local_err = NULL;
 
-    if (!hotplug_dev2) {
+    if (!hotplug_dev2 && dev->hotplugged) {
         /*
          * Without a bus hotplug handler, we cannot control the plug/unplug
-         * order. This should never be the case on x86, however better add
-         * a safety net.
+         * order. We should never reach this point when hotplugging on x86,
+         * however, better add a safety net.
          */
-        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
+        error_setg(errp, "virtio-pmem-pci hotplug not supported on this bus.");
         return;
     }
     /*
@@ -1678,7 +1678,7 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
      */
     memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
                            &local_err);
-    if (!local_err) {
+    if (!local_err && hotplug_dev2) {
         hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
     }
     error_propagate(errp, local_err);
@@ -1696,9 +1696,11 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
      * device bits.
      */
     memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
-    hotplug_handler_plug(hotplug_dev2, dev, &local_err);
-    if (local_err) {
-        memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+    if (hotplug_dev2) {
+        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
+        if (local_err) {
+            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+        }
     }
     error_propagate(errp, local_err);
 }
-- 
2.25.4


