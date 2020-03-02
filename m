Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DA32146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmJk1iJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DA32146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8mk2-0007OC-D3
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8mig-0005tU-Eq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8mif-00046A-FS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:10:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8mif-00045z-BW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583161857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgJDnF/rESmmV2RfOYOeUzbb0dk+p/svr2gi+YBczEk=;
 b=hmJk1iJRigywBcYSdU5rvj1sXDpr6T4f0Ii8NVfAA5vl0h/rntA3oQcrUwPAoWg7DouZxb
 vDuoWeUmjDwqqqFiqVfGGdJjRYpOk4ueSw0dwFx7mSYELMd+j15eboa/RJJZcLCPl9oHPO
 ITbZ6x54wub/4EqJVANm0kmEPjf1RLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-LslynhpkMhmch3izmUYyMA-1; Mon, 02 Mar 2020 10:10:55 -0500
X-MC-Unique: LslynhpkMhmch3izmUYyMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FC358010E8
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2020 15:10:54 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B8FC19C4F;
 Mon,  2 Mar 2020 15:10:47 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] Revert "vfio/pci: Disable INTx fast path if using
 split irqchip"
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200228161503.382656-1-peterx@redhat.com>
 <20200228161503.382656-6-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6ffe70cb-a2d3-ef4e-6e66-11c8dc619eeb@redhat.com>
Date: Mon, 2 Mar 2020 16:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200228161503.382656-6-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 2/28/20 5:15 PM, Peter Xu wrote:
> With the resamplefd list introduced, we can savely enable VFIO INTx
> fast path again with split irqchip so it can still be faster than the
> complete slow path.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/vfio/pci.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
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
> 


