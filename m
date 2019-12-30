Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5093C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 13:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8178E20409
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 13:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGySc4hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8178E20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilv2M-00040K-NC
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 08:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ilv1l-0003Tm-8D
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 08:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ilv1j-0001lu-R2
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 08:24:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ilv1j-0001lQ-Ns
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 08:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577712246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtXuCuSZBKOV2ZC47bx4pdWKDfRHgngSAt9jaXBLx1I=;
 b=cGySc4hVTro/VXXu3CSv6s+/vufKer1gG8vuQIWdP+YnmQBLSEj11hRVAHPaJCHoNicKu9
 4f1HEP2YzHBU5FfhpTssPauHtae4ANrfYXi6UJHcbjyQlXTmGs+NIwJk13yWAaH/lqS7rT
 ANmX5B8uoB+JcO5RYfi7TU8O/hxQ2GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-7JNoN4BgOcmCWBAoyyFC4g-1; Mon, 30 Dec 2019 08:24:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50062801E74;
 Mon, 30 Dec 2019 13:23:59 +0000 (UTC)
Received: from localhost (ovpn-116-43.gru2.redhat.com [10.97.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A581F107A44F;
 Mon, 30 Dec 2019 13:23:54 +0000 (UTC)
Date: Mon, 30 Dec 2019 10:23:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PULL 4/8] vfio/pci: Respond to KVM irqchip change notifier
Message-ID: <20191230132352.GC4395@habkost.net>
References: <20191126060151.729845-1-david@gibson.dropbear.id.au>
 <20191126060151.729845-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20191126060151.729845-5-david@gibson.dropbear.id.au>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7JNoN4BgOcmCWBAoyyFC4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, groug@kaod.org,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 05:01:47PM +1100, David Gibson wrote:
> VFIO PCI devices already respond to the pci intx routing notifier, in ord=
er
> to update kernel irqchip mappings when routing is updated.  However this
> won't handle the case where the irqchip itself is replaced by a different
> model while retaining the same routing.  This case can happen on
> the pseries machine type due to PAPR feature negotiation.
>=20
> To handle that case, add a handler for the irqchip change notifier, which
> does much the same thing as the routing notifier, but is unconditional,
> rather than being a no-op when the routing hasn't changed.
>=20
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
[...]
> @@ -2973,30 +2981,32 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
>                                                    vfio_intx_mmap_enable,=
 vdev);
>          pci_device_set_intx_routing_notifier(&vdev->pdev,
>                                               vfio_intx_routing_notifier)=
;
> +        vdev->irqchip_change_notifier.notify =3D vfio_irqchip_change;
> +        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);

This code is conditional on
    (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)).

However:

[...]
> -out_teardown:
> +out_deregister:
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
>  error:
> @@ -3064,6 +3076,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);

This is unconditional.  This doesn't look safe, and might be the
cause of the crash reported at
https://bugzilla.redhat.com/show_bug.cgi?id=3D1782678

--=20
Eduardo


