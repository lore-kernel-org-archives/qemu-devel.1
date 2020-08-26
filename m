Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D433C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F7D2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsphT6Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F7D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAzsw-0004CM-CC
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 14:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAzsI-0003cB-1K
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:10:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAzsF-0005HH-Ot
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598465414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PiApvT1sTiwwUhR3nn4DVseSe1rzlHNor0YuHEpkx1A=;
 b=UsphT6Pclaj0ybo7g7RP3k1vFNIp0TUBAKqVj0BOrF3f7jUKHicDwN7PxHbQgPV3q0jnUK
 1o0fDFhTodPVeeyCs3cpUdxDc4Uigb/FvUUVXCA9n1iZrr3UwsdknPVkW7QViTybxFTlAf
 EoCxi5qfHM9Wc2qHf2XWOQsfdi7GjJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-wWgFRKcxNuaxoPWIhxloQQ-1; Wed, 26 Aug 2020 14:10:09 -0400
X-MC-Unique: wWgFRKcxNuaxoPWIhxloQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 659C210ABDDC;
 Wed, 26 Aug 2020 18:10:08 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25C535C1DA;
 Wed, 26 Aug 2020 18:10:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] armsse: Define ARMSSEClass correctly
Date: Wed, 26 Aug 2020 14:10:06 -0400
Message-Id: <20200826181006.4097163-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 14:10:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_ARM_SSE is a TYPE_SYS_BUS_DEVICE subclass, but
ARMSSEClass::parent_class is declared as DeviceClass.

It never caused any problems by pure luck:

We were not setting class_size for TYPE_ARM_SSE, so class_size of
TYPE_SYS_BUS_DEVICE was being used (sizeof(SysBusDeviceClass)).
This made the system allocate enough memory for TYPE_ARM_SSE
devices even though ARMSSEClass was too small for a sysbus
device.

Additionally, the ARMSSEClass::info field ended up at the same
offset as SysBusDeviceClass::explicit_ofw_unit_address.  This
would make sysbus_get_fw_dev_path() crash for the device.
Luckily, sysbus_get_fw_dev_path() never gets called for
TYPE_ARM_SSE devices, because qdev_get_fw_dev_path() is only used
by the boot device code, and TYPE_ARM_SSE devices don't appear at
the fw_boot_order list.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
---
 include/hw/arm/armsse.h | 2 +-
 hw/arm/armsse.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 84080c2299..b10173beab 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -220,7 +220,7 @@ typedef struct ARMSSE {
 typedef struct ARMSSEInfo ARMSSEInfo;
 
 typedef struct ARMSSEClass {
-    DeviceClass parent_class;
+    SysBusDeviceClass parent_class;
     const ARMSSEInfo *info;
 } ARMSSEClass;
 
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index dcbff9bd8f..6381bbd94d 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1160,6 +1160,7 @@ static const TypeInfo armsse_info = {
     .name = TYPE_ARMSSE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMSSE),
+    .class_size = sizeof(ARMSSEClass),
     .instance_init = armsse_init,
     .abstract = true,
     .interfaces = (InterfaceInfo[]) {
-- 
2.26.2


