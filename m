Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA86C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50FE20720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itoGwq0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50FE20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmyP-0007qS-O3
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmv0-0002es-0W
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49091
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmux-0001Is-HP
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zAm2WZsz8jFA4V7I3jZT5e4XH4Wdo1IJW/sufln0SFE=;
 b=itoGwq0YcoOjKl/jEqZToFwU9GK9VeCVIAF/TscmnvEUWmyn3dj/SqBmf/RXBxZzhA+u3P
 t9XHUvLI3cBI2usxnhg/F495J6x7vm6umIsD9b2cI4HsDG82X3dBq6Zl2qUPOAzImqDjRX
 ddZLiVGtfyndv6zsNzBYbMxkEn4ndoM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-r5BGi9uUMhmtKJM7Lpb6Mw-1; Sat, 04 Jul 2020 14:29:36 -0400
X-MC-Unique: r5BGi9uUMhmtKJM7Lpb6Mw-1
Received: by mail-wr1-f69.google.com with SMTP id y13so36372883wrp.13
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zAm2WZsz8jFA4V7I3jZT5e4XH4Wdo1IJW/sufln0SFE=;
 b=juvjcO0knz32VdnGfKHJjZubQZT3eg897/DyZWW8LX5Uic3pGJRCndvm3mpzmh4oJX
 IVoEV9AdhKnHK4quDwKZsvrk8P6TagL1MTJJLqvmNqdXWxFReZS01X0otSG15WMau4ki
 Ax44bsbJREysIbQycXXXE6Z1ELgzOpHam+lIUHc13+bWdu0qXsCqO+ZhXIBmkRry8ynF
 ZxZBEh7T2WcgyhoWJTiJd/YLi0Jeqyx/Rcfl7GpFywyMfqt/yEAN6x9ri3YMtx+pZlKJ
 DH+UY9Jpa9sbJBZvPlwmJOVimWxU2ONqvDJ34uEmdNkQ4nmY3XZF26dFJDomWlaftJhW
 p1VA==
X-Gm-Message-State: AOAM533eG48A/7rH9bt/LvD2fGBKEuEfSET+ZdpzqP1A95fDqarr7koQ
 NN/vbt9w2NzkeTqzXrPhiaXkjJg9WN2Gq+WHxrdAjesovEYNbi94KbsHWLITkrKLDe+02SE1EM8
 0a7HTAq8V8oKTHTY=
X-Received: by 2002:adf:fa81:: with SMTP id h1mr43872385wrr.288.1593887375635; 
 Sat, 04 Jul 2020 11:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPT2IaD1JL44r79iuBa7ESJw3EaC1FsfABCBydH/JVo1xurbkbMytgYPHmjg3qW+zJ/XKFew==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr43872369wrr.288.1593887375433; 
 Sat, 04 Jul 2020 11:29:35 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 k11sm19031491wrd.23.2020.07.04.11.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:34 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/41] pc: Support coldplugging of virtio-pmem-pci devices
 on all buses
Message-ID: <20200704182750.1088103-5-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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


