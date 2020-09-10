Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B9DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F6720829
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTbeALIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F6720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPTh-0001tV-UF
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kGPSX-0001A5-6C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:30:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kGPSV-0000Ae-Ge
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599755401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yov5WJt8lwBj98MQF0uxLLqCdX2SSLZ+KDE/veAC+I=;
 b=KTbeALIOVYlGDDVNjalWUBTONtGxS/VTSGkGMgDoNgmxjNpQc4caaUyssJzgi6n9LVJbP2
 vQMSX/zOccgt5XvoiQBhR3yV3p3zmWjJVOtQIM5VQEtg9hdJTfsczl+JR4HJPXXJNSHTGg
 GyoQwbYB9OKpoN+qAw2RLBdwQTZfILw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-ZgxRPF0MN1SeWrB_CC9SDQ-1; Thu, 10 Sep 2020 12:29:56 -0400
X-MC-Unique: ZgxRPF0MN1SeWrB_CC9SDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E4525705C;
 Thu, 10 Sep 2020 16:29:55 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E297719C71;
 Thu, 10 Sep 2020 16:29:51 +0000 (UTC)
Date: Thu, 10 Sep 2020 10:29:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v6 3/4] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Message-ID: <20200910102949.2502144d@w520.home>
In-Reply-To: <4df84b90-68f6-7d69-024a-30ab2af5cc7e@redhat.com>
References: <20200909142354.334859-1-philmd@redhat.com>
 <20200909142354.334859-4-philmd@redhat.com>
 <20200910104435.GA45048@stefanha-x1.localdomain>
 <4df84b90-68f6-7d69-024a-30ab2af5cc7e@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 17:29:25 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Stefan, Alex.
>=20
> On 9/10/20 12:44 PM, Stefan Hajnoczi wrote:
> > On Wed, Sep 09, 2020 at 04:23:53PM +0200, Philippe Mathieu-Daud=C3=83=
=C2=A9 wrote: =20
> >> +/**
> >> + * Initialize device MSIX IRQs and register event notifiers.
> >> + * @irq_count: pointer to number of MSIX IRQs to initialize
> >> + * @notifier: Array of @irq_count notifiers (each corresponding to a =
MSIX IRQ)
> >> +
> >> + * If the number of IRQs requested exceeds the available on the devic=
e,
> >> + * store the number of available IRQs in @irq_count and return -EOVER=
FLOW.
> >> + */
> >> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *not=
ifier,
> >> +                                 unsigned *irq_count, Error **errp)
> >> +{
> >> +    int r;
> >> +    size_t irq_set_size;
> >> +    struct vfio_irq_set *irq_set;
> >> +    struct vfio_irq_info irq_info =3D {
> >> +        .argsz =3D sizeof(irq_info),
> >> +        .index =3D VFIO_PCI_MSIX_IRQ_INDEX
> >> +    };
> >> +
> >> +    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
> >> +        error_setg_errno(errp, errno, "Failed to get device interrupt=
 info");
> >> +        return -errno;
> >> +    }
> >> +    if (irq_info.count < *irq_count) {
> >> +        error_setg(errp, "Not enough device interrupts available");
> >> +        *irq_count =3D irq_info.count;
> >> +        return -EOVERFLOW;
> >> +    }
> >> +    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
> >> +        error_setg(errp, "Device interrupt doesn't support eventfd");
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    irq_set_size =3D sizeof(*irq_set) + *irq_count * sizeof(int32_t);
> >> +    irq_set =3D g_malloc0(irq_set_size);
> >> +
> >> +    /* Get to a known IRQ state */
> >> +    *irq_set =3D (struct vfio_irq_set) {
> >> +        .argsz =3D irq_set_size,
> >> +        .flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TR=
IGGER,
> >> +        .index =3D irq_info.index,
> >> +        .start =3D 0,
> >> +        .count =3D *irq_count,
> >> +    };
> >> +
> >> +    for (unsigned i =3D 0; i < *irq_count; i++) {
> >> +        ((int32_t *)&irq_set->data)[i] =3D event_notifier_get_fd(&not=
ifier[i]);
> >> +    }
> >> +    r =3D ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
> >> +    g_free(irq_set);
> >> +    if (r <=3D 0) {
> >> +        error_setg_errno(errp, errno, "Failed to setup device interru=
pts");
> >> +        return -errno;
> >> +    } else if (r < *irq_count) {
> >> +        error_setg(errp, "Not enough device interrupts available");
> >> +        *irq_count =3D r;
> >> +        return -EOVERFLOW;
> >> +    } =20
> >=20
> > EOVERFLOW can occur in two cases: VFIO_DEVICE_GET_IRQ_INFO and
> > VFIO_DEVICE_SET_IRQS. =20
>=20
> Yes.
>=20
> >=20
> > If it happens in the second case the notifier[] array has been
> > registered successfully. =20
>=20
> No, I don't think so:
>=20
> vfio_pci_set_msi_trigger() register the notifier only if
> vfio_msi_enable() succeeded (returned 0). If vfio_msi_enable()
> failed it returns the number of vectors available but do
> not register the notifiers.
>=20
> Alex, do you confirm?

Yes, if we can't setup what the user requested we don't setup anything.
However, I think we return zero on success, which seems to fall into
your error condition.  Has this been tested?  Thanks,

Alex

> > The caller has no way of distinguishing the two cases. Therefore the
> > caller doesn't know if the eventfds will be used by the kernel after
> > EOVERFLOW.
> >=20
> > If the second case can ever happen then this function should probably
> > call VFIO_DEVICE_SET_IRQS again with VFIO_IRQ_SET_DATA_NONE to
> > unregister the eventfds before returning EOVERFLOW.
> >=20
> > STefan
> >  =20
>=20


