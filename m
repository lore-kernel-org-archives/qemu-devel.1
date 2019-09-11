Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77024C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329052075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bdSpWgPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329052075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85MI-0000f8-D6
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i85HS-0004z2-G0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i85HQ-0005p4-MX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:15:42 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:9201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i85HQ-0005o5-BR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568218541;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KBCbseHXGl9x2qnrWiLzBky7MDY+S7D9+BO3P/CT/N8=;
 b=bdSpWgPkgG9G31qFZYY5e9Z+j5jEUQ6IJrXNUuLO/cPFJc7JD8aNrU67
 OFXCu1s4GSOsj5vrDTkIWhcIDrpiLGO3Pf20rwgGy7dRVfs3hqQmdYDdV
 kpwS0sdW3WUcy/GfDBaKhIGar3zZM08s7gdWiGezwOf4LFaDPB8NTZFGF g=;
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
IronPort-SDR: ULHa7o3LECx1Rm1bcoVlO2MzsOmHAtjp9eVgW7JLKB6oWv4Q/vP9nJUvoSiyPnMahukh9nnH2b
 01i7wIJk7WI3A4D/dwkO+Xmkz21I1j86tirqrQs01i1omTysyAkA1EVImlkNa4E5BBnAxZ8Wlf
 E1Oz1zI790bFOnWznoitUY2eJaNZcNnA374P3pCCKIf2VFFPXNKolWjfSUW8Mqdc4wzNe0Gn8b
 CdPsfp+GajevoQstYFMdxaaUqMuYmJ4hkbnhTRx9W1Fc3+1uuB7wzqJy4QelnPEh7BYFiruTdH
 o6s=
X-SBRS: 2.7
X-MesageID: 5440600
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,494,1559534400"; 
   d="scan'208";a="5440600"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>
Thread-Topic: [PATCH 3/3] xen: perform XenDevice clean-up in XenBus watch
 handler
Thread-Index: AQHVaK5L2oOauKnz0Ua8akuNXe6iDqcmpqNQ
Date: Wed, 11 Sep 2019 16:15:34 +0000
Message-ID: <91a39e7bc56c4916b956b0752e0aa9dd@AMSPEX02CL03.citrite.net>
References: <20190911143618.23477-1-paul.durrant@citrix.com>
 <20190911143618.23477-4-paul.durrant@citrix.com>
In-Reply-To: <20190911143618.23477-4-paul.durrant@citrix.com>
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
Subject: Re: [Qemu-devel] [PATCH 3/3] xen: perform XenDevice clean-up in
 XenBus watch handler
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
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Paul Durrant <paul.durrant@citrix.com>
> Sent: 11 September 2019 15:36
> To: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Stefano Stabellini <sstabelli=
ni@kernel.org>; Anthony
> Perard <anthony.perard@citrix.com>
> Subject: [PATCH 3/3] xen: perform XenDevice clean-up in XenBus watch hand=
ler
>=20
> Cleaning up offine XenDevice objects directly in
> xen_device_backend_changed() is dangerous as xen_device_unrealize() will
> modify the watch list that is being walked. Even the QLIST_FOREACH_SAFE()
> used in notifier_list_notify() is insufficient as *two* notifiers (for
> the frontend and backend watches) are removed, thus potentially rendering
> the 'next' pointer unsafe.
>=20
> The solution is to use the XenBus backend_watch handler to do the clean-u=
p
> instead, as it is invoked whilst walking a separate watch list.
>=20
> This patch therefore adds a new 'offline_devices' list to XenBus, to whic=
h
> offline devices are added by xen_device_backend_changed(). The XenBus
> backend_watch registration is also changed to not only invoke
> xen_bus_enumerate() but also a new xen_bus_cleanup() function, which will
> walk 'offline_devices' and perform the necessary actions.
> For safety a an extra 'online' check is also added to
> xen_bus_type_enumerate() to make sure that no attempt is made to create a
> new XenDevice object for a backend that is offline.
>=20
> NOTE: This patch also include some cosmetic changes:
>       - substitute the local variable name 'backend_state'
>         in xen_bus_type_enumerate() with 'state', since there
>         is no ambiguity with any other state in that context.
>       - change xen_device_state_is_active() to
>         xen_device_frontend_is_active() (and pass a XenDevice directly)
>         since the state tests contained therein only apply to a frontend.
>       - use 'state' rather then 'xendev->backend_state' in
>         xen_device_backend_changed() to shorten the code.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> ---
>  hw/xen/trace-events      |  2 +
>  hw/xen/xen-bus.c         | 91 +++++++++++++++++++++++++++++-----------
>  include/hw/xen/xen-bus.h |  2 +
>  3 files changed, 70 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> index 80ce3dafad..e6885bc751 100644
> --- a/hw/xen/trace-events
> +++ b/hw/xen/trace-events
> @@ -17,8 +17,10 @@ xen_domid_restrict(int err) "err: %u"
>  xen_bus_realize(void) ""
>  xen_bus_unrealize(void) ""
>  xen_bus_enumerate(void) ""
> +xen_bus_cleanup(void) ""
>  xen_bus_type_enumerate(const char *type) "type: %s"
>  xen_bus_backend_create(const char *type, const char *path) "type: %s pat=
h: %s"
> +xen_bus_device_cleanup(const char *type, char *name) "type: %s name: %s"
>  xen_bus_add_watch(const char *node, const char *key) "node: %s key: %s"
>  xen_bus_remove_watch(const char *node, const char *key) "node: %s key: %=
s"
>  xen_device_realize(const char *type, char *name) "type: %s name: %s"
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 810a4e2df3..055beb7260 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -340,13 +340,18 @@ static void xen_bus_type_enumerate(XenBus *xenbus, =
const char *type)
>      for (i =3D 0; i < n; i++) {
>          char *backend_path =3D g_strdup_printf("%s/%s", domain_path,
>                                               backend[i]);
> -        enum xenbus_state backend_state;
> +        enum xenbus_state state;
> +        unsigned int online;
>=20
>          if (xs_node_scanf(xenbus->xsh, XBT_NULL, backend_path, "state",
> -                          NULL, "%u", &backend_state) !=3D 1)
> -            backend_state =3D XenbusStateUnknown;
> +                          NULL, "%u", &state) !=3D 1)
> +            state =3D XenbusStateUnknown;
>=20
> -        if (backend_state =3D=3D XenbusStateInitialising) {
> +        if (xs_node_scanf(xenbus->xsh, XBT_NULL, backend_path, "online",
> +                          NULL, "%u", &online) !=3D 1)
> +            online =3D 0;
> +
> +        if (online && state =3D=3D XenbusStateInitialising) {
>              Error *local_err =3D NULL;
>=20
>              xen_bus_backend_create(xenbus, type, backend[i], backend_pat=
h,
> @@ -365,9 +370,8 @@ out:
>      g_free(domain_path);
>  }
>=20
> -static void xen_bus_enumerate(void *opaque)
> +static void xen_bus_enumerate(XenBus *xenbus)
>  {
> -    XenBus *xenbus =3D opaque;
>      char **type;
>      unsigned int i, n;
>=20
> @@ -385,6 +389,44 @@ static void xen_bus_enumerate(void *opaque)
>      free(type);
>  }
>=20
> +static void xen_bus_device_cleanup(XenDevice *xendev)
> +{
> +    const char *type =3D object_get_typename(OBJECT(xendev));
> +    Error *local_err =3D NULL;
> +
> +    trace_xen_bus_device_cleanup(type, xendev->name);
> +
> +    g_assert(!xendev->backend_online);
> +
> +    if (!xen_backend_try_device_destroy(xendev, &local_err)) {
> +        object_unparent(OBJECT(xendev));
> +    }
> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
> +}
> +
> +static void xen_bus_cleanup(XenBus *xenbus)
> +{
> +    XenDevice *xendev, *next;
> +
> +    trace_xen_bus_cleanup();
> +
> +    QLIST_FOREACH_SAFE(xendev, &xenbus->offline_devices, list, next) {
> +        QLIST_REMOVE(xendev, list);
> +        xen_bus_device_cleanup(xendev);
> +    }
> +}
> +
> +static void xen_bus_backend_changed(void *opaque)
> +{
> +    XenBus *xenbus =3D opaque;
> +
> +    xen_bus_enumerate(xenbus);
> +    xen_bus_cleanup(xenbus);
> +}
> +
>  static void xen_bus_unrealize(BusState *bus, Error **errp)
>  {
>      XenBus *xenbus =3D XEN_BUS(bus);
> @@ -433,7 +475,7 @@ static void xen_bus_realize(BusState *bus, Error **er=
rp)
>=20
>      xenbus->backend_watch =3D
>          xen_bus_add_watch(xenbus, "", /* domain root node */
> -                          "backend", xen_bus_enumerate, &local_err);
> +                          "backend", xen_bus_backend_changed, &local_err=
);
>      if (local_err) {
>          /* This need not be treated as a hard error so don't propagate *=
/
>          error_reportf_err(local_err,
> @@ -555,9 +597,9 @@ static void xen_device_backend_set_online(XenDevice *=
xendev, bool online)
>   * Tell from the state whether the frontend is likely alive,
>   * i.e. it will react to a change of state of the backend.
>   */
> -static bool xen_device_state_is_active(enum xenbus_state state)
> +static bool xen_device_frontend_is_active(XenDevice *xendev)
>  {
> -    switch (state) {
> +    switch (xendev->frontend_state) {
>      case XenbusStateInitWait:
>      case XenbusStateInitialised:
>      case XenbusStateConnected:
> @@ -594,30 +636,29 @@ static void xen_device_backend_changed(void *opaque=
)
>       * state to Closing, but there is no active frontend then set the
>       * backend state to Closed.
>       */
> -    if (xendev->backend_state =3D=3D XenbusStateClosing &&
> -        !xen_device_state_is_active(xendev->frontend_state)) {
> +    if (state =3D=3D XenbusStateClosing &&
> +        !xen_device_frontend_is_active(xendev)) {
>          xen_device_backend_set_state(xendev, XenbusStateClosed);
>      }
>=20
>      /*
>       * If a backend is still 'online' then we should leave it alone but,
> -     * if a backend is not 'online', then the device should be destroyed
> -     * once the state is Closed.
> +     * if a backend is not 'online', then the device is a candidate
> +     * for destruction. Hence add it to the 'offline' list to be cleaned
> +     * by xen_bus_cleanup().
>       */
> -    if (!xendev->backend_online &&
> -        (xendev->backend_state =3D=3D XenbusStateClosed ||
> -         xendev->backend_state =3D=3D XenbusStateInitialising ||
> -         xendev->backend_state =3D=3D XenbusStateInitWait ||
> -         xendev->backend_state =3D=3D XenbusStateUnknown)) {
> -        Error *local_err =3D NULL;
> +    if (!online &&
> +        (state =3D=3D XenbusStateClosed ||  state =3D=3D XenbusStateInit=
ialising ||
> +         state =3D=3D XenbusStateInitWait || state =3D=3D XenbusStateUnk=
nown)) {
> +        XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>=20
> -        if (!xen_backend_try_device_destroy(xendev, &local_err)) {
> -            object_unparent(OBJECT(xendev));
> -        }
> +        QLIST_INSERT_HEAD(&xenbus->offline_devices, xendev, list);

I realize now that I should have a check here to make sure the above does n=
ot happen twice. I'll send a v2.

  Paul

>=20
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> +        /*
> +         * Re-write the state to cause a XenBus backend_watch notificati=
on,
> +         * resulting in a call to xen_bus_cleanup().
> +         */
> +        xen_device_backend_printf(xendev, "state", "%u", state);
>      }
>  }
>=20
> diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
> index 0d198148f6..15d71aff70 100644
> --- a/include/hw/xen/xen-bus.h
> +++ b/include/hw/xen/xen-bus.h
> @@ -33,6 +33,7 @@ typedef struct XenDevice {
>      xengnttab_handle *xgth;
>      bool feature_grant_copy;
>      QLIST_HEAD(, XenEventChannel) event_channels;
> +    QLIST_ENTRY(XenDevice) list;
>  } XenDevice;
>=20
>  typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
> @@ -68,6 +69,7 @@ typedef struct XenBus {
>      struct xs_handle *xsh;
>      XenWatchList *watch_list;
>      XenWatch *backend_watch;
> +    QLIST_HEAD(, XenDevice) offline_devices;
>  } XenBus;
>=20
>  typedef struct XenBusClass {
> --
> 2.20.1.2.gb21ebb6


