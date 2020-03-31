Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F70C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 22:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C284E20842
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUMsxQTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C284E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJPST-0004VA-Vl
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 18:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jJPRL-00044w-6H
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 18:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jJPRJ-0006RJ-BY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 18:32:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22031
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jJPRJ-0006NG-1V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 18:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585693976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTx7isEgpV7I+Ivh50RiItxwua9HQyl9ruPuDi+PRtk=;
 b=SUMsxQTH43qYO5MSWqEblXmzhyAv/PgBJPjj/rRzqclF0Tk3TtYYB/2IpZ6m1eGI8/bIbN
 zc7Rfg3hoP4/fyvkvrAFVpYG0IOActiXtOipsqDhaGuDCHRMF3QtgMJxVdk/BtUIvKsLZ6
 CRVgVeOplZLWx2x0BOiDuk01WUrQ2Yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-md2ZYIjyNcGQQHzq3zQqCQ-1; Tue, 31 Mar 2020 18:32:52 -0400
X-MC-Unique: md2ZYIjyNcGQQHzq3zQqCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EB151005509
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 22:32:51 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB8D60BE0;
 Tue, 31 Mar 2020 22:32:45 +0000 (UTC)
Date: Tue, 31 Mar 2020 16:32:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4 0/5] vfio/pci: Fix up breakage against split irqchip
 and INTx
Message-ID: <20200331163245.74e81595@w520.home>
In-Reply-To: <20200318145204.74483-1-peterx@redhat.com>
References: <20200318145204.74483-1-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 10:51:59 -0400
Peter Xu <peterx@redhat.com> wrote:

> v4:
> - pick r-b and a-b for Alex without patch 4
> - only kick resamplefd for level triggered irq (as 3.1 change on patch
>   4) [Alex]
> - fix mingw build error with below squashed into patch 4:

IMO, it'd be nice to get this in for QEMU 5.0, were others thinking
something different?  I provided acks thinking Paolo might take it, but
I can send a pull request for it if Paolo wants to ack instead.  Thanks,

Alex

> ----------------------------------------
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 2ae96e10be..b9ec570c03 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -241,6 +241,7 @@ void ioapic_eoi_broadcast(int vector)
>                  continue;
>              }
> 
> +#ifdef CONFIG_KVM
>              /*
>               * When IOAPIC is in the userspace while APIC is still in
>               * the kernel (i.e., split irqchip), we have a trick to
> @@ -257,6 +258,7 @@ void ioapic_eoi_broadcast(int vector)
>               * emulated devices that are using/sharing the same IRQ.
>               */
>              kvm_resample_fd_notify(n);
> +#endif
> 
>              if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
>                  continue;
> ----------------------------------------
> 
> v3:
> - collect r-bs for Eric
> - unconditionally call kvm_resample_fd_notify(), change comment [Alex]
> - remove the split irqchip check in kvm_resample_fd_notify(), then let
>   it return nothing [Alex]
> - test against shared irq to make sure it won't break
> 
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
> 
> Peter Xu (5):
>   vfio/pci: Disable INTx fast path if using split irqchip
>   vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for irqfds
>   KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
>   KVM: Kick resamplefd for split kernel irqchip
>   Revert "vfio/pci: Disable INTx fast path if using split irqchip"
> 
>  accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++++++++++++----
>  accel/kvm/trace-events |  1 +
>  hw/intc/ioapic.c       | 19 +++++++++
>  hw/vfio/pci.c          | 37 +++++++---------
>  include/sysemu/kvm.h   |  4 ++
>  5 files changed, 126 insertions(+), 30 deletions(-)
> 


