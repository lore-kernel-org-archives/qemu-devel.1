Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61261C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B9A20644
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNoF0ZIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B9A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqqE-0008UU-Cq
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hgqI2-00016M-Mr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hgqI0-0002gj-Ch
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:47:42 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hgqHr-0002Zs-KU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:47:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id s20so5836675otp.4
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=66jcoQfpbBEjhrwObrI3YU1kPZW5NkQInhBX/cZUjSI=;
 b=WNoF0ZItm9h5/phaDrBp2WeS5oul6HPoZsdTCeWDkVP/BYWxj39M7tWzfVhtnreXAL
 bd/ZFHQ2ggtpkOzvY9OccYEbI/p4+W1CnzNSmg1rp+bGgFNZ+nyB+h8CkdrlUs3VewuZ
 nMA3gG0HUJllp+fnTlH9BF5pj8yCANIh7NV0w3rEzeNEH8skIJwWUZzYi8sYWbDzqHcy
 b1woczKXsSoXIDLlauC824iywae+EehJlMKBroWJM3qE+6/RzQHkvcL7JNUK//tOtvuO
 CV+tcQSmKFNxcqnlOtBiLRqCvT7j2L1KZ4wcpFt5xwI6GSp1mACV2viiT8PlF31A7Mou
 HXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=66jcoQfpbBEjhrwObrI3YU1kPZW5NkQInhBX/cZUjSI=;
 b=kQ5zlLxRizzff/grXgLZ53+1OfGueDCV/MTM+wOkcehnZoDfOYanuRMcx+BBAhNzWj
 T0cOO9YE2Jq1mfqaf8LNm0P7VfWlo/nix9xmiL/enIbKVc3C4ARu/GDaxjskQcNMpRkK
 IFdMguyd7YC6ajmgs8/jyySrM7x3pc5iZBqeSKezpH8DVMt2xM0YhzIe19A7WxtoUIjm
 N8wR34F7I6DK0Z8ixVDbMVUpIY7zSWjdLqE5PjMtRLGjrW8k/3YXEu2DSvHQk+V9wn9i
 ZtURUebtnhb0sdXeZQiD3iZsj+eIlGEpMWXuki9FRvhzNbG6FA1cZGqA1+Qm0SVEcMvn
 cDPA==
X-Gm-Message-State: APjAAAU4zTowPr6n1pjSZurauCndjkYn/mkPhZFE8XQLuOWiOMyWyjxr
 AfH30Uu+aYwru9hkFPPNF2y+AL6SXXHv8IUprjKuZpl8
X-Google-Smtp-Source: APXvYqzspAmKdjEx7WS7CM8tGNDwfcTHyIOQmat/xTOfxfXgW5WvUCxITtzinBPT8UvBWT/EzBBk3NWJN2PU8bGw8Uk=
X-Received: by 2002:a05:6830:1141:: with SMTP id
 x1mr7328367otq.333.1561722170993; 
 Fri, 28 Jun 2019 04:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190628094901.13347-1-ppandit@redhat.com>
In-Reply-To: <20190628094901.13347-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Jun 2019 19:42:14 +0800
Message-ID: <CAKXe6S+aLo3B_f6xAOuQWSdvi4TiZfWhXw0hVrMww17BprztQw@mail.gmail.com>
To: P J P <ppandit@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] qemu-bridge-helper: restrict bridge name
 to IFNAMSIZ
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
Cc: Riccardo Schirone <rschiron@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Prasad,

P J P <ppandit@redhat.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:52=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The interface names in qemu-bridge-helper are defined to be
> of size IFNAMSIZ(=3D16), including the terminating null('\0') byte.
> The same is applied to interface names read from 'bridge.conf'
> file to form ACLs rules. If user supplied '--br=3Dbridge' name
> is not restricted to the same length, it could lead to ACL bypass
> issue. Restrict bridge name to IFNAMSIZ, including null byte.
>
> Reported-by: Riccardo Schirone <rschiron@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  qemu-bridge-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index f9940deefd..2eca8c5cc4 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -246,7 +246,7 @@ int main(int argc, char **argv)
>          if (strcmp(argv[index], "--use-vnet") =3D=3D 0) {
>              use_vnet =3D 1;
>          } else if (strncmp(argv[index], "--br=3D", 5) =3D=3D 0) {
> -            bridge =3D &argv[index][5];
> +            bridge =3D strndup(&argv[index][5], IFNAMSIZ - 1);
>


I thinke we should cleanup the bridge in the final.

Thanks,
Li Qiang



>          } else if (strncmp(argv[index], "--fd=3D", 5) =3D=3D 0) {
>              unixfd =3D atoi(&argv[index][5]);
>          } else {
> --
> 2.21.0
>
>
>
