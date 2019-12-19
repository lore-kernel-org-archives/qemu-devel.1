Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1F6206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWmbm4UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1F6206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihybL-0001lZ-Sb
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihyaQ-0000vX-KM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihyaP-0003wP-Ch
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:23:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihyaN-0003uE-Lz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:23:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id b19so6045801wmj.4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+W2Sd6h1wLGm45rnCGSKMSf419Kj8BT6ZgXLYhnkCuY=;
 b=NWmbm4UK2DJKBgZVYFjRrCG3byI8QcCT7d1Mhtdzg591+0xRyzxhaHThmb3LwrVd+t
 ykFNI0prdN2UFdFvrX6QWH8FmGYhR78OqjAQjWAJ+kolmsxN5szaCX5g8VMr8tj2rFRW
 9I5cIMRJpyc4t2kQeCrjRh6YMkx1P6nNvzVsawBBV78jOHf3xyMqFtvWss9DryWhs+gc
 seMKE6wCPt/Y3d+DbGPEweq2p+66FYnlzCRPLjdljGgacCZJneA11kjNAJxadbZQ6W0P
 X8ZUVrvrv2kMsdcYeakDOO3EGe8MPNGP4mwvzZYPGQLEn4jH4mJS9Go+GNsDmxsRXxX4
 345Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+W2Sd6h1wLGm45rnCGSKMSf419Kj8BT6ZgXLYhnkCuY=;
 b=CoxYYu3MEyIs7HTQBOlfjOvL9cMRpNDebg0rf+wtGL+NjXoQ8kV8Bh9NSBrzTHV/Cf
 fq6Op5BuwSohY0MwoptP6w/7tyMQc7DmsOe/v1R9t990egsg0B11mAir1T8dJzBkjt3n
 aw0nPG0t6sgnofAufC+Xexr/ku2S0oXykIcDyLEtYFML/kRzzzqpacpHxM+ZHj42GlH3
 gcHnnU65abqNNcgw28H++evpJJJTy1aHNaPY/OKNWdJVZZ4O+XcTOD44nRJjc+2ImCIf
 vWAayxLx98aHQBy6iXXG8Bw2AUjazmHGEvXY3dS/sJwROYZRZ52czVrFMv/SIFv7jghT
 ULZw==
X-Gm-Message-State: APjAAAXTd7VXUiMVPtFBoL9b5QtnAWNEC2gjdGGAMcNGhSPCkFkQIQq0
 KtEOTaouIR4tS6oSayH5v5o=
X-Google-Smtp-Source: APXvYqwG1+htmescADVXn4KSzrnbXoMbxoOgPJpC2u+4Q2Uf9N1bWH88QXB8LxKnKbWW9Gyp2PltMA==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr11121305wmd.80.1576772614670; 
 Thu, 19 Dec 2019 08:23:34 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c5sm6691164wmb.9.2019.12.19.08.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:23:33 -0800 (PST)
Date: Thu, 19 Dec 2019 16:23:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/2] virtio: make seg_max virtqueue size dependent
Message-ID: <20191219162332.GK1624084@stefanha-x1.localdomain>
References: <20191216100451.28060-1-dplotnikov@virtuozzo.com>
 <20191216060349-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDymnuGqqhW10CwH"
Content-Disposition: inline
In-Reply-To: <20191216060349-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 06:04:21AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 16, 2019 at 01:04:49PM +0300, Denis Plotnikov wrote:
> > v4:
> >   * rebased on 4.2 [MST]
>=20
>=20
> Looks good. Can I get some acks from storage guys pls?

Looks good to me.

Stefan

--qDymnuGqqhW10CwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37pAMACgkQnKSrs4Gr
c8i3HggAlBP72bL1oP8Nj4b/mq1hcWIzurdRqD8pIjZIkjIyIqvhnvGTPYpuXbe/
IFcdHYf1b68cvRS6LM7gNm8NamRi9VE4ilsEhDZYVSc5RWSKJVM8iblzQWbV1cOR
NAhMmQSCUwc2i+ijRLo5YnclASral91N8S0xvkTbtObDHAIdGiOcHEqQR/U3r1Ao
KFlAjfd9fjUrjt16GbsY5JOZ71mv+TGLZpuO4ya8JHZhi/XYTfDRooMYW467E8B9
Lc3UZEOczpxV8wlXnkvLLVBJ/W71bf2X1SkgPFq6/QxmUbq+oQBzsxJcu9O0WHVA
f5+6ILoxWyhcMYDC+Rk+MRSuP3UzqQ==
=wD0L
-----END PGP SIGNATURE-----

--qDymnuGqqhW10CwH--

