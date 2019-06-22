Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B793C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529FE2084E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="oeTkkWkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529FE2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heTt2-0006Cl-Lh
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 20:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46714)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@163.com>) id 1heTn0-0002XG-Hu
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1heTmz-00064B-BX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:21:54 -0400
Received: from m12-13.163.com ([220.181.12.13]:49294)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1heTmy-0005zd-AT
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=O84hladO0cfx5Ur2HP
 Z72mgm6uy/ITH4gX3sTPbtxzs=; b=oeTkkWkMzFNLbGFjixyxclF9Vnp0gjubLy
 Q15YH8s8ieFCUJ2iPI7GtpOupBV9i7TdfXnVnPI2h6+gHHbzLK7hFot1yK9WLmV+
 Ay8dq+JqH7eDP6MqsMQbXlXsNhUixZSa99D16rfIP+3sDWnOQQC9Jq6E8XZD5zUt
 Hvx7jGl6E=
Received: from localhost.localdomain (unknown [115.200.202.73])
 by smtp9 (Coremail) with SMTP id DcCowACnLqeZdA1d_ihoCA--.23625S2;
 Sat, 22 Jun 2019 08:21:46 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com,
	pbonzini@redhat.com
Date: Fri, 21 Jun 2019 17:21:19 -0700
Message-Id: <20190622002119.126834-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowACnLqeZdA1d_ihoCA--.23625S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy8WrW7CrWDur1UuFy7GFg_yoW5tFy8pr
 ZrAF93Kr95Kry8XFW8Za1xAF1fGr1kAryUGa92kayFgr15Zr1rZF1DJF1vqFyYg3yfAry5
 Zay7GFn5Ga4v9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqFAJUUUUU=
X-Originating-IP: [115.200.202.73]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLxrbbVUMJ-seqQAAsx
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH v2] ioapic: use irq number instead of vector in
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

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v1:
remove auto-generated unnecessary message

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



