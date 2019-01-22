Received: from eggs.gnu.org ([209.51.188.92]:48734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm16W-0005vG-RE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm16Q-0006YA-QO
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:48:56 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:35363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm16P-000679-UI
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:48:50 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 22 Jan 2019 15:38:26 +0000
Message-ID: <36a27f84261e42608b006bb06d1a661a@AMSPEX02CL03.citrite.net>
References: <20190122144028.11518-1-paul.durrant@citrix.com>
In-Reply-To: <20190122144028.11518-1-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen: fix xen-bus state model to allow
 frontend re-connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 22 January 2019 14:40
> To: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>
> Subject: [PATCH] xen: fix xen-bus state model to allow frontend re-
> connection
>=20
> There is a flaw in the xen-bus state model. To allow a frontend to re-
> connect the backend state of an online XenDevice is transitioned from
> Closed to InitWait, but this is currently done unilaterally which is
> incorrect. The backend state should remain Closed until the frontend stat=
e
> transitions to Initialising.
>=20
> This patch removes the automatic backend state transition from
> xen_device_backend_state_changed() and, instead, adds an extra check in
> xen_device_frontend_state_changed() to determine whether a frontend is
> trying to re-connect to a previously Closed XenDevice. Only if this is
> found to be the case is the backend state transitioned from Closed to
> InitWait. Note that this transition will be common amongst all XenDevice
> classes and hence xen_device_frontend_state_changed() returns immediately
> afterwards without calling into the XenDeviceClass frontend_changed()
> method.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Unfortunately this is still not quite right. Further testing has now shown =
that xl block-detach is no longer working properly. I'll send a v2 once tha=
t is fixed.

  Paul

> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> ---
>  hw/xen/xen-bus.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 3aeccec69c..1b31a1dc50 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -547,20 +547,12 @@ static void xen_device_backend_changed(void *opaque=
)
>      }
>=20
>      /*
> -     * If a backend is still 'online' then its state should be cycled
> -     * back round to InitWait in order for a new frontend instance to
> -     * connect. This may happen when, for example, a frontend driver is
> -     * re-installed or updated.
> -     * If a backend is not 'online' then the device should be destroyed.
> +     * If a backend is still 'online' then we should leave it alone but,
> +     * if a backend is not 'online', then the device should be destroyed
> +     * once the state is Closed.
>       */
> -    if (xendev->backend_online &&
> +    if (!xendev->backend_online &&
>          xendev->backend_state =3D=3D XenbusStateClosed) {
> -        xen_device_backend_set_state(xendev, XenbusStateInitWait);
> -    } else if (!xendev->backend_online &&
> -               (xendev->backend_state =3D=3D XenbusStateClosed ||
> -                xendev->backend_state =3D=3D XenbusStateInitialising ||
> -                xendev->backend_state =3D=3D XenbusStateInitWait ||
> -                xendev->backend_state =3D=3D XenbusStateUnknown)) {
>          Error *local_err =3D NULL;
>=20
>          if (!xen_backend_try_device_destroy(xendev, &local_err)) {
> @@ -715,6 +707,17 @@ static void xen_device_frontend_changed(void *opaque=
)
>=20
>      xen_device_frontend_set_state(xendev, state);
>=20
> +    if (state =3D=3D XenbusStateInitialising &&
> +        xendev->backend_state =3D=3D XenbusStateClosed &&
> +        xendev->backend_online) {
> +        /*
> +         * The frontend is re-initializing so switch back to
> +         * InitWait.
> +         */
> +        xen_device_backend_set_state(xendev, XenbusStateInitWait);
> +        return;
> +    }
> +
>      if (xendev_class->frontend_changed) {
>          Error *local_err =3D NULL;
>=20
> --
> 2.20.1.2.gb21ebb6
