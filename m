Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5780CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D12720768
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba7b1WcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D12720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6KuR-00031M-Ah
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6Kog-0006ue-Cp
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:31:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6Koe-0005Hb-BU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597354275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KfK2suo72kdZbNjnAgvQfY9Qwd9Z9o3yGwk/wxOKehs=;
 b=Ba7b1WcKgC2IYmPz16ZTrnoV7ujiXJhp3a93OEu1we+NXwAm6yJ5E75raOn6GmZiUNQpTz
 KBqxhBGLLKWhElC4QpLrsi8IPmftBoBdMHRuOMRJSd9AxwzHNu1BqTOyQQ2jXSJ4hhBZxg
 rnLpjP7bnjm6Kb+Btzu5E/fY/NpFoRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-1x3NZxNNOti10l7oIfakoQ-1; Thu, 13 Aug 2020 17:31:13 -0400
X-MC-Unique: 1x3NZxNNOti10l7oIfakoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED05118B9EC0;
 Thu, 13 Aug 2020 21:31:12 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A5AA600C5;
 Thu, 13 Aug 2020 21:31:09 +0000 (UTC)
Date: Thu, 13 Aug 2020 15:31:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 7/7] util/vfio-helpers: Allow opening device
 requesting for multiple IRQs
Message-ID: <20200813153108.722e4788@x1.home>
In-Reply-To: <20200813172957.8289-8-philmd@redhat.com>
References: <20200813172957.8289-1-philmd@redhat.com>
 <20200813172957.8289-8-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Thu, 13 Aug 2020 19:29:57 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Now that our helper is ready for handling multiple IRQs, let
> qemu_vfio_open_pci() take an 'irq_count' argument.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

As with patch 2/ tying IRQ setup with the opening of a device seems
wrong.  Get the device open, then create an interface to configure the
interrupt.  Thanks,

Alex


>  include/qemu/vfio-helpers.h | 2 +-
>  block/nvme.c                | 5 ++++-
>  util/vfio-helpers.c         | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 5c2d8ee5b3..4773b116df 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -16,7 +16,7 @@
>  typedef struct QEMUVFIOState QEMUVFIOState;
> =20
>  QEMUVFIOState *qemu_vfio_open_pci(const char *device, int irq_type,
> -                                  Error **errp);
> +                                  unsigned irq_count, Error **errp);
>  void qemu_vfio_close(QEMUVFIOState *s);
>  int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
>                        bool temporary, uint64_t *iova_list);
> diff --git a/block/nvme.c b/block/nvme.c
> index a5ef571492..2d7aac3903 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -106,6 +106,9 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) !=3D =
0x1000);
>  #define INDEX_ADMIN     0
>  #define INDEX_IO(n)     (1 + n)
> =20
> +/* This driver shares a single MSIX IRQ for the admin and I/O queues */
> +#define MSIX_IRQ_COUNT  1
> +
>  struct BDRVNVMeState {
>      AioContext *aio_context;
>      QEMUVFIOState *vfio;
> @@ -712,7 +715,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>      }
> =20
>      s->vfio =3D qemu_vfio_open_pci(device, VFIO_PCI_MSIX_IRQ_INDEX,
> -                                 errp);
> +                                 MSIX_IRQ_COUNT, errp);
>      if (!s->vfio) {
>          ret =3D -EINVAL;
>          goto out;
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 7a934d1a1b..36fafef0d3 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -450,12 +450,12 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
>   * Open a PCI device, e.g. "0000:00:01.0".
>   */
>  QEMUVFIOState *qemu_vfio_open_pci(const char *device, int irq_type,
> -                                  Error **errp)
> +                                  unsigned irq_count, Error **errp)
>  {
>      int r;
>      QEMUVFIOState *s =3D g_new0(QEMUVFIOState, 1);
> =20
> -    r =3D qemu_vfio_init_pci(s, device, irq_type, 1, errp);
> +    r =3D qemu_vfio_init_pci(s, device, irq_type, irq_count, errp);
>      if (r) {
>          g_free(s);
>          return NULL;


