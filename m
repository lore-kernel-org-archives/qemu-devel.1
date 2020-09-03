Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A08C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A444D2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A444D2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDgXT-000256-Q6
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 00:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDgWt-0001eJ-IQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:07:19 -0400
Received: from relay64.bu.edu ([128.197.228.104]:53264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDgWr-0003Mu-Qt
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:07:19 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 08346B5D004204
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 3 Sep 2020 00:06:15 -0400
Date: Thu, 3 Sep 2020 00:06:11 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
Message-ID: <20200903040611.fjam4nwqopec723y@mozz.bu.edu>
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:03:17
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
Cc: peter.maydell@linaro.org, dmitry.fleytman@gmail.com, mst@redhat.com,
 liq3ea@gmail.com, Li Qiang <liq3ea@163.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200903 1154, Jason Wang wrote:
> 
> On 2020/9/3 上午12:22, Li Qiang wrote:
> > The qemu device fuzzer has found several DMA to MMIO issue.
> > These issues is caused by the guest driver programs the DMA
> > address, then in the device MMIO handler it trigger the DMA
> > and as the DMA address is MMIO it will trigger another dispatch
> > and reenter the MMIO handler again. However most of the device
> > is not reentrant.
> > 
> > DMA to MMIO will cause issues depend by the device emulator,
> > mostly it will crash the qemu. Following is three classic
> > DMA to MMIO issue.
> > 
> > e1000e: https://bugs.launchpad.net/qemu/+bug/1886362
> > xhci: https://bugs.launchpad.net/qemu/+bug/1891354
> > virtio-gpu: https://bugs.launchpad.net/qemu/+bug/1888606
> > 
> > The DMA to MMIO issue I think can be classified as following:
> > 1. DMA to the device itself
> > 2. device A DMA to device B and to device C
> > 3. device A DMA to device B and to device A
> > 
> > The first case of course should not be allowed.
> > The second case I think it ok as the device IO handler has no
> > assumption about the IO data came from no matter it come from
> > device or other device. This is for P2P DMA.
> > The third case I think it also should not be allowed.
> > 
> > So our issue has been reduced by one case: not allowed the
> > device's IO handler reenter.
> > 
> > Paolo suggested that we can refactor the device emulation with
> > BH. However it is a lot of work.
> > I have thought several propose to address this, also discuss
> > this with Jason Wang in private email.
> > 
> > I have can solve this issue in core framework or in specific device.
> > After try several methods I choose address it in per-device for
> > following reason:
> > 1. If we address it in core framwork we have to recored and check the
> > device or MR info in MR dispatch write function. Unfortunally we have
> > no these info in core framework.
> > 2. The performance will also be decrease largely
> > 3. Only the device itself know its IO
> 
> 
> I think we still need to seek a way to address this issue completely.
> 
> How about adding a flag in MemoryRegionOps and detect the reentrancy through
> that flag?

What happens for devices with multiple MemoryRegions? Make all the
MemoryRegionOps share the same flag?

What about the virtio-gpu bug, where the problem happens in a bh->mmio
access rather than an mmio->mmio access?

-Alex

> Thanks
> 
> 
> > 
> > The (most of the) device emulation is protected by BQL one time only
> > a device emulation code can be run. We can add a flag to indicate the
> > IO is running. The first two patches does this. For simplicity at the
> > RFC stage I just set it while enter the IO callback and clear it exit
> > the IO callback. It should be check/set/clean according the per-device's
> > IO emulation.
> > The second issue which itself suffers a race condition so I uses a
> > atomic.
> > 
> > 
> > 
> > 
> > Li Qiang (3):
> >    e1000e: make the IO handler reentrant
> >    xhci: make the IO handler reentrant
> >    virtio-gpu: make the IO handler reentrant
> > 
> >   hw/display/virtio-gpu.c        | 10 ++++++
> >   hw/net/e1000e.c                | 35 +++++++++++++++++++-
> >   hw/usb/hcd-xhci.c              | 60 ++++++++++++++++++++++++++++++++++
> >   hw/usb/hcd-xhci.h              |  1 +
> >   include/hw/virtio/virtio-gpu.h |  1 +
> >   5 files changed, 106 insertions(+), 1 deletion(-)
> > 
> 

