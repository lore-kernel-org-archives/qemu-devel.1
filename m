Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90091C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637C72065D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637C72065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtQC-0001M8-Lb
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jxtPU-0000ZC-29
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:38:24 -0400
Received: from relay68.bu.edu ([128.197.228.73]:33529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jxtPS-000624-1f
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:38:23 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 06LEbS4J000788
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2020 10:37:31 -0400
Date: Tue, 21 Jul 2020 10:37:28 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
Message-ID: <20200721143723.zegwmuoyn6q75e5u@mozz.bu.edu>
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
 <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
 <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
 <CAFEAcA-qrpXJtzW=tigyAqQuYFNCBMQK_CZFx6zYkcJa+RuZuw@mail.gmail.com>
 <28d42c0f-99eb-a9c1-e3fc-98f11ee686ab@redhat.com>
 <CAFEAcA8ECKgRanHLiFZMDS3fd77ASBkba2nfv+iwnjgSLWnbPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8ECKgRanHLiFZMDS3fd77ASBkba2nfv+iwnjgSLWnbPw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:38:21
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Bug 1886362 <1886362@bugs.launchpad.net>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200721 1444, Peter Maydell wrote:
> On Tue, 21 Jul 2020 at 14:21, Jason Wang <jasowang@redhat.com> wrote:
> > On 2020/7/21 下午8:31, Peter Maydell wrote:
> > > On Wed, 15 Jul 2020 at 09:36, Jason Wang <jasowang@redhat.com> wrote:
> > >> I think the point is to make DMA to MMIO work as real hardware.
> > > I wouldn't care to give a 100% guarantee that asking a real
> > > h/w device to DMA to itself didn't cause it to misbehave :-)
> > > It's more likely to happen-to-work because the DMA engine bit
> > > of a real h/w device is going to be decoupled somewhat from
> > > the respond-to-memory-transactions-for-registers logic, but
> > > it probably wasn't something the designers were actively
> > > thinking about either...
>
I searched around but couldn't find anything talking about this case for
real hardware. I also looked at some HDL code for FPGAs that do DMA, but
it seems most of the PCI DMA components are contained in proprietary
IPs, though maybe I'm missing something (I've never programmed
a DMA-capable FPGA).

> > I think some device want such peer to peer transactions:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/pci/p2pdma.rst
> 
> That's a device DMAing to another device, not DMAing to *itself*
> (device-to-another-device DMA should work fine in QEMU). And only
> a very few devices will ever be sensible targets of the DMA --
> basically things like nvme that have a looks-like-memory area,
> or special cases like doorbell registers.
> 
> > > Yeah, this is the interesting part for QEMU. How should we
> > > structure devices that do DMA so that we can be sure that
> > > the device emulation at least doesn't crash? We could have
> > > a rule that all devices that do DMA must always postpone
> > > all of that DMA to a bottom-half, but that's a lot of
> > > refactoring of a lot of device code...
> >
> >
> > It looks to me the issue happens only for device with loopback
> 
> I think in principle we have a problem for any device that
> (a) has memory mapped registers and (b) does DMA reads
> whose address is guest-controlled. Loopback isn't a
> requirement -- if the guest programs, say, an RX descriptor
> base address to point at the device's own registers, you
> get exactly the same kind of unexpected-reentrancy.

Could this be something that we check for in the
pci_dma_* functions in hw/pci/pci.h? There we still have context about
the source device for the dma read/write and could, compare addr against
the device's PCI BARr's. Not sure about:
1.) How to do this without the overhead of convering the addr
to a MemoryRegion, which is normally done, once, at the flatview_write
stage.
2.) What to do if we catch such a DMA request? Quietly drop it?
3.) Non-PCI devices.

I think this still doesn't cover the even crazier case where:
CPU writes to DEV_A's MMIO
DEV_A writes to DEV_B's MMIO
DEV_B writes to DEV_A's MMIO
and neither DEV_A or DEV_B use BHs...

-Alex

> thanks
> -- PMM
> 

