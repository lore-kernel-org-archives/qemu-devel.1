Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FB42076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON5UCWpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FB42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5YrD-0006bE-Gr
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 14:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k5Ypx-0005gr-Ae
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:17:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k5Ypu-0005LD-Db
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597169840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVtJMfYTO7u506B3TOgJ6c9mkt85KyhwmdZAgPfPlyY=;
 b=ON5UCWpDeHQCqTmNi302GXAQ1S0IVFqUpPFRa+X3ZoxIqz9EyLB16DUcjbtZc2kXtI7HCk
 o85CrNZQ/4oKC1voJOSp1XkwJRmXC3AaVzy0oZOB2FSqQaVf3RObU/Njfe4sm0OD72jW17
 WUmxdn+CY3mYb/FofeU+1PnaRggp8Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-6gxGvoPlOSGzU2hQhOt0cg-1; Tue, 11 Aug 2020 14:17:17 -0400
X-MC-Unique: 6gxGvoPlOSGzU2hQhOt0cg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 415C7100CCC0;
 Tue, 11 Aug 2020 18:17:16 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA8441001281;
 Tue, 11 Aug 2020 18:17:10 +0000 (UTC)
Date: Tue, 11 Aug 2020 12:17:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 3/3] util/vfio-helpers: Let qemu_vfio_pci_init_irq
 take IRQ index argument
Message-ID: <20200811121710.10ccf015@x1.home>
In-Reply-To: <20200811172845.16698-4-philmd@redhat.com>
References: <20200811172845.16698-1-philmd@redhat.com>
 <20200811172845.16698-4-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
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

On Tue, 11 Aug 2020 19:28:45 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Add a new 'index' argument to qemu_vfio_pci_init_irq() to be able
> to initialize other IRQs than IRQ #0. Adapt the single user of this
> API in nvme_init().

This is actually addressing the what the vfio uAPI refers to as the
subindex, the index is the interrupt type, ex. MSI-X.

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 +-
>  block/nvme.c                |  2 +-
>  util/vfio-helpers.c         | 12 +++++++++---
>  3 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 1f057c2b9e..ff63e75096 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -27,6 +27,6 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index=
,
>  void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>                               uint64_t offset, uint64_t size);
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
> -                           int irq_type, Error **errp);
> +                           int irq_type, unsigned index, Error **errp);
> =20
>  #endif
> diff --git a/block/nvme.c b/block/nvme.c
> index 374e268915..2b3986b66d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -757,7 +757,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>      }
> =20
>      ret =3D qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
> -                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
> +                                 VFIO_PCI_MSIX_IRQ_INDEX, 0, errp);
>      if (ret) {
>          goto out;
>      }
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 3ad7e6be52..ba9a869364 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -173,10 +173,11 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int =
index, void *bar,
>  }
> =20
>  /**
> - * Initialize device IRQ with @irq_type and register an event notifier.
> + * Initialize device IRQ @index with @irq_type
> + * and register an event notifier.
>   */
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
> -                           int irq_type, Error **errp)
> +                           int irq_type, unsigned index, Error **errp)
>  {


But MSI-X will expose the VFIO_IRQ_INFO_NORESIZE flag, which means that
we cannot incrementally enable additional subindexes, aka vectors,
without first disabling and re-enabling the entire index/irq_type.
Therefore this is exposing an API that isn't actually supported.
Thanks,

Alex

>      int r;
>      struct vfio_irq_set *irq_set;
> @@ -193,6 +194,11 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNo=
tifier *e,
>          return -EINVAL;
>      }
>      trace_qemu_vfio_pci_init_irq(irq_info.count);
> +    if (index >=3D irq_info.count) {
> +        error_setg(errp, "Device has %"PRIu32" interrupts (requested ind=
ex %u)",
> +                   irq_info.count, index);
> +        return -EINVAL;
> +    }
> =20
>      irq_set_size =3D sizeof(*irq_set) + sizeof(int32_t);
>      irq_set =3D g_malloc0(irq_set_size);
> @@ -202,7 +208,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNot=
ifier *e,
>          .argsz =3D irq_set_size,
>          .flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGG=
ER,
>          .index =3D irq_info.index,
> -        .start =3D 0,
> +        .start =3D index,
>          .count =3D 1,
>      };
> =20


