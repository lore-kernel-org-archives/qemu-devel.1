Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EBC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D25206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDFBxEKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D25206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELBH-0003Zx-Lf
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 18:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jELAO-0002Fp-8u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jELAN-00017C-0x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:58:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jELAM-00015y-SW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584485910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBYfWjCMiq0Djg2x4GiWR+BXaRtFhOFGVm6raUE6Xv8=;
 b=gDFBxEKFzjAfaAlLf6Ixg1VMH+0o+n4Z+l8ncNIQQhB3Tnn7UiZTRZxViQfuoNMi1AY5cx
 rUoQck9ezNACGnUF/w5boiP3yovDUFF5cQzaEnLRZwIrBxmwpc9Ln7Tf8/PLVhgjAMgbV9
 HRKBY03hAiBUVPRG4GvnChJpquyGK7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-Oim56d-tOdW3FRjPhybQ4w-1; Tue, 17 Mar 2020 18:58:28 -0400
X-MC-Unique: Oim56d-tOdW3FRjPhybQ4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8F16A6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 22:58:28 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28DB75C1BB;
 Tue, 17 Mar 2020 22:58:22 +0000 (UTC)
Date: Tue, 17 Mar 2020 16:58:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 5/5] Revert "vfio/pci: Disable INTx fast path if
 using split irqchip"
Message-ID: <20200317165822.080a8dd3@w520.home>
In-Reply-To: <20200317195042.282977-6-peterx@redhat.com>
References: <20200317195042.282977-1-peterx@redhat.com>
 <20200317195042.282977-6-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Tue, 17 Mar 2020 15:50:42 -0400
Peter Xu <peterx@redhat.com> wrote:

> With the resamplefd list introduced, we can savely enable VFIO INTx
> fast path again with split irqchip so it can still be faster than the
> complete slow path.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/pci.c | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 09703362df..1c0aa27386 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -124,18 +124,6 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>          return;
>      }
>  
> -    if (kvm_irqchip_is_split()) {
> -        /*
> -         * VFIO INTx is currently not working with split kernel
> -         * irqchip for level triggered interrupts.  Go the slow path
> -         * as long as split is enabled so we can be at least
> -         * functional (even with poor performance).
> -         *
> -         * TODO: Remove this after all things fixed up.
> -         */
> -        return;
> -    }
> -
>      /* Get to a known interrupt state */
>      qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
>      vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);


