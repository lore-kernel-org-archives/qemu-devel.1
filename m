Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED2BC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC68E205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="csuQnl+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC68E205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kTp-0007C7-1b
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0kSb-00061p-64
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0kST-0005mf-9O
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:36:50 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:51778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i0kSO-0005fQ-49
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566470200;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/FBm/NcT3AZytSJTpvMcO9mfGZB13QdkUyU9NQAsv2Y=;
 b=csuQnl+ss+jK2jKSuS3OvtYeFXnRnU/vCNXQerIRUhcsiizm7X8haPlL
 gopb1nPoqk8V9S9Q9qqwyg6F7ZM2WhV1EG8Lg6aMnmF7erhvYUXrAfMMB
 9XyjXs8vxWlzcUYq/4xUAIY0gJhwpG/3CkX5EJypTHexnJweZ2zBvZ6qR s=;
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
IronPort-SDR: /JXPxTaox28WTZlliNf6bjaxVVWydsKUaY9xYj+bFH0L9kzR2Bod3L+48fh9Ng9cSJJfSViSUW
 td7slS+pKX1ev0Kh6Kl0gJgSIbEaSE7JzYFETrySu0t43z3wMt1urADecLs7MDR7UJBDVCeuKS
 FHmk1jH7V+omGSg4vp1WAKFc2cooi2n1uZnIzvvqOPieth37GEAUaSOMCXBQ+E8TxKBYkkjv8a
 Lj3qQ4mP4T+ApcplS+Ztvv1a6Fz4B+Ts3UoOhPxrHsBWSeWvzqbvaqcVk+7GG7pMhYmQFlXACj
 4Rk=
X-SBRS: 2.7
X-MesageID: 4792964
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,416,1559534400"; 
   d="scan'208";a="4792964"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>
Thread-Topic: [PATCH 2/2] xen-bus: Avoid rewriting identical values to xenstore
Thread-Index: AQHVWAGpK6THQS4Lrk6EcsKhvd7AqqcFuu6QgAEaRACAACIz8A==
Date: Thu, 22 Aug 2019 10:36:32 +0000
Message-ID: <b63f378211d8451d8267f83f0922138e@AMSPEX02CL03.citrite.net>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-3-anthony.perard@citrix.com>
 <703d5a46d4c74eb4afd93d76b7341efc@AMSPEX02CL03.citrite.net>
 <20190822102132.GJ1289@perard.uk.xensource.com>
In-Reply-To: <20190822102132.GJ1289@perard.uk.xensource.com>
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
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 22 August 2019 11:22
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; x=
en-devel@lists.xenproject.org
> Subject: Re: [PATCH 2/2] xen-bus: Avoid rewriting identical values to xen=
store
>=20
> On Wed, Aug 21, 2019 at 04:40:05PM +0100, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Anthony PERARD <anthony.perard@citrix.com>
> > > Sent: 21 August 2019 10:20
> > > To: qemu-devel@nongnu.org
> > > Cc: Anthony Perard <anthony.perard@citrix.com>; Stefano Stabellini <s=
stabellini@kernel.org>; Paul
> > > Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.org
> > > Subject: [PATCH 2/2] xen-bus: Avoid rewriting identical values to xen=
store
> > >
> > > When QEMU receive a xenstore watch event suggesting that the "state" =
or
> > > "online" status of the frontend or the backend changed, it record thi=
s
> > > in its own state but it also re-write the value back into xenstore ev=
en
> > > so there were no changed. This trigger an unnecessary xenstore watch
> > > event which QEMU will process again (and maybe the frontend as well).
> > >
> > > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > > ---
> > >  hw/xen/xen-bus.c | 37 ++++++++++++++++++++++++-------------
> > >  1 file changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > > index 982eca4533..c83f07424a 100644
> > > --- a/hw/xen/xen-bus.c
> > > +++ b/hw/xen/xen-bus.c
> > > @@ -481,20 +481,27 @@ static int xen_device_backend_scanf(XenDevice *=
xendev, const char *key,
> > >      return rc;
> > >  }
> > >
> > > -void xen_device_backend_set_state(XenDevice *xendev,
> > > -                                  enum xenbus_state state)
> > > +static bool xen_device_backend_record_state(XenDevice *xendev,
> > > +                                            enum xenbus_state state)
> > >  {
> > >      const char *type =3D object_get_typename(OBJECT(xendev));
> > >
> > >      if (xendev->backend_state =3D=3D state) {
> > > -        return;
> > > +        return false;
> > >      }
> > >
> > >      trace_xen_device_backend_state(type, xendev->name,
> > >                                     xs_strstate(state));
> > >
> > >      xendev->backend_state =3D state;
> > > -    xen_device_backend_printf(xendev, "state", "%u", state);
> > > +    return true;
> > > +}
> > > +
> > > +void xen_device_backend_set_state(XenDevice *xendev,
> > > +                                  enum xenbus_state state)
> > > +{
> > > +    if (xen_device_backend_record_state(xendev, state))
> > > +        xen_device_backend_printf(xendev, "state", "%u", state);
> > >  }
> > >
> > >  enum xenbus_state xen_device_backend_get_state(XenDevice *xendev)
> > > @@ -502,7 +509,8 @@ enum xenbus_state xen_device_backend_get_state(Xe=
nDevice *xendev)
> > >      return xendev->backend_state;
> > >  }
> > >
> > > -static void xen_device_backend_set_online(XenDevice *xendev, bool on=
line)
> > > +static void xen_device_backend_set_online(XenDevice *xendev, bool on=
line,
> > > +                                          bool export)
> > >  {
> > >      const char *type =3D object_get_typename(OBJECT(xendev));
> > >
> > > @@ -513,7 +521,8 @@ static void xen_device_backend_set_online(XenDevi=
ce *xendev, bool online)
> > >      trace_xen_device_backend_online(type, xendev->name, online);
> > >
> > >      xendev->backend_online =3D online;
> > > -    xen_device_backend_printf(xendev, "online", "%u", online);
> > > +    if (export)
> > > +        xen_device_backend_printf(xendev, "online", "%u", online);
> > >  }
> > >
> >
> > Perhaps the behaviour of backend_set_state() and backend_set_online() c=
ould be the same? I.e. they
> both take an 'export' (or perhaps 'publish'?) parameter and only write xe=
nstore if that is true. (I
> realise that would involve modifying xen-block to pass 'true' as the extr=
a export/publish param, but I
> think it would be neater overall).
>=20
> I've actually did it this way for backend_set_state() because the only
> reason to update internal states without writing that state into
> xenstore is because the xenstore state changed, so
> {front,back}end_changed() are the only function that don't want/need to
> write the new state into xenstore. I wanted to avoid misuse of the
> extra export/publish param in future backend drivers.
>=20
> As for frontend_set_state() and backend_set_online(), they are only used
> in xen-bus.c, creating a new function didn't seems as needed.
>=20
> I kind of think that maybe I should go further and also have
> frontend_record_state() is it could be possible to have frontend drivers
> in QEMU. (and maybe record_online so they all looks the same.)
>=20

I guess I don't like the term 'record'... I'd really like to stick with 'se=
t'...

> So, would you prefer to have the extra param to *_set_*() that should be
> "true" outside of *_changed(), or the extra functions like I did with
> backend_{set,record}_state() ?
>=20

...so I prefer the extra param.

But, now I look at the code again without your patch applied I don't actual=
ly see the problem it is trying to fix. The functions xen_device_[back|fron=
t]end_set_state return early if the state being set matches the existing st=
ate and hence never get to the line where the state is written to xenstore.

  Paul

> Thanks,
>=20
> --
> Anthony PERARD

