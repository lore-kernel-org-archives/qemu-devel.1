Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E7C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48A320732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyVsOW4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48A320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j711X-0000TS-SK
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j710Y-00080V-MI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j710W-00029W-PC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:02:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j710U-00024t-SQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582740121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+8Fj6KLqXuPf3Au4e0QGr5vSbTdDSgY5sBqllU3PRY=;
 b=ZyVsOW4c+RXWeX9ihng66XQkDUOD4TydjyjodOyOIUjHAZhALJDP5HbKhI1b/LgUitJLrN
 vETfxvOM7m7A1fbfMBvENKBlpY35sKKHeCGNM4MEU/ARu6RKz096eLqWDvfiSI7aO4dF4F
 wO2mGGUQNEg1Hu7kfsmQKa+8qMPpDCg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-gDnf-sruPjyR2zwOw2cweQ-1; Wed, 26 Feb 2020 13:01:58 -0500
X-MC-Unique: gDnf-sruPjyR2zwOw2cweQ-1
Received: by mail-qt1-f200.google.com with SMTP id c11so3208852qtv.19
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=J//p7ec8pBvmNZvIE0gq8BxamWTkgi696RXVTLV621U=;
 b=QDln7rwpZcaJ0P8MWxYtp59Nh8PAJJRa7df1ueaoDYShJVMcTNqe7B/mtFgWjuJazD
 RLMIJqXDuvulvU7nDhijpeuomnxQZ082IMMYIoAVYNLD1+ShZvKesRvav3wcKLJmxPyD
 HliU6FQF9/2aLI6jqns9C4ER0DSqiTA2H6iiXkYJ2P//A834YZBtLZSwMQRSifQ8VrzC
 wld5N+Huf8ETE/hpqq66eqDJsZbb+Se4RqCOQL8sMHKxnohzV6wCNikYWQERIRrtlHtq
 PPr2Tsfy0ZQd6ikMtursed26P8Np8EbjtPRQyY23rwF5RC0I5kHM3E27YKWLty1yZ3dg
 ZBOg==
X-Gm-Message-State: APjAAAWY3GbMr9G9qUan7ZJXUcLKd33HGTUOyDGGJI1op1IgQQnW+MYj
 4U9FR2l9h6kjGS5KnPHtPdeN1xd9ReRyh+D4fCA3yR6YkgP7R9wx1WjPnoYI2DHkhNyusmjRZYs
 BXd/QmPb0pyExvHQ=
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr272834qvb.187.1582740118422; 
 Wed, 26 Feb 2020 10:01:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYE34PPfAzlFrzG0f5aw/8Q0dGbe/tlpVkpxmZzYDjfl30vbyPoZZk6q1vnhumyEO0XiDy8A==
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr272470qvb.187.1582740113490; 
 Wed, 26 Feb 2020 10:01:53 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id u2sm1550500qtd.72.2020.02.26.10.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:01:52 -0800 (PST)
Date: Wed, 26 Feb 2020 13:01:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num()
 logic
Message-ID: <20200226180150.GF140200@xz-x1>
References: <20200226174956.17018-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226174956.17018-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 06:49:56PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Reorder the if() statement to simplify the function.
> This avoid bugs like the one fixed by commit a2e1cd41ccf.

This seems to hint that this patch fixes a problem, but it's pure
refactoring, right?

And I'm not sure about git-diff -w or so, but... I can't apply such a
patch cleanly using "git am".  Are you sure a patch like this would
work (without space change information)?

Thanks,

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6258c58ac9..e720a8939c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -987,14 +987,17 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, =
uint32_t level)
>  static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_=
num)
>  {
>      VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
> -    if (!vtd_bus) {
> +    GHashTableIter iter;
> +
> +    if (vtd_bus) {
> +        return vtd_bus;
> +    }
> +
>      /*
>       * Iterate over the registered buses to find the one which
>       * currently hold this bus number, and update the bus_num
>       * lookup table:
>       */
> -        GHashTableIter iter;
> -
>      g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
>      while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
>          if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> @@ -1002,9 +1005,8 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUS=
tate *s, uint8_t bus_num)
>              return vtd_bus;
>          }
>      }
> -        vtd_bus =3D NULL;
> -    }
> -    return vtd_bus;
> +
> +    return NULL;
>  }
> =20
>  /* Given the @iova, get relevant @slptep. @slpte_level will be the last =
level
> --=20
> 2.21.1
>=20

--=20
Peter Xu


