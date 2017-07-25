Received: from eggs.gnu.org ([2001:4830:134:3::10]:52432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0QL-0006AM-FU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0QI-0007pS-Cx
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:02:57 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0QI-0007p8-5K
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:02:54 -0400
Received: by mail-wr0-x244.google.com with SMTP id 12so11927348wrb.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:02:54 -0700 (PDT)
Date: Tue, 25 Jul 2017 15:02:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725140250.GK23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-6-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-6-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/9] tests/libqos/usb: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:22PM +0200, Markus Armbruster wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the previous commit.
>=20
> The case in usb_test_hotplug() slightly more complicated: it
> interpolates *into* JSON values.  Clean it up by building the values
> separately, so we can again leave interpolation to qmp().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqos/usb.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>=20
> diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
> index 0cdfaec..f88d4a6 100644
> --- a/tests/libqos/usb.c
> +++ b/tests/libqos/usb.c
> @@ -40,18 +40,20 @@ void uhci_port_test(struct qhc *hc, int port, uint16_=
t expect)
>  void usb_test_hotplug(const char *hcd_id, const int port,
>                        void (*port_check)(void))
>  {
> +    char id[32];
> +    char *bus;
>      QDict *response;
> -    char  *cmd;
> =20
> -    cmd =3D g_strdup_printf("{'execute': 'device_add',"
> -                          " 'arguments': {"
> -                          "   'driver': 'usb-tablet',"
> -                          "   'port': '%d',"
> -                          "   'bus': '%s.0',"
> -                          "   'id': 'usbdev%d'"
> -                          "}}", port, hcd_id, port);
> -    response =3D qmp(cmd);
> -    g_free(cmd);
> +    sprintf(id, "usbdev%d", port);
> +    bus =3D g_strdup_printf("%s.0", hcd_id);
> +    response =3D qmp("{'execute': 'device_add',"
> +                   " 'arguments': {"
> +                   "   'driver': 'usb-tablet',"
> +                   "   'port': %s,"
> +                   "   'bus': %s,"
> +                   "   'id': %s"
> +                   " }}", id + 6, bus, id);

Or: id + strlen("usbdev")

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd0+KAAoJEJykq7OBq3PILfcIAIabO5eVkcDq3YAPUOFNmw13
CqFXLGMVxOVJOtC4hCjLfvPjnsHDU6BL8baAwx42h9tl0I0fJUk9F519EdwEyd/F
U1LFmwWolv46FK5Pb5/5KivQg1jzexgmAZwWdw9n9aPK8Dc6QoGFn0CyoYTEMx0s
ZJgFjn/+aq1OWA+UQ7py8ZK/vuo2KfVgaMlNcmpJB05BGWl1H6tkA/26X7T5uLYy
rl8myVLmTWD7O1G8aGlw317OoaOXbcUbP0FA9W9M+2iGM3qi7HFJdSdzMiJKO5Fm
s4ZPrt9McFa8mCy68HvqKYGp/wXuGqg8ZnudIrdMCcu5F1GCxyRpFYgfljiskGk=
=Kfzz
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--
