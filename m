Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40416C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E53D216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiNK7xa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E53D216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV0v-00042R-Ae
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34266)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkS-0004Yh-LK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkQ-00033s-LR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUkL-0002n8-Nc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id r1so4699621wrl.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tkNz7uqIs0Rv1hq1F0XpRF7vtnO8a8dqtlBjE4VOmbk=;
 b=CiNK7xa1Jx2Ke2fdyKqozCsgA8qo8aCH4aKnQkiM3/MeT+qSk6SHXC1Ymv5D1/AC/7
 fAuBD+3TQjrfDG0KN2ddV8fZ2KIWqDra8hQSw6R65TvZ4DptCg/U91j3MxuPZOZyClQF
 omMlyuylSzdJ4mFjGrG3bul7z3K/4IJj2ka0aMxoj8VIiQ0+R9ikCWYimVjlVRUDjz9K
 J9P7o6YVdw8dsng2d/sZxlLWnfgFZfvaDU6EcGOileGAXMH7MCf9XzrTX/rfSkjhoKjm
 L8tPA1rN3AgAlfRTgaTLSHePA85Dg//nz2fNA0nCdrsAApqU2+6gVoFYsH+m6EZ53ST6
 7kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=tkNz7uqIs0Rv1hq1F0XpRF7vtnO8a8dqtlBjE4VOmbk=;
 b=aO2V+zWW2JDclbavJ1EK77mxy1YoMn5EUBQwNFq0jK5ymilT3+HxTL+HawZd1mwJqE
 84Ko23kDK0FEbOOIbgS9lUubLoa0NQk+Ndzn2bM0llf/I8d4Bzwgxxb1VyMm4NdNSfdx
 hcg5IHNfMGeym6PtOmjFpuOK6JbmOCg2/QOmJ0nCkWdlCav+qQ+YZSA6+8VgygjCPqjM
 /KI0IF7/8cLaebdxO9IDiqn7ICoHc4SmEX80OHN6ahsVUyXmdPnbfGU65/fmRoeTnFYg
 6WO7Ye3xF+9woEvnjQJKcvLDeqxxuR+Bqrtl9G8gQKpPRCD9KcNtNb2NIeTJp2tV7+r1
 08Tg==
X-Gm-Message-State: APjAAAXKVxEfJROROsGXRmhE3Kok/UxjtOpMJgqJwL7hUmgKPNsjkpVP
 V1NlNGkG1ToJR6yfFyS+rjYj5BbRc9E=
X-Google-Smtp-Source: APXvYqy2kXav6uHXm46tXNoqwg6Z+fTsS1uqDM1WinsjQIMu/CoKLgLdL8FPpnvRixxaFukcdI5A6w==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr5000065wrx.300.1562358214871; 
 Fri, 05 Jul 2019 13:23:34 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:22 +0200
Message-Id: <1562358202-28008-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 12/12] ioapic: use irq number instead of vector
 in ioapic_eoi_broadcast
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
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

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
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190622002119.126834-1-liq3ea@163.com>
---
 hw/intc/ioapic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index db9e518..c408749 100644
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
1.8.3.1


