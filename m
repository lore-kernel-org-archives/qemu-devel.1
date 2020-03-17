Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35BBC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CD020714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDm3bYf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CD020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELAG-0001n9-PF
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 18:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jEL9c-0001E5-Bz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jEL9b-0005de-5e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:57:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jEL9b-0005XT-19
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584485862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wExJl7M4naEVyv4gnIdbvBytTJNkbS04/S4G23ZBtKQ=;
 b=SDm3bYf++M5Qz8ykojEiHSEADOnozxxEhLS3bFFHsMnk/PrL60DbhhgBThaghAavP2uFw7
 qbyqFX6TpUIPbDJct8w7ioy9rPqie2INMgaVbYc81gW1aDUzXWf1yQ2W6KghviF50xIcUz
 LEhVlolIwRIrNZ9/7TAArxHlW64If14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-dYL1pIk9PASaZRZLzczxUw-1; Tue, 17 Mar 2020 18:57:40 -0400
X-MC-Unique: dYL1pIk9PASaZRZLzczxUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 722BB107ACC9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 22:57:39 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84D9160BE0;
 Tue, 17 Mar 2020 22:57:33 +0000 (UTC)
Date: Tue, 17 Mar 2020 16:57:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 1/5] vfio/pci: Disable INTx fast path if using split
 irqchip
Message-ID: <20200317165733.72c82684@w520.home>
In-Reply-To: <20200317195042.282977-2-peterx@redhat.com>
References: <20200317195042.282977-1-peterx@redhat.com>
 <20200317195042.282977-2-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Tue, 17 Mar 2020 15:50:38 -0400
Peter Xu <peterx@redhat.com> wrote:

> It's currently broken.  Let's use the slow path to at least make it
> functional.
> 
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5e75a95129..98e0e0c994 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -128,6 +128,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>          return;
>      }
>  
> +    if (kvm_irqchip_is_split()) {
> +        /*
> +         * VFIO INTx is currently not working with split kernel
> +         * irqchip for level triggered interrupts.  Go the slow path
> +         * as long as split is enabled so we can be at least
> +         * functional (even with poor performance).
> +         *
> +         * TODO: Remove this after all things fixed up.
> +         */
> +        return;
> +    }
> +
>      /* Get to a known interrupt state */
>      qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
>      vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);


