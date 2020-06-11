Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5EC20720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUpR4zB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5EC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTkn-0004Rt-0O
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAB-0001Sw-Pq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA8-0001MF-0h
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y83Uw1+pZMxcGDtGlla7jbfWJHY6UGPWVFOHylfE1Lo=;
 b=LUpR4zB5sWSjla6IonJsXykkaT9DmEV1/cfx/BRN38f7uJMXtYGLJL7I4iIlApkEPU/i0X
 o7BYslZcZl2Lf2Y/TDA0KC4H99qF279/w2M55SE1tfTm3Q9a8PYLX9nJDQYZSyENGGQt/D
 sgLQUK4JxT5iQr+Yei+M4Yl7X2ha0CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-vxxmsrYCPCeHCnbACknC0Q-1; Thu, 11 Jun 2020 15:46:53 -0400
X-MC-Unique: vxxmsrYCPCeHCnbACknC0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23C0D107ACCD
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:46:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEBA660CC0;
 Thu, 11 Jun 2020 19:46:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 077/115] memory: Make 'info mtree' not display disabled regions
 by default
Date: Thu, 11 Jun 2020 15:44:11 -0400
Message-Id: <20200611194449.31468-78-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We might have many disabled memory regions, making the 'info mtree'
output too verbose to be useful.
Remove the disabled regions in the default output, but allow the
monitor user to display them using the '-D' option.

Before:

  (qemu) info mtree
  memory-region: system
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
      00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
      00000000000c0000-00000000000c3fff (prio 1, ram): alias pam-ram @pc.ram 00000000000c0000-00000000000c3fff [disabled]
      00000000000c0000-00000000000c3fff (prio 1, ram): alias pam-pci @pc.ram 00000000000c0000-00000000000c3fff [disabled]
      00000000000c0000-00000000000c3fff (prio 1, ram): alias pam-rom @pc.ram 00000000000c0000-00000000000c3fff [disabled]
      00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
      00000000000c4000-00000000000c7fff (prio 1, ram): alias pam-ram @pc.ram 00000000000c4000-00000000000c7fff [disabled]
      00000000000c4000-00000000000c7fff (prio 1, ram): alias pam-pci @pc.ram 00000000000c4000-00000000000c7fff [disabled]
      00000000000c4000-00000000000c7fff (prio 1, ram): alias pam-rom @pc.ram 00000000000c4000-00000000000c7fff [disabled]
      00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
      00000000000c8000-00000000000cbfff (prio 1, ram): alias pam-ram @pc.ram 00000000000c8000-00000000000cbfff [disabled]
      00000000000c8000-00000000000cbfff (prio 1, ram): alias pam-pci @pc.ram 00000000000c8000-00000000000cbfff [disabled]
      00000000000c8000-00000000000cbfff (prio 1, ram): alias pam-rom @pc.ram 00000000000c8000-00000000000cbfff [disabled]
      00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 00000000000c8000-00000000000cbfff
      00000000000cc000-00000000000cffff (prio 1, ram): alias pam-ram @pc.ram 00000000000cc000-00000000000cffff [disabled]
      00000000000cc000-00000000000cffff (prio 1, ram): alias pam-pci @pc.ram 00000000000cc000-00000000000cffff [disabled]
      00000000000cc000-00000000000cffff (prio 1, ram): alias pam-rom @pc.ram 00000000000cc000-00000000000cffff [disabled]
      00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 00000000000cc000-00000000000cffff
      00000000000d0000-00000000000d3fff (prio 1, ram): alias pam-ram @pc.ram 00000000000d0000-00000000000d3fff [disabled]
      00000000000d0000-00000000000d3fff (prio 1, ram): alias pam-pci @pc.ram 00000000000d0000-00000000000d3fff [disabled]
      00000000000d0000-00000000000d3fff (prio 1, ram): alias pam-rom @pc.ram 00000000000d0000-00000000000d3fff [disabled]
      00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 00000000000d0000-00000000000d3fff
      00000000000d4000-00000000000d7fff (prio 1, ram): alias pam-ram @pc.ram 00000000000d4000-00000000000d7fff [disabled]
      00000000000d4000-00000000000d7fff (prio 1, ram): alias pam-pci @pc.ram 00000000000d4000-00000000000d7fff [disabled]
      00000000000d4000-00000000000d7fff (prio 1, ram): alias pam-rom @pc.ram 00000000000d4000-00000000000d7fff [disabled]
      00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 00000000000d4000-00000000000d7fff
      00000000000d8000-00000000000dbfff (prio 1, ram): alias pam-ram @pc.ram 00000000000d8000-00000000000dbfff [disabled]
      00000000000d8000-00000000000dbfff (prio 1, ram): alias pam-pci @pc.ram 00000000000d8000-00000000000dbfff [disabled]
      00000000000d8000-00000000000dbfff (prio 1, ram): alias pam-rom @pc.ram 00000000000d8000-00000000000dbfff [disabled]
      00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 00000000000d8000-00000000000dbfff
      00000000000dc000-00000000000dffff (prio 1, ram): alias pam-ram @pc.ram 00000000000dc000-00000000000dffff [disabled]
      00000000000dc000-00000000000dffff (prio 1, ram): alias pam-pci @pc.ram 00000000000dc000-00000000000dffff [disabled]
      00000000000dc000-00000000000dffff (prio 1, ram): alias pam-rom @pc.ram 00000000000dc000-00000000000dffff [disabled]
      00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 00000000000dc000-00000000000dffff
      00000000000e0000-00000000000e3fff (prio 1, ram): alias pam-ram @pc.ram 00000000000e0000-00000000000e3fff [disabled]
      00000000000e0000-00000000000e3fff (prio 1, ram): alias pam-pci @pc.ram 00000000000e0000-00000000000e3fff [disabled]
      00000000000e0000-00000000000e3fff (prio 1, ram): alias pam-rom @pc.ram 00000000000e0000-00000000000e3fff [disabled]
      00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 00000000000e0000-00000000000e3fff
      00000000000e4000-00000000000e7fff (prio 1, ram): alias pam-ram @pc.ram 00000000000e4000-00000000000e7fff [disabled]
      00000000000e4000-00000000000e7fff (prio 1, ram): alias pam-pci @pc.ram 00000000000e4000-00000000000e7fff [disabled]
      00000000000e4000-00000000000e7fff (prio 1, ram): alias pam-rom @pc.ram 00000000000e4000-00000000000e7fff [disabled]
      00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 00000000000e4000-00000000000e7fff
      00000000000e8000-00000000000ebfff (prio 1, ram): alias pam-ram @pc.ram 00000000000e8000-00000000000ebfff [disabled]
      00000000000e8000-00000000000ebfff (prio 1, ram): alias pam-pci @pc.ram 00000000000e8000-00000000000ebfff [disabled]
      00000000000e8000-00000000000ebfff (prio 1, ram): alias pam-rom @pc.ram 00000000000e8000-00000000000ebfff [disabled]
      00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 00000000000e8000-00000000000ebfff
      00000000000ec000-00000000000effff (prio 1, ram): alias pam-ram @pc.ram 00000000000ec000-00000000000effff [disabled]
      00000000000ec000-00000000000effff (prio 1, ram): alias pam-pci @pc.ram 00000000000ec000-00000000000effff [disabled]
      00000000000ec000-00000000000effff (prio 1, ram): alias pam-rom @pc.ram 00000000000ec000-00000000000effff [disabled]
      00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 00000000000ec000-00000000000effff
      00000000000f0000-00000000000fffff (prio 1, ram): alias pam-ram @pc.ram 00000000000f0000-00000000000fffff [disabled]
      00000000000f0000-00000000000fffff (prio 1, ram): alias pam-pci @pc.ram 00000000000f0000-00000000000fffff [disabled]
      00000000000f0000-00000000000fffff (prio 1, ram): alias pam-rom @pc.ram 00000000000f0000-00000000000fffff [disabled]
      00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 00000000000f0000-00000000000fffff
      00000000fec00000-00000000fec00fff (prio 0, i/o): ioapic
      00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
      00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi

After:

  (qemu) info mtree
  memory-region: system
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
      00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
      00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
      00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
      00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 00000000000c8000-00000000000cbfff
      00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 00000000000cc000-00000000000cffff
      00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 00000000000d0000-00000000000d3fff
      00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 00000000000d4000-00000000000d7fff
      00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 00000000000d8000-00000000000dbfff
      00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 00000000000dc000-00000000000dffff
      00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 00000000000e0000-00000000000e3fff
      00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 00000000000e4000-00000000000e7fff
      00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 00000000000e8000-00000000000ebfff
      00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 00000000000ec000-00000000000effff
      00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 00000000000f0000-00000000000fffff
      00000000fec00000-00000000fec00fff (prio 0, i/o): ioapic
      00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
      00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi

The old behavior is preserved using 'info mtree -D'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx  |  7 ++--
 include/exec/memory.h |  2 +-
 memory.c              | 75 +++++++++++++++++++++++--------------------
 monitor/misc.c        |  3 +-
 4 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ca5198438d..30209e3903 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -254,11 +254,12 @@ ERST
 
     {
         .name       = "mtree",
-        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o",
-        .params     = "[-f][-d][-o]",
+        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o,disabled:-D",
+        .params     = "[-f][-d][-o][-D]",
         .help       = "show memory tree (-f: dump flat view for address spaces;"
                       "-d: dump dispatch tree, valid with -f only);"
-                      "-o: dump region owners/parents",
+                      "-o: dump region owners/parents;"
+                      "-D: dump disabled regions",
         .cmd        = hmp_info_mtree,
     },
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 48df5abe13..bd7fdd6081 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1984,7 +1984,7 @@ void memory_global_dirty_log_start(void);
  */
 void memory_global_dirty_log_stop(void);
 
-void mtree_info(bool flatview, bool dispatch_tree, bool owner);
+void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled);
 
 /**
  * memory_region_dispatch_read: perform a read directly to the specified
diff --git a/memory.c b/memory.c
index 91ceaf9fcf..2f15a4b250 100644
--- a/memory.c
+++ b/memory.c
@@ -2882,7 +2882,7 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
                            MemoryRegionListHead *alias_print_queue,
-                           bool owner)
+                           bool owner, bool display_disabled)
 {
     MemoryRegionList *new_ml, *ml, *next_ml;
     MemoryRegionListHead submr_print_queue;
@@ -2894,10 +2894,6 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         return;
     }
 
-    for (i = 0; i < level; i++) {
-        qemu_printf(MTREE_INDENT);
-    }
-
     cur_start = base + mr->addr;
     cur_end = cur_start + MR_SIZE(mr->size);
 
@@ -2926,35 +2922,46 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
             ml->mr = mr->alias;
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
         }
-        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
-                    " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
-                    "-" TARGET_FMT_plx "%s",
-                    cur_start, cur_end,
-                    mr->priority,
-                    mr->nonvolatile ? "nv-" : "",
-                    memory_region_type((MemoryRegion *)mr),
-                    memory_region_name(mr),
-                    memory_region_name(mr->alias),
-                    mr->alias_offset,
-                    mr->alias_offset + MR_SIZE(mr->size),
-                    mr->enabled ? "" : " [disabled]");
-        if (owner) {
-            mtree_print_mr_owner(mr);
+        if (mr->enabled || display_disabled) {
+            for (i = 0; i < level; i++) {
+                qemu_printf(MTREE_INDENT);
+            }
+            qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
+                        " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
+                        "-" TARGET_FMT_plx "%s",
+                        cur_start, cur_end,
+                        mr->priority,
+                        mr->nonvolatile ? "nv-" : "",
+                        memory_region_type((MemoryRegion *)mr),
+                        memory_region_name(mr),
+                        memory_region_name(mr->alias),
+                        mr->alias_offset,
+                        mr->alias_offset + MR_SIZE(mr->size),
+                        mr->enabled ? "" : " [disabled]");
+            if (owner) {
+                mtree_print_mr_owner(mr);
+            }
+            qemu_printf("\n");
         }
     } else {
-        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
-                    " (prio %d, %s%s): %s%s",
-                    cur_start, cur_end,
-                    mr->priority,
-                    mr->nonvolatile ? "nv-" : "",
-                    memory_region_type((MemoryRegion *)mr),
-                    memory_region_name(mr),
-                    mr->enabled ? "" : " [disabled]");
-        if (owner) {
-            mtree_print_mr_owner(mr);
+        if (mr->enabled || display_disabled) {
+            for (i = 0; i < level; i++) {
+                qemu_printf(MTREE_INDENT);
+            }
+            qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
+                        " (prio %d, %s%s): %s%s",
+                        cur_start, cur_end,
+                        mr->priority,
+                        mr->nonvolatile ? "nv-" : "",
+                        memory_region_type((MemoryRegion *)mr),
+                        memory_region_name(mr),
+                        mr->enabled ? "" : " [disabled]");
+            if (owner) {
+                mtree_print_mr_owner(mr);
+            }
+            qemu_printf("\n");
         }
     }
-    qemu_printf("\n");
 
     QTAILQ_INIT(&submr_print_queue);
 
@@ -2977,7 +2984,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
         mtree_print_mr(ml->mr, level + 1, cur_start,
-                       alias_print_queue, owner);
+                       alias_print_queue, owner, display_disabled);
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
@@ -3088,7 +3095,7 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
     return true;
 }
 
-void mtree_info(bool flatview, bool dispatch_tree, bool owner)
+void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
@@ -3136,14 +3143,14 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
         qemu_printf("address-space: %s\n", as->name);
-        mtree_print_mr(as->root, 1, 0, &ml_head, owner);
+        mtree_print_mr(as->root, 1, 0, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner);
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
diff --git a/monitor/misc.c b/monitor/misc.c
index f5207cd242..89bb970b00 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -957,8 +957,9 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
     bool owner = qdict_get_try_bool(qdict, "owner", false);
+    bool disabled = qdict_get_try_bool(qdict, "disabled", false);
 
-    mtree_info(flatview, dispatch_tree, owner);
+    mtree_info(flatview, dispatch_tree, owner, disabled);
 }
 
 #ifdef CONFIG_PROFILER
-- 
2.26.2



