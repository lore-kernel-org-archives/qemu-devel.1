Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB1C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 22:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D792073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 22:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKGH5Wlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D792073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9z8N-0004yy-H3
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 17:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j9z7j-0004Oy-Of
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j9z7h-00018z-0Z
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:37:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j9z7g-00017c-P3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583447862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wusVlAsID4V9SbQ3yq1XUJeFCYy9tn0UTkr2BN+iK3o=;
 b=CKGH5WlxI/bP+dkAXlKNIP4QVXJQRXGtjoK9fdwrPr7ndPF7OGvgWjNgzlLTUTl6fOQBG3
 jQnzfwKpz0tfnxGglEuRdZFPMP+WLxQuWWlf6tPiBdHn6+FUp+mI5RMeyark2F0Oa02GFE
 7kvVHame5Dl5b3IINZ+zLcGPzUx0NZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-4rl2eYYDPaC9KyJoYcgbug-1; Thu, 05 Mar 2020 17:37:39 -0500
X-MC-Unique: 4rl2eYYDPaC9KyJoYcgbug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1598107ACCA;
 Thu,  5 Mar 2020 22:37:37 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB8339E;
 Thu,  5 Mar 2020 22:37:37 +0000 (UTC)
Date: Thu, 5 Mar 2020 15:37:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Roman Kapl <rka@sysgo.com>
Subject: Re: [PATCH] vfio: avoid SET_ACTION_TRIGGER ioctls
Message-ID: <20200305153735.238a9ddd@w520.home>
In-Reply-To: <20200228120800.5979-1-rka@sysgo.com>
References: <20200228120800.5979-1-rka@sysgo.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 13:08:00 +0100
Roman Kapl <rka@sysgo.com> wrote:

> For MSI-X interrupts, remember what the last used eventfd was (KVM
> bypass vs QEMU) and only call vfio_set_irq_signaling if it has changed.
> 
> This not only helps with performance, but it seems that interrupts can
> be lost during VFIO_IRQ_SET_ACTION_TRIGGER. With the 'x-no-kvm-msix'
> switch and this patch, SET_ACTION_TRIGGER is not called during
> mask/unmask. This really only affects guests that actively use MSI-X masking.
> 
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> ---
> 
> This patch scratches my particular itch. I am able to get our guest (which masks
> MSI on each interrupt) running, without getting randomly stuck on waiting for
> interrupt. However, the solution is far from perfect (x-no-kvm-msix is required)
> and pretty slow. I would be interested in hearing any ideas how to improve this.
> Some ideas:
> 
> 1) Fix the kernel so that SET_ACTION_TRIGGER does not loose interrupts (I think
> the problem is there, but not 100% sure). I've tested on 5.3.0-40-generic
> #32~18.04.1-Ubuntu SMP.

I'd be curious if this (yet unmerged) series resolve this:

https://lore.kernel.org/lkml/cover.1567394624.git.luoben@linux.alibaba.com/
 
> 2) Add support for MASK/UNMASK for MSI-X in kernel and use that. But I don't
> know how to do PBA in that case. Another IOCTL? We could look at the real PBA
> array, if mapping is supported, but that seems hacky.

That lack of a masking API in the host kernel is part of the reason we
take the hacky approach of emulating the PBA in QEMU.  We could have
the PBA MemoryRegion do a pread() from the device, but if we're doing
some ioctls on every un/mask, we're probably already digging ourselves
out of a hole.

It would be interesting to see if the series above prevents dropping
interrupts, how it compares with the reduced ioctls + QEMU handling you
have here.

> 3) Twiddle the bits behing kernel's back, if it can be mapped?

I'm not sure what you're thinking here, you mean mask vectors directly
on the device w/o a host kernel masking API and then read the PBA
directly from the device, mapping it directly to the guest if possible?
The MSI-X MMIO space can be mmapped by QEMU, we rely on interrupt
remmappers to protect us from malicious users.  QEMU certainly
shouldn't touch the vector or data fields, but masking might be
reasonably safe, then we could leave the KVM route in place.  I'm
afraid it might be difficult to integrate with QEMU MSI-X support
though.

> Still, I think this patch does not hurt anything and could be applied if no-one
> can think of a better way.
> 
> ---
> 
>  hw/vfio/pci.c | 32 ++++++++++++++++++++++----------
>  hw/vfio/pci.h |  2 ++
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e6569a7968..5f7ce91519 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -390,12 +390,16 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>           * MSI-X mask and pending bits are emulated, so we want to use the
>           * KVM signaling path only when configured and unmasked.
>           */
> -        if (vdev->msi_vectors[i].use) {
> -            if (vdev->msi_vectors[i].virq < 0 ||
> -                (msix && msix_is_masked(&vdev->pdev, i))) {
> -                fd = event_notifier_get_fd(&vdev->msi_vectors[i].interrupt);
> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
> +        if (vector->use) {
> +            if (vector->virq < 0 ||
> +                (msix && msix_is_masked(&vdev->pdev, i)))
> +            {
> +                vector->kvm_path_active = false;
> +                fd = event_notifier_get_fd(&vector->interrupt);
>              } else {
> -                fd = event_notifier_get_fd(&vdev->msi_vectors[i].kvm_interrupt);
> +                vector->kvm_path_active = true;
> +                fd = event_notifier_get_fd(&vector->kvm_interrupt);
>              }
>          }
>  
> @@ -509,17 +513,23 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>      } else {
>          Error *err = NULL;
>          int32_t fd;
> +        bool kvm_path;
>  
>          if (vector->virq >= 0) {
>              fd = event_notifier_get_fd(&vector->kvm_interrupt);
> +            kvm_path = true;
>          } else {
>              fd = event_notifier_get_fd(&vector->interrupt);
> +            kvm_path = false;
>          }
>  
> -        if (vfio_set_irq_signaling(&vdev->vbasedev,
> -                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> -            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        if (vector->kvm_path_active != kvm_path) {
> +            if (vfio_set_irq_signaling(&vdev->vbasedev,
> +                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +            }
> +            vector->kvm_path_active = kvm_path;


Wouldn't this be more intuitive if we just cached the current fd on the
VFIOMSIVector object and created a vfio_set_irq_signaling() wrapper for
vectors that only calls through when the fd changes, updating the fd on
successful return otherwise?  AIUI, you're only trying to prevent
gratuitous calls to vfio_set_irq_signaling() when the eventfd remains
unchanged, which is the common case for your configuration of running
in QEMU interrupt mode.  Thanks,

Alex

>          }
>      }
>  
> @@ -555,13 +565,15 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>       * core will mask the interrupt and set pending bits, allowing it to
>       * be re-asserted on unmask.  Nothing to do if already using QEMU mode.
>       */
> -    if (vector->virq >= 0) {
> +    if (vector->virq >= 0 && vector->kvm_path_active) {
>          int32_t fd = event_notifier_get_fd(&vector->interrupt);
>          Error *err = NULL;
>  
>          if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
>                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>              error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        } else {
> +            vector->kvm_path_active = false;
>          }
>      }
>  }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b329d50338..b01d2676cf 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -91,6 +91,8 @@ typedef struct VFIOMSIVector {
>       */
>      EventNotifier interrupt;
>      EventNotifier kvm_interrupt;
> +    /* Set when the trigger action is set to the KVM bypass FD */
> +    bool kvm_path_active;
>      struct VFIOPCIDevice *vdev; /* back pointer to device */
>      int virq;
>      bool use;


