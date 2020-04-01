Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64807C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDD02071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDD02071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJfrr-0006pa-4o
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jJfmq-00037r-U6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jJfmp-00067M-Cf
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:00:16 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:25575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jJfml-0005cx-UG; Wed, 01 Apr 2020 12:00:12 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 54A3A4277B;
 Wed,  1 Apr 2020 17:59:59 +0200 (CEST)
Date: Wed, 1 Apr 2020 17:50:30 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <1854680630.1.1585756230142@webmail.proxmox.com>
In-Reply-To: <997901084.0.1585755465486@webmail.proxmox.com>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev23
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On April 1, 2020 5:37 PM Dietmar Maurer <dietmar@proxmox.com> wrote:
> 
>  
> > > I really nobody else able to reproduce this (somebody already tried to reproduce)?
> > 
> > I can get hangs, but that's for job_completed(), not for starting the
> > job. Also, my hangs have a non-empty bs->tracked_requests, so it looks
> > like a different case to me.
> 
> Please can you post the command line args of your VM? I use something like
> 
> ./x86_64-softmmu/qemu-system-x86_64 -chardev 'socket,id=qmp,path=/var/run/qemu-server/101.qmp,server,nowait' -mon 'chardev=qmp,mode=control' -pidfile /var/run/qemu-server/101.pid  -m 1024 -object 'iothread,id=iothread-virtioscsi0' -device 'virtio-scsi-pci,id=virtioscsi0,iothread=iothread-virtioscsi0' -drive 'file=/backup/disk3/debian-buster.raw,if=none,id=drive-scsi0,format=raw,cache=none,aio=native,detect-zeroes=on' -device 'scsi-hd,bus=virtioscsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0' -machine "type=pc,accel=kvm"

BTW, I get a segfault if I start above VM without "accel=kvm", 

gdb --args ./x86_64-softmmu/qemu-system-x86_64 -chardev 'socket,id=qmp,path=/var/run/qemu-server/101.qmp,server,nowait' -mon 'chardev=qmp,mode=control' -pidfile /var/run/qemu-server/101.pid  -m 1024 -object 'iothread,id=iothread-virtioscsi0' -device 'virtio-scsi-pci,id=virtioscsi0,iothread=iothread-virtioscsi0' -drive 'file=/backup/disk3/debian-buster.raw,if=none,id=drive-scsi0,format=raw,cache=none,aio=native,detect-zeroes=on' -device 'scsi-hd,bus=virtioscsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0' -machine "type=pc"

after a few seconds:

Thread 3 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe857e700 (LWP 22257)]
0x000055555587c130 in do_tb_phys_invalidate (tb=tb@entry=0x7fffa7b40500 <code_gen_buffer+3409107>, 
    rm_from_page_list=rm_from_page_list@entry=true)
    at /home/dietmar/pve5-devel/mirror_qemu/accel/tcg/translate-all.c:1483
1483	    atomic_set(&tcg_ctx->tb_phys_invalidate_count,
(gdb) bt
#0  0x000055555587c130 in do_tb_phys_invalidate
    (tb=tb@entry=0x7fffa7b40500 <code_gen_buffer+3409107>, rm_from_page_list=rm_from_page_list@entry=true)
    at /home/dietmar/pve5-devel/mirror_qemu/accel/tcg/translate-all.c:1483
#1  0x000055555587c53b in tb_phys_invalidate__locked (tb=0x7fffa7b40500 <code_gen_buffer+3409107>)
    at /home/dietmar/pve5-devel/mirror_qemu/accel/tcg/translate-all.c:1960
#2  0x000055555587c53b in tb_invalidate_phys_page_range__locked
    (pages=pages@entry=0x7fffe780d400, p=0x7fff651066a0, start=start@entry=1072709632, end=end@entry=1072713728, retaddr=retaddr@entry=0) at /home/dietmar/pve5-devel/mirror_qemu/accel/tcg/translate-all.c:1960
#3  0x000055555587dad1 in tb_invalidate_phys_range (start=1072709632, end=1072771072)
    at /home/dietmar/pve5-devel/mirror_qemu/accel/tcg/translate-all.c:2036
#4  0x0000555555801c12 in invalidate_and_set_dirty
    (mr=<optimized out>, addr=<optimized out>, length=<optimized out>)
    at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3036
#5  0x00005555558072df in address_space_unmap
    (as=<optimized out>, buffer=<optimized out>, len=<optimized out>, is_write=<optimized out>, access_len=65536)
    at /home/dietmar/pve5-devel/mirror_qemu/exec.c:3571
#6  0x0000555555967ff6 in dma_memory_unmap
    (access_len=<optimized out>, dir=<optimized out>, len=<optimized out>, buffer=<optimized out>, as=<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/include/sysemu/dma.h:145
#7  0x0000555555967ff6 in dma_blk_unmap (dbs=dbs@entry=0x7fffe7839220) at dma-helpers.c:104
#8  0x0000555555968394 in dma_complete (ret=0, dbs=0x7fffe7839220) at dma-helpers.c:116
#9  0x0000555555968394 in dma_blk_cb (opaque=0x7fffe7839220, ret=0) at dma-helpers.c:136
#10 0x0000555555bac78e in blk_aio_complete (acb=0x7fffe783da00) at block/block-backend.c:1339
#11 0x0000555555c7280b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>)
    at util/coroutine-ucontext.c:115
#12 0x00007ffff6176b50 in __correctly_grouped_prefixwc
    (begin=0x7fffa7b40240 <code_gen_buffer+3408403> L"\x3ff0497b", end=0x12 <error: Cannot access memory at address 0x12>, thousands=0 L'\000', grouping=0x7fffa7b40590 <code_gen_buffer+3409251> "\001") at grouping.c:171
#13 0x0000000000000000 in  ()


It runs fine without iothreads.

But I guess this is a totally different problem?


