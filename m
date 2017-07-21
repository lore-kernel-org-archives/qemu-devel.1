Received: from eggs.gnu.org ([2001:4830:134:3::10]:41993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZGJ-000136-1T
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZGF-0005BK-Q3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYZGF-0005Ah-Ge
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:50:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B4B84E33A
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:50:34 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0c08f67-c180-ea20-852d-011376d2b5c5@redhat.com>
Date: Fri, 21 Jul 2017 09:50:33 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EkupgRouJ8CFiJMsuVV6ulfCemKJer3fV"
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EkupgRouJ8CFiJMsuVV6ulfCemKJer3fV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d0c08f67-c180-ea20-852d-011376d2b5c5@redhat.com>
Subject: Re: [PATCH 5/9] tests/libqos/usb: Clean up string interpolation into
 QMP input
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the previous commit.
>=20
> The case in usb_test_hotplug() slightly more complicated: it

s/()/() is/

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
> @@ -40,18 +40,20 @@ void uhci_port_test(struct qhc *hc, int port, uint1=
6_t expect)
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

I know this fits, but do any of our compilers issue dumb warnings about
possible buffer overflow?  I guess we'll deal with that if someone
reports a problem.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EkupgRouJ8CFiJMsuVV6ulfCemKJer3fV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyFLkACgkQp6FrSiUn
Q2poUQgAhx1L13lE68WTsLnbcbPJ4IuFSGBsl1tCJJCoh/WB8YlZGTZ7v7B/pzI1
HuJrI+RodCXBgEqjNpb8CGBcvomC+RdtVse8Kcbld3phXrZeDywIz0BDaLwyIh7E
+AIriwry5/AQTKTkKrrErnw7mJNzO0F5i34WCUhhJ+KkHb9NwLISCDV4uwCFUWWo
3UP1AFLsiujUzCOjk+20OUZBHgc6NCA8xrMopg6NJsm+3qj7ZBCybkXj96qr+yHK
t7E1GvnrrVkeMWERpDy2UJctlOXv4KmDSbwdP8jWY2kA50sioaPDCaYk8Wx8Yae6
X1dPWPPdmnnpSK03kUMmjI2w/29CvA==
=FzZp
-----END PGP SIGNATURE-----

--EkupgRouJ8CFiJMsuVV6ulfCemKJer3fV--
