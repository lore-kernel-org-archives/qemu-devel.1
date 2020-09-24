Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF5C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2080221D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzIXXX0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2080221D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNzP-00060T-5r
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTt-0001M3-Uj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTq-00066s-BZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEIReYmQcgdw8jBCiFVetApG9AVjEvFU/hT+rphRXpQ=;
 b=LzIXXX0As/W7ujJZ91w0YyeBVqUGyTlKN7SWXdFAbmNSdMsU4+xIXAzHrpCZVCJA4VkhSf
 ObLihIIgwEFeusVVv0pfJ+9+oIQCr5cf1U4UxL+x+CdaTNhwE0CQ1C1bLzWV/uGZ3Y3Rkz
 0zmBvsW6QVm+TDD/+09O65TT8SvRZUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-kUQ8ADvUMMmC61IsUpRBAw-1; Thu, 24 Sep 2020 05:23:55 -0400
X-MC-Unique: kUQ8ADvUMMmC61IsUpRBAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAA9681F00F;
 Thu, 24 Sep 2020 09:23:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BAF05C22B;
 Thu, 24 Sep 2020 09:23:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/92] hw/i386/q35: Remove unreachable Xen code on Q35 machine
Date: Thu, 24 Sep 2020 05:22:34 -0400
Message-Id: <20200924092314.1722645-53-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Xen accelerator requires specific changes to a machine to be able
to use it. See for example the 'Xen PC' machine configure its PCI
bus calling pc_xen_hvm_init_pci(). There is no 'Xen Q35' machine
declared. This code was probably added while introducing the Q35
machine, based on the existing PC machine (see commit df2d8b3ed4
"Introduce q35 pc based chipset emulator"). Remove the unreachable
code to simplify this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200722082517.18708-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_q35.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 11ab5bd7be..a4a37b26c5 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -34,9 +34,7 @@
 #include "sysemu/arch_init.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
-#include "sysemu/xen.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
@@ -179,10 +177,6 @@ static void pc_q35_init(MachineState *machine)
         x86ms->below_4g_mem_size = machine->ram_size;
     }
 
-    if (xen_enabled()) {
-        xen_hvm_init(pcms, &ram_memory);
-    }
-
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     kvmclock_create();
@@ -208,10 +202,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, get_system_memory(),
-                       rom_memory, &ram_memory);
-    }
+    pc_memory_init(pcms, get_system_memory(), rom_memory, &ram_memory);
 
     /* create pci host bus */
     q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
@@ -271,7 +262,7 @@ static void pc_q35_init(MachineState *machine)
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
-        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
+        pcms->vmport = ON_OFF_AUTO_ON;
     }
 
     /* init basic PC hardware */
-- 
2.26.2



