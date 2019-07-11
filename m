Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5A9C742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591D320863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saBchn4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591D320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqc8-0004bN-Fd
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 04:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48493)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hlqbl-00031d-3C
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hlqbg-0004vF-Qe
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:08:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hlqbg-0004ut-Ja; Fri, 12 Jul 2019 04:08:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id r1so8929305wrl.7;
 Fri, 12 Jul 2019 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8Uh9U6frhW0MIoKGkbYWr6ViDpRba0ohH7xp8mVHHyE=;
 b=saBchn4MzZsZY3Tyre/yGcnplUIfRCgkR5Est6BWvVV6fK26kWWA5vtcRH4FU8KmCu
 hAYOgkk8DqNNv4UiSVUUWa2x9G1GyTUaSyLGnhS8Qi1zhf/hvoRbFEzxn1OpDGjjMJIB
 9ep2ubsErfRIL2jfPwzSlO56ijBGFVDTvPL9P4j683JqpUPG/JBHdDGTnzl7IFRVXg6K
 bV9DdJTh2g4NH0Kl5admoPmZqBQE3UbiVhZGiZnQQQ5EeiRFDF03piaehfQV2kzvdAGv
 ZUsUQvrIMs+yOWjWX/l1u5xvSK/0tyjxAGPYNWMPLTQr+H5k2HY/I32RJtBzxgbD3ARa
 dUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8Uh9U6frhW0MIoKGkbYWr6ViDpRba0ohH7xp8mVHHyE=;
 b=a/lRYOLxfnj5by6fiqy1vZVk1jm1yO8qF1qa5ScMllojsmc1jNMSharclA3Myb/KNt
 As24PGqWG7TcebM60t16e52d1zue372gCT0bu7zKB5gRLM2QrTfIZ45mPcaGyLV0omM5
 f6uI55KTKEYPV1wcQ3uhCvPS2h3km5BiLf4rmLkNVmbu/aWKigbRoeOCLQRndftMKiFU
 wNKYS215kGqxU2xE++XyQPNLqvPjKcVE76U7Biu69gMoepK/JvRG+sFnndPQtFb4y8Z7
 Lo0DXhZGSje6eh6i7RoJZ7V/Q9SlaWVf1rgeXAvQGqzTDNYfnWmQq4H9F+LQ+1mJ3Mhu
 vmNA==
X-Gm-Message-State: APjAAAUeWm/9AaJmBW/en0oDJJql66kwYEbR0u0fQTe5fpEknbH+Cz3G
 EyYtl+6I5QVroYU9dwTkZOL5TOx2wQZ3nQ==
X-Google-Smtp-Source: APXvYqymhJ38nIX2cUHezUfr0LW7nRNXGfDNBgYYG004amfiK++40q4jIcsciJn2caoXG9KTt02E/g==
X-Received: by 2002:adf:8364:: with SMTP id 91mr10081563wrd.13.1562918919610; 
 Fri, 12 Jul 2019 01:08:39 -0700 (PDT)
Received: from localhost ([92.184.96.85])
 by smtp.gmail.com with ESMTPSA id j9sm5386044wrn.81.2019.07.12.01.08.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 01:08:38 -0700 (PDT)
Date: Thu, 11 Jul 2019 14:24:36 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: shaju.abraham@nutanix.com
Message-ID: <20190711122436.GH13422@stefanha-x1.localdomain>
References: <1562554503-177179-1-git-send-email-shaju.abraham@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <1562554503-177179-1-git-send-email-shaju.abraham@nutanix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] Fix Guest VM crash due to
 iSCSI Sense Key error
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 07, 2019 at 07:55:03PM -0700, shaju.abraham@nutanix.com wrote:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

CCing John Snow, IDE maintainer.

You can use scripts/get_maintainer.pl -f hw/ide/core.c to find out who
to send patches to.

Stefan

> From: Shaju Abraham <shaju.abraham@nutanix.com>
>=20
> During the  IDE DMA transfer for a ISCSI target,when libiscsi encounters
> a SENSE KEY error, it sets the task->sense to  the value "COMMAND ABORTED=
".
> The function iscsi_translate_sense() later translaters this error to -ECA=
NCELED
> and this value is passed to the callback function. In the case of  IDE DM=
A read
> or write, the callback function returns immediately if the value of the r=
et
> argument is -ECANCELED.
> Later when ide_cancel_dma_sync() function is invoked  the assertion
> "s->bus->dma->aiocb =3D=3D ((void *)0)" fails and the qemu process gets t=
erminated.
> Fix the issue by making the value of s->bus->dma->aiocb =3D NULL when
> -ECANCELED is passed to the callback.
>=20
> Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
> ---
>  hw/ide/core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 6afadf8..78ea357 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -841,6 +841,7 @@ static void ide_dma_cb(void *opaque, int ret)
>      bool stay_active =3D false;
> =20
>      if (ret =3D=3D -ECANCELED) {
> +        s->bus->dma->aiocb =3D NULL;
>          return;
>      }
> =20
> --=20
> 1.9.4
>=20
>=20

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0nKoQACgkQnKSrs4Gr
c8jrWgf+KX6mIQYRt8k9knmf7XVr7PYP9vzI8N3fTRFbT+s70CzRyXpUghbZp3WY
wN7pOURiBOCuaQe2YJacLqdjGOYgtvmldk3IXDR+K4ctplOd/qs9MQPCMhDXOO8S
FzKopdrWMOxg4MkZwNhmPPs3WfYprFRGDQKdEloCn71BZZwFQ3HxmdH9R2EFWLtC
ZsCIbt+lIrMSSYdtGFlRm3kisl37Tecgk8wEi35Cn1aUA9kblZvVim6FEzFxNwj+
eYUm4Q3ZgvYKsyFadaFSFFZ5W3FMwoLhGsm7tZO6hIBjj+z30sF4Iog2lhHfXK16
/y2vDqVE27DyzheO0SC0qBv3MZwaKg==
=Dg0k
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--

