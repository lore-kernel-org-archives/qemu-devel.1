Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FD8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F652053B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/yF4gaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F652053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2sy7-0006aU-GO
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2sxM-00066L-79
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2sxL-00076m-68
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:05:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i2sxK-00075T-UF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:05:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so1487878wrd.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wtBzDvT/08sxj366Z0AF1jJ+KAz4lYKNAltltz6QxaY=;
 b=K/yF4gaa5w3hKI+SmTXLwfMtSKhYy5dygReb3fRm/vcD+RZiGe9C74C4L3zrct4BtR
 qsNFQ4KuwONyg2Dk0l0a+cHA8dgWuAtscqlrGTA/O6uC9VV46zAc0flqb2dY2/mqE5mK
 Z355aosEBOD+K4kyOKflxuIGCs7fUDK6ZBzYLNYKEQ45B3SiCmi6xAXuEoN9yLtNyrr5
 xxcDGaS0lcCCQq5sQJuMvIysIkaijbqevbW/KVJRxJGgYPPqhLlqWegwqriAI5Ift9V+
 eonhSdXF2hf2pFkXObjMdSwA2GoiBeXmZ3Gn1ETQOoD668unB6MQjZD9wxN1fkGF0TEo
 KcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wtBzDvT/08sxj366Z0AF1jJ+KAz4lYKNAltltz6QxaY=;
 b=GB8rLsiiF5K6WKoA4flTX27YuSTbaFzpwPTVvV3yXPma3hhNAyYozUw2GhQcOwuiZu
 QhdSgf20l3x2TOhRxvH9s2VBPqFbpdUeio3wri9AIvBRlbJ+xLTIhLXzBkWAhKtj5mOm
 vQx1xR4e469gCStp7C9S0Ok1CqjYqK67ASX6qMy2DNBNSiHy2kWtw2COL7XEGHra5/Xp
 Xc0vHirx1E8EF7JvSO/b9k+qJP7wEn62zc0umdB+pzM2AYE17KxZ3edIndkq3fNp//qN
 Qv/2EzLDHjhuaOxnHSPLxijbA6t325qXk+8b1DiTgQX6EwuJYK7m3kWU6vBv40PP8sif
 msmQ==
X-Gm-Message-State: APjAAAUodcqSq7gPvC98psmK2mGZaFuEOU4uV9WT2vIv8VUklcgFWEAg
 OiCfD9XYRNs7SbS/dNRCMmrwsxLBYqk=
X-Google-Smtp-Source: APXvYqzq6lMQ5440Ce1IPriKH68oWkJHQMhRmfVH7ylw5wxW47WIeVBvWJQIEpeU9QBo8qgMQrREVw==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr2904503wro.337.1566979524463; 
 Wed, 28 Aug 2019 01:05:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q18sm1596499wrw.36.2019.08.28.01.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 01:05:23 -0700 (PDT)
Date: Wed, 28 Aug 2019 09:05:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190828080522.GA5285@stefanha-x1.localdomain>
References: <20190815132651.22410-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20190815132651.22410-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add Stefan Hajnoczi as
 vhost-vsock maintainer
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 02:26:51PM +0100, Stefan Hajnoczi wrote:
> A MAINTAINERS entry wasn't added when this code was merged.  Add it now
> so that scripts/get_maintainer.pl works for vhost-vsock.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6de200453..b8fc408bf3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1571,6 +1571,13 @@ F: hw/virtio/virtio-crypto.c
>  F: hw/virtio/virtio-crypto-pci.c
>  F: include/hw/virtio/virtio-crypto.h
> =20
> +vhost-vsock
> +M: Stefan Hajnoczi <stefanha@redhat.com>
> +S: Supported
> +F: hw/virtio/vhost-vsock.c
> +F: hw/virtio/vhost-vsock-pci.c
> +F: include/hw/virtio/vhost-vsock.h
> +
>  nvme
>  M: Keith Busch <keith.busch@intel.com>
>  L: qemu-block@nongnu.org
> --=20
> 2.21.0

Michael: Would you like to take this through your tree?

Stefan

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mNcIACgkQnKSrs4Gr
c8g07wf9F4+NcfbamPPvxBsHt1pj4vtgyrDkcLkuoDu8Tlnge1d6LNbjnP5zGKXG
3o9TmauQcLkOnAFtGriX41x9d7SbYzodApzpoi/226GrxWl4vs+yJR59BGYubiKW
SmhBMd6AhpMCivP0dmeyCaM0Svp78M/6ytNoGLYprZu0QqXZkGo6BTPdtLvIbPa/
5zzkqqzyo8PrXqDUG8sbhSaUs+fCDo9+a2Tz6hBHPUAiQa6qbjqRoaudzaeUDIWO
fnnMuizIM8SSRALoiGJ65E0ixYrwOV0oGRFJ/TNDs3zKnAitbgNYYIO0//llNQ77
juFdqfYQCdvdl0F0h2QbP96sgfN2bg==
=ljDI
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

