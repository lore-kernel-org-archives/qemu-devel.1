Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F930C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F154C20829
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG2Z0Sfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F154C20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Krz-000118-Au
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6KoZ-0006jX-5L
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:31:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6KoV-0005GH-Ky
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597354266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cL3LIwOY30382AbIbwYRhFePIRcDUaysvuHQJ8BKLJc=;
 b=LG2Z0SfytbrbPFI9b58wm30fw7/IuKfNXqpTUFPX5k9hdeEconqHJREbuZRG+FmygNsHj8
 tc1d83IGYoB6QOZgoZNdE6z6eyoMyKtuVBcJTi+IgoBr2mamQyATzJlxXiVA9xXwbR2BXB
 FFZuw2bhw8HHW0x+fazd/SE6jKmRWFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-0oihQFykOf-8isxq_OXXbA-1; Thu, 13 Aug 2020 17:31:04 -0400
X-MC-Unique: 0oihQFykOf-8isxq_OXXbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04C071DDE0;
 Thu, 13 Aug 2020 21:31:03 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A68F1992D;
 Thu, 13 Aug 2020 21:31:02 +0000 (UTC)
Date: Thu, 13 Aug 2020 15:31:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 6/7] util/vfio-helpers: Allow to set
 EventNotifier to particular IRQ
Message-ID: <20200813153101.5fff5fd0@x1.home>
In-Reply-To: <20200813172957.8289-7-philmd@redhat.com>
References: <20200813172957.8289-1-philmd@redhat.com>
 <20200813172957.8289-7-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:30:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 13 Aug 2020 19:29:56 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Let qemu_vfio_pci_init_irq() take an 'index' argument, so we can
> set the EventNotifier to a specific IRQ.
> Add a safety check. Since our helper is limited to one single IRQ
> we are safe.
>=20
> Our only user is the NVMe block driver, update it (also safe because
> it only uses the first IRQ).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 +-
>  block/nvme.c                |  2 +-
>  util/vfio-helpers.c         | 11 +++++++++--
>  3 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 728f40922b..5c2d8ee5b3 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -28,6 +28,6 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index=
,
>  void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>                               uint64_t offset, uint64_t size);
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
> -                           Error **errp);
> +                           int irq_index, Error **errp);
> =20
>  #endif
> diff --git a/block/nvme.c b/block/nvme.c
> index 21b0770c02..a5ef571492 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -785,7 +785,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>          }
>      }
> =20
> -    ret =3D qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier, errp);
> +    ret =3D qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier, INDEX_ADMI=
N, errp);
>      if (ret) {
>          goto out;
>      }
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 5781e4f066..7a934d1a1b 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -180,13 +180,20 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int =
index, void *bar,
>   * Initialize device IRQ with @irq_type and and register an event notifi=
er.
>   */
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
> -                           Error **errp)
> +                           int irq_index, Error **errp)
>  {
>      int r;
>      struct vfio_irq_set *irq_set;
>      size_t irq_set_size;
>      struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info) };
> =20
> +    if (irq_index >=3D s->irq_count) {
> +        error_setg(errp,
> +                   "Illegal interrupt %d (device initialized for %zu in =
total)",
> +                   irq_index, s->irq_count);
> +        return -EINVAL;
> +    }
> +
>      irq_info.index =3D s->irq_type;
>      if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
>          error_setg_errno(errp, errno, "Failed to get device interrupt in=
fo");
> @@ -196,7 +203,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNot=
ifier *e,
>          error_setg(errp, "Device interrupt doesn't support eventfd");
>          return -EINVAL;
>      }
> -    s->eventfd[0] =3D event_notifier_get_fd(e);
> +    s->eventfd[irq_index] =3D event_notifier_get_fd(e);

This can't work.  For each fd in the array provided the kernel is going
to try to get that fd and configure it as an eventfd.  For each call
until we set all eventfd index {0..irq_count}, this SET_IRQS ioctl will
fail.  I would probably make that pre-configure function I referred to
earlier and create a single spurious interrupt eventfd and configure
all of the vectors to signal that one eventfd.  You could then have
this per vector callback swap the eventfd with the caller provided one
for the given vector.

NB, I don't know if you're going to run into trouble with this scheme
with the fact that devices can behave differently based on the number
of vectors they have enabled.  You're creating an interface for a
driver, so presumably that driver knows, for example, that as soon as
vector N is enabled, signaling for event foo moves from vector 0 to
vector N.  Thanks,

Alex

> =20
>      irq_set_size =3D sizeof(*irq_set) + s->irq_count * sizeof(int32_t);
>      irq_set =3D g_malloc0(irq_set_size);


