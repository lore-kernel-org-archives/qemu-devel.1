Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4090C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ABD206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="coZGv0q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ABD206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Y3v-0000tj-Ga
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i2Y26-0007yG-T6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i2Y24-00078I-Lw
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:44:58 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:60758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i2Y24-00075s-CP; Tue, 27 Aug 2019 05:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566899096;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DX4oOpDsY33vAk0aDmO5lJ3NCIk2/NjTQmYB4BMZtUc=;
 b=coZGv0q6+XOjsPUsVSeoTMY6oPmvcrfppbOFUU13zzXJiIDJ+0A75XrN
 U5gb78DPYU3+E0je7WSvgFJcZkf/9qJ/xAhN45xXe9V+rioG+Zzd7SYWg
 H+y4uln5EOptFzgwMFzooufuEtsSetSCvA+DcZo+nOhw40XbHie0eZsyq w=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: woavd0/T7knpnaegmG6zQXiLI51w2HzGAZ/NdfYfT3dMn5+ipMkpFA+bhzKh3tu2n2rtLvWWBb
 QTtfrNkuesaBpRfOfJYOOuuIa61AJ+bX5rvU9YtYG7Axo8SnV/yRj5xWbxvTi8Uz/WrHnOIHXb
 IOHr/b/9pLu1kQ++HQ5qzVt72zLa+slP0LixGAbTY1bhVzLgckS1H7Vac6GsqlS7vr5v0Uj1w/
 niKle4yUkoFg3LxHrfZDJfDdxRW4Pgsn0KWDEXm5wB0zJy9llHbFG+VC3cBRvqBv5eiuV2Atl2
 iX0=
X-SBRS: 2.7
X-MesageID: 4978399
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,436,1559534400"; 
   d="scan'208";a="4978399"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 1/2] xen-bus: Fix backend state transition on device
 reset
Thread-Index: AQHVWZu40FkCyruIxkOY4hQyauVsBKcOxNHg
Date: Tue, 27 Aug 2019 09:44:48 +0000
Message-ID: <fae714e07fce4694b9555da6bc986663@AMSPEX02CL03.citrite.net>
References: <20190823101534.465-1-anthony.perard@citrix.com>
 <20190823101534.465-2-anthony.perard@citrix.com>
In-Reply-To: <20190823101534.465-2-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: Re: [Qemu-devel] [PATCH v2 1/2] xen-bus: Fix backend state
 transition on device reset
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
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 23 August 2019 11:16
> To: qemu-devel@nongnu.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-stable@nongnu.org; S=
tefano Stabellini
> <sstabellini@kernel.org>; Paul Durrant <Paul.Durrant@citrix.com>; xen-dev=
el@lists.xenproject.org
> Subject: [PATCH v2 1/2] xen-bus: Fix backend state transition on device r=
eset
>=20
> When a frontend wants to reset its state and the backend one, it
> starts with setting "Closing", then waits for the backend (QEMU) to do
> the same.
>=20
> But when QEMU is setting "Closing" to its state, it triggers an event
> (xenstore watch) that re-execute xen_device_backend_changed() and set
> the backend state to "Closed". QEMU should wait for the frontend to
> set "Closed" before doing the same.
>=20
> Before setting "Closed" to the backend_state, we are also going to
> check if there is a frontend. If that the case, when the backend state
> is set to "Closing" the frontend should react and sets its state to
> "Closing" then "Closed". The backend should wait for that to happen.
>=20
> Fixes: b6af8926fb858c4f1426e5acb2cfc1f0580ec98a
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
> Cc: qemu-stable@nongnu.org
> ---
>=20
> Notes:
>     v2:
>     - use a helper
>     - Add InitWait and Initialised to the list of active state
>=20
>  hw/xen/xen-bus.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index e40500242d..62c127b926 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -516,6 +516,23 @@ static void xen_device_backend_set_online(XenDevice =
*xendev, bool online)
>      xen_device_backend_printf(xendev, "online", "%u", online);
>  }
>=20
> +/*
> + * Tell from the state whether the frontend is likely alive,
> + * i.e. it will react to a change of state of the backend.
> + */
> +static bool xen_device_state_is_active(enum xenbus_state state)
> +{
> +    switch (state) {
> +    case XenbusStateInitWait:
> +    case XenbusStateInitialised:
> +    case XenbusStateConnected:
> +    case XenbusStateClosing:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  static void xen_device_backend_changed(void *opaque)
>  {
>      XenDevice *xendev =3D opaque;
> @@ -539,11 +556,11 @@ static void xen_device_backend_changed(void *opaque=
)
>=20
>      /*
>       * If the toolstack (or unplug request callback) has set the backend
> -     * state to Closing, but there is no active frontend (i.e. the
> -     * state is not Connected) then set the backend state to Closed.
> +     * state to Closing, but there is no active frontend then set the
> +     * backend state to Closed.
>       */
>      if (xendev->backend_state =3D=3D XenbusStateClosing &&
> -        xendev->frontend_state !=3D XenbusStateConnected) {
> +        !xen_device_state_is_active(state)) {
>          xen_device_backend_set_state(xendev, XenbusStateClosed);
>      }
>=20
> --
> Anthony PERARD


