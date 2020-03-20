Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5FBC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5F32072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRKRFu/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJSR-0004Qz-68
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jFJRk-0003tJ-AO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jFJRj-0005cc-Bp
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:20:28 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jFJRj-0005ac-2o; Fri, 20 Mar 2020 11:20:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id d198so1193713wmd.0;
 Fri, 20 Mar 2020 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UjdZKPXiUWUEicE+z/OuFQfCMXvdDVk6kxJN6ZvZQ9Y=;
 b=IRKRFu/9RrqQV003gJUzvQXwwgkVX+N4mtby/veWgZxdnoK/4fMZqm57gAc67PcAUh
 17oDETCxLOvH7BvbF82cPah9gavkPE+fMmRaqHZtbWwjlH7Nl4te2IF971jbX+wyA5ef
 PKYwootRF4CgifOAjEGYBCeiTjplRyoUmpj7oB8jcjEYeZNtHlM2C1G59kvgBFhNIZfZ
 WEchns5rayYCC3AHdVLg1DUeP243Ri/UjNxA0Hs5vJCsFw+cWnumTxFnGL9JYy/xVJLI
 rQVPOx0WvYYD33FIrF0kCE6Qibe37CgzRSWa72EDmL4XZUDEPo9UIhiKFPyk/4TLplGy
 eA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UjdZKPXiUWUEicE+z/OuFQfCMXvdDVk6kxJN6ZvZQ9Y=;
 b=gF9XTrhuAenDjvX3p0gM+tnoN/pHe0oZ6mneYG/ve5Dqg9cCGHqTb/4sZln8bks4yX
 mNq8+lh3nCItCytHt0Q6F0cEw+JtBC4LjzxgF8kTSVLcPqKRYNvSwLhBs3AB+or+Rt+Z
 lJ0+/5aMjnokRbUepilQFgjT5+Oy1qvCi0YN8+mEL1dO17mJSTJwTW/VNpOWPFsqkltO
 4Rk2JBdvDSjTx+aY4ySOoKA92BH2JFczwJTDdXpe10L2TlYlinBwEdhVCuLvAie63OJJ
 NdDokDEoLNKHkCDSI5J5jxrwXKZjufx15bISBo/fV+k4op2uGMktrSdRwEP3Zpwq2n+f
 gMpQ==
X-Gm-Message-State: ANhLgQ14RXeZOHABlt0Oo4+ipRZmDw0m1MwMe5WoyfVQcpHBsVoY6mpB
 7U7VXRiKr3SWl/rzrH8eAWw=
X-Google-Smtp-Source: ADFU+vt1p90o3dOblFxxY3aEFSPwOpJZRgZAjvY6AaRiMeNeIaCwNuOBbeYukMc7jzdeNUSgODrang==
X-Received: by 2002:a05:600c:2947:: with SMTP id
 n7mr11367154wmd.13.1584717624963; 
 Fri, 20 Mar 2020 08:20:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q13sm8610120wrs.91.2020.03.20.08.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 08:20:24 -0700 (PDT)
Date: Fri, 20 Mar 2020 15:20:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/rdma/vmw/pvrdma_dev_ring: Replace strncpy with pstrcpy
Message-ID: <20200320152022.GC138042@stefanha-x1.localdomain>
References: <20200318134849.237011-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20200318134849.237011-1-jusual@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 02:48:49PM +0100, Julia Suvorova wrote:
> ring->name is defined as 'char name[MAX_RING_NAME_SZ]'. Replace untruncat=
ed
> strncpy with QEMU function.
> This case prevented QEMU from compiling with --enable-sanitizers.
>=20
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/rdma/vmw/pvrdma_dev_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is my equivalent patch
<20200316160702.478964-3-stefanha@redhat.com> but feel free to merge
this.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl503zYACgkQnKSrs4Gr
c8jheQf9HA1iCTM/WkiNOjSVOp8hXbM26YCCYKH1uetfSd5qSDmFs8iHPNRESuMN
56Jdi5mI7oeJYtj/1niU9OFZrhgbdfQQkiU4gzwdqQw/N21e6cQTD+VlYsHD4PRs
ZgpJprNPxbu9RM82L4NAJLZq/uQGER/n59flQndWBJS68cpBx+R7nR0p3inpH7QR
STBQ0GKvf8rRqEwsVztUsCE809SsLSix6+OV42OylomvtO9CsR4s5ugPMNwefhl3
WuF5b4Lc5kSZhC0BasCLribZnhLWtoEC/BxIMmzhy30s0WcBzAMPgGBmPtsY7m/M
v/ZhACAqo4gdiqkbY/QqbdY+8dhWSA==
=Of2S
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

