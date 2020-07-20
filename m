Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2086C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9655322C9C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9655322C9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWOz-0002kg-RF
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jxWOJ-0002Io-Ax
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:03:39 -0400
Received: from relay64.bu.edu ([128.197.228.104]:35453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jxWOD-000136-SI
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:03:38 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 06KE2vup030544
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Jul 2020 10:03:00 -0400
Date: Mon, 20 Jul 2020 10:02:57 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] net: check payload length limit for all frames
Message-ID: <20200720140257.okfgo3k5y5xfi57e@mozz.bu.edu>
References: <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
 <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
 <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
 <nycvar.YSQ.7.78.906.2007171016480.950384@xnncv>
 <3620abab-a464-8e3c-d5b9-0bd80b35e2f1@redhat.com>
 <nycvar.YSQ.7.78.906.2007171326100.4380@xnncv>
 <CAKXe6SJbJaEepRVFtNy=5fhJrw8+Gax=mcwFuhfXrHTgo+wmog@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007200752230.4380@xnncv>
 <20200720033304.sttpqr337xsf4rna@mozz.bu.edu>
 <CAKXe6SKV8=B2rb6EY72W17r6-oz5nx9VQndH9gSyafubOU4rJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXe6SKV8=B2rb6EY72W17r6-oz5nx9VQndH9gSyafubOU4rJg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 10:03:32
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200720 1946, Li Qiang wrote:
> 
> This seems is the same issue as LP#1886362 .
> Look at the free path.
> Here the 'e1000e_write_to_rx_buffers' trigger DMA and then go to
> address space dispatch. So the DMA is not RAM but a MMIO range.
> Then we go to another send path, and in that we frees the 'iov'.
> 
> Alex do you tried my patch to solve LP#1886362 ?
> I have tried it and it seems no this UAF triggered.

Hi Li,
I think the bugs are triggered in a similar way, and they stem from the
same underlying issue (the code wasn't designed to read/write to its own
MMIO range), but the actual UAFs are different.
I agree that your patch should fix all of these types of bugs in the
e1000e.
Thanks
-Alex

> Thanks,
> Li Qiang
> 
> 
> > previously allocated by thread T0 here:
> >     #0 0x561dd231130d in malloc (/home/alxndr/Development/qemu/build-asan/i386-softmmu/qemu-system-i386+0x2bb630d)
> >     #1 0x7f58c023d500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x54500)
> >     #2 0x561dd43d0666 in net_rx_pkt_pull_data /home/alxndr/Development/qemu/hw/net/net_rx_pkt.c:103:9
> >     #3 0x561dd43d2cf6 in net_rx_pkt_attach_iovec_ex /home/alxndr/Development/qemu/hw/net/net_rx_pkt.c:158:5
> >     #4 0x561dd440360f in e1000e_receive_iov /home/alxndr/Development/qemu/hw/net/e1000e_core.c:1695:5
> >     #5 0x561dd43fd91a in e1000e_nc_receive_iov /home/alxndr/Development/qemu/hw/net/e1000e.c:213:12
> >     #6 0x561dd43c82e7 in net_tx_pkt_sendv /home/alxndr/Development/qemu/hw/net/net_tx_pkt.c:553:9
> >     #7 0x561dd43c65e6 in net_tx_pkt_send /home/alxndr/Development/qemu/hw/net/net_tx_pkt.c:629:9
> >     #8 0x561dd43c9c78 in net_tx_pkt_send_loopback /home/alxndr/Development/qemu/hw/net/net_tx_pkt.c:642:11
> >     #9 0x561dd4472cf6 in e1000e_tx_pkt_send /home/alxndr/Development/qemu/hw/net/e1000e_core.c:664:16
> >     #10 0x561dd446f296 in e1000e_process_tx_desc /home/alxndr/Development/qemu/hw/net/e1000e_core.c:743:17
> >     #11 0x561dd446ce68 in e1000e_start_xmit /home/alxndr/Development/qemu/hw/net/e1000e_core.c:934:9
> >     #12 0x561dd445635d in e1000e_set_tdt /home/alxndr/Development/qemu/hw/net/e1000e_core.c:2451:9
> >     #13 0x561dd440f19e in e1000e_core_write /home/alxndr/Development/qemu/hw/net/e1000e_core.c:3265:9
> >     #14 0x561dd43f77b7 in e1000e_mmio_write /home/alxndr/Development/qemu/hw/net/e1000e.c:109:5
> >     #15 0x561dd2ff62a3 in memory_region_write_accessor /home/alxndr/Development/qemu/softmmu/memory.c:483:5
> >     #16 0x561dd2ff5747 in access_with_adjusted_size /home/alxndr/Development/qemu/softmmu/memory.c:544:18
> >     #17 0x561dd2ff3366 in memory_region_dispatch_write /home/alxndr/Development/qemu/softmmu/memory.c:1465:16
> >     #18 0x561dd23a5476 in flatview_write_continue /home/alxndr/Development/qemu/exec.c:3176:23
> >     #19 0x561dd238de86 in flatview_write /home/alxndr/Development/qemu/exec.c:3216:14
> >     #20 0x561dd238d9a7 in address_space_write /home/alxndr/Development/qemu/exec.c:3307:18
> >     #21 0x561dd30a43b1 in qtest_process_command /home/alxndr/Development/qemu/softmmu/qtest.c:567:9
> >     #22 0x561dd3094b38 in qtest_process_inbuf /home/alxndr/Development/qemu/softmmu/qtest.c:710:9
> >     #23 0x561dd30937c5 in qtest_read /home/alxndr/Development/qemu/softmmu/qtest.c:722:5
> >     #24 0x561dd5f33993 in qemu_chr_be_write_impl /home/alxndr/Development/qemu/chardev/char.c:188:9
> >     #25 0x561dd5f33b17 in qemu_chr_be_write /home/alxndr/Development/qemu/chardev/char.c:200:9
> >     #26 0x561dd5f47e03 in fd_chr_read /home/alxndr/Development/qemu/chardev/char-fd.c:68:9
> >     #27 0x561dd609c1c4 in qio_channel_fd_source_dispatch /home/alxndr/Development/qemu/io/channel-watch.c:84:12
> >     #28 0x7f58c0237897 in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e897)
> >
> > Let me know if I can help with anything else!
> > -Alex
> >
> > > Thank you.
> > > --
> > > Prasad J Pandit / Red Hat Product Security Team
> > > 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> >

