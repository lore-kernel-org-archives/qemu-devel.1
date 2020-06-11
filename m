Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01503C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE36F2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbjK0Qev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE36F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTN9-00051f-10
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8e-0007ct-3d
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8a-0000wV-Ox
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwfsifuosc1Hr9eoc0Zlhiw1A6ToPZpXeqtV05HpnVc=;
 b=hbjK0Qev6vMDj3c5qDC6q+CTfLo1xWtwKmHXafcKyOHhdoOW1Q6mqxVODBtG5a7HPD4iLL
 7z/wsjZoJM+fCIV+BKHvHtuImlloUOK6be0F4IbYr+ratjAi4HIxRoJIXxLYuPjbL1Qt+r
 5LRz8vXkP7B1RWczjX4LPX6Zd8aHWNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-LQqjEWeDOKqLz0VMgejBEA-1; Thu, 11 Jun 2020 15:45:17 -0400
X-MC-Unique: LQqjEWeDOKqLz0VMgejBEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 569A1A0C00;
 Thu, 11 Jun 2020 19:45:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E53195D9DC;
 Thu, 11 Jun 2020 19:45:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 029/115] hw/i386/vmport: Introduce vmware-vmx-version property
Date: Thu, 11 Jun 2020 15:43:23 -0400
Message-Id: <20200611194449.31468-30-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

vmware-vmx-version is a number returned from CMD_GETVERSION which specifies
to guest VMware Tools the the host VMX version. If the host reports a number
that is different than what the guest VMware Tools expects, it may force
guest to upgrade VMware Tools. (See comment above VERSION_MAGIC and
VmCheck_IsVirtualWorld() function in open-vm-tools open-source code).

For better readability and allow maintaining compatability for guests
which may expect different vmware-vmx-version, make vmware-vmx-version a
VMPort object property. This would allow user to control it's value via
"-global vmport.vmware-vmx-version=X".

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200312165431.82118-6-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vmport.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 730b61fcaa..dfebaf5b73 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -60,6 +60,8 @@ typedef struct VMPortState {
     VMPortReadFunc *func[VMPORT_ENTRIES];
     void *opaque[VMPORT_ENTRIES];
 
+    uint32_t vmware_vmx_version;
+
     uint32_t compat_flags;
 } VMPortState;
 
@@ -138,7 +140,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     X86CPU *cpu = X86_CPU(current_cpu);
 
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
-    return 6;
+    return port_state->vmware_vmx_version;
 }
 
 static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
@@ -179,6 +181,11 @@ static Property vmport_properties[] = {
                     VMPORT_COMPAT_READ_SET_EAX_BIT, true),
     DEFINE_PROP_BIT("x-signal-unsupported-cmd", VMPortState, compat_flags,
                     VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
+
+    /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
+    DEFINE_PROP_UINT32("vmware-vmx-version", VMPortState,
+                       vmware_vmx_version, 6),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2



