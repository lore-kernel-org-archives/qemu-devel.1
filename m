Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA240206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZ8bA2YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA240206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Kqv-00006h-6k
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6KoJ-0006Ny-W4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:30:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50891
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6KoG-0005Du-Qe
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597354251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjIojqQI3BXkByMl6qwFKXnS00UC6pgVoE7kXrD08Sk=;
 b=XZ8bA2YLylqJuoej/XbutlaO6drLvf9b2eDII8jAbpLxtRlw0SL4pyPQAkKYyJ8Om95fsy
 JrsKdB4YPld04ladlLa8ytOPFlc6o7Eg8nQBTSnhvchXryBykVXyjJhxq0ZpkfkdxhFFCP
 ArTLL/10pf41eSzIFEBvQjf5WFAWN5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-xcg1hBlSOJChBtYbDA5KYw-1; Thu, 13 Aug 2020 17:30:49 -0400
X-MC-Unique: xcg1hBlSOJChBtYbDA5KYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 654FD1DDE0;
 Thu, 13 Aug 2020 21:30:48 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F47719746;
 Thu, 13 Aug 2020 21:30:44 +0000 (UTC)
Date: Thu, 13 Aug 2020 15:30:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 2/7] util/vfio-helpers: Move IRQ 'type' from
 pci_init_irq() to open_pci()
Message-ID: <20200813153043.6d0b057b@x1.home>
In-Reply-To: <20200813172957.8289-3-philmd@redhat.com>
References: <20200813172957.8289-1-philmd@redhat.com>
 <20200813172957.8289-3-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:30:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 13 Aug 2020 19:29:52 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Once opened, we will used the same IRQ type for all our event
> notifiers, so pass the argument when we open the PCI device,
> store the IRQ type in the driver state, and directly use the
> value saved in the state each time we call qemu_vfio_pci_init_irq.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

This feels quite a bit strange to me, a PCI device can operate in one
of several interrupt modes, or without interrupts at all.  Why would we
force a user of this interface to define the interrupt type they'll use
in advance and then not even verify if the device supports that type?
A driver might want to fall back to a different interrupt type if the
one they want is not supported.  If we want to abstract this from the
driver then we should at least have an interface separate from the
initial open function that tells us to preconfigure some specified
number of vectors.  We could then have a preference policy that would
attempt to use MSI-X, followed by MSI, followed by INTx (assuming
request is for a single vector), based on what the device supports.
Then a driver could fallback to fewer interrupts if the device does not
support, or the host system cannot provide, the desired number of
interrupts.  Thanks,

Alex


>  include/qemu/vfio-helpers.h |  5 +++--
>  block/nvme.c                |  6 +++---
>  util/vfio-helpers.c         | 13 +++++++++----
>  3 files changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 1f057c2b9e..728f40922b 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -15,7 +15,8 @@
> =20
>  typedef struct QEMUVFIOState QEMUVFIOState;
> =20
> -QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
> +QEMUVFIOState *qemu_vfio_open_pci(const char *device, int irq_type,
> +                                  Error **errp);
>  void qemu_vfio_close(QEMUVFIOState *s);
>  int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
>                        bool temporary, uint64_t *iova_list);
> @@ -27,6 +28,6 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index=
,
>  void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>                               uint64_t offset, uint64_t size);
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
> -                           int irq_type, Error **errp);
> +                           Error **errp);
> =20
>  #endif
> diff --git a/block/nvme.c b/block/nvme.c
> index a61e86a83e..21b0770c02 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -711,7 +711,8 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>          return ret;
>      }
> =20
> -    s->vfio =3D qemu_vfio_open_pci(device, errp);
> +    s->vfio =3D qemu_vfio_open_pci(device, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                 errp);
>      if (!s->vfio) {
>          ret =3D -EINVAL;
>          goto out;
> @@ -784,8 +785,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>          }
>      }
> =20
> -    ret =3D qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
> -                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
> +    ret =3D qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier, errp);
>      if (ret) {
>          goto out;
>      }
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 9cb9b553a5..f1196e43dc 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -43,6 +43,8 @@ typedef struct {
>  struct QEMUVFIOState {
>      QemuMutex lock;
> =20
> +    int irq_type; /* vfio index */
> +
>      /* These fields are protected by BQL */
>      int container;
>      int group;
> @@ -176,14 +178,14 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int =
index, void *bar,
>   * Initialize device IRQ with @irq_type and and register an event notifi=
er.
>   */
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
> -                           int irq_type, Error **errp)
> +                           Error **errp)
>  {
>      int r;
>      struct vfio_irq_set *irq_set;
>      size_t irq_set_size;
>      struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info) };
> =20
> -    irq_info.index =3D irq_type;
> +    irq_info.index =3D s->irq_type;
>      if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
>          error_setg_errno(errp, errno, "Failed to get device interrupt in=
fo");
>          return -errno;
> @@ -237,6 +239,7 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *=
s, void *buf, int size, int
>  }
> =20
>  static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
> +                              int irq_type,
>                                Error **errp)
>  {
>      int ret;
> @@ -331,6 +334,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const=
 char *device,
>          ret =3D -errno;
>          goto fail;
>      }
> +    s->irq_type =3D irq_type;
> =20
>      if (device_info.num_regions < VFIO_PCI_CONFIG_REGION_INDEX) {
>          error_setg(errp, "Invalid device regions");
> @@ -423,12 +427,13 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
>  /**
>   * Open a PCI device, e.g. "0000:00:01.0".
>   */
> -QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
> +QEMUVFIOState *qemu_vfio_open_pci(const char *device, int irq_type,
> +                                  Error **errp)
>  {
>      int r;
>      QEMUVFIOState *s =3D g_new0(QEMUVFIOState, 1);
> =20
> -    r =3D qemu_vfio_init_pci(s, device, errp);
> +    r =3D qemu_vfio_init_pci(s, device, irq_type, errp);
>      if (r) {
>          g_free(s);
>          return NULL;


