Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20F6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0BA20658
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkE2E5cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0BA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k85Nr-0000Vd-M6
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k85Mz-0008Fq-AF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k85Mv-0005Ra-CD
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597771552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+/tyYJ2dDzvr6Jgg4ekwKWnwn+UDUFx2mhXU7AC1P4=;
 b=GkE2E5czNRUXHzAkndoAd+tom7Hg1QwwQbSswDEoYOX9SdIk45MoCE11HlSe1tDMAAMXxg
 cjBREUl8eSxxsKUO+ihHU+gFuq9lYbrmr+flF7EHK6NGnzRL41gefqObtz2YQH+XNVvwqq
 8yu+DBnkretZt53xDYin9597W/E1Q5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-xkuDBno_OQKwolyfPbyvMQ-1; Tue, 18 Aug 2020 13:25:49 -0400
X-MC-Unique: xkuDBno_OQKwolyfPbyvMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B141A81CBF1;
 Tue, 18 Aug 2020 17:25:48 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30B2C60BE5;
 Tue, 18 Aug 2020 17:25:45 +0000 (UTC)
Date: Tue, 18 Aug 2020 11:25:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v3 4/5] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Message-ID: <20200818112544.1ce38439@x1.home>
In-Reply-To: <20200818164509.736367-5-philmd@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
 <20200818164509.736367-5-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 18:45:08 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> qemu_vfio_pci_init_irq() allows us to initialize any type of IRQ,
> but only one. Introduce qemu_vfio_pci_init_msix_irqs() which is
> specific to MSIX IRQ type, and allow us to use multiple IRQs
> (thus passing multiple eventfd notifiers).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 ++
>  util/vfio-helpers.c         | 53 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 1f057c2b9e4..63108ebc8da 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -28,5 +28,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int inde=
x, void *bar,
>                               uint64_t offset, uint64_t size);
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>                             int irq_type, Error **errp);
> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *e,
> +                                 unsigned irq_count, Error **errp);
> =20
>  #endif
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 696f2d51712..fb3a79a5bcb 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -215,6 +215,59 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNo=
tifier *e,
>      return 0;
>  }
> =20
> +/**
> + * Initialize device MSIX IRQs and register event notifiers.
> + * @irq_count: number of MSIX IRQs to initialize
> + * @e: Array of @irq_count notifiers (each corresponding to a MSIX IRQ)
> + */
> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *e,
> +                                 unsigned irq_count, Error **errp)
> +{
> +    int r;
> +    struct vfio_irq_set *irq_set;
> +    size_t irq_set_size;
> +    struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info) };
> +
> +    irq_info.index =3D VFIO_PCI_MSIX_IRQ_INDEX;

Nit, this could be initialized in the declaration with argsz.

> +    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
> +        error_setg_errno(errp, errno, "Failed to get device interrupt in=
fo");
> +        return -errno;
> +    }
> +    if (irq_info.count <=3D irq_count) {


Shouldn't this only test strictly less than?  The API seems to leave
the problem of determining how many vectors might be available as an
exercise for the caller.  Thanks,

Alex


> +        error_setg(errp,
> +                   "Not enough device interrupts available (only %" PRIu=
32 ")",
> +                   irq_info.count);
> +        return -EINVAL;
> +    }
> +    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
> +        error_setg(errp, "Device interrupt doesn't support eventfd");
> +        return -EINVAL;
> +    }
> +
> +    irq_set_size =3D sizeof(*irq_set) + irq_count * sizeof(int32_t);
> +    irq_set =3D g_malloc0(irq_set_size);
> +
> +    /* Get to a known IRQ state */
> +    *irq_set =3D (struct vfio_irq_set) {
> +        .argsz =3D irq_set_size,
> +        .flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGG=
ER,
> +        .index =3D irq_info.index,
> +        .start =3D 0,
> +        .count =3D irq_count,
> +    };
> +
> +    for (unsigned i =3D 0; i < irq_count; i++) {
> +        ((int32_t *)&irq_set->data)[i] =3D event_notifier_get_fd(&e[i]);
> +    }
> +    r =3D ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
> +    g_free(irq_set);
> +    if (r) {
> +        error_setg_errno(errp, errno, "Failed to setup device interrupts=
");
> +        return -errno;
> +    }
> +    return 0;
> +}
> +
>  static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
>                                       int size, int ofs)
>  {


