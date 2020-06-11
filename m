Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70E5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FED206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSO+amRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FED206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTYk-0006Ru-A7
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8u-0007tW-Ds
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8s-00011u-00
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjlB80Koby3bUcNCP1SMMXQG/Rg7x+AxPJv8cE+Cwoo=;
 b=NSO+amRl1abcnZfhcVOC/mqrjOjKvLR7GFde+tdfyjiztw3YM1xpRx2M7f9mqTL02gzv+C
 m4LI5cVUjMn8IDcwas+gcomW88In8Aal2r1JXJJ+JydOrv6USb1oONUez0oMS6EGDxh4px
 /QDNsE+sYNl6+yppj3b4WCdX5bT6XO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-qN8xpH4gMai0TI1T3yAZPg-1; Thu, 11 Jun 2020 15:45:23 -0400
X-MC-Unique: qN8xpH4gMai0TI1T3yAZPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A945DA0C01;
 Thu, 11 Jun 2020 19:45:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B53B7E589;
 Thu, 11 Jun 2020 19:45:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 034/115] hw/i386/vmport: Add support for CMD_GET_VCPU_INFO
Date: Thu, 11 Jun 2020 15:43:28 -0400
Message-Id: <20200611194449.31468-35-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Command currently returns that it is unimplemented by setting
the reserved-bit in it's return value.

Following patches will return various useful vCPU information
to guest.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200312165431.82118-13-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vmport.c         | 14 ++++++++++++++
 include/hw/i386/vmport.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 8006ff91d4..942a0e94e3 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -54,6 +54,13 @@
 #define VMPORT_COMPAT_CMDS_V2                   \
     (1 << VMPORT_COMPAT_CMDS_V2_BIT)
 
+/* vCPU features reported by CMD_GET_VCPU_INFO */
+#define VCPU_INFO_SLC64_BIT             0
+#define VCPU_INFO_SYNC_VTSCS_BIT        1
+#define VCPU_INFO_HV_REPLAY_OK_BIT      2
+#define VCPU_INFO_LEGACY_X2APIC_BIT     3
+#define VCPU_INFO_RESERVED_BIT          31
+
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
 typedef struct VMPortState {
@@ -167,6 +174,11 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
     return ram_size;
 }
 
+static uint32_t vmport_cmd_get_vcpu_info(void *opaque, uint32_t addr)
+{
+    return 1 << VCPU_INFO_RESERVED_BIT;
+}
+
 static const MemoryRegionOps vmport_ops = {
     .read = vmport_ioport_read,
     .write = vmport_ioport_write,
@@ -192,6 +204,8 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
     if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
         vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
+        vmport_register(VMPORT_CMD_GET_VCPU_INFO, vmport_cmd_get_vcpu_info,
+                        NULL);
     }
 }
 
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 7f566ccc02..7656432358 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -13,6 +13,7 @@ typedef enum {
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
+    VMPORT_CMD_GET_VCPU_INFO    = 68,
     VMPORT_ENTRIES
 } VMPortCommand;
 
-- 
2.26.2



