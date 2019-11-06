Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA9C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159F72166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIdKq11R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159F72166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNDJ-0003eS-9M
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSNCZ-0002uh-E3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSNCY-0001Ub-B3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:26:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSNCY-0001Ta-4L
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:26:30 -0500
Received: by mail-wm1-x343.google.com with SMTP id f3so3812991wmc.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TfUs6/qY6ssmyn9HRVNQybzNSomwA/ZMZsEcY5N2wSQ=;
 b=EIdKq11R/SC1v3gBMkqKsu+9ZQfnMj7uBw/4UwjRQGcVG89xYIYuAEPmybl465UisW
 RNg28w10zJ0SEI+8T621Y2zjBiBWdz4+T/zaZ9itkPkH/pAV2grXyPvW9l1Oxv2EyI/4
 7dNmg9CI4cDGOtOKurMKxPhGMECAuJj9VwwpqmAVb0S2bf7mGPH7le4Bb/EvQSq3/V4w
 SrdITX7QCDJCamV1E3D8Lrmphf0pU2lScd+6DXac99pjz+0Q5tkLGrROuv9mo6cT/pjl
 cp1BxjPOBT5Jqvg4aOrx1bHHtwBXUwZkXbJXnh548SJTLB6LS8RyBhoYWLaT+PbvTbBL
 wsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TfUs6/qY6ssmyn9HRVNQybzNSomwA/ZMZsEcY5N2wSQ=;
 b=R1PqskelAseyyf2xjMo6C1Xn+j4uCc2qmIjZkuCKLsa468WlRl+jl4IgLtsNkbIW/K
 VSuCCNQ01P5bff9pc6KNLBwpNP9Yttg+2IC3OeZbWVusDKol0sKcWZaREiNBUrj9JbMu
 5pKhFdhR7SgK8WNMGDwuumW+Do4u0PE7lGmO4YdZjT3sXVyU0RsZlxBa1m27e8gBS54h
 p5ULeVVcZn6+pvbVbnRfDJZ7Baru3T8ZCfBAd9FefzVg2O3hTdaNqdSxkH9DXOYfW6B5
 fUW548wmOFWM4STlt7DBVUNIZNZ5kNbitpRfGyL1DkvvcfoMq0Ig2JRpJ7FdFcvMMdX1
 J2SQ==
X-Gm-Message-State: APjAAAXZckUGdeqyCunC1NVRZshNceYMlqbXcaB+vjvctq8Vd1T7Xt0D
 RDyv8QQB8bU5ERmdonMxOEY=
X-Google-Smtp-Source: APXvYqzSBxeUhpk+TjvMuWudB6hbQbInrn0eYb8G2Xz8HVf4r7/UQqUXBXqrI/4pUPtWRx5Rc98Rsg==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr3192713wmc.164.1573053988579; 
 Wed, 06 Nov 2019 07:26:28 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id z14sm12737222wrl.60.2019.11.06.07.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 07:26:27 -0800 (PST)
Date: Wed, 6 Nov 2019 16:26:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 06/20] module: check module wasn't already initialized
Message-ID: <20191106152626.GE340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-7-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-7-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:52PM +0000, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>=20
> The virtual-device fuzzer must initialize QOM, prior to running
> vl:qemu_init, so that it can use the qos_graph to identify the arguments
> required to initialize a guest for libqos-assisted fuzzing. This change
> prevents errors when vl:qemu_init tries to (re)initialize the previously
> initialized QOM module.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  util/module.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C5iIACgkQnKSrs4Gr
c8gsHgf9E1wtW8/ldmT1VNE5uHrzzv7V1qTjevjd8yWOb2//aVT78YvPKIe3rNFI
8xPHDVKrKqTi0ooUSLLSJlu5fKb5Sg/xH2/A7+FbmH/E8aP9CA2sNGogWGrEfJl9
pAxkYqm7hT1fU9xokz+ii7dg+nV9BYUj7CQSqIwVSu88K+tEVJHBT6NO/zC/jMMM
WHjdUH5QYVkr4RM0IzHNSDxDs46+Q2R0CLe+EQg5RHmNracFN1TUhCTzobWqZb+P
wFA7WDu4sEVdrBYSY4NgiSATEQVP9voKrl8ZZHLxov72GeoTn536E7yMkM2tn0kS
sTkaLVVJiQltM98mYf77e9E+Vhdx7g==
=y9Jy
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--

