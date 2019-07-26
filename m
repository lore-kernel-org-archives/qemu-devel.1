Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F9C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A22218D4
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+S0bJzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A22218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzto-0005uG-M5
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqztb-0005Vy-Vs
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqztZ-0005iQ-KU
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:04:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqztT-0005Xa-6G
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:04:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id s3so47944330wms.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=N0CTKjNKza51sjyIp7lnGv+7HmTfTrmUCccrgk0AS3E=;
 b=O+S0bJzLh0DTUC+tuBxIOx1ntfgwwFZKjMxHPuK9EINX7007D8EYO/ootpe5xzGPaj
 yTcKCa/16pYslg4RQbJJkCWRwO9CtaprBdGiY14US1OB3veogsZ1EIQaSYZK3XcTj14B
 kfYY2kdwDYVppa8FrbvIA7rbET4AMQGYdGfMV3BanFqyoARHXzl28dNuOJsgK3eA5vy5
 tosEsZOLLwkNV4PhFSbwUIqhuBadFOOU2c19QDzo9cat2Kbu8AJSAaApIQOws8x2CnS8
 S6KbL78rILhyAXldqmvVLAfJZ8tuRkj0mILLulmscAXeEzlVNelQ69TCb+JWrc3V8F/c
 4TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=N0CTKjNKza51sjyIp7lnGv+7HmTfTrmUCccrgk0AS3E=;
 b=DBHnO+PQrx87MIXADYK9d5LjF984Yuzg3ZzB1qsjgRqqmt7lGmzaAh0mFSfcQuRHaK
 jhrkPEjLlv5snfM0WOqEfoFhcZCS8eB/ffnDbHy3SphcLFOWzF09S8iJLbL0QBBOsy9s
 O1HXugz8cR7k4y1mkvIQq5/CT8/9rDDYYXYPp2gBJCOwkEr1rnaFPHH5qvWmuX6reDQd
 8q3EZ9Uf+d4TNLn+RAK1OHqy3YwRYSHr6Pr2/TycbovhZnZ46ZWtoQB+rbtWxHJkNtOz
 xYZREiAsyPtthM7dDPWQhcJiB5jzFV258uNUAqENPQJ4ShdKWzEhuJDiEwXhQxGLXNFg
 8iSA==
X-Gm-Message-State: APjAAAUjb+i/exo5G0laKpDUYMLMlrqNuwJBBweQnE9i1sM4Ap4bAyVO
 +zAkmEXZPC+C13h90irloRA=
X-Google-Smtp-Source: APXvYqzSDvebbIwfkpNERzfLEvt2rajUQ9Q/PU/rWxjcNZJQF2tmMBpVnlAD4UEGWdbnc8oYuypgWQ==
X-Received: by 2002:a1c:cfc3:: with SMTP id
 f186mr80035057wmg.134.1564146256811; 
 Fri, 26 Jul 2019 06:04:16 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g19sm60119830wmg.10.2019.07.26.06.04.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 06:04:15 -0700 (PDT)
Date: Fri, 26 Jul 2019 14:04:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726130414.GG25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-10-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline
In-Reply-To: <20190725032321.12721-10-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RFC 09/19] fuzz: use mtree_info to find mapped
 addresses
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 03:23:51AM +0000, Oleinik, Alexander wrote:
> Locate mmio and port i/o addresses that are mapped to devices so we can
> limit the fuzzer to only these addresses. This should be replaced with
> a sane way of enumaring these memory regions.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  memory.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/memory.c b/memory.c
> index 5d8c9a9234..fa6cbe4f1d 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -34,6 +34,11 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/boards.h"
>  #include "migration/vmstate.h"
> +#ifdef CONFIG_FUZZ
> +#include "tests/fuzz/fuzz.h"
> +#include "tests/fuzz/qos_fuzz.h"
> +#endif
> +
> =20
>  //#define DEBUG_UNASSIGNED
> =20
> @@ -3016,12 +3021,20 @@ static void mtree_print_flatview(gpointer key, gp=
ointer value,
>      int n =3D view->nr;
>      int i;
>      AddressSpace *as;
> +#ifdef CONFIG_FUZZ
> +    bool io=3Dfalse;
> +#endif
> +
> =20
>      qemu_printf("FlatView #%d\n", fvi->counter);
>      ++fvi->counter;
> =20
>      for (i =3D 0; i < fv_address_spaces->len; ++i) {
>          as =3D g_array_index(fv_address_spaces, AddressSpace*, i);
> +#ifdef CONFIG_FUZZ
> +        if(strcmp("I/O",as->name) =3D=3D 0)
> +            io =3D true;
> +#endif
>          qemu_printf(" AS \"%s\", root: %s",
>                      as->name, memory_region_name(as->root));
>          if (as->root->alias) {
> @@ -3062,6 +3075,27 @@ static void mtree_print_flatview(gpointer key, gpo=
inter value,
>                          range->readonly ? "rom" : memory_region_type(mr),
>                          memory_region_name(mr));
>          }
> +#ifdef CONFIG_FUZZ
> +        if(strcmp("i/o", memory_region_type(mr))=3D=3D0 && strcmp("io", =
memory_region_name(mr))){
> +            fuzz_memory_region *fmr =3D g_new0(fuzz_memory_region, 1);
> +            if(!fuzz_memory_region_head)
> +            {
> +                fuzz_memory_region_head =3D fmr;
> +                fuzz_memory_region_tail =3D fmr;
> +            }
> +            fmr->io =3D io;
> +            fmr->start =3D int128_get64(range->addr.start);
> +            fmr->length =3D MR_SIZE(range->addr.size);
> +            fmr->next =3D fuzz_memory_region_head;
> +            fuzz_memory_region_tail->next =3D fmr;
> +            fuzz_memory_region_tail =3D fmr;
> +            if(io =3D=3D true){
> +                total_io_mem +=3D MR_SIZE(range->addr.size)+1;
> +            } else {
> +                total_ram_mem +=3D MR_SIZE(range->addr.size)+1;
> +            }
> +        }
> +#endif

Why is this patch modifying a print function?  I think the goal is to
build the fuzz_memory_region list and calculate
total_io_mem/total_ram_mem.  This should be done by a separate function.

Can you use memory_region_is_ram() instead of the string compares?

Stefan

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl06+k4ACgkQnKSrs4Gr
c8iaJAgAhxAHw2esg4sjB6CZoGlaTMmiCHe4vdw44HXUNuFsrgQUfbBHfgqnOIPO
BIPJWh85npVTpGn4SaYsoWecybIFwzUt6DQtq3OKi6mTKTpQeNVlqr8aFOOcTbL8
PraMavegcwg5qVd3mi9eLa0i/FpvCHOS1YaTR7BFoZYmPeRVzeF320WecopS9ScG
IsdJb07G/HVLqUfNTzS2JUiORUq5+lGiGX5Xb/SLuvRES4de11qIzACDl600g94n
6aG1giZVPaxLuZX1eygQoCupiPjzMU2Guxr4cLy3a/+zh0HPDYfP9nwHk3BoVSKt
Zg6M4Yvepwt8h4hJdJOpDS+5EwwpMA==
=SKw9
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--

