Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA374C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E4C2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adBbp1J4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E4C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8mj9-0006MI-W4
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8mi3-0005On-SJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8mi2-0003tX-JF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:10:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8mi2-0003t9-EV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583161817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNix4A4drFTzRf6rvfVEOs/bmCR/EkjR6i/NDRTXRSs=;
 b=adBbp1J4g1ZyNTqZweuj0iidv61dzPCBhRYzAd/cVwdI9MEMQJMPoq8C5uyLMF0kCFFvdh
 k85BoDSi6pO+CtZ6UJwNgHKna/PT7lr0gO7p3AbBlqNkamcRTczLDcvLMmKHElr3KM7YVF
 1ETZhgs9Do/AKvugmkDwlSsEcxhbtDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-DsDYW7TLOmuuRVTahU-MJw-1; Mon, 02 Mar 2020 10:10:15 -0500
X-MC-Unique: DsDYW7TLOmuuRVTahU-MJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DE5910753FE
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2020 15:10:14 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE91A7386E;
 Mon,  2 Mar 2020 15:10:01 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] vfio/pci: Fix up breakage against split irqchip
 and INTx
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200228161503.382656-1-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b1afbf77-714a-c86a-bdb9-a1b4a6d1e85f@redhat.com>
Date: Mon, 2 Mar 2020 16:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200228161503.382656-1-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/28/20 5:14 PM, Peter Xu wrote:
> v2:
> - pick tags
> - don't register resamplefd with KVM kernel when the userspace
>   resamplefd path is enabled (should enable fast path on new kernels)
> - fix resamplefd mem leak
> - fix commit message of patch 4 [Eric]
> - let kvm_resample_fd_notify() return a boolean, skip ioapic check if
>   returned true
> - more comments here and there in the code to state the fact that
>   userspace ioapic irr & remote-irr are bypassed [Paolo]
> 
> VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
> will directly fail with resamplefd attached so QEMU will automatically
> fallback to the INTx slow path.  However on old kernels it's still
> broken.
> 
> Only until recently I noticed that this could also break PXE boot for
> assigned NICs [1].  My wild guess is that the PXE ROM will be mostly
> using INTx as well, which means we can't bypass that even if we
> enables MSI for the guest kernel.
> 
> This series tries to first fix this issue function-wise, then speed up
> for the INTx again with resamplefd (mostly following the ideas
> proposed by Paolo one year ago [2]).  My TCP_RR test shows that:
> 
>   - Before this series: this is broken, no number to show
> 
>   - After patch 1 (enable slow path): get 63% perf comparing to full
>     kernel irqchip
> 
>   - After whole series (enable fast path partly, irq injection will be
>     the same as fast path, however userspace needs to intercept for
>     EOI broadcast to resamplefd, though should still be faster than
>     the MMIO trick for intx eoi): get 93% perf comparing to full
>     kernel irqchip, which is a 46% performance boost
> 
> I think we can consider to apply patch 1 even sooner than the rest of
> the series to unbreak intx+split first.
> 
> The whole test matrix for reference:
> 
>   |----------+---------+-------------------+--------------+--------------------|
>   | IRQ type | irqchip | TCP_STREAM (Gbps) | TCP_RR (pps) | note               |
>   |----------+---------+-------------------+--------------+--------------------|
>   | msi      | on      |              9.39 |        17567 |                    |
>   | nomsi    | on      |              9.29 |        14056 |                    |
>   | msi      | split   |              9.36 |        17330 |                    |
>   | nomsi    | split   |                 / |            / | currently broken   |
>   | nomsi    | split   |              8.98 |         8977 | after patch 1      |
>   | nomsi    | split   |              9.21 |        13142 | after whole series |
>   |----------+---------+-------------------+--------------+--------------------|
> 
> Any review comment is welcomed.  Thanks,
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1786404
> [2] https://patchwork.kernel.org/patch/10738541/#22609933

For the whole series:
Tested-by: Eric Auger <eric.auger@redhat.com>

using a 5.2-rc1 kernel with reverted "654f1f13ea56  kvm: Check
irqchip mode before assign irqfd" and guest booting with nomsi.

Thanks

Eric

> 
> Peter Xu (5):
>   vfio/pci: Disable INTx fast path if using split irqchip
>   vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for irqfds
>   KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
>   KVM: Kick resamplefd for split kernel irqchip
>   Revert "vfio/pci: Disable INTx fast path if using split irqchip"
> 
>  accel/kvm/kvm-all.c    | 101 +++++++++++++++++++++++++++++++++++++----
>  accel/kvm/trace-events |   1 +
>  hw/intc/ioapic.c       |  23 +++++++++-
>  hw/vfio/pci.c          |  37 ++++++---------
>  include/sysemu/kvm.h   |   7 +++
>  5 files changed, 137 insertions(+), 32 deletions(-)
> 


