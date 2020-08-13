Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A322C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1477620768
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqAiVUcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1477620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6KtR-000299-Cw
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6KoZ-0006k9-MR
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:31:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6KoV-0005GK-RS
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597354267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2YkRldmDTkJlKPcrrIcerSBCBODH4Ehdu6a7zds9C8=;
 b=KqAiVUcwG8XY2FIY1Oz2aoM1t2pLg4/CcPPF4XF6m1MKbwerv0Y9DM5wSne6HjuJ+DMXnr
 ZccGOpsHnH5i03YfDez96XdE/L9h+lc+Di8XASyy25ypJ7MdY9KXJpzqCeQHCaEr8ikBVI
 mAUfrZs76cANBEVsOj+hN8zbsnoJH+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-gc1VpL9_M6agGX44vrjc2w-1; Thu, 13 Aug 2020 17:31:00 -0400
X-MC-Unique: gc1VpL9_M6agGX44vrjc2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54B18100CF64;
 Thu, 13 Aug 2020 21:30:59 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7DE05D9E2;
 Thu, 13 Aug 2020 21:30:55 +0000 (UTC)
Date: Thu, 13 Aug 2020 15:30:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 4/7] util/vfio-helpers: Check the device allow up
 to 'irq_count' IRQs
Message-ID: <20200813153055.2fe6a225@x1.home>
In-Reply-To: <20200813172957.8289-5-philmd@redhat.com>
References: <20200813172957.8289-1-philmd@redhat.com>
 <20200813172957.8289-5-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.003
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 13 Aug 2020 19:29:54 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> As we want to use more than one single IRQ, add a check that
> the device accept our request to use multiple IRQs.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 6 ++++++
>  util/trace-events   | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index bad60076f3..b81d4c70c2 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -335,6 +335,12 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, cons=
t char *device,
>          ret =3D -errno;
>          goto fail;
>      }
> +    trace_qemu_vfio_init_pci(device_info.num_irqs);
> +    if (device_info.num_irqs < irq_count) {
> +        error_setg(errp, "Invalid device IRQ count");
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }

This is confusing the number of IRQ indexes (ie. IRQ types -
INTx/MSI/MSIx plus virtual interrupts like error reporting and device
request) with the number of sub-indexes available for a given type
again.  You actually need to look at VFIO_DEVICE_GET_IRQ_INFO for the
specified irq_type to see if it supports irq_count sub-indexes.

Maybe think of interrupts as a 2-dimensional array, we have:

INDEX   \  SUBINDEX
         \ 0 1 2 3 4 ... N
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
INTx  [0]|=20
MSI   [1]|
MSI-X [2]|
...   [M]|

VFIO_DEVICE_GET_INFO only tells us essentially the last INDEX that the
device supports.  In order to learn about the number of SUBINDEXes, or
vectors, if any, that each INDEX provides, we need to look at
VFIO_DEVICE_GET_IRQ_INFO.  When we're wanting to probe support for some
number of concurrent device interrupt vectors, we need to look at the
vfio_irq_info.count value for the desired index, ie. the extent of the
entries in the row associated with our column index type.  Thanks,

Alex

>      s->irq_type =3D irq_type;
>      s->irq_count =3D irq_count;
> =20
> diff --git a/util/trace-events b/util/trace-events
> index 0ce42822eb..2e85555be3 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -83,3 +83,4 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size,=
 int index, uint64_t iova
>  qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s=
 %p host %p size %zu iova 0x%"PRIx64
>  qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint=
64_t *iova) "s %p host %p size %zu temporary %d iova %p"
>  qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
> +qemu_vfio_init_pci(uint32_t count) "device interrupt count: %"PRIu32


