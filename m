Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB5C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36A32469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfZXGkxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36A32469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7LAU-00009T-SC
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7L9a-000817-72
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7L9Y-0005qC-8U
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:32:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7L9Y-0005pF-2V
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582817563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flkaoN32fHfnV+Wb3CdGYQ+uAtG2ZUjFEdjzExVmXQw=;
 b=ZfZXGkxELwJFsvZAEa2wtGq0kYzt7nGNhL51jZ6b2RZUR7dMSp2XzSHC5oEPK8L9MfRn9z
 c+x9bKkAsnm4IMNGWUhTlPkoKhxfpsviuEAx1cxyq4oY9pL1sssv6l0lmN2nWjMoUkma6C
 RsT0RmSaNXTMOpAAHLuUuzk9C9YHnxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-lxI3cm93PMum2-EIgQ-WTA-1; Thu, 27 Feb 2020 10:32:35 -0500
X-MC-Unique: lxI3cm93PMum2-EIgQ-WTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82092107BAB6
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 15:32:34 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAE525DA7B;
 Thu, 27 Feb 2020 15:32:26 +0000 (UTC)
Subject: Re: [PATCH 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200226225048.216508-1-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bd685da9-bc50-f901-bfec-a1cd18832307@redhat.com>
Date: Thu, 27 Feb 2020 16:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200226225048.216508-1-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On 2/26/20 11:50 PM, Peter Xu wrote:
> VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
> will directly fail with resamplefd attached so QEMU will automatically
> fallback to the INTx slow path.  However on old kernels it's still
> broken.
I think you should quote the commit that changes the behavior:
654f1f13ea56  kvm: Check irqchip mode before assign irqfd?
so that one can understand what it fixed.

So on kernels that do not feature that commit, the ioctl succeeds and we
pretend the resamplefd was properly attached whereas in practice it was
never triggered.

Thanks

Eric

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
> 
> Peter Xu (5):
>   vfio/pci: Disable INTx fast path if using split irqchip
>   vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for irqfds
>   KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
>   KVM: Kick resamplefd for split kernel irqchip
>   Revert "vfio/pci: Disable INTx fast path if using split irqchip"
> 
>  accel/kvm/kvm-all.c    | 83 +++++++++++++++++++++++++++++++++++++++---
>  accel/kvm/trace-events |  1 +
>  hw/intc/ioapic.c       | 11 +++++-
>  hw/vfio/pci.c          | 37 ++++++++-----------
>  include/sysemu/kvm.h   |  4 ++
>  5 files changed, 106 insertions(+), 30 deletions(-)
> 


