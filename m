Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86101C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E5620708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfeU8iAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E5620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnDt-0000sb-KB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsn7j-0008EJ-Ns
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:54:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsn7i-0004sv-6u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594126497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Z16Tgq/lHTtNURBIfdG7/VdPyWMNzUE7lIxlb0vcRX8=;
 b=ZfeU8iAJQGCCP5d9TsHsCahp9gffcp0ICsTHErZvDJ8gtN3qUmt/WjADgfYv1OjjnN7I/e
 M0JlUg+iaJp/5HupBiwM7TlkiZ+c7fOSP8n/NAQi8czcjIK0i6sAMDBB1EX/b0OmvilpBF
 2BP4x5QL2KH6XXLzcRzs/y6o+hg5Wqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-RkvcAhOnMXm2yandsucMjA-1; Tue, 07 Jul 2020 08:54:52 -0400
X-MC-Unique: RkvcAhOnMXm2yandsucMjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAF17891555;
 Tue,  7 Jul 2020 12:54:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CB2610023A7;
 Tue,  7 Jul 2020 12:54:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A338231F99; Tue,  7 Jul 2020 14:53:57 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/20] microvm: wire up hotplug
Date: Tue,  7 Jul 2020 14:53:52 +0200
Message-Id: <20200707125356.32450-17-kraxel@redhat.com>
In-Reply-To: <20200707125356.32450-1-kraxel@redhat.com>
References: <20200707125356.32450-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cpu hotplug code handles the initialization of coldplugged cpus
too, so it is needed even in case cpu hotplug is not supported.

Wire cpu hotplug up for microvm.
Without this we get a broken MADT table.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/microvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 3d8a66cfc3ac..a5b16b728f9f 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -320,6 +320,39 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
     g_free(cmdline);
 }
 
+static void microvm_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    x86_cpu_pre_plug(hotplug_dev, dev, errp);
+}
+
+static void microvm_device_plug_cb(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    x86_cpu_plug(hotplug_dev, dev, errp);
+}
+
+static void microvm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                             DeviceState *dev, Error **errp)
+{
+    error_setg(errp, "unplug not supported by microvm");
+}
+
+static void microvm_device_unplug_cb(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    error_setg(errp, "unplug not supported by microvm");
+}
+
+static HotplugHandler *microvm_get_hotplug_handler(MachineState *machine,
+                                                   DeviceState *dev)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        return HOTPLUG_HANDLER(machine);
+    }
+    return NULL;
+}
+
 static void microvm_machine_state_init(MachineState *machine)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(machine);
@@ -503,6 +536,7 @@ static void microvm_machine_initfn(Object *obj)
 static void microvm_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->init = microvm_machine_state_init;
 
@@ -523,6 +557,13 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     /* Machine class handlers */
     mc->reset = microvm_machine_reset;
 
+    /* hotplug (for cpu coldplug) */
+    mc->get_hotplug_handler = microvm_get_hotplug_handler;
+    hc->pre_plug = microvm_device_pre_plug_cb;
+    hc->plug = microvm_device_plug_cb;
+    hc->unplug_request = microvm_device_unplug_request_cb;
+    hc->unplug = microvm_device_unplug_cb;
+
     object_class_property_add(oc, MICROVM_MACHINE_PIC, "OnOffAuto",
                               microvm_machine_get_pic,
                               microvm_machine_set_pic,
@@ -572,6 +613,7 @@ static const TypeInfo microvm_machine_info = {
     .class_size    = sizeof(MicrovmMachineClass),
     .class_init    = microvm_class_init,
     .interfaces = (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
          { }
     },
 };
-- 
2.18.4


