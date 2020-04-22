Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BEC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C5D2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FncwCgLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C5D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRINm-0008MV-Pi
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRIN0-0007k1-NX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRIN0-0005Xt-43
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:37:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRIMz-0005TD-Nb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:37:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id t63so3122884wmt.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/rXlD3QLOa0hkB9/1gelb3El8JJx59Gu4hwU3hKka4U=;
 b=FncwCgLb+ulnMpU5gCKBZr8NqH30ASlW2oqybtzRuTwWGx3LlW5R8X6g/PxOfC1SAH
 PTjgCgoqT6xFL3XwWZx7oh5QH8X13fE163Sw7ClVgU1s0mrC9sjKI9UvsCh8AzKf0rlP
 Pj0FWU4mGGqW6e3Xp4kBqbbm1JWInz3BEuJcXO5nWCFpjIs4gNFlme0ppbZS7orGZ397
 HN2HzwzytPuVw/ZkzRZtOkgDf0KnSacNolbPMYi0yxpOcWi/oHRY8Hp56+FwXyn4zSgv
 vY7X6CzszZBKSnMiAqn86eUzAAGYz20vVQFTbFrbPXIsvgU8ad2vW2ujMsGvUTCDmFF6
 aiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/rXlD3QLOa0hkB9/1gelb3El8JJx59Gu4hwU3hKka4U=;
 b=NtBaGQqJOCF1f3Ur27EeSsVC4zI95dYvJ6ri5928FVPU1WooJCGvVdrD+xkkNBQiSt
 O9jewroPl9aQtUu4eol5FOR6cw8GTkkqTfS8SxLPPgaj9IykChXRbWbCR67HXiiPKiS4
 WcDn/5jq9T5ADTu56yieUJB1C36B92vvlMOM3w+xaPnKKmAQaAmVMPQbnVW2WPNV9maK
 WGcorO4DSJKA+f0Cb6qxwYOHAZ91QKsdL6J9AyKujViudjtNDdCaQd5qGqjVtQGjaHQz
 lK9zl3O8R32DbOnWlZu3UVp6d6quYJRxLcYvry1ZG8m7lMju2/NFYbq8Ix1T7L7WLA9M
 qjjQ==
X-Gm-Message-State: AGi0PuZRi0yJatCWp6aF0Zd/QjW2hVRXvRWdf4Gkme5qiZwEqh6hv9ec
 /z/fSAwNuhr/3CNva5eCIM0=
X-Google-Smtp-Source: APiQypJArzp8ErLstDyP89689dEEEv5h8/Pq6lFvPPCsXdZY7UVhRX28yTc2MSJmBRsVX1ka/+E+CA==
X-Received: by 2002:a1c:668a:: with SMTP id a132mr11855441wmc.46.1587573424281; 
 Wed, 22 Apr 2020 09:37:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q17sm8080812wmj.45.2020.04.22.09.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 09:37:03 -0700 (PDT)
Date: Wed, 22 Apr 2020 17:37:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH] fuzz: select fuzz target using executable name
Message-ID: <20200422163701.GK47385@stefanha-x1.localdomain>
References: <20200421182230.6313-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Content-Disposition: inline
In-Reply-To: <20200421182230.6313-1-alxndr@bu.edu>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 02:22:30PM -0400, Alexander Bulekov wrote:
> The fuzzers are built into a binary (e.g. qemu-fuzz-i386). To select the
> device to fuzz/fuzz target, we usually use the --fuzz-target=3D argument.
> This commit allows the fuzz-target to be specified using the name of the
> executable. If the executable name ends with -target-FUZZ_TARGET, then
> we select the fuzz target based on this name, rather than the
> --fuzz-target argument. This is useful for systems such as oss-fuzz
> where we don't have control of the arguments passed to the fuzzer.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/fuzz.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

I fixed the indentation when merging.

Thanks, applied to my master tree:
https://github.com/stefanha/qemu/commits/master

Stefan

--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gcq0ACgkQnKSrs4Gr
c8gYHAf/c6TRkVLAD5ac7xJ4AsW7Xb3xykcMpZ7FyMdqDp9t4UveVP6qP7gj05xp
1F2iQZ30kDFg8Ssfzl1iXLK9B/3hueCdDqJu9TS12+uG+r7H+S7bTOU9HmXd68OT
hhglYC6Arui3bmjF/Oc0vnbO57ZyHkbzigwz7+yQO4lSQ2ZaAJQ1UfsUMzQXLPMS
JdfLjFK/2u1Uc+Rm2ao4oMr8wxFl+lTIfPTrzzWJWRZlxPw6cFfYhNxWC8kJ5aGp
RJHkDgpR27IPJ4YJF/yFCn8SEoX9+P8VHGA2sdkUeyFclrLOF0rGMsRH0zDjTkrE
u2xOu2BfC5LlyKCIbiN6NlCIk2AsuQ==
=ln5R
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--

