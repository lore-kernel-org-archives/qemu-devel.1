Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9BC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A512077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgZsJMc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A512077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqBa-0000Gc-Cn
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ioozQ-0007LG-A0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ioozP-0006GR-1w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:33:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ioozO-0006G1-Ts
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578404022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qy8XArzqdhSuNPmt781U/XXMMYtFQGsAe2yAQwds87k=;
 b=OgZsJMc12SXNqZu4/pdKFD3Nbc+Q9yPa3fj1ys605/YGaNw65a4PZixhthP4YWvk1xIJ/z
 y8ntkIw2mscuEZeg7lp/TtA2NfBlD6XCS6mvSEFk+YV+Wx0B62qQhAYBFwD7Og0NUJSXMM
 Edjf04LDc5/ny0xi7IwZix1+pjO2V8w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-ETwl4RJIPKWlBYBv7CVyaw-1; Tue, 07 Jan 2020 08:33:37 -0500
Received: by mail-qt1-f198.google.com with SMTP id p12so36376563qtu.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mbWyuV09w6dFxpToORccWwL4yGT3GH+qoXS0i7qzuCE=;
 b=JtNV4ewOPbG+AS4MV6ZMqNMT9dHKxvryuoxC+sx2iIRLaf9+YHKzsQIhb+y31YySn2
 B9w3Z1F4S65ej27NfRAScpXMeB5lVnRzsDf3X2Npg45U4gDvoMiL8irVdlsbEenkfZwP
 h63kkoPleNNl8z6FVMu2DChZ5N7YgYWT8oAiwNIQqhKUdSuQcgxycdjJtI3HNU+pfARe
 vdNpx0Ky50mb5dSLgPaXFI3A96YIHoWfydvG6p09/3sFf6VjC6GxBz/dxGoB/niMT7Q8
 H1JULQR1+R7a64Z5QK1uR7knW2racgy94t6t400kTrHaVjCdijWbEu9NYffeCv02Gl3w
 7J1A==
X-Gm-Message-State: APjAAAVgTkueuGPeqJPlvyTXRI0/taxqDf8McE7OHfWaJSEbcFohCMLE
 Ejqg6uufHkRbOTNoI9RaHr3ifm11frSlB3dSn/1nXxJevyM8INrj1JrP8RslF/r4UGrr7+3BoTy
 P/AStR6qVUSxVzr4=
X-Received: by 2002:a05:620a:228:: with SMTP id
 u8mr87530237qkm.88.1578404017397; 
 Tue, 07 Jan 2020 05:33:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCq/7Zdqmtoc8UiQv0McpMAPqtKl+vpi/qzQH5lGsUVuTBEsRtGReWKGO2NKhxXDgrKxddfw==
X-Received: by 2002:a05:620a:228:: with SMTP id
 u8mr87530222qkm.88.1578404017179; 
 Tue, 07 Jan 2020 05:33:37 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::3])
 by smtp.gmail.com with ESMTPSA id 65sm21347228qtf.95.2020.01.07.05.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:33:36 -0800 (PST)
Date: Tue, 7 Jan 2020 08:33:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio/pci: Don't remove irqchip notifier if not registered
Message-ID: <20200107133332.GE219677@xz-x1>
References: <20191231133915.115363-1-peterx@redhat.com>
 <20200106151324.15fbb68d@w520.home>
MIME-Version: 1.0
In-Reply-To: <20200106151324.15fbb68d@w520.home>
X-MC-Unique: ETwl4RJIPKWlBYBv7CVyaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yanghliu@redhat.com, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 03:13:24PM -0700, Alex Williamson wrote:
> On Tue, 31 Dec 2019 08:39:15 -0500
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > The kvm irqchip notifier is only registered if the device supports
> > INTx, however it's unconditionally removed.  If the assigned device
> > does not support INTx, this will cause QEMU to crash when unplugging
> > the device from the system.  Change it to conditionally remove the
> > notifier only if the notify hook is setup.
> >=20
> > CC: Eduardo Habkost <ehabkost@redhat.com>
> > CC: David Gibson <david@gibson.dropbear.id.au>
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > Reported-by: yanghliu@redhat.com
> > Fixes: c5478fea27 ("vfio/pci: Respond to KVM irqchip change notifier", =
2019-11-26)
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1782678
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/vfio/pci.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 2d40b396f2..337a173ce7 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3076,7 +3076,9 @@ static void vfio_exitfn(PCIDevice *pdev)
> >      vfio_unregister_req_notifier(vdev);
> >      vfio_unregister_err_notifier(vdev);
> >      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> > -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier)=
;
> > +    if (vdev->irqchip_change_notifier.notify) {
> > +        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notif=
ier);
> > +    }
> >      vfio_disable_interrupts(vdev);
> >      if (vdev->intx.mmap_timer) {
> >          timer_free(vdev->intx.mmap_timer);
>=20
>=20
> Thanks, Peter!  Sent a pull request with David and Greg's R-b, stable
> tag, and debug credit to Eduardo as I think he spotted the issue first.
> Thanks,

Yes thanks!  I wished Eduardo had even updated the bz when he debugged
so I won't be needinfo-ed and did it twice without notice :)

--=20
Peter Xu


