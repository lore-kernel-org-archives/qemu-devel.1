Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC10C4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C7A2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CW+1sIEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C7A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j73CP-0004ri-0U
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 15:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j73B1-0003kp-Bd
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j73B0-000580-A3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:21:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j73B0-00054g-5q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582748461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucajfixNPAZHitKtwg3MvaodwjJFnax0QB5I1m2QMVY=;
 b=CW+1sIEGXRCvmJEM2fwUgxcDuKOl+eewNC/2PKGX4lXBZrsIbUE+z84Z98Y78FYIJCyABY
 1QAjCeu5UQPEwxBkouEF07jIj8qQrpBs48/IHd4DQn9nSPV15mT8XzvO15ywyoGBQk5K1l
 CI3gIQvwubxj9PsDgdlOvB5a3CgXV2c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-jgUNknPTPkSpQ7Oy9W5LGQ-1; Wed, 26 Feb 2020 15:20:57 -0500
X-MC-Unique: jgUNknPTPkSpQ7Oy9W5LGQ-1
Received: by mail-qk1-f200.google.com with SMTP id d2so723965qko.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 12:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yzwLbxoVf1qt7EqxO7WDwE95pIYCWjl3zAKr5js9Lo0=;
 b=tLKVCVfDs2HOCN0cnqdoDhNmjSTvK/33D1vivZgv4BdQvyOV+yfCUcAkywUAv5ojpJ
 KEqLQa2kBKNDR26NQOXH1OPN9yBRYZQcymHwGa7ahIBMS9zX3bPKS9Ckvl+sK0B//xnY
 x84j67HbUToIZ29wtzxINDjhBGnCUkPd+T5mxnadXpGGxMKZLHshH5xfdOA9vbYiqfQY
 9IIsAdS25S6f/jbLjTkO3q/F3ljL1thZORmkOw6KoepZvICXev6Zuhe2aQuj9joJnloA
 pgKYwolRQQ7kWF1oLLj+4teTLPm+VidkPpMfX6D1eDwLyAOIhBPGi5/1norB0rhNuKBG
 e2Vg==
X-Gm-Message-State: APjAAAUIW7Nax0bQ04ZYMtRlHnHI1BXEil3y8g20XpK+ICJj65Thfl4k
 WDu/81HrXxpX6tes479Gq62j4K20/kX2O1Iwahj/Nca4YD0wYTkQKdFie4Df2flylTYBa58IUVy
 jSqtQ3l+440iv9vg=
X-Received: by 2002:a05:620a:1f1:: with SMTP id
 x17mr1073090qkn.302.1582748457227; 
 Wed, 26 Feb 2020 12:20:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/DD8IA9fAd8RJRh1YdJxGIyGDxFGS43zTaVutKMQkYnhppZV7xvC19bG+Rpo+oV6ix71giA==
X-Received: by 2002:a05:620a:1f1:: with SMTP id
 x17mr1073044qkn.302.1582748456928; 
 Wed, 26 Feb 2020 12:20:56 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id 133sm1762022qkh.109.2020.02.26.12.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 12:20:56 -0800 (PST)
Date: Wed, 26 Feb 2020 15:20:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] hw/i386/intel_iommu: Simplify
 vtd_find_as_from_bus_num() logic
Message-ID: <20200226202054.GA180973@xz-x1>
References: <20200226201030.22583-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226201030.22583-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Wed, Feb 26, 2020 at 09:10:30PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> The vtd_find_as_from_bus_num() function was introduced (in commit
> dbaabb25f) in a code format that could return an incorrect pointer,
> which was later fixed by commit a2e1cd41ccf.
> We could have avoid this by writing the if() statement differently.
> Do it now, in case this function is re-used. The code is easier to
> review (harder to miss bugs).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Since v2: Re-worded commit description, patch sent without -w.
>=20
> This patch is easier to review with 'git-diff -w' (--ignore-all-space):
>=20
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

(However we'll need to read below after all... :)

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


