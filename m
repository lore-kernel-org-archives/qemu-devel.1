Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68225C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E728020578
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e54+zFfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E728020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6Be-0003XE-Rk
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hs6B5-0002wl-TX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hs6B4-0000gC-P7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:59:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hs6B4-0000fc-Hz
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:59:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id h19so43095199wme.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pJYsOjM1Rz8kP+YK41Ovyk0Du29eAyTUKYGbhHoeQso=;
 b=e54+zFfR+LYVHdENSX5Jp0C6E7h6je7J5O+58MM6WgmW8VCxZFqd6IF9QXr+2tqkK/
 T5ibq1e45UF5qViZKmP8pHe0NfE1qjwdUCVvEbZ6lShZoA5KoYbWTsyKYik/3hMU11h7
 HoC5/wz+J4ycHeQcPJTuZtiR6zFxNWJnx5KthCSTpUMBc8zKE6r4AcEUOGB7IYTMVXRq
 0ZIa98WNUg7H6D2X1QyVVHyDST57yPeNsxogwV8uDSWthqIx4uuLAOAEgDLR2g8DSjch
 0bxKQGQJtCcV7blYhZ+oS5JVfODRlt2Cc18a0JKfUCv9os6OaGvFQRQI0gyAsUS978+s
 HcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pJYsOjM1Rz8kP+YK41Ovyk0Du29eAyTUKYGbhHoeQso=;
 b=c77y4j7oFZm6Oun3l9AINHyouL464yNZBzS4XpMUzGh+4S5nikRza/NqHBX6LYNsJ4
 Z78WexQMBaEO2MivrGEbqKg9trsBSCFBqUgAgEzT0ULxIi8PV0DFC8iw58yPWN3lo+tt
 xAVvJlAOYZa/PzglbwkBHIIQqRsH7Oh8wanvlZfrXXLvy1z5gWL6yrSObdw0mLg2R9zX
 nZdoscUuDd/9is72mVuqI1JyM+40AG8ACdC1RLa069B5jXHP+ndYzsYe2VVsF0PQamjZ
 5OXQY+Xtcpb1su7SSRTWz+XnXXiFrRS4eN8+aj/dq2bivUSSLJqmAgLj0tfUDSvqcVaG
 BtbQ==
X-Gm-Message-State: APjAAAVw3qmuZTYjBwCfJigTmLPysFp7qED3E7F0dV0+OEDKq/hiLVf5
 DyUMPkD5JfGKLUHijg28r1A=
X-Google-Smtp-Source: APXvYqxRMx59rOHV2mFkfrYPQyaQvsbnWSJfxBKkvs5QFCla9xVAgqMsQjkbwHVRwGk7kW0uMYkVlg==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr26769106wmk.55.1564408741403; 
 Mon, 29 Jul 2019 06:59:01 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f2sm57125722wrq.48.2019.07.29.06.59.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 06:59:00 -0700 (PDT)
Date: Mon, 29 Jul 2019 14:58:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190729135859.GD6771@stefanha-x1.localdomain>
References: <20190724070307.12568-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <20190724070307.12568-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] docs/nvdimm: add example on persistent
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
Cc: ross.zwisler@linux.intel.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiaoguangrong.eric@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 03:03:07PM +0800, Wei Yang wrote:
> Persistent backend setup requires some knowledge about nvdimm and ndctl
> tool. Some users report they may struggle to gather these knowledge and
> have difficulty to setup it properly.
>=20
> Here we provide two examples for persistent backend and gives the link
> to ndctl. By doing so, user could try it directly and do more
> investigation on persistent backend setup with ndctl.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  docs/nvdimm.txt | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index b531cacd35..baba7a940d 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -171,6 +171,32 @@ guest software that this vNVDIMM device contains a r=
egion that cannot
>  accept persistent writes. In result, for example, the guest Linux
>  NVDIMM driver, marks such vNVDIMM device as read-only.
> =20
> +Backend File Setup Example
> +..........................

For consistency with the rest of the document please use '-' instead of
'.'.

> +
> +Here is two examples for how to setup these persistent backend on
> +linux, which leverages the tool ndctl [3].

Small grammar tweaks:

  Here are two examples showing how to set up persistent backends on
  Linux using the tool ndctl [3].

> +
> +It is easy to setup DAX device backend file.

Please move this into the "A. DAX device" section and use it as an
introduction to explain what this section is about:

  Use the following command to set up /dev/dax0.0 so that the entirety
  of namespace0.0 can be exposed as an emulated NVDIMM to the guest:

> +
> +A. DAX device
> +
> +    ndctl create-namespace -f -e namespace0.0 -m devdax
> +
> +The /dev/dax0.0 could be used directly in "mem-path" option.
> +
> +For DAX file, it is more than creating the proper namespace. The
> +block device should be partitioned and mounted (with dax option).

Please move this into "B. DAX file":

  Individual files on a DAX host file system can be exposed as emulated
  NVDIMMS.  First an fsdax block device is created, partitioned, and
  then mounted with the "dax" mount option:

> +
> +B. DAX file
> +
> +    ndctl create-namespace -f -e namespace0.0 -m fsdax
> +    (partition /dev/pmem0 with name pmem0p1)
> +    mount -o dax /dev/pmem0p1 /mnt
> +    (dd a file with proper size in /mnt)

"dd a file" could be "create or copy a disk image file with qemu-img(1),
cp(1), or dd(1) in /mnt".

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0++6MACgkQnKSrs4Gr
c8jLTwf/cB3r7hIDG5h9dnq6QtV5u4fh80LVFUK9ZP0dL8/+Ev5ZLyF9qNbGNDQH
wmyy62ydpEgudre/8yT+EzI/KfD422gJn1XVDDH5qt4gJwhtefpFPLio54EuZIwt
hLKZ6c52zZbiir+xis1nksvaAREBjBgAp7IYvXwk6tQT3B2mi048d3Xha8haijfX
w4jARjc9cIi5/r6ZH+B3R+k8ZQIL/subptL3WvKBQfuh7rb9SMhOFwFh2Pfx1noB
xiYvP7y7InjQKNxeEK1di7d3k4l3vUFTtHBo0TXieZ058iJfcfMqmv/5ygB5inik
tcufDJT8IaraIldzumaSKlkT0+VkBA==
=Dkz7
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--

