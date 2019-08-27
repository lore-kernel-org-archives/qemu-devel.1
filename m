Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89689C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E7D206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gGNP13QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E7D206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Y5Z-00027c-AJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i2Y3U-0000th-1p
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i2Y3R-0007wN-QY
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:46:23 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:38243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i2Y3R-0007vi-Fi
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566899181;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dng0AhqVZPM38aMq8YY9YOZnoQQL1HnvtXQ2Kd6180c=;
 b=gGNP13QOxqzhx222KVqj3QZQP0hhdeT5MRuGpPcON7Xk6aluRIxZUtK6
 7PUGkVxHoATFk/9WCJqzduXu3pMJJBDh/tHjzRCFgURpHVoKQn2rAyxbj
 skOPJWo5+pdovBsItyaZpRyleurPWGlEvieG3m9N9jSWXTyq7ZJZR3GJh 0=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: McgfIaNBEGvMEQKOrczUGnBIHvQMbhANJN/cSRIo9g0qxmP3Xav6hqucmE73nQjEDzMVKWRp0Y
 RScGypITPX78HDr6wL6vwgWWMOOppVb/a5iC0+W9cZVuCkcN6HEs1nYrdg52pwfK2HRCGpBjEO
 6o7n9T7V5ufV6OXo1CNzEXuGL9mG3KNeWNJe4Yw/JL03AVp0jIKZTqtv4pS0CaTuCnCQcPXT05
 MXGCG0OhDVWrU6pHpd1sdQtxVud9l845vyk7lusf+idVpZs3KWGlae/GotRmGVWNb0B31vRy4G
 dks=
X-SBRS: 2.7
X-MesageID: 4748662
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,436,1559534400"; 
   d="scan'208";a="4748662"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 2/2] xen-bus: Avoid rewriting identical values to
 xenstore
Thread-Index: AQHVWZu4AfJbcgj9V0CJghQKigFNTacOxSww
Date: Tue, 27 Aug 2019 09:46:15 +0000
Message-ID: <322ae907c2594237bdc7b63a24f63bab@AMSPEX02CL03.citrite.net>
References: <20190823101534.465-1-anthony.perard@citrix.com>
 <20190823101534.465-3-anthony.perard@citrix.com>
In-Reply-To: <20190823101534.465-3-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
Subject: Re: [Qemu-devel] [PATCH v2 2/2] xen-bus: Avoid rewriting identical
 values to xenstore
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 23 August 2019 11:16
> To: qemu-devel@nongnu.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; Stefano Stabellini <sstab=
ellini@kernel.org>; Paul
> Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.org
> Subject: [PATCH v2 2/2] xen-bus: Avoid rewriting identical values to xens=
tore
>=20
> When QEMU receives a xenstore watch event suggesting that the "state"
> of the frontend changed, it records this in its own state but it also
> re-write the value back into xenstore even so there were no change.
> This triggers an unnecessary xenstore watch event which QEMU will
> process again (and maybe the frontend as well). Also QEMU could
> potentially write an already old value.
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>=20
> Notes:
>     v2:
>     - fix coding style
>     - only change frontend_set_state() and use 'publish' instead of 'expo=
rt'.
>=20
>  hw/xen/xen-bus.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 62c127b926..a04478ad4f 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -698,7 +698,8 @@ int xen_device_frontend_scanf(XenDevice *xendev, cons=
t char *key,
>  }
>=20
>  static void xen_device_frontend_set_state(XenDevice *xendev,
> -                                          enum xenbus_state state)
> +                                          enum xenbus_state state,
> +                                          bool publish)
>  {
>      const char *type =3D object_get_typename(OBJECT(xendev));
>=20
> @@ -710,7 +711,9 @@ static void xen_device_frontend_set_state(XenDevice *=
xendev,
>                                      xs_strstate(state));
>=20
>      xendev->frontend_state =3D state;
> -    xen_device_frontend_printf(xendev, "state", "%u", state);
> +    if (publish) {
> +        xen_device_frontend_printf(xendev, "state", "%u", state);
> +    }
>  }
>=20
>  static void xen_device_frontend_changed(void *opaque)
> @@ -726,7 +729,7 @@ static void xen_device_frontend_changed(void *opaque)
>          state =3D XenbusStateUnknown;
>      }
>=20
> -    xen_device_frontend_set_state(xendev, state);
> +    xen_device_frontend_set_state(xendev, state, false);
>=20
>      if (state =3D=3D XenbusStateInitialising &&
>          xendev->backend_state =3D=3D XenbusStateClosed &&
> @@ -1169,7 +1172,7 @@ static void xen_device_realize(DeviceState *dev, Er=
ror **errp)
>      xen_device_frontend_printf(xendev, "backend-id", "%u",
>                                 xenbus->backend_id);
>=20
> -    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
> +    xen_device_frontend_set_state(xendev, XenbusStateInitialising, true)=
;
>=20
>      xendev->exit.notify =3D xen_device_exit;
>      qemu_add_exit_notifier(&xendev->exit);
> --
> Anthony PERARD


