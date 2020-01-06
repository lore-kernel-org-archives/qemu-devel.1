Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22811C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE4E207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfkrqAA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE4E207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioadz-0006nF-C4
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 17:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ioacv-00063d-Jk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ioacu-0006NQ-4R
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:13:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ioacu-0006Mr-05
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578348811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fuTVo76IzuQe1COv+R1QShzTH/IJu+/YcS1DdeN6zw=;
 b=TfkrqAA0xtkRdqHMjSpTPdPSF2NF/riMCdqdPBBsxSfK0Ki2eyI4Wy7JfFusWrtQEoW013
 2qk82VNKViuuKxffisxN/SlTCUSYhppsHXY+gZiemxOXAd9VLCyZBRyrj/yTzM5iyMzruw
 kunMqXhT/+tMrUjM3avL9AFb5Htu+A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-pTQLpytEPf-50GsTbaJASw-1; Mon, 06 Jan 2020 17:13:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68624107ACFA;
 Mon,  6 Jan 2020 22:13:28 +0000 (UTC)
Received: from w520.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 912C25D9CA;
 Mon,  6 Jan 2020 22:13:25 +0000 (UTC)
Date: Mon, 6 Jan 2020 15:13:24 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] vfio/pci: Don't remove irqchip notifier if not registered
Message-ID: <20200106151324.15fbb68d@w520.home>
In-Reply-To: <20191231133915.115363-1-peterx@redhat.com>
References: <20191231133915.115363-1-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pTQLpytEPf-50GsTbaJASw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yanghliu@redhat.com, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Dec 2019 08:39:15 -0500
Peter Xu <peterx@redhat.com> wrote:

> The kvm irqchip notifier is only registered if the device supports
> INTx, however it's unconditionally removed.  If the assigned device
> does not support INTx, this will cause QEMU to crash when unplugging
> the device from the system.  Change it to conditionally remove the
> notifier only if the notify hook is setup.
> 
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: yanghliu@redhat.com
> Fixes: c5478fea27 ("vfio/pci: Respond to KVM irqchip change notifier", 2019-11-26)
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1782678
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2d40b396f2..337a173ce7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3076,7 +3076,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    if (vdev->irqchip_change_notifier.notify) {
> +        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    }
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
>          timer_free(vdev->intx.mmap_timer);


Thanks, Peter!  Sent a pull request with David and Greg's R-b, stable
tag, and debug credit to Eduardo as I think he spotted the issue first.
Thanks,

Alex


