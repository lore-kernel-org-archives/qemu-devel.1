Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B652146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq3hrRt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B652146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxL1-0006Hi-LT
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihxJN-0004TC-6z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihxJL-0003vh-HL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:01:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihxJL-0003qg-AM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576767714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+c3Csgiy8XrqVIovrFnIQNfUMw744CUdjxYMx3rnCbg=;
 b=gq3hrRt4ZAf+TyFk731HwrTOTfqftL5UNOqLRgt187gUnY2y05HD8Hsk9+9Vpy+T0Z2dzc
 C1V3b0f/cGvJCxqaT6osmyNcH7a/7BCjJX0KHIhyiRgKbVnfpJWQAu5uvnS2MYz6NQz+wG
 TPapN5HxLCuwe4OO/XI7XKXh7YWgJao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-aie19yPZOw-SX_aROIVZcA-1; Thu, 19 Dec 2019 10:01:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 633D419057AA;
 Thu, 19 Dec 2019 15:01:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C2FA6E3F7;
 Thu, 19 Dec 2019 15:01:38 +0000 (UTC)
Date: Thu, 19 Dec 2019 16:01:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v2 2/2] ide: Fix incorrect handling of some PRDTs in
 ide_dma_cb()
Message-ID: <20191219150136.GL5230@linux.fritz.box>
References: <20191216181405.462292-1-alex.popov@linux.com>
 <20191216181405.462292-2-alex.popov@linux.com>
MIME-Version: 1.0
In-Reply-To: <20191216181405.462292-2-alex.popov@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: aie19yPZOw-SX_aROIVZcA-1
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.12.2019 um 19:14 hat Alexander Popov geschrieben:
> The commit a718978ed58a from July 2015 introduced the assertion which
> implies that the size of successful DMA transfers handled in ide_dma_cb()
> should be multiple of 512 (the size of a sector). But guest systems can
> initiate DMA transfers that don't fit this requirement.
>=20
> For fixing that let's check the number of bytes prepared for the transfer
> by the prepare_buf() handler. The code in ide_dma_cb() must behave
> according to the Programming Interface for Bus Master IDE Controller
> (Revision 1.0 5/16/94):
> 1. If PRDs specified a smaller size than the IDE transfer
>    size, then the Interrupt and Active bits in the Controller
>    status register are not set (Error Condition).
> 2. If the size of the physical memory regions was equal to
>    the IDE device transfer size, the Interrupt bit in the
>    Controller status register is set to 1, Active bit is set to 0.
> 3. If PRDs specified a larger size than the IDE transfer size,
>    the Interrupt and Active bits in the Controller status register
>    are both set to 1.
>=20
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  hw/ide/core.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 754ff4dc34..171831c7bd 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
>      int64_t sector_num;
>      uint64_t offset;
>      bool stay_active =3D false;
> +    int32_t prep_size =3D 0;
> =20
>      if (ret =3D=3D -EINVAL) {
>          ide_dma_error(s);
> @@ -863,13 +864,15 @@ static void ide_dma_cb(void *opaque, int ret)
>          }
>      }
> =20
> -    n =3D s->io_buffer_size >> 9;
> -    if (n > s->nsector) {
> -        /* The PRDs were longer than needed for this request. Shorten th=
em so
> -         * we don't get a negative remainder. The Active bit must remain=
 set
> -         * after the request completes. */
> +    if (s->io_buffer_size > s->nsector * 512) {
> +        /*
> +         * The PRDs were longer than needed for this request.
> +         * The Active bit must remain set after the request completes.
> +         */
>          n =3D s->nsector;
>          stay_active =3D true;
> +    } else {
> +        n =3D s->io_buffer_size >> 9;
>      }
> =20
>      sector_num =3D ide_get_sector(s);
> @@ -892,9 +895,20 @@ static void ide_dma_cb(void *opaque, int ret)
>      n =3D s->nsector;
>      s->io_buffer_index =3D 0;
>      s->io_buffer_size =3D n * 512;
> -    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < =
512) {
> -        /* The PRDs were too short. Reset the Active bit, but don't rais=
e an
> -         * interrupt. */
> +    prep_size =3D s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffe=
r_size);
> +    /* prepare_buf() must succeed and respect the limit */
> +    assert(prep_size > 0 && prep_size <=3D n * 512);

Hm, I'm not sure about prep_size > 0. Maybe it's true for
bmdma_prepare_buf() for PCI (I'm not even sure there: What happens if we
pass a PRDT with 0 entries? Should we have another test case for this?),
but other controllers like AHCI don't seem to interpret an entry with
size 0 as maximum size.

John, what do you think?

> +    /*
> +     * Now prep_size stores the number of bytes in the sglist, and
> +     * s->io_buffer_size stores the number of bytes described by the PRD=
s.
> +     */
> +
> +    if (prep_size < n * 512) {
> +        /*
> +         * The PRDs are too short for this request. Error condition!
> +         * Reset the Active bit and don't raise the interrupt.
> +         */
>          s->status =3D READY_STAT | SEEK_STAT;
>          dma_buf_commit(s, 0);
>          goto eot;

Here you decided that we don't need to do partial I/O for short PRDTs. I
think my conclusion was that the spec doesn't really say what we need to
do, so this is fine with me.

Apart from the assertion above, the patch looks good to me.

Kevin


