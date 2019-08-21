Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E1B22DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NgDTgY0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E1B22DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Sjh-0006NB-PN
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0Sib-00051g-FM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0SiY-0002CL-Hp
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:40:12 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:6613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i0SiY-00028L-1I
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566402009;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vGLYHkduOt3TNP4VMQhgpLWndIJCOB9lb/CG+R8GJG8=;
 b=NgDTgY0gCqzT5+sBiHuZCSPWTktpox37+E/PPmQbUHwk1Sg94GBMIjmP
 pbLy0Crbubgt6u4IrUpF4uKIEqDHC/DBWyH1TjRzTKwnqTgnMLNPwdD30
 bb6q2adwOEkXFtRTfSGEANPPd2Razjqv4ZIzJQMCZ1F/V2o3dp/3vuyaK U=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: SpjE6MtqCiY/ljGuT7GJaAczMaXNee01Y3GBmwk+CmS3naDFdMprmq9vSTapmBMczSXw5GXQQY
 ayGNX1y814CQVZb1dimAtmjiEeXtgz+qNTiQWuWhOWt8CTVE8USOeLQiQuPwAtGoKrKtL9CuZk
 bgCehtvdmjJNDfwJ21Zl62yrcgom0CYvVsowT2+tUp8ABFQoPGC8pNHFLMJGr+IamDQ3976fYI
 NFJmaRtE0AQ8lEZ06FO3xi5Z7lP8guDS5obFP+RY6ea20M3KqGCEJUiByHDnXBTTDJo1o7D9+I
 20E=
X-SBRS: 2.7
X-MesageID: 4786323
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,412,1559534400"; 
   d="scan'208";a="4786323"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 2/2] xen-bus: Avoid rewriting identical values to xenstore
Thread-Index: AQHVWAGpK6THQS4Lrk6EcsKhvd7AqqcFuu6Q
Date: Wed, 21 Aug 2019 15:40:05 +0000
Message-ID: <703d5a46d4c74eb4afd93d76b7341efc@AMSPEX02CL03.citrite.net>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-3-anthony.perard@citrix.com>
In-Reply-To: <20190821092020.17952-3-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: Re: [Qemu-devel] [PATCH 2/2] xen-bus: Avoid rewriting identical
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
> Sent: 21 August 2019 10:20
> To: qemu-devel@nongnu.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; Stefano Stabellini <sstab=
ellini@kernel.org>; Paul
> Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.org
> Subject: [PATCH 2/2] xen-bus: Avoid rewriting identical values to xenstor=
e
>=20
> When QEMU receive a xenstore watch event suggesting that the "state" or
> "online" status of the frontend or the backend changed, it record this
> in its own state but it also re-write the value back into xenstore even
> so there were no changed. This trigger an unnecessary xenstore watch
> event which QEMU will process again (and maybe the frontend as well).
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  hw/xen/xen-bus.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 982eca4533..c83f07424a 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -481,20 +481,27 @@ static int xen_device_backend_scanf(XenDevice *xend=
ev, const char *key,
>      return rc;
>  }
>=20
> -void xen_device_backend_set_state(XenDevice *xendev,
> -                                  enum xenbus_state state)
> +static bool xen_device_backend_record_state(XenDevice *xendev,
> +                                            enum xenbus_state state)
>  {
>      const char *type =3D object_get_typename(OBJECT(xendev));
>=20
>      if (xendev->backend_state =3D=3D state) {
> -        return;
> +        return false;
>      }
>=20
>      trace_xen_device_backend_state(type, xendev->name,
>                                     xs_strstate(state));
>=20
>      xendev->backend_state =3D state;
> -    xen_device_backend_printf(xendev, "state", "%u", state);
> +    return true;
> +}
> +
> +void xen_device_backend_set_state(XenDevice *xendev,
> +                                  enum xenbus_state state)
> +{
> +    if (xen_device_backend_record_state(xendev, state))
> +        xen_device_backend_printf(xendev, "state", "%u", state);
>  }
>=20
>  enum xenbus_state xen_device_backend_get_state(XenDevice *xendev)
> @@ -502,7 +509,8 @@ enum xenbus_state xen_device_backend_get_state(XenDev=
ice *xendev)
>      return xendev->backend_state;
>  }
>=20
> -static void xen_device_backend_set_online(XenDevice *xendev, bool online=
)
> +static void xen_device_backend_set_online(XenDevice *xendev, bool online=
,
> +                                          bool export)
>  {
>      const char *type =3D object_get_typename(OBJECT(xendev));
>=20
> @@ -513,7 +521,8 @@ static void xen_device_backend_set_online(XenDevice *=
xendev, bool online)
>      trace_xen_device_backend_online(type, xendev->name, online);
>=20
>      xendev->backend_online =3D online;
> -    xen_device_backend_printf(xendev, "online", "%u", online);
> +    if (export)
> +        xen_device_backend_printf(xendev, "online", "%u", online);
>  }
>

Perhaps the behaviour of backend_set_state() and backend_set_online() could=
 be the same? I.e. they both take an 'export' (or perhaps 'publish'?) param=
eter and only write xenstore if that is true. (I realise that would involve=
 modifying xen-block to pass 'true' as the extra export/publish param, but =
I think it would be neater overall).
=20
>  static void xen_device_backend_changed(void *opaque)
> @@ -529,13 +538,13 @@ static void xen_device_backend_changed(void *opaque=
)
>          state =3D XenbusStateUnknown;
>      }
>=20
> -    xen_device_backend_set_state(xendev, state);
> +    xen_device_backend_record_state(xendev, state);
>=20
>      if (xen_device_backend_scanf(xendev, "online", "%u", &online) !=3D 1=
) {
>          online =3D 0;
>      }
>=20
> -    xen_device_backend_set_online(xendev, !!online);
> +    xen_device_backend_set_online(xendev, !!online, false);
>=20

You could then pass 'false' here in both cases.

>      /*
>       * If the toolstack (or unplug request callback) has set the backend
> @@ -683,7 +692,8 @@ int xen_device_frontend_scanf(XenDevice *xendev, cons=
t char *key,
>  }
>=20
>  static void xen_device_frontend_set_state(XenDevice *xendev,
> -                                          enum xenbus_state state)
> +                                          enum xenbus_state state,
> +                                          bool export)
>  {
>      const char *type =3D object_get_typename(OBJECT(xendev));
>=20
> @@ -695,7 +705,8 @@ static void xen_device_frontend_set_state(XenDevice *=
xendev,
>                                      xs_strstate(state));
>=20
>      xendev->frontend_state =3D state;
> -    xen_device_frontend_printf(xendev, "state", "%u", state);
> +    if (export)
> +        xen_device_frontend_printf(xendev, "state", "%u", state);
>  }
>=20
>  static void xen_device_frontend_changed(void *opaque)
> @@ -711,7 +722,7 @@ static void xen_device_frontend_changed(void *opaque)
>          state =3D XenbusStateUnknown;
>      }
>=20
> -    xen_device_frontend_set_state(xendev, state);
> +    xen_device_frontend_set_state(xendev, state, false);
>=20
>      if (state =3D=3D XenbusStateInitialising &&
>          xendev->backend_state =3D=3D XenbusStateClosed &&
> @@ -1146,7 +1157,7 @@ static void xen_device_realize(DeviceState *dev, Er=
ror **errp)
>                                xendev->frontend_id);
>      xen_device_backend_printf(xendev, "hotplug-status", "connected");
>=20
> -    xen_device_backend_set_online(xendev, true);
> +    xen_device_backend_set_online(xendev, true, true);
>      xen_device_backend_set_state(xendev, XenbusStateInitWait);
>=20
>      xen_device_frontend_printf(xendev, "backend", "%s",
> @@ -1154,7 +1165,7 @@ static void xen_device_realize(DeviceState *dev, Er=
ror **errp)
>      xen_device_frontend_printf(xendev, "backend-id", "%u",
>                                 xenbus->backend_id);
>=20
> -    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
> +    xen_device_frontend_set_state(xendev, XenbusStateInitialising, true)=
;
>=20

And similarly pass 'true' here for all three cases.

What do you think?

  Paul

>      xendev->exit.notify =3D xen_device_exit;
>      qemu_add_exit_notifier(&xendev->exit);
> --
> Anthony PERARD


