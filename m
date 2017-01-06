Received: from eggs.gnu.org ([2001:4830:134:3::10]:45086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPWjp-0001QO-AQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPWjo-0000k3-88
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:47:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPWjn-0000io-Up
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:47:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE47A7FD41
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:47:27 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5fa7e668-053a-e07a-e04a-f836fd8ca6a5@redhat.com>
Date: Fri, 6 Jan 2017 09:47:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L3saHAvfR8S9rnIsnPggK47kh65xLr4q3"
Subject: Re: [Qemu-devel] [PATCH 4/8] ui: refactor code for populating
 SocketAddress from vnc_display_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L3saHAvfR8S9rnIsnPggK47kh65xLr4q3
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <5fa7e668-053a-e07a-e04a-f836fd8ca6a5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] ui: refactor code for populating
 SocketAddress from vnc_display_open
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-5-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:06 AM, Daniel P. Berrange wrote:
> The code which interprets the CLI args to populate the SocketAddress
> objects for plain & websockets VNC is quite complex already and will
> need further enhancements shortly. Refactor it into separate methods
> to avoid vnc_display_open getting even larger. As a side effect of
> the refactoring, it is now possible to specify a listen address for
> the websocket server explicitly. e.g,
>=20
>   -vnc localhost:5900,websockets=3D0.0.0.0:8080
>=20
> will listen on localhost for the plain VNC server, but expose the
> websockets VNC server on the public interface. This refactoring
> also removes the restriction that prevents enabling websockets
> when the plain VNC server is listening on a UNIX socket.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-options.hx |  12 ++-
>  ui/vnc.c        | 282 ++++++++++++++++++++++++++++++++++++------------=
--------
>  2 files changed, 189 insertions(+), 105 deletions(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c534a2f..7470def 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1297,10 +1297,14 @@ is a TCP port number, not a display number.
>  @item websocket
> =20
>  Opens an additional TCP listening port dedicated to VNC Websocket conn=
ections.
> -By definition the Websocket port is 5700+@var{display}. If @var{host} =
is
> -specified connections will only be allowed from this host.
> -As an alternative the Websocket port could be specified by using
> -@code{websocket}=3D@var{port}.
> +If a bare @var{websocket} option is given, the Websocket port is
> +5700+@var{display}. An alternative port can be specified with the
> +syntax @code{websocket}=3D@var{port}.
> +
> +If @var{host} is specified connections will only be allowed from this =
host.
> +It is possible to control the websocket listen address independantly u=
sing

s/independantly/independently,/

> +the syntax @code{websocket}=3D@var{host}:@var{port}.
> +
>  If no TLS credentials are provided, the websocket connection runs in
>  unencrypted mode. If TLS credentials are provided, the websocket conne=
ction
>  requires encrypted client connections.
> diff --git a/ui/vnc.c b/ui/vnc.c
> index b37aab4..8d3f9c1 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3519,6 +3519,178 @@ vnc_display_create_creds(bool x509,
>  }
> =20
> =20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--L3saHAvfR8S9rnIsnPggK47kh65xLr4q3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb7wNAAoJEKeha0olJ0Nq90oH/At+mYY6zbhyiwcUGfmX0wpT
JH0IeVjboVayf8InTYITlO2WT1MKWDXchsdQmxGDdZugXiJRiJo+mgcK54+wxvYN
Vz3x3KGD4xPH+kQNgCGkhUsUiP77izmLWqIWq6FVF7rP6n75mqFsaEaS+NQpqv8h
dp9n2p/AxkYxlSkCHXGGAAzvObWd6oizVWYS9My8UNBDVjUSkx8cgnVCn7bzO4hX
kQUHNDPJt2k9skCWxS3rafLKtxzDbP2LwOdKP06HwX1kq7cR4jNf6meinphy1FRw
JPDTGoZX7OTMjktXsixcCJHUu8PVdAz13iTWBmVXVCPwwZk+1lKdBVOYMK2W6qQ=
=nJX1
-----END PGP SIGNATURE-----

--L3saHAvfR8S9rnIsnPggK47kh65xLr4q3--
