Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C5C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CF2207E8
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk3gvkGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CF2207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9vK-0002vX-Mw
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lJ-00046E-Km
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lF-0006gN-Jk
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFZIkXFOAgybJAPH2U4fM+2A0t74nWu4tXE43Va7XeI=;
 b=Wk3gvkGFm1rbDWdCA7/zSkUtgJLChb+hHfyvTQo/9bIuF/Rb1kosO3uToS3BnczLa2Ya/D
 I61a20HOeGfdbWaOE4hRo4slaH3jYJoPGEkEEdPXPvReHs3aSvhNSQogVA4L+EvMykOvBH
 E6hlejvWM2vqeBkI2mX60R/oSLhJ3SM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-X7SbjfZqMnyTG2KI6_yx4g-1; Sat, 10 Oct 2020 03:57:46 -0400
X-MC-Unique: X7SbjfZqMnyTG2KI6_yx4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68AD88030CA;
 Sat, 10 Oct 2020 07:57:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 290236EF4F;
 Sat, 10 Oct 2020 07:57:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/39] qom: fix objects with improper parent type
Date: Sat, 10 Oct 2020 03:57:13 -0400
Message-Id: <20201010075739.951385-14-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Sergey Nizovtsev <snizovtsev@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some objects accidentally inherit ObjectClass instead of Object.
They compile silently but may crash after downcasting.

In this patch, we introduce a coccinelle script to find broken
declarations and fix them manually with proper base type.

Signed-off-by: Sergey Nizovtsev <snizovtsev@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                              |  1 +
 include/hw/acpi/vmgenid.h                |  2 +-
 include/hw/misc/vmcoreinfo.h             |  2 +-
 include/net/can_host.h                   |  2 +-
 scripts/coccinelle/qom-parent-type.cocci | 26 ++++++++++++++++++++++++
 5 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent-type.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ef459a33c..fcb2c03c2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2462,6 +2462,7 @@ F: include/monitor/qdev.h
 F: include/qom/
 F: qapi/qom.json
 F: qapi/qdev.json
+F: scripts/coccinelle/qom-parent-type.cocci
 F: softmmu/qdev-monitor.c
 F: qom/
 F: tests/check-qom-interface.c
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index d50fbacb8e..cb4ad37fc5 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -19,7 +19,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(VmGenIdState, VMGENID)
 
 struct VmGenIdState {
-    DeviceClass parent_obj;
+    DeviceState parent_obj;
     QemuUUID guid;                /* The 128-bit GUID seen by the guest */
     uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian) */
 };
diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index ebada6617a..0b7b55d400 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -24,7 +24,7 @@ DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
 typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
 
 struct VMCoreInfoState {
-    DeviceClass parent_obj;
+    DeviceState parent_obj;
 
     bool has_vmcoreinfo;
     FWCfgVMCoreInfo vmcoreinfo;
diff --git a/include/net/can_host.h b/include/net/can_host.h
index 4e3ce3f954..caab71bdda 100644
--- a/include/net/can_host.h
+++ b/include/net/can_host.h
@@ -35,7 +35,7 @@
 OBJECT_DECLARE_TYPE(CanHostState, CanHostClass, CAN_HOST)
 
 struct CanHostState {
-    ObjectClass oc;
+    Object oc;
 
     CanBusState *bus;
     CanBusClientState bus_client;
diff --git a/scripts/coccinelle/qom-parent-type.cocci b/scripts/coccinelle/qom-parent-type.cocci
new file mode 100644
index 0000000000..9afb3edd97
--- /dev/null
+++ b/scripts/coccinelle/qom-parent-type.cocci
@@ -0,0 +1,26 @@
+// Highlight object declarations that don't look like object class but
+// accidentally inherit from it.
+
+@match@
+identifier obj_t, fld;
+type parent_t =~ ".*Class$";
+@@
+struct obj_t {
+    parent_t fld;
+    ...
+};
+
+@script:python filter depends on match@
+obj_t << match.obj_t;
+@@
+is_class_obj = obj_t.endswith('Class')
+cocci.include_match(not is_class_obj)
+
+@replacement depends on filter@
+identifier match.obj_t, match.fld;
+type match.parent_t;
+@@
+struct obj_t {
+*   parent_t fld;
+    ...
+};
-- 
2.26.2



