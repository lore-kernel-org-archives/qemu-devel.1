Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA54C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1B920754
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxPhiaWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1B920754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFY9-0004cX-Vj
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jFFXJ-0003qg-Ob
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jFFXI-0008Vr-MR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:09:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jFFXI-0008Sp-FM
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:09:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id 31so911232wrs.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8U95VLC/ES7XoGI/EEOErdLjfAUYHt5wBfPmytmairI=;
 b=AxPhiaWPgrVhben8Va9wO0VGXrupshDYj2ZVhwC89MqMmTcN/w/Q/hvJYjxE5NHvZt
 KXz53LnqTjm/GBr3fzMPfT/SzOFyltkaSPoiyYAA1jc8oUjmSf5a0mqBhoyHYpdaKCjN
 55OCmhMub2PRTSb25UmDUVZHijpNKHgFd63lfKWz5Bes7Td+USScKplkyK6XgnqS6n+x
 8HA5SLy7l24jAfWNe8PWE4urp/AyteEfE0F4mxRxNvBKaADwSZv3fDKmjAdoTsQFNjcw
 +8EXPuMenqG9kHGATccFBCA1hwXi0fuNIhQ9QG2j+YJlk4dzFY9OZMpHKsmBi+btf3I5
 kB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8U95VLC/ES7XoGI/EEOErdLjfAUYHt5wBfPmytmairI=;
 b=YUIkwJC26rEmYU3qBP+l7+lBh6EmLON/sUyMUNSu0/R4LCmtWR0ck3zywP2ZfzudPd
 5Gd/37//F1iWBsuKxqBbNsYoq+KTxFH31JF3zX+eUGg5HBxPG9Q6bQZt9LWF7vxGoF8v
 GmP8sPSpJD2UQkGUppWPWerCkUEGSmLM6v9qqxnSCyt1xcEmo7gnf4K89ibMAwU3JlRp
 4wdEUlEM1oLc1tr+6kv4+IXyA4lnccHz8ierjJ7ytWfrxCi6HXTHzCpLnKmYja449H7C
 VzJQ+0c1cTjqVjOFwIyU0lspVuMmboZ2zXyTP9OSkij+hfnqYTv6ZUzzlLRBP7X1E9By
 KYVg==
X-Gm-Message-State: ANhLgQ1FR5vcfQierFvoZGnGTsob84Yo0ro3wOQDnrGlG+jCT4jGcUpU
 TVwkAaqNHgUe5riLn/dxgCo=
X-Google-Smtp-Source: ADFU+vsC/DSCuezviTuTsoqn+nubci/TJRob6VQwLs5o7obLgdpgPMacD70+wRKbEo9ahZbG9dqFfQ==
X-Received: by 2002:adf:bbcd:: with SMTP id z13mr10257098wrg.389.1584702594939; 
 Fri, 20 Mar 2020 04:09:54 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s131sm7302414wmf.35.2020.03.20.04.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 04:09:54 -0700 (PDT)
Date: Fri, 20 Mar 2020 11:09:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: dnbrdsky@gmail.com
Subject: Re: [PATCH] misc: fix __COUNTER__ macro to be referenced properly
Message-ID: <20200320110952.GA130533@stefanha-x1.localdomain>
References: <20200319161925.1818377-1-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20200319161925.1818377-1-dnbrdsky@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 09:19:24AM -0700, dnbrdsky@gmail.com wrote:
> From: danbrodsky <dnbrdsky@gmail.com>
>=20
> - __COUNTER__ doesn't work with ## concat
> - replaced ## with glue() macro so __COUNTER__ is evaluated
>=20
> Signed-off-by: danbrodsky <dnbrdsky@gmail.com>
> ---
>  include/qemu/lockable.h | 2 +-
>  include/qemu/rcu.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
> index 1aeb2cb1a6..a9258f2c2c 100644
> --- a/include/qemu/lockable.h
> +++ b/include/qemu/lockable.h
> @@ -170,7 +170,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lock=
able_auto_unlock)
>   *   }
>   */
>  #define QEMU_LOCK_GUARD(x) \
> -    g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ =3D \
> +    g_autoptr(QemuLockable) glue(qemu_lockable_auto, __COUNTER__) =3D \
>              qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x)))
> =20
>  #endif

Please fix WITH_QEMU_LOCK_GUARD() too.  It's in the same header file and
gcc -E shows that it also fails to expand __COUNTER__:

  for (__attribute__((cleanup(glib_autoptr_cleanup_QemuLockable)))
      QemuLockable_autoptr qemu_lockable_auto__COUNTER__ =3D ...

Thanks,
Stefan

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl50pIAACgkQnKSrs4Gr
c8gNAAgAwCT9f2z203QjMmbuTKYIBfWPBm77PNbT2J36fkeuasqGYS2Jd66ENTTC
UxFs6+i8Oz+/9qTs0G+JaoFURProu0Wsu/qzq5DdxHycuH14E3pb3oNPwe4HMxn3
RIFyFZfcZaY6Jx6I0ybHH1RZofZGD07iPTYmEBzB0GwgVHafNMjRgMDUr+9vRMVP
cO9sulgfrjrW2p7IX32vbDWLC18gP7AlTcTGSNVj9iUB8C7OC9q+m6gVMLSv6GwI
aOg7lAMbE/JAqXdYMf7ThC2kHEs0ADx18yzG10cqLJi3ugUr0neIECbKsccBt2S3
RORCvB9CBmUkLpjSAU5NQtOxGg00IQ==
=Q/K4
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

