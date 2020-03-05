Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65A7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9FE2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qpcj7Tqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9FE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA0P7-0004bO-LP
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 18:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jA0OV-00048f-Qa
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jA0OT-00021D-3n
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:59:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jA0OS-0001zX-Ss
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583452748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWNxRJ8WlPXdol16rWT4OshMWcJmQyf76OCjD2Xachk=;
 b=Qpcj7Tqj2Yo/p3/gvr1Ien91sg0AWyaZdDU699gTlsrNCxTGQnqmmq4hUu8yeGz23lW/oY
 /nzLocMEtGELZOxqwnBduzMSip6jyEBocgfy9hXgc9+c9iMpkGUufhiYr+iX5TGURPjE0W
 WuPbQkeCqjAkCnUPkZ0l92WygQbcGcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-bhjH8cT5Pk6P4Bbho52tYg-1; Thu, 05 Mar 2020 18:59:04 -0500
X-MC-Unique: bhjH8cT5Pk6P4Bbho52tYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 756E6800D50
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 23:59:03 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A4AB8F34E;
 Thu,  5 Mar 2020 23:58:57 +0000 (UTC)
Date: Thu, 5 Mar 2020 16:58:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200305165857.6a3ec29f@w520.home>
In-Reply-To: <20200228161503.382656-5-peterx@redhat.com>
References: <20200228161503.382656-1-peterx@redhat.com>
 <20200228161503.382656-5-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 11:15:02 -0500
Peter Xu <peterx@redhat.com> wrote:

> This is majorly only for X86 because that's the only one that supports
> split irqchip for now.
> 
> When the irqchip is split, we face a dilemma that KVM irqfd will be
> enabled, however the slow irqchip is still running in the userspace.
> It means that the resamplefd in the kernel irqfds won't take any
> effect and it will miss to ack INTx interrupts on EOIs.
> 
> One example is split irqchip with VFIO INTx, which will break if we
> use the VFIO INTx fast path.
> 
> This patch can potentially supports the VFIO fast path again for INTx,
> that the IRQ delivery will still use the fast path, while we don't
> need to trap MMIOs in QEMU for the device to emulate the EIOs (see the
> callers of vfio_eoi() hook).  However the EOI of the INTx will still
> need to be done from the userspace by caching all the resamplefds in
> QEMU and kick properly for IOAPIC EOI broadcast.
> 
> This is tricky because in this case the userspace ioapic irr &
> remote-irr will be bypassed.  However such a change will greatly boost
> performance for assigned devices using INTx irqs (TCP_RR boosts 46%
> after this patch applied).
> 
> When the userspace is responsible for the resamplefd kickup, don't
> register it on the kvm_irqfd anymore, because on newer kernels (after
> commit 654f1f13ea56, 5.2+) the KVM_IRQFD will fail if with both split
> irqchip and resamplefd.  This will make sure that the fast path will
> work for all supported kernels.
> 
> https://patchwork.kernel.org/patch/10738541/#22609933
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c    | 85 +++++++++++++++++++++++++++++++++++++++++-
>  accel/kvm/trace-events |  1 +
>  hw/intc/ioapic.c       | 23 +++++++++++-
>  include/sysemu/kvm.h   |  7 ++++
>  4 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d49b74512a..89771ea114 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -159,9 +159,65 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
>  static NotifierList kvm_irqchip_change_notifiers =
>      NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
>  
> +struct KVMResampleFd {
> +    int gsi;
> +    EventNotifier *resample_event;
> +    QLIST_ENTRY(KVMResampleFd) node;
> +};
> +typedef struct KVMResampleFd KVMResampleFd;
> +
> +/*
> + * Only used with split irqchip where we need to do the resample fd
> + * kick for the kernel from userspace.
> + */
> +static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =
> +    QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
> +
>  #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
>  #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
>  
> +static inline void kvm_resample_fd_remove(int gsi)
> +{
> +    KVMResampleFd *rfd;
> +
> +    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
> +        if (rfd->gsi == gsi) {
> +            QLIST_REMOVE(rfd, node);
> +            g_free(rfd);
> +            break;
> +        }
> +    }
> +}
> +
> +static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
> +{
> +    KVMResampleFd *rfd = g_new0(KVMResampleFd, 1);
> +
> +    rfd->gsi = gsi;
> +    rfd->resample_event = event;
> +
> +    QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
> +}
> +
> +bool kvm_resample_fd_notify(int gsi)
> +{
> +    KVMResampleFd *rfd;
> +
> +    if (!kvm_irqchip_is_split()) {
> +        return false;
> +    }

Nit, checking split irqchip here seems unnecessary.  We're only adding
and removing list entries based on split irqchip below, so the list
would be empty anyway, unless another user comes along that might have
a reason for this functionality that isn't as tied to split irqchip.

Overall the series looks like a big improvement versus falling back to
our crappy generic EOI hackery with split irqchip.  Thanks,

Alex

> +
> +    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
> +        if (rfd->gsi == gsi) {
> +            event_notifier_set(rfd->resample_event);
> +            trace_kvm_resample_fd_notify(gsi);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  int kvm_get_max_memslots(void)
>  {
>      KVMState *s = KVM_STATE(current_accel());
> @@ -1642,8 +1698,33 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
>      };
>  
>      if (rfd != -1) {
> -        irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
> -        irqfd.resamplefd = rfd;
> +        assert(assign);
> +        if (kvm_irqchip_is_split()) {
> +            /*
> +             * When the slow irqchip (e.g. IOAPIC) is in the
> +             * userspace, KVM kernel resamplefd will not work because
> +             * the EOI of the interrupt will be delivered to userspace
> +             * instead, so the KVM kernel resamplefd kick will be
> +             * skipped.  The userspace here mimics what the kernel
> +             * provides with resamplefd, remember the resamplefd and
> +             * kick it when we receive EOI of this IRQ.
> +             *
> +             * This is hackery because IOAPIC is mostly bypassed
> +             * (except EOI broadcasts) when irqfd is used.  However
> +             * this can bring much performance back for split irqchip
> +             * with INTx IRQs (for VFIO, this gives 93% perf of the
> +             * full fast path, which is 46% perf boost comparing to
> +             * the INTx slow path).
> +             */
> +            kvm_resample_fd_insert(virq, resample);
> +        } else {
> +            irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
> +            irqfd.resamplefd = rfd;
> +        }
> +    } else if (!assign) {
> +        if (kvm_irqchip_is_split()) {
> +            kvm_resample_fd_remove(virq);
> +        }
>      }
>  
>      if (!kvm_irqfds_enabled()) {
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 4fb6e59d19..a68eb66534 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -16,4 +16,5 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_
>  kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
>  kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
>  kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
> +kvm_resample_fd_notify(int gsi) "gsi %d"
>  
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 15747fe2c2..13921b333d 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -236,8 +236,27 @@ void ioapic_eoi_broadcast(int vector)
>          for (n = 0; n < IOAPIC_NUM_PINS; n++) {
>              entry = s->ioredtbl[n];
>  
> -            if ((entry & IOAPIC_VECTOR_MASK) != vector ||
> -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) != IOAPIC_TRIGGER_LEVEL) {
> +            if ((entry & IOAPIC_VECTOR_MASK) != vector) {
> +                continue;
> +            }
> +
> +            /*
> +             * When IOAPIC is in the userspace while APIC is still in
> +             * the kernel (i.e., split irqchip), we have a trick to
> +             * kick the resamplefd logic for registered irqfds from
> +             * userspace to deactivate the IRQ.  When that happens, it
> +             * means the irq bypassed userspace IOAPIC (so the irr and
> +             * remote-irr of the table entry should be bypassed too
> +             * even if interrupt come), then we don't need to clear
> +             * the remote-IRR and check irr again because they'll
> +             * always be zeros.
> +             */
> +            if (kvm_resample_fd_notify(n)) {
> +                continue;
> +            }
> +
> +            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=
> +                IOAPIC_TRIGGER_LEVEL) {
>                  continue;
>              }
>  
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 141342de98..3f0830cc4f 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -555,4 +555,11 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
>  int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
>  struct ppc_radix_page_info *kvm_get_radix_page_info(void);
>  int kvm_get_max_memslots(void);
> +
> +/*
> + * Notify resamplefd for EOI of specific interrupts.  Returns true
> + * when one resamplefd is notified, false if no such IRQ found.
> + */
> +bool kvm_resample_fd_notify(int gsi);
> +
>  #endif


