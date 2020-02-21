Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF6EC35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA4A20722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+q+v9FY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA4A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j53qj-0007DG-I5
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j53pu-00063Y-Rr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j53pt-0006Um-L1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:39:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j53pt-0006TG-GS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582274341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jKPj3gf+T3ocOqgvJULo7PhApveqgiAwsnEtaSBAEQ=;
 b=e+q+v9FYiHBMDN9wgzsZpOa3UtSZDBM7LtPy2K5kxuriFeAtmhR+4jVNDL2IiJKwlHHtQ0
 juP26Iv2eaV1qRklmE6iso7BC2xBdSH2AF/k+zKM6fu0mHrzx22ATRtpzsZamfHr+7WBx1
 IT7YpkSlrN015YEQfOhKWkNmvG4O2zY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-icepWPbFPbqSoFkIU1jjaA-1; Fri, 21 Feb 2020 03:38:59 -0500
X-MC-Unique: icepWPbFPbqSoFkIU1jjaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7A62800D50;
 Fri, 21 Feb 2020 08:38:55 +0000 (UTC)
Received: from gondolin (ovpn-117-64.ams2.redhat.com [10.36.117.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE7D75D9E2;
 Fri, 21 Feb 2020 08:38:33 +0000 (UTC)
Date: Fri, 21 Feb 2020 09:38:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3 08/20] Remove unnecessary cast when using the
 address_space API
Message-ID: <20200221093830.63bc308e.cohuck@redhat.com>
In-Reply-To: <20200220130548.29974-9-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-9-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 14:05:36 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> This commit was produced with the included Coccinelle script
> scripts/coccinelle/exec_rw_const.
>=20
> Two lines in hw/net/dp8393x.c that Coccinelle produced that
> were over 80 characters were re-wrapped by hand.
>=20
> Suggested-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  scripts/coccinelle/exec_rw_const.cocci | 15 +++++++++++++-
>  target/i386/hvf/vmx.h                  |  2 +-
>  hw/arm/boot.c                          |  6 ++----
>  hw/dma/rc4030.c                        |  4 ++--
>  hw/dma/xlnx-zdma.c                     |  2 +-
>  hw/net/cadence_gem.c                   | 21 +++++++++----------
>  hw/net/dp8393x.c                       | 28 +++++++++++++-------------
>  hw/s390x/css.c                         |  4 ++--
>  qtest.c                                | 12 +++++------
>  target/i386/hvf/x86_mmu.c              |  2 +-
>  target/i386/whpx-all.c                 |  2 +-
>  target/s390x/mmu_helper.c              |  2 +-
>  12 files changed, 54 insertions(+), 46 deletions(-)
>=20

> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 844caab408..f27f8c45a5 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -875,7 +875,7 @@ static inline int ida_read_next_idaw(CcwDataStream *c=
ds)
>              return -EINVAL; /* channel program check */
>          }
>          ret =3D address_space_rw(&address_space_memory, idaw_addr,
> -                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fm=
t2,
> +                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt2,
>                                 sizeof(idaw.fmt2), false);
>          cds->cda =3D be64_to_cpu(idaw.fmt2);
>      } else {
> @@ -884,7 +884,7 @@ static inline int ida_read_next_idaw(CcwDataStream *c=
ds)
>              return -EINVAL; /* channel program check */
>          }
>          ret =3D address_space_rw(&address_space_memory, idaw_addr,
> -                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fm=
t1,
> +                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt1,
>                                 sizeof(idaw.fmt1), false);
>          cds->cda =3D be64_to_cpu(idaw.fmt1);
>          if (cds->cda & 0x80000000) {

> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index c9f3f34750..0be2f300bb 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -106,7 +106,7 @@ static inline bool read_table_entry(CPUS390XState *en=
v, hwaddr gaddr,
>       * We treat them as absolute addresses and don't wrap them.
>       */
>      if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIE=
D,
> -                                    (uint8_t *)entry, sizeof(*entry)) !=
=3D
> +                                    entry, sizeof(*entry)) !=3D
>                   MEMTX_OK)) {
>          return false;
>      }

s390 parts
Acked-by: Cornelia Huck <cohuck@redhat.com>


