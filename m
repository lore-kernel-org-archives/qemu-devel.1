Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2102076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNV+RQdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2102076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joiiq-0000V6-07
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joiho-0007T5-6v
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:23:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joihl-0003Af-VL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593156201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5gcxusQzyzo3jSltVar2tBWqpPktP5b6qDTjVFvjTk=;
 b=MNV+RQdLMiMw0yn9jw0Zi+DvjEuJnKrAwXpkzDNLkmabwMIK49wi/FkDnYWkvKRsq1DMhb
 rebU9kC16WylBojYs7ntiTkoOUOI4wUoIFH+1tOanaiB8Ygel7+ZDpRoXTOtINrIMH93C3
 b4SSZbwhbyHrtA1LONRjE5uwud5fwBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-V9G5qmFIM82M1WqWRFUFRA-1; Fri, 26 Jun 2020 03:23:19 -0400
X-MC-Unique: V9G5qmFIM82M1WqWRFUFRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BE368015FB;
 Fri, 26 Jun 2020 07:23:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-35.ams2.redhat.com [10.36.113.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEDF360C1D;
 Fri, 26 Jun 2020 07:23:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/21] pc: Support coldplugging of virtio-pmem-pci devices
 on all buses
Date: Fri, 26 Jun 2020 09:22:28 +0200
Message-Id: <20200626072248.78761-2-david@redhat.com>
In-Reply-To: <20200626072248.78761-1-david@redhat.com>
References: <20200626072248.78761-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Richard Henderson <rth@twiddle.net>
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
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
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
index 803bd52ca4..2dfd69b973 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1643,13 +1643,13 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -1658,7 +1658,7 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
      */
     memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
                            &local_err);
-    if (!local_err) {
+    if (!local_err && hotplug_dev2) {
         hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
     }
     error_propagate(errp, local_err);
@@ -1676,9 +1676,11 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
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
2.26.2


