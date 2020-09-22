Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D442AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464D0221E7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0IualcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D0221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqrb-0002TR-EF
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjf-0008RR-Cz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjd-0006LM-Ik
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600813564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pD66mRra1s/USq9HMY95tB2B6J0Gqgyb9MdS85lj7Rw=;
 b=i0IualcQ+vZIXadKVpKDqzjSHTpngTLnjfYxsWhaI0RhUP/dGYs8owBILLKc6Qu0zb+AKP
 wPff0eMbYIotV6HwwIR1uq069hQGSU2V21jp1gyYIuA8RnIZZcM9dXprkx0X6V+Py92zqR
 vFn7HQcPgeG2T/CFqI+W3uQk1YhChz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-ldHHHItCO_KrZWRjDjzxRg-1; Tue, 22 Sep 2020 18:26:02 -0400
X-MC-Unique: ldHHHItCO_KrZWRjDjzxRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E15802B5E;
 Tue, 22 Sep 2020 22:26:01 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB38673670;
 Tue, 22 Sep 2020 22:26:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/11] i440fx: Register i440FX-pcihost properties as class
 properties
Date: Tue, 22 Sep 2020 18:25:40 -0400
Message-Id: <20200922222542.2354748-10-ehabkost@redhat.com>
In-Reply-To: <20200922222542.2354748-1-ehabkost@redhat.com>
References: <20200922222542.2354748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200921221045.699690-23-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci-host/i440fx.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index aecbcc2446e..28c9bae8994 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -210,22 +210,6 @@ static void i440fx_pcihost_initfn(Object *obj)
                           "pci-conf-idx", 4);
     memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
                           "pci-conf-data", 4);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
-                        i440fx_pcihost_get_pci_hole_start,
-                        NULL, NULL, NULL);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
-                        i440fx_pcihost_get_pci_hole_end,
-                        NULL, NULL, NULL);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
-                        i440fx_pcihost_get_pci_hole64_start,
-                        NULL, NULL, NULL);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
-                        i440fx_pcihost_get_pci_hole64_end,
-                        NULL, NULL, NULL);
 }
 
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
@@ -401,6 +385,22 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, i440fx_props);
     /* Reason: needs to be wired up by pc_init1 */
     dc->user_creatable = false;
+
+    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
+                              i440fx_pcihost_get_pci_hole_start,
+                              NULL, NULL, NULL);
+
+    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
+                              i440fx_pcihost_get_pci_hole_end,
+                              NULL, NULL, NULL);
+
+    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
+                              i440fx_pcihost_get_pci_hole64_start,
+                              NULL, NULL, NULL);
+
+    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
+                              i440fx_pcihost_get_pci_hole64_end,
+                              NULL, NULL, NULL);
 }
 
 static const TypeInfo i440fx_pcihost_info = {
-- 
2.26.2


