Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07084C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D7624690
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsysLhmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D7624690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GyT-0000wI-1E
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7Gxs-0000Ue-V2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7Gxr-0005dO-Nd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:04:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7Gxr-0005d5-JH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582801462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6VhJQhQ07nlwNc209gZjI1zaB68QC89xVnxd1ygYQ8=;
 b=bsysLhmK0FW2NRg+fFj4rbolWP+OnhOOU/AFMbvlsZ6KKPDLuq7B9I3LyCEDnuXnwqPuDN
 W3KANFmwnO3hJ0WP71gJOscN2IQSvBUfRL5N/iKT9AIzeIGoRMqLPsTB6gVYlqaz07C31s
 uYnjWypVY7hwPcfHJqsT0x/I2ZhCgeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-uysLh42ROwqKUi4UQESXjQ-1; Thu, 27 Feb 2020 06:04:21 -0500
X-MC-Unique: uysLh42ROwqKUi4UQESXjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C09F477
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 11:04:20 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7656419C58;
 Thu, 27 Feb 2020 11:04:13 +0000 (UTC)
Subject: Re: [PATCH 2/5] vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi()
 for irqfds
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200226225048.216508-1-peterx@redhat.com>
 <20200226225048.216508-3-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bce7702f-c40b-c7d7-5184-44e893b7b806@redhat.com>
Date: Thu, 27 Feb 2020 12:04:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200226225048.216508-3-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/26/20 11:50 PM, Peter Xu wrote:
> VFIO is currently the only one left that is not using the generic
> function (kvm_irqchip_add_irqfd_notifier_gsi()) to register irqfds.
> Let VFIO use the common framework too.
> 
> Follow up patches will introduce extra features for kvm irqfd, so that
> VFIO can easily leverage that after the switch.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
Looks good to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/vfio/pci.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 98e0e0c994..09703362df 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -115,11 +115,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>  static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>  {
>  #ifdef CONFIG_KVM
> -    struct kvm_irqfd irqfd = {
> -        .fd = event_notifier_get_fd(&vdev->intx.interrupt),
> -        .gsi = vdev->intx.route.irq,
> -        .flags = KVM_IRQFD_FLAG_RESAMPLE,
> -    };
> +    int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
>      Error *err = NULL;
>  
>      if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
> @@ -141,7 +137,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>      }
>  
>      /* Get to a known interrupt state */
> -    qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
> +    qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
>      vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>      vdev->intx.pending = false;
>      pci_irq_deassert(&vdev->pdev);
> @@ -152,17 +148,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>          goto fail;
>      }
>  
> -    /* KVM triggers it, VFIO listens for it */
> -    irqfd.resamplefd = event_notifier_get_fd(&vdev->intx.unmask);
> -
> -    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
> +    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
> +                                           &vdev->intx.interrupt,
> +                                           &vdev->intx.unmask,
> +                                           vdev->intx.route.irq)) {
>          error_setg_errno(errp, errno, "failed to setup resample irqfd");
>          goto fail_irqfd;
>      }
>  
>      if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>                                 VFIO_IRQ_SET_ACTION_UNMASK,
> -                               irqfd.resamplefd, &err)) {
> +                               event_notifier_get_fd(&vdev->intx.unmask),
> +                               &err)) {
>          error_propagate(errp, err);
>          goto fail_vfio;
>      }
> @@ -177,12 +174,12 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>      return;
>  
>  fail_vfio:
> -    irqfd.flags = KVM_IRQFD_FLAG_DEASSIGN;
> -    kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd);
> +    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
> +                                          vdev->intx.route.irq);
>  fail_irqfd:
>      event_notifier_cleanup(&vdev->intx.unmask);
>  fail:
> -    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
> +    qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>      vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>  #endif
>  }
> @@ -190,12 +187,6 @@ fail:
>  static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>  {
>  #ifdef CONFIG_KVM
> -    struct kvm_irqfd irqfd = {
> -        .fd = event_notifier_get_fd(&vdev->intx.interrupt),
> -        .gsi = vdev->intx.route.irq,
> -        .flags = KVM_IRQFD_FLAG_DEASSIGN,
> -    };
> -
>      if (!vdev->intx.kvm_accel) {
>          return;
>      }
> @@ -209,7 +200,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>      pci_irq_deassert(&vdev->pdev);
>  
>      /* Tell KVM to stop listening for an INTx irqfd */
> -    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
> +    if (kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
> +                                              vdev->intx.route.irq)) {
>          error_report("vfio: Error: Failed to disable INTx irqfd: %m");
>      }
>  
> @@ -217,7 +209,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>      event_notifier_cleanup(&vdev->intx.unmask);
>  
>      /* QEMU starts listening for interrupt events. */
> -    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
> +    qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
> +                        vfio_intx_interrupt, NULL, vdev);
>  
>      vdev->intx.kvm_accel = false;
>  
> 


