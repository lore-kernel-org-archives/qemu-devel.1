Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC696C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AEA22208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AEA22208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGodH-0002d2-V9
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kGock-0002Dp-GB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:22:18 -0400
Received: from relay68.bu.edu ([128.197.228.73]:37548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kGoci-0007gk-I0
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:22:18 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 08BJKkKB009109
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 11 Sep 2020 15:20:49 -0400
Date: Fri, 11 Sep 2020 15:20:45 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] hw: usb: hcd-ohci: check len and frame_number variables
Message-ID: <20200911192045.3amzn6zlaynpxbfy@mozz.bu.edu>
References: <20200911122703.126696-1-ppandit@redhat.com>
 <CAKXe6SLFG1XMCw7yNM3bres29jiqJ5oLpJUgzXGjj8ay=NkwHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXe6SLFG1XMCw7yNM3bres29jiqJ5oLpJUgzXGjj8ay=NkwHQ@mail.gmail.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:22:15
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Yi Ren <yunye.ry@alibaba-inc.com>, Yongkang Jia <j_kangel@163.com>,
 Gaoning Pan <pgn@zju.edu.cn>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200911 2257, Li Qiang wrote:
> P J P <ppandit@redhat.com> 于2020年9月11日周五 下午8:30写道：
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > While servicing the OHCI transfer descriptors(TD), OHCI host
> > controller derives variables 'start_addr', 'end_addr', 'len'
> > etc. from values supplied by the host controller driver.
> > Host controller driver may supply values such that using
> > above variables leads to out-of-bounds access or loop issues.
> > Add checks to avoid them.
> >
> > AddressSanitizer: stack-buffer-overflow on address 0x7ffd53af76a0
> >   READ of size 2 at 0x7ffd53af76a0 thread T0
> >   #0 ohci_service_iso_td ../hw/usb/hcd-ohci.c:734
> >   #1 ohci_service_ed_list ../hw/usb/hcd-ohci.c:1180
> >   #2 ohci_process_lists ../hw/usb/hcd-ohci.c:1214
> >   #3 ohci_frame_boundary ../hw/usb/hcd-ohci.c:1257
> >   #4 timerlist_run_timers ../util/qemu-timer.c:572
> >   #5 qemu_clock_run_timers ../util/qemu-timer.c:586
> >   #6 qemu_clock_run_all_timers ../util/qemu-timer.c:672
> >   #7 main_loop_wait ../util/main-loop.c:527
> >   #8 qemu_main_loop ../softmmu/vl.c:1676
> >   #9 main ../softmmu/main.c:50
> >
> 
> Hello Prasad,
> Could you also provide the reproducer?
> 
> > Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> > Reported-by: Yongkang Jia <j_kangel@163.com>
> > Reported-by: Yi Ren <yunye.ry@alibaba-inc.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/usb/hcd-ohci.c | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> > index 1e6e85e86a..76fb9282e3 100644
> > --- a/hw/usb/hcd-ohci.c
> > +++ b/hw/usb/hcd-ohci.c
> > @@ -691,6 +691,11 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
> >             the next ISO TD of the same ED */
> >          trace_usb_ohci_iso_td_relative_frame_number_big(relative_frame_number,
> >                                                          frame_count);
> > +        if (OHCI_CC_DATAOVERRUN == OHCI_BM(iso_td.flags, TD_CC)) {
> > +            /* avoid infinite loop */
> > +            return 1;
> > +        }
> 
> I think it is better to split this patch to 2 or three as the infinite
> loop as the buffer overflow are independent.
> 
> 1. here the infinite loop
> 
> > +
> >          OHCI_SET_BM(iso_td.flags, TD_CC, OHCI_CC_DATAOVERRUN);
> >          ed->head &= ~OHCI_DPTR_MASK;
> >          ed->head |= (iso_td.next & OHCI_DPTR_MASK);
> > @@ -731,7 +736,11 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
> >      }
> >
> >      start_offset = iso_td.offset[relative_frame_number];
> > -    next_offset = iso_td.offset[relative_frame_number + 1];
> > +    if (relative_frame_number < frame_count) {
> > +        next_offset = iso_td.offset[relative_frame_number + 1];
> > +    } else {
> > +        next_offset = iso_td.be;
> > +    }
> 
> 2. here the stack buffer overflow
> 
> >
> >      if (!(OHCI_BM(start_offset, TD_PSW_CC) & 0xe) ||
> >          ((relative_frame_number < frame_count) &&
> > @@ -764,7 +773,12 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
> >          }
> >      } else {
> >          /* Last packet in the ISO TD */
> > -        end_addr = iso_td.be;
> > +        end_addr = next_offset;
> > +    }
> > +
> > +    if (start_addr > end_addr) {
> > +        trace_usb_ohci_iso_td_bad_cc_overrun(start_addr, end_addr);
> > +        return 1;
> >      }
> >
> >      if ((start_addr & OHCI_PAGE_MASK) != (end_addr & OHCI_PAGE_MASK)) {
> > @@ -773,6 +787,9 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
> >      } else {
> >          len = end_addr - start_addr + 1;
> >      }
> > +    if (len > sizeof(ohci->usb_buf)) {
> > +        len = sizeof(ohci->usb_buf);
> > +    }
> >
> >      if (len && dir != OHCI_TD_DIR_IN) {
> >          if (ohci_copy_iso_td(ohci, start_addr, end_addr, ohci->usb_buf, len,
> > @@ -975,8 +992,16 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
> >          if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
> >              len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
> >          } else {
> > +            if (td.cbp > td.be) {
> > +                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> > +                ohci_die(ohci);
> > +                return 1;
> > +            }
> >              len = (td.be - td.cbp) + 1;
> >          }
> > +        if (len > sizeof(ohci->usb_buf)) {
> > +            len = sizeof(ohci->usb_buf);
> > +        }
> >
> 
> 3. Then here is the heap overflow.
> 

Maybe this is the heap-overflow?

cat << EOF | ./qemu-system-i386 -device pci-ohci,id=usbb \
-device usb-tablet,bus=usbb.0,port=1,usb_version=1 \
-nodefaults -qtest stdio -nographic
outl 0xcf8 0x80001013
outl 0xcfc 0x1fd555a
outl 0xcf8 0x80001002
outl 0xcfc 0x7fe072f
write 0x5a000004 0x1 0xa5
write 0x0 0x1 0x26
write 0x1 0x1 0xfc
write 0xfc27 0x1 0xaa
write 0xfc30 0x1 0x04
write 0x40006 0x1 0x27
write 0x4000e 0x1 0x27
write 0x40011 0x1 0xff
EOF

==3325498==ERROR: AddressSanitizer: heap-buffer-overflow 
WRITE of size 131661824 at 0x6270000031a0 thread T0
#0 0x5564784a5a9f in __asan_memcpy (u-system-i386+0x2db6a9f)
#1 0x55647abc4cee in flatview_read_continue exec.c:3246:13
#2 0x55647abc7513 in flatview_read exec.c:3279:12
#3 0x55647abc7068 in address_space_read_full exec.c:3292:18
#4 0x55647abc8208 in address_space_rw exec.c:3320:16
#5 0x5564798a9467 in dma_memory_rw_relaxed include/sysemu/dma.h:87:18
#6 0x5564798a8e85 in dma_memory_rw include/sysemu/dma.h:110:12
#7 0x5564798b1d16 in ohci_copy_iso_td hw/usb/hcd-ohci.c:624:9
#8 0x5564798a2d66 in ohci_service_iso_td hw/usb/hcd-ohci.c:778:13
#9 0x556479897e1b in ohci_service_ed_list hw/usb/hcd-ohci.c:1180:21
#10 0x556479889dc6 in ohci_frame_boundary hw/usb/hcd-ohci.c:1245:9
#11 0x55647c40c527 in timerlist_run_timers util/qemu-timer.c:572:9

-Alex

> 
> So I think it can be more easier to review to split this to 3 patches.
> 
> Thanks,
> Li Qiang
> 
> >          pktlen = len;
> >          if (len && dir != OHCI_TD_DIR_IN) {
> > --
> > 2.26.2
> >
> >
> 

