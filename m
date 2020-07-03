Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA46C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE002207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bfe/Njzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE002207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHeF-0003F0-4s
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbo-0006dT-Gq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbm-0004ND-Jr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zAm2WZsz8jFA4V7I3jZT5e4XH4Wdo1IJW/sufln0SFE=;
 b=Bfe/Njzg9k2XPtkrfhyxRp/zdDChCt+pxI4PPxj5fiajsUUJG180kdTghiGFSP9pT0TSlt
 Zf/11IbixrRi9znTb9tt9te2wxkEEqRAKirIouZRa0OzosY/1C+lSYHU2wf8yHNhyE661Y
 8Xkc+1dYepUUSjCzE5r2gWxNpBqcZC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-fWeBs5jfMnWlc70NENxPag-1; Fri, 03 Jul 2020 05:03:44 -0400
X-MC-Unique: fWeBs5jfMnWlc70NENxPag-1
Received: by mail-wm1-f70.google.com with SMTP id g187so34473955wme.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zAm2WZsz8jFA4V7I3jZT5e4XH4Wdo1IJW/sufln0SFE=;
 b=iTZzCG9InuDNZ09Q/yeCyt2usd6QVVUQGrSR/AP1AiyvFWVi+CxyEMaRcLXR4rbqu5
 zzQUpqv+NRXp4oQL5nQnSBbydGq1SPIRq/N/6OgWtsLPtP5h0Zm10lualiblWQTx7+t5
 O4Zd4+jWHHLY0vOp7WywETAfUw1FLfiArZtof3j+8/AZjHidZi4/AI8bCht+AI6aMrbV
 HO5Q+vcqdZa8gqI1FzT4TUV8rtfZLtm+ESYMw7OG8iMlzurl9Qkm0+hiWNYIxh7mzhWT
 6Hx+cCz9ezPrlKBHVsgjsJAXVWIgakNY7lZo+lzs+GltRPGzb+VfTeOdEUY7i0Gi4mZZ
 Kvgw==
X-Gm-Message-State: AOAM53267JbBPy87kgBpG8BFs0bxXGtzyq3rOuBJwF0KCSCPC2hmvFO1
 h6LvLs0waVFrifHT9VTE7Qehzy0CPRtccvC6SzS9NRESPzpCDxmpJb04l25Kjcac5DJR4p1cyyp
 083Qm99Fn/QttdDE=
X-Received: by 2002:a1c:b103:: with SMTP id a3mr35426326wmf.186.1593767022776; 
 Fri, 03 Jul 2020 02:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAwOkXJuUflto4b9dJWf5KWO22GkGrEzGFgLtLk73NjZ1tIdVgpxkN0p7zfjsDkR4HJo7w9Q==
X-Received: by 2002:a1c:b103:: with SMTP id a3mr35426314wmf.186.1593767022605; 
 Fri, 03 Jul 2020 02:03:42 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 q1sm13319920wro.82.2020.07.03.02.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:42 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] pc: Support coldplugging of virtio-pmem-pci devices on
 all buses
Message-ID: <20200703090252.368694-5-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20200626072248.78761-2-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4af9679d03..58b1425c17 100644
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
MST


