Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D18DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659F720771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8iBZ4Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659F720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6O1-0008GN-M8
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jy6MU-00073i-2e
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:28:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jy6MR-0000SA-QY
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595392086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beK0/BfqKFKNJ1EqM3TbZwAHIxqXpS5JvWlvCmVPfn4=;
 b=F8iBZ4Jc6rrM6xHn7Dfl6xKQ3amLyU0cJryx4LCwimVA3Q6ugdaVmFJ57yeFU/vVHtT0cR
 dNse58xyz2AegyULyVfm6urVUuvLs7Ovag2EZuOizOfNj7uiOTUFMdRvZAWeov7mVEK8SW
 0wbZ/x+yYUZ9bsOEveuUz8MROLWcHaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-NKouwMhEPQS8HI5UVaQRXA-1; Wed, 22 Jul 2020 00:28:02 -0400
X-MC-Unique: NKouwMhEPQS8HI5UVaQRXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64CAB800C64;
 Wed, 22 Jul 2020 04:28:01 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9433C6FECD;
 Wed, 22 Jul 2020 04:28:00 +0000 (UTC)
Subject: Re: [Bug 1878253] [NEW] null-ptr dereference in
 address_space_to_flatview through ide
To: Bug 1878253 <1878253@bugs.launchpad.net>
References: <158930706000.2313.17393615876486439811.malonedeb@gac.canonical.com>
 <159387929229.3426.10851162301936170602.launchpad@wampee.canonical.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <78a9ea9e-f3e0-728a-db57-4aba17f76915@redhat.com>
Date: Wed, 22 Jul 2020 00:28:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159387929229.3426.10851162301936170602.launchpad@wampee.canonical.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 12:14 PM, Launchpad Bug Tracker wrote:
> You have been subscribed to a public bug by Philippe Mathieu-Daudé (philmd):
> 
> Hello,
> While fuzzing, I found an input that triggers a null-ptr dereference in
> address_space_to_flatview through ide:
> 
> ==31699==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000020 (pc 0x55e0f562bafd bp 0x7ffee92355b0 sp 0x7ffee92354e0 T0)
> ==31699==The signal is caused by a READ memory access.
> ==31699==Hint: address points to the zero page.
>      #0 0x55e0f562bafd in address_space_to_flatview /home/alxndr/Development/qemu/include/exec/memory.h:693:12
>      #1 0x55e0f562bafd in address_space_write /home/alxndr/Development/qemu/exec.c:3267:14
>      #2 0x55e0f562dd9c in address_space_unmap /home/alxndr/Development/qemu/exec.c:3592:9
>      #3 0x55e0f5ab8277 in dma_memory_unmap /home/alxndr/Development/qemu/include/sysemu/dma.h:145:5
>      #4 0x55e0f5ab8277 in dma_blk_unmap /home/alxndr/Development/qemu/dma-helpers.c:104:9
>      #5 0x55e0f5ab8277 in dma_blk_cb /home/alxndr/Development/qemu/dma-helpers.c:139:5
>      #6 0x55e0f617a6b8 in blk_aio_complete /home/alxndr/Development/qemu/block/block-backend.c:1398:9
>      #7 0x55e0f617a6b8 in blk_aio_complete_bh /home/alxndr/Development/qemu/block/block-backend.c:1408:5
>      #8 0x55e0f6355efb in aio_bh_call /home/alxndr/Development/qemu/util/async.c:136:5
>      #9 0x55e0f6355efb in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
>      #10 0x55e0f63608ce in aio_dispatch /home/alxndr/Development/qemu/util/aio-posix.c:380:5
>      #11 0x55e0f635799a in aio_ctx_dispatch /home/alxndr/Development/qemu/util/async.c:306:5
>      #12 0x7f16e85d69ed in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e9ed)
>      #13 0x55e0f635e384 in glib_pollfds_poll /home/alxndr/Development/qemu/util/main-loop.c:219:9
>      #14 0x55e0f635e384 in os_host_main_loop_wait /home/alxndr/Development/qemu/util/main-loop.c:242:5
>      #15 0x55e0f635e384 in main_loop_wait /home/alxndr/Development/qemu/util/main-loop.c:518:11
>      #16 0x55e0f593d676 in qemu_main_loop /home/alxndr/Development/qemu/softmmu/vl.c:1664:9
>      #17 0x55e0f6267c6a in main /home/alxndr/Development/qemu/softmmu/main.c:49:5
>      #18 0x7f16e7186e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.30/csu/../csu/libc-start.c:308:16
>      #19 0x55e0f55727b9 in _start (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x9027b9)
> 
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV /home/alxndr/Development/qemu/include/exec/memory.h:693:12 in address_space_to_flatview
> 
> I can reproduce it in qemu 5.0 using:
> 
> cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc -nographic -drive file=null-co://,if=ide,cache=writeback,format=raw -nodefaults -display none -nographic -qtest stdio -monitor none -serial none
> outl 0xcf8 0x80000920
> outl 0xcfc 0xc001
> outl 0xcf8 0x80000924
> outl 0xcf8 0x80000904
> outw 0xcfc 0x7
> outb 0x1f7 0xc8
> outw 0x3f6 0xe784
> outw 0x3f6 0xeb01
> outb 0xc005 0x21
> write 0x2103 0x1 0x4e
> outb 0xc000 0x1b
> outw 0x1f7 0xff35
> EOF
> 

Willing to bet this is the same root cause as some of the others, 
because of this sequence:

outb 0x1f7 0xc8 (Issues a command)
outb 0x3f6 0x84 [1000 0100] - Arms SRST
outb 0x3f6 0x01 [0000 0001] - Issues SRST
...
outb 0x1f7 0x35 - Issues another command

The problem continues to be that SRST allows new commands to come in 
while the state machine is still stuck on the first command.

--js

> I also attached the traces to this launchpad report, in case the
> formatting is broken:
> 
> qemu-system-i386 -M pc -nographic -drive file=null-
> co://,if=ide,cache=writeback,format=raw -nodefaults -display none
> -nographic -qtest stdio -monitor none -serial none < attachment
> 
> Please let me know if I can provide any further info.
> -Alex
> 
> ** Affects: qemu
>       Importance: Undecided
>           Status: New
> 


