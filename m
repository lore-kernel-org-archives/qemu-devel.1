Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC0CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B30220838
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S18CL7q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B30220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuZc-0000Eh-1i
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuMP-00007d-FB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuM5-000856-6k
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600350824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odgLodS2G/U0lzGZ6RFORwdviL3pGpTx11UsgTu+KT0=;
 b=S18CL7q4stA8su88+UDmkda/P5bGsRhcN1xCXjrYe2uM+amWqRWCwtnMTrWKWpq+K0+vQk
 3THr+dCXS+r5D693zcyZp/KLrYuuslMnsAovL3kfnsnjS+tKrWtVzGtWZkPuohfO22tNdN
 q2S+wTpCQTa1n0TzctRIP6N22Tt/Pe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-K4P10ie-NWCDuFsZ-vrseQ-1; Thu, 17 Sep 2020 09:53:40 -0400
X-MC-Unique: K4P10ie-NWCDuFsZ-vrseQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F2F21084CA4;
 Thu, 17 Sep 2020 13:53:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3FF55767;
 Thu, 17 Sep 2020 13:53:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5519031F09; Thu, 17 Sep 2020 15:53:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] microvm: wire up hotplug
Date: Thu, 17 Sep 2020 15:53:18 +0200
Message-Id: <20200917135323.18022-17-kraxel@redhat.com>
In-Reply-To: <20200917135323.18022-1-kraxel@redhat.com>
References: <20200917135323.18022-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cpu hotplug code handles the initialization of coldplugged cpus
too, so it is needed even in case cpu hotplug is not supported.

Wire cpu hotplug up for microvm.
Without this we get a broken MADT table.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Message-id: 20200915120909.20838-17-kraxel@redhat.com
---
 hw/i386/microvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 9df15354ce0f..8de8ca864963 100644
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
 
@@ -524,6 +558,13 @@ static void microvm_class_init(ObjectClass *oc, void *data)
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
@@ -573,6 +614,7 @@ static const TypeInfo microvm_machine_info = {
     .class_size    = sizeof(MicrovmMachineClass),
     .class_init    = microvm_class_init,
     .interfaces = (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
          { }
     },
 };
-- 
2.27.0


