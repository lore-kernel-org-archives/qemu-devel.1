Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAF7C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACDB2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dny3DbVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACDB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8O38-0001jR-AN
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i8O19-0000eK-1W
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i8O17-0004Ks-Mg
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:16:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i8O17-0004K8-G4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:16:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id l16so28109349wrv.12
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hLFHB0vPNRtSuQt9lndoa2Px2QBQn/5h93HrunzTles=;
 b=dny3DbVTAVXyYWyPenJiHzK1mmNGeHE/+c1GtO/1zkrsjQNL3dTTKqw7MR5k00YHgp
 AN3ROCrhnMNjpBpn29N4nWI8cmycuK6njIwF0Du0PZ5wBjtrzk+8OimAuAB6oAoUBagB
 B2Byhzr56SDNL7L2+nIFsPyCqeI7Cy+B2y8ScvtF/m+W/3N0JyyuRUWbS/Jp8jAZ4G7H
 jKyFZlhwIryjP/UO/D7Zd3KnZrclaxvsS1md5FgmmOzTyNQOy8bX9OifmUJm44txQo/t
 xEHiIrxVYtYEKVDhYG64G/mwa0aUE4zs0Wu3wQh3LoU1j2AgMGw8e+Bxb0Cn2yIFldJz
 tNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hLFHB0vPNRtSuQt9lndoa2Px2QBQn/5h93HrunzTles=;
 b=tGH40mb6pvgycJs3HwrHX4xETbUO5pSynvq4rsv3oKZyjKszqr4//7MOCtvtk0PBGa
 XvlqYJrhWG8fGjuuz8zd9c/Acx9W+skz8VX3eyrDIc43piKnvD+0irR/vliGBLgpTN/k
 b5RiVy1IupKVrBCV9HM5TEglZ32i2qQ2hhnZHq0hEOVMsC5XZRmTtYIUxG9TMNrmk0F2
 MkKfFQQSEIa8oisgItPAAp1xqSRUISBxOP84FDYpR52QgS0uJmLEApymKeYH6i1Q6O66
 0cZxH1/Qdb5KIkfOvxOX0ad0bPJlMjjoGVg6eJV1EJJjkITLosyALlA+RfppTpFuxKRB
 RFvQ==
X-Gm-Message-State: APjAAAUyiD+ZreRfCgxrisOOahxuE7hXgmm9URfauuwYqqJz2GHhG2W1
 pVHldpAE3ilekfuf/lMET3I=
X-Google-Smtp-Source: APXvYqy0otUit7dFilrUTiu0SVVJ+ANbMHoVMjCGe1vipghw3osDDIUcXk0tlZhzlvl5XjxARIYvDA==
X-Received: by 2002:adf:f9ce:: with SMTP id w14mr11878130wrr.132.1568290564161; 
 Thu, 12 Sep 2019 05:16:04 -0700 (PDT)
Received: from localhost (178.165.130.7.wireless.dyn.drei.com. [178.165.130.7])
 by smtp.gmail.com with ESMTPSA id g73sm8636723wme.10.2019.09.12.05.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 05:16:02 -0700 (PDT)
Date: Thu, 12 Sep 2019 14:16:00 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190912121600.GG23174@stefanha-x1.localdomain>
References: <20190801004053.7021-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <20190801004053.7021-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2] docs/nvdimm: add example on persistent
 backend setup
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
Cc: pagupta@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, xiaoguangrong.eric@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2019 at 08:40:53AM +0800, Wei Yang wrote:
> Persistent backend setup requires some knowledge about nvdimm and ndctl
> tool. Some users report they may struggle to gather these knowledge and
> have difficulty to setup it properly.
>=20
> Here we provide two examples for persistent backend and gives the link
> to ndctl. By doing so, user could try it directly and do more
> investigation on persistent backend setup with ndctl.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
>=20
> ---
> v2: rephrase the doc based on Stefan Hajnoczi's suggestion
> ---
>  docs/nvdimm.txt | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Sorry, I was expecting someone else to pick this patch up.  But since
there have been no takers...

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16NwAACgkQnKSrs4Gr
c8iWfgf/YEm2+iuhE5z/CKAcz3oLesxyqqaX/jN/GDKD3slpQI+IM6eojMok4o6M
HFJ/ACauIOhdbdqAin+VxnDWtGZ2QvZUhF9H5yIKbP36UA+D1CRHQXAWKFZ8ynGz
hUUQOLhGkjNZLcI9tZcIgoE9cvIGuxjpZAOePb94oDVdnxUmXGbA+SxRyUcGTRQx
Sk6xBCDhTl7HgdIuyXsuPrQDwFMMhQAGpWkAiUdZM6FSdAT7ocEP4KR1ezFxZqyC
1CIn6atdb0ERW6Kgz1HIticDPIlFJooEJvE8SlgGEilLqVebkOSV34BK/xFE4zO1
PfAgfTY3NYNohRpg0mpB4ZPYTF7snw==
=zH0q
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--

