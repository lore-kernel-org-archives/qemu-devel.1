Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583FBC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B622086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B622086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIBz-0002He-BE
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iBIBB-0001i2-9R
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iBIBA-00007u-05
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iBIB6-00005K-IG; Fri, 20 Sep 2019 08:38:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0703105786C;
 Fri, 20 Sep 2019 12:38:23 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF20D5C220;
 Fri, 20 Sep 2019 12:38:20 +0000 (UTC)
Subject: Re: [PATCH v2] nbd/server: attach client channel to the export's
 AioContext
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
References: <20190912110032.26395-1-slp@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <b186ebf4-bf9f-b653-938f-9219e3722c07@redhat.com>
Date: Fri, 20 Sep 2019 07:38:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912110032.26395-1-slp@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZiPJhoLPShnHOrKjLM2QRnFe8N1Vco2Tt"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 20 Sep 2019 12:38:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZiPJhoLPShnHOrKjLM2QRnFe8N1Vco2Tt
Content-Type: multipart/mixed; boundary="zvtd6IYAqitCuFrGQ8di7CPLt5QdYoLSp";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com
Message-ID: <b186ebf4-bf9f-b653-938f-9219e3722c07@redhat.com>
Subject: Re: [PATCH v2] nbd/server: attach client channel to the export's
 AioContext
References: <20190912110032.26395-1-slp@redhat.com>
In-Reply-To: <20190912110032.26395-1-slp@redhat.com>

--zvtd6IYAqitCuFrGQ8di7CPLt5QdYoLSp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/12/19 6:00 AM, Sergio Lopez wrote:
> On creation, the export's AioContext is set to the same one as the
> BlockBackend, while the AioContext in the client QIOChannel is left
> untouched.
>=20
> As a result, when using data-plane, nbd_client_receive_next_request()
> schedules coroutines in the IOThread AioContext, while the client's
> QIOChannel is serviced from the main_loop, potentially triggering the
> assertion at qio_channel_restart_[read|write].
>=20
> To fix this, as soon we have the export corresponding to the client,
> we call qio_channel_attach_aio_context() to attach the QIOChannel
> context to the export's AioContext. This matches with the logic at
> blk_aio_attached().
>=20
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1748253
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changelog
>=20
> v2:
>  - Attach the channel once after negotiation completes, avoiding
>    duplication. (thanks Kevin Wolf).
> ---
>  nbd/server.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 28c3c8be85..31d624e146 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1297,6 +1297,11 @@ static coroutine_fn int nbd_negotiate(NBDClient =
*client, Error **errp)
>          return ret;
>      }
> =20
> +    /* Attach the channel to the same AioContext as the export */
> +    if (client->exp && client->exp->ctx) {
> +        qio_channel_attach_aio_context(client->ioc, client->exp->ctx);=

> +    }
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

Will queue through my NBD tree.

>      assert(!client->optlen);
>      trace_nbd_negotiate_success();
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zvtd6IYAqitCuFrGQ8di7CPLt5QdYoLSp--

--ZiPJhoLPShnHOrKjLM2QRnFe8N1Vco2Tt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2EyDsACgkQp6FrSiUn
Q2oYrwf+IXgXe+29Bn0pGxRZyX4mblLr1peEfL1X+v+opeaarZD3VrEIGpaJuhAg
WETJWBa5DWIX7KoQBDmpvA4LeV7/JOtIe3gQNdd/YxV87K/xp0NTlNg0YkORa0Fb
qJXvW4I3xdFeAihj+zDgCgqKQ+sreDtgi0BXGYo9KJqDqgT+UUappSCIO5QSV5KX
N3Wgh1/eNGyoSEwfb4AQe1Y2cjPWf+MA0lceuh5SXrXH4UJB+IHXze+JERJ5oBjz
UPJRaBBsL+zRwSaFMqC1a25KMhA8BWJul7+d/qP2BYmrf1v5Y6twlLVdxhtJTQDJ
XKIunGW6sj1UwDyX2NvI3c3/XT1oYw==
=nbPr
-----END PGP SIGNATURE-----

--ZiPJhoLPShnHOrKjLM2QRnFe8N1Vco2Tt--

