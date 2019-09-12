Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D56C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32122075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnLZlF4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32122075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Nsn-0004Ui-Ou
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i8Ns6-00042C-9j
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i8Ns5-0006wv-3P
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:06:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i8Ns4-0006ua-T7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:06:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id r195so7391251wme.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VQTQdtQ8y3+0fC6PchdJUaw8rLXynOgBJ7e8t7L9FW8=;
 b=ZnLZlF4duSAHbwloKcwrWCbLMRL/Z6p8D6TpriMBh/jN/2BGXORHDZA7zmsnkeDPf1
 YDO5FBC/zFY4vYlHg25/yKWDvtK5TOJmg6xQf1A1Vla5i4pDZ/kWMIFmdIxxxvqgcW/S
 rfbDIhAgqCBamriAJ2OKZFQbSJnUPBGgbjhvr/fcLW0ngdS94IMBP6DJV4oL/RvCeH9e
 8Pw7TBIP6lCMbzsxfVUMmCoVAzBkcLX14QtDx3+jl2mdN8rBsOFUrO1Qp5u+A7KJewEz
 RN5uBxSQk0fq9I8Aq2d9AKLmVKXDIJyoXKRaGz0mTRqT6R+QxVlVz8KsZgz+zgy6SBXw
 IdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VQTQdtQ8y3+0fC6PchdJUaw8rLXynOgBJ7e8t7L9FW8=;
 b=snpWsMA4kELGVrGapSh4o7v2QrlOt8xFKsRGVFdCLlNcT2Zzbt2/bpRyOzpQgthjyy
 b9F43CwLqimPSc+fRqXMf9LYn3cvQcOvsbSXGCw221LxKTp7L85A9CW7JUjG12LMDAt3
 IJNJIkGaIa1Dhl4CDTmgCmqkgscYnXhCVhohiZ/Gr3y/9rj20s3fne4uX6GZtYPU9itm
 T7PaypOZHwoQrLm8YMfsg1LSRF8usZRU5/Aq96dVZI2y/xbPsPre1LLtrWQIu/ZIPn5q
 ORhMpd1V4eCp8g5dcM4/6UJg0eZRok3vUsBRl8yMP8vFGNXv56pl81Eo3N+Z1AU3AwlP
 GHIA==
X-Gm-Message-State: APjAAAWgs877r6GOVRM1GjmeDj6WMqtgPKRrNsyGLjP3Imh6jqB0kHyj
 XqWvfVIOBEDETOSWO/43cH8=
X-Google-Smtp-Source: APXvYqxBTYiGqod7Ys+6TZBgx1qp6G3LZFw/i4rsVOH3FaGDGwkDCvrcN5P0ZPapCLLDpkWNL38csw==
X-Received: by 2002:a1c:d188:: with SMTP id i130mr8299960wmg.101.1568290003543; 
 Thu, 12 Sep 2019 05:06:43 -0700 (PDT)
Received: from localhost (178.165.130.7.wireless.dyn.drei.com. [178.165.130.7])
 by smtp.gmail.com with ESMTPSA id b16sm37948227wrh.5.2019.09.12.05.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 05:06:42 -0700 (PDT)
Date: Thu, 12 Sep 2019 14:06:41 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Toe Dev <devtoe82@gmail.com>
Message-ID: <20190912120641.GF23174@stefanha-x1.localdomain>
References: <CAN+O=TJAFiBEUVudnQ8cszfpo48GG9z-9FecsOtU+HU3PNisHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <CAN+O=TJAFiBEUVudnQ8cszfpo48GG9z-9FecsOtU+HU3PNisHQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] Subject: Re:  [PATCH] hw/block/nvme
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
Cc: keith.busch@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 11:23:50PM +0300, Toe Dev wrote:
> Hey,
> While reviewing I noticed maybe we need to update the spec revision.
> In: nvme_class_init(...)
>=20
> current code  pc->revision=3D2
> change to: pc->revision=3D3
> However not really important I think.. Just for consistency.
> When I done reviewing, should it be patched too, How?

The NVMe specification declares the PCI Revision ID field implementation
specific.  It doesn't seem to be a reflection of the NVMe specification
supported by the device.

If there is a PCI Vendor 0x8086 Device 0x5845 in the real world with
revision =3D 3 that we now emulate correctly, then it could be updated.

However, for live migration compatibility QEMU must keep old
guest-visible behavior too.  It's not as simple as changing the revision
value to 3, because then existing VMs migrating from an old QEMU to a
new QEMU would suddenly see the hardware change beneath them.

QEMU has the "machine types" mechanism to deal with this.  QEMU 4.2 and
later machine types (e.g. "pc-q35-4.2") would use revision =3D 3 while
older machine types would use revision =3D 2.  This maintains live
migration compatibility.

In summary, there is probably no strong reason to change this (although
I'm not an NVMe expert so maybe I've missed something).

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16NNAACgkQnKSrs4Gr
c8jTjQf7B1b134xSLOAswnhZ7AtDuVyA+HXbkYZ+bneW8Bqc8jyBp8/BIUedZYBy
toMa7ZNs6DXH35wI9sLAeHn7pFoLCxwddzzdOJpKG5595TZE2GaWaE0rd/nOifck
XSSSIuZflgyx4fM6R1igJ2IyPkOyYvNbxysFmVsRHDrPp/fPUvbfY99WctXyoOG5
ZWzBCrTeVysCA1zUeqtJhjFnpozdEsT3Ue93v3yuHWFFI+xezD4OhJFlM9pKB76v
n7bWfO8GBNl9knn2GMhf2bM0FThQcf0tD5+y487naVxa5DM+X676DkP2vnQrG1o9
b4m+WbFJh/f25mysqG0zT8gIKI+xkg==
=gxt1
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--

