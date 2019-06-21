Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E744C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D64F2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="fP8djRMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64F2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMCw-0001JT-Aq
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39816)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@163.com>) id 1heMBS-0000kE-PD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1heMBR-0004qU-LX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:14:38 -0400
Received: from m12-11.163.com ([220.181.12.11]:54730)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1heMBQ-0004eD-Jk
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=5Sz96pIxWBRXCDHdLR
 NcLUWdsQGPhUNCfg1O6aj01uc=; b=fP8djRMSU+cUy9N3ticG4pGE1s14Sr19nS
 I3Gz3tm465jZbuGAfStRe16y/HxK4fsIOA96pEy9/icWNvNQX8pOFm+0SJXvot2C
 c2V/FpqxXerhPg/FE/RAGV434oyhHDhEnznjp/5a09VfP8xEVJBTJSUQJ3SyEGhc
 oT3i1usTw=
Received: from localhost.localdomain (unknown [115.200.202.73])
 by smtp7 (Coremail) with SMTP id C8CowACHM7xcAg1dyKZbBA--.13028S2;
 Sat, 22 Jun 2019 00:14:21 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com,
	pbonzini@redhat.com
Date: Fri, 21 Jun 2019 09:14:05 -0700
Message-Id: <20190621161405.124983-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowACHM7xcAg1dyKZbBA--.13028S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy8WrW7CrWDur1UuFy7GFg_yoWrGrWDpF
 ZrCF93KrZ5Kry8XFW8Za1xZF1fGr1kAryUGa9YkayFgr15Zr1rZFn7tF1vqFy5W3yfAryY
 vay7GFn3Ga4v9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UoVb9UUUUU=
X-Originating-IP: [115.200.202.73]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLxTabVUMJ-VOSwABsD
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.11
Subject: [Qemu-devel] [PATCH] ioapic: use irq number instead of vector in
 ioapic_eoi_broadcast
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When emulating irqchip in qemu, such as following command:

x86_64-softmmu/qemu-system-x86_64 -m 1024 -smp 4 -hda /home/test/test.img
-machine kernel-irqchip=off --enable-kvm -vnc :0 -device edu -monitor stdio

We will get a crash with following asan output:

(qemu) /home/test/qemu5/qemu/hw/intc/ioapic.c:266:27: runtime error: index 35 out of bounds for type 'int [24]'
=================================================================
==113504==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61b000003114 at pc 0x5579e3c7a80f bp 0x7fd004bf8c10 sp 0x7fd004bf8c00
WRITE of size 4 at 0x61b000003114 thread T4
    #0 0x5579e3c7a80e in ioapic_eoi_broadcast /home/test/qemu5/qemu/hw/intc/ioapic.c:266
    #1 0x5579e3c6f480 in apic_eoi /home/test/qemu5/qemu/hw/intc/apic.c:428
    #2 0x5579e3c720a7 in apic_mem_write /home/test/qemu5/qemu/hw/intc/apic.c:802
    #3 0x5579e3b1e31a in memory_region_write_accessor /home/test/qemu5/qemu/memory.c:503
    #4 0x5579e3b1e6a2 in access_with_adjusted_size /home/test/qemu5/qemu/memory.c:569
    #5 0x5579e3b28d77 in memory_region_dispatch_write /home/test/qemu5/qemu/memory.c:1497
    #6 0x5579e3a1b36b in flatview_write_continue /home/test/qemu5/qemu/exec.c:3323
    #7 0x5579e3a1b633 in flatview_write /home/test/qemu5/qemu/exec.c:3362
    #8 0x5579e3a1bcb1 in address_space_write /home/test/qemu5/qemu/exec.c:3452
    #9 0x5579e3a1bd03 in address_space_rw /home/test/qemu5/qemu/exec.c:3463
    #10 0x5579e3b8b979 in kvm_cpu_exec /home/test/qemu5/qemu/accel/kvm/kvm-all.c:2045
    #11 0x5579e3ae4499 in qemu_kvm_cpu_thread_fn /home/test/qemu5/qemu/cpus.c:1287
    #12 0x5579e4cbdb9f in qemu_thread_start util/qemu-thread-posix.c:502
    #13 0x7fd0146376da in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x76da)
    #14 0x7fd01436088e in __clone (/lib/x86_64-linux-gnu/libc.so.6+0x12188e

This is because in ioapic_eoi_broadcast function, we uses 'vector' to
index the 's->irq_eoi'. To fix this, we should uses the irq number.

# Please enter the commit message for your changes. Lines starting
# with '#' will be kept; you may remove them yourself if you want to.
# An empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#	modified:   hw/intc/ioapic.c
#
# Untracked files:
#	0001-migration-fix-a-typo.patch
#	roms/vgabios/
#	vhost-user-input
#

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/intc/ioapic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 7074489fdf..711775cc6f 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -245,8 +245,8 @@ void ioapic_eoi_broadcast(int vector)
             s->ioredtbl[n] = entry & ~IOAPIC_LVT_REMOTE_IRR;
 
             if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
-                ++s->irq_eoi[vector];
-                if (s->irq_eoi[vector] >= SUCCESSIVE_IRQ_MAX_COUNT) {
+                ++s->irq_eoi[n];
+                if (s->irq_eoi[n] >= SUCCESSIVE_IRQ_MAX_COUNT) {
                     /*
                      * Real hardware does not deliver the interrupt immediately
                      * during eoi broadcast, and this lets a buggy guest make
@@ -254,16 +254,16 @@ void ioapic_eoi_broadcast(int vector)
                      * level-triggered interrupt. Emulate this behavior if we
                      * detect an interrupt storm.
                      */
-                    s->irq_eoi[vector] = 0;
+                    s->irq_eoi[n] = 0;
                     timer_mod_anticipate(s->delayed_ioapic_service_timer,
                                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                                          NANOSECONDS_PER_SECOND / 100);
-                    trace_ioapic_eoi_delayed_reassert(vector);
+                    trace_ioapic_eoi_delayed_reassert(n);
                 } else {
                     ioapic_service(s);
                 }
             } else {
-                s->irq_eoi[vector] = 0;
+                s->irq_eoi[n] = 0;
             }
         }
     }
-- 
2.17.1



