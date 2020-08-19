Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2425C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1EF2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tm1bu+J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1EF2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ReX-0002w1-PC
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 13:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k8Rde-0001f1-Ej
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:12:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k8Rdb-00085r-IC
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597857150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=895PlM1WPTgniq5ZYTcNLupt7mvFaQr+47UIOwaQgc0=;
 b=Tm1bu+J5i9yrNoHx2NOcf7qPkdDYp1buLbjQ/Q9b/c7sp7TwIe4u8v8pVGpnbGobU7/Xoe
 Yw7AgJaIiGFpChxHDgVB8WQTj33fibfYrNsDkOyLL3g/kDhnIOIMh1avwRADiXXPfP88xw
 tAihpraD8JlgrmM/Qe+mHv60iCDD52I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-3P17Diq7MgGXvTg3qSpxqg-1; Wed, 19 Aug 2020 13:12:29 -0400
X-MC-Unique: 3P17Diq7MgGXvTg3qSpxqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A3D1008550;
 Wed, 19 Aug 2020 17:12:25 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81AE25C3E0;
 Wed, 19 Aug 2020 17:12:22 +0000 (UTC)
Date: Wed, 19 Aug 2020 11:12:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v4 4/5] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Message-ID: <20200819111221.06633860@x1.home>
In-Reply-To: <20200819160318.835292-5-philmd@redhat.com>
References: <20200819160318.835292-1-philmd@redhat.com>
 <20200819160318.835292-5-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, 19 Aug 2020 18:03:17 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> qemu_vfio_pci_init_irq() allows us to initialize any type of IRQ,
> but only one. Introduce qemu_vfio_pci_init_msix_irqs() which is
> specific to MSIX IRQ type, and allow us to use multiple IRQs
> (thus passing multiple eventfd notifiers).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 ++
>  util/vfio-helpers.c         | 57 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>=20
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 1f057c2b9e4..8e6bd83ea41 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -28,5 +28,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int inde=
x, void *bar,
>                               uint64_t offset, uint64_t size);
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>                             int irq_type, Error **errp);
> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *e,
> +                                 unsigned *irq_count, Error **errp);
> =20
>  #endif
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 8f4a3d452ed..6f833972587 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -216,6 +216,63 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNo=
tifier *e,
>      return 0;
>  }
> =20
> +/**
> + * Initialize device MSIX IRQs and register event notifiers.
> + * @irq_count: pointer to number of MSIX IRQs to initialize
> + * @notifier: Array of @irq_count notifiers (each corresponding to a MSI=
X IRQ)
> +
> + * If the number of IRQs requested exceeds the available on the device,
> + * store the number of available IRQs in @irq_count and return -EOVERFLO=
W.
> + */
> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *notifi=
er,
> +                                 unsigned *irq_count, Error **errp)
> +{
> +    int r;
> +    size_t irq_set_size;
> +    struct vfio_irq_set *irq_set;
> +    struct vfio_irq_info irq_info =3D {
> +        .argsz =3D sizeof(irq_info),
> +        .index =3D VFIO_PCI_MSIX_IRQ_INDEX
> +    };
> +
> +    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
> +        error_setg_errno(errp, errno, "Failed to get device interrupt in=
fo");
> +        return -errno;
> +    }
> +    if (irq_info.count < *irq_count) {
> +        error_setg(errp, "Not enough device interrupts available");
> +        *irq_count =3D irq_info.count;
> +        return -EOVERFLOW;
> +    }
> +    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
> +        error_setg(errp, "Device interrupt doesn't support eventfd");
> +        return -EINVAL;
> +    }
> +
> +    irq_set_size =3D sizeof(*irq_set) + *irq_count * sizeof(int32_t);
> +    irq_set =3D g_malloc0(irq_set_size);
> +
> +    /* Get to a known IRQ state */
> +    *irq_set =3D (struct vfio_irq_set) {
> +        .argsz =3D irq_set_size,
> +        .flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGG=
ER,
> +        .index =3D irq_info.index,
> +        .start =3D 0,
> +        .count =3D *irq_count,
> +    };
> +
> +    for (unsigned i =3D 0; i < *irq_count; i++) {
> +        ((int32_t *)&irq_set->data)[i] =3D event_notifier_get_fd(&notifi=
er[i]);
> +    }
> +    r =3D ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
> +    g_free(irq_set);
> +    if (r) {
> +        error_setg_errno(errp, errno, "Failed to setup device interrupts=
");
> +        return -errno;

FWIW, the former irq_info.count check returns what the device is
capable of, the platform might only have limited vector space
available, therefore this ioctl can also return a value indicating the
number of vectors \actually\ available.  So if r > 0 you could return
it in *irq_count (which also makes me wonder if errno would be set in
that case).  Thanks,

Alex

> +    }
> +    return 0;
> +}
> +
>  static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
>                                       int size, int ofs)
>  {


