Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A820C7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692D421670
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJAJGF35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692D421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuPq-0008MP-Jg
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hpuPd-0007v3-EK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hpuPc-0006UB-92
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:01:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hpuPb-0006Tp-W1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:01:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so43056692wrf.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=95OTb8rTZeEmQuv8TsyVDZnyZ0+X4W/S9AoqgSsNcQI=;
 b=KJAJGF35+Xk22wR5nnsu42qkVWJGql6gZfqkTkDqZaD7XM5yhTYe1njcKxVHHReXas
 PNR7Hu+PRJ5mfOiW64Mbh4FH0CWby4BO/5FMaT6PdRCL56hP/rCSHEtEPdSsoHlgaM+Y
 tupUiapRxdeWEOpSMGF6wri5N1S0AmqsiMRkRe7Oe4o2Ihnj3kcXvU0IO1MBVAJnoflL
 w9gL0NTGe/Cu8vNExd/N5R230Htl3blFIXKPq3BOQK8qn3HObn2G+0uHeW0RJjZyMar1
 f3sw8VwD5DYUIsjlMhFdkkHLOs+7bhVNTd0Q56Tqmvx23HtVtM/IeOBbqDTTKZi2gRg4
 Q1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=95OTb8rTZeEmQuv8TsyVDZnyZ0+X4W/S9AoqgSsNcQI=;
 b=NHt2/IPZM5FNozqNqU4LWNp5FtEDLSBIWv5kJTP9UQmCQQgCjqNhH6Kbd1L8LfZGMK
 Sbr5ho5UV38XWuup4YxmrmRjhYXKObQzWCk2mfU2O2QIuQVd10UihQ81BUoaPsMH3MqT
 XXFfkjfk89EdBv4dfR8qQWaWMGkDqdOqnK09jlauQjVC/x7JHFiPICG7EiOGAKNuUQE1
 O7dWy2cSMzQ9FnW+rK4tHlooYEPKWTBB6aVKWHBWarHaYz3zqW63cbFN+Zlf0mO7OAJa
 WaYUyoTpRVMVO1MK8rNEC2EWvvrL4KBW25DGdVwweeiFxCwIuieZCqNbgrbaZYcmyCOJ
 L8DA==
X-Gm-Message-State: APjAAAWMGyhd9xgfeWyht/mHcFZyIPoyiFCfsrmF6rDmt72XLjqgmAXS
 +TlnZJ9kbA4rc1oXobboQS8=
X-Google-Smtp-Source: APXvYqwwwdLH8G9gea0UZ+IHlj/IGhQg2BwE/SXXQM4KEdfVKzUeHQwN+lMFe2QQJ7xsz2Uf8FyOTQ==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr26465299wru.339.1563886858938; 
 Tue, 23 Jul 2019 06:00:58 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t185sm36342736wma.11.2019.07.23.06.00.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 06:00:58 -0700 (PDT)
Date: Tue, 23 Jul 2019 14:00:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: P J P <ppandit@redhat.com>
Message-ID: <20190723130056.GB5445@stefanha-x1.localdomain>
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20190723104754.29324-3-ppandit@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 2/3] qemu-bridge-helper: move repeating
 code in parse_acl_file
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 04:17:53PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Move repeating error handling sequence in parse_acl_file routine
> to an 'err' label.
>=20
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  qemu-bridge-helper.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> Reviewed v3:
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg00247.ht=
ml

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl03BQgACgkQnKSrs4Gr
c8giPAf/V3oCaXj4Y+Yqw0zFb3ez6E+WspwQsU+g+5AYg2v+7HLo/p2XfRQ2BNNb
cHrcr9crwCBD1+xVplFJ2sFpxniKp8qkoma/oGtrozw44R5AP9pWK9Jyt6kIt+XV
SaWKh/QaFmmJNSMpfq9eqL1nwHSvKnHW/yQIGVuWbvd9V8Tx+g67MCpeJahxzGfx
1tSVtRWxnupalV6DpbYAkjIQxT+tMjvwhw+V4NvBVVMa04j47CB8pgciw3bxd5H5
H8apMn9ktJNXh1qcwMzP1hSQd6VbRkpONmrouxVIP04FUCld5NaAQU6MsW5UyF+r
/TN5+4FiU9RpDAuanvHl6TWwsTXMMA==
=6Dnw
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

