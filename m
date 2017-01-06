Received: from eggs.gnu.org ([2001:4830:134:3::10]:56441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXT9-00073V-7t
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXT4-0006wS-BX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:34:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPXT4-0006vk-2r
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:34:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22866C056793
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:34:14 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fb1d736-aef5-ef03-ca11-7caf1b8a6e9d@redhat.com>
Date: Fri, 6 Jan 2017 10:34:11 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kEKuNRHxES2cs8UtNfhJ4PlkTqsJlxCpj"
Subject: Re: [Qemu-devel] [PATCH 8/8] ui: add ability to specify multiple
 VNC listen addresses
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
--kEKuNRHxES2cs8UtNfhJ4PlkTqsJlxCpj
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <7fb1d736-aef5-ef03-ca11-7caf1b8a6e9d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] ui: add ability to specify multiple VNC
 listen addresses
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-9-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:07 AM, Daniel P. Berrange wrote:
> This change allows the listen address and websocket address
> options for -vnc to be repeated. This causes the VNC server
> to listen on multiple addresses. e.g.
>=20
>  $ $QEMU -vnc vnc=3Dlocalhost:1,vnc=3Dunix:/tmp/vnc,\
>               websocket=3D127.0.0.1:8080,websocket=3D[::]:8081
>=20
> results in listening on
>=20
> 127.0.0.1:5901, 127.0.0.1:8080, ::1:5901, :::8081 & /tmp/vnc
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc.c | 191 +++++++++++++++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 130 insertions(+), 61 deletions(-)
>=20

> +    for (i =3D 0; i < nsaddrstr; i++) {
> +        int rv;
> +        rv =3D vnc_display_get_address(saddrstr[i], false, 0, to,
> +                                     has_ipv4, has_ipv6,
> +                                     ipv4, ipv6,
> +                                     &saddr, errp);
> +        if (rv < 0) {
> +            goto cleanup;
> +        }
> +        /* Historical compat - if only a single listen address was
> +         * provided, then the display num can be used to set the
> +         * default websocket port
> +         */
> +        if (nsaddrstr =3D=3D 1) {
> +            displaynum =3D rv;
> +        }
> +        *retsaddr =3D g_renew(SocketAddress *, *retsaddr, *retnsaddr +=
 1);
> +        (*retsaddr)[(*retnsaddr)++] =3D saddr;

Again, do we care if the user supplies LOTS of vnc addresses and
witnesses O(n^2) initialization cost?

>      }
> -    if (wsaddrstr) {
> -        if (vnc_display_get_address(wsaddrstr, true, displaynum, to,
> +    for (i =3D 0; i < nwsaddrstr; i++) {
> +        if (vnc_display_get_address(wsaddrstr[i], true, displaynum, to=
,
>                                      has_ipv4, has_ipv6,

> +
> +        *retwsaddr =3D g_renew(SocketAddress *, *retwsaddr, *retnwsadd=
r + 1);
> +        (*retwsaddr)[(*retnwsaddr)++] =3D wsaddr;

Same for websocket addresses.

>  static int vnc_display_connect(VncDisplay *vd,
> -                               SocketAddress *saddr,
> -                               SocketAddress *wsaddr,
> +                               SocketAddress **saddr,
> +                               size_t nsaddr,
> +                               SocketAddress **wsaddr,
> +                               size_t nwsaddr,
>                                 Error **errp)
>  {
>      /* connect to viewer */
>      QIOChannelSocket *sioc =3D NULL;
> -    if (wsaddr) {
> +    if (nwsaddr !=3D 0) {
>          error_setg(errp, "Cannot use websockets in reverse mode");
>          return -1;
>      }
> -    vd->is_unix =3D saddr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
> +    if (nsaddr !=3D 1) {
> +        error_setg(errp, "Expected a single address in reverse mo");

s/mo/mode/


>  static int vnc_display_listen(VncDisplay *vd,

> -    if (wsaddr &&
> -        vnc_display_listen_addr(vd, wsaddr,
> -                                "vnc-ws-listen",
> -                                &vd->lwebsock,
> -                                &vd->lwebsock_tag,
> -                                &vd->nlwebsock,
> -                                errp) < 0) {
> -        return -1;
> +    for (i =3D 0; i < nwsaddr; i++) {
> +        if (vnc_display_listen_addr(vd, wsaddr[i],
> +                                    "vnc-ws-listen",
> +                                    &vd->lwebsock,
> +                                    &vd->lwebsock_tag,
> +                                    &vd->nlwebsock,
> +                                    errp) < 0) {

And while your earlier arguments that resolving a single name into
multiple websocket IP addrs is not going to notice an O(n^2) growth
pattern, now we are calling that growth pattern over N websocket names
where N is user-controlled.  But this time I don't have a good bound on
how many IP addrs nlwebsock will grow to. So maybe we do want to
consider geometric allocation growth (requires tracking and passing an
allocated size alongside the currently-used size).

But overall I think you're enhancement makes sense.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kEKuNRHxES2cs8UtNfhJ4PlkTqsJlxCpj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb8cDAAoJEKeha0olJ0Nq3FoIAItG2TnrTdaQqra0WXbALz1M
8r+MMO2NbETCIFfEKw2SiPUAT75C6cmuhKJYZ1tYWLJlHDmv63oGkUMcV2R/6hjX
DnrqmbhtbhXZFXkprqXr5ZBkndkQGuYE/Bv1yrxqiZoK/QIBoqN+zagdGN2dENZE
qGqjHyFV08jyLydAvNwXgiWl+b4kqZoJiZFmxHXiDNrGhNVsxbDG7Bql1IZVYLsn
DRxDU1d5qCy88ka+kHQ9X1HL61BlOmUxLWUEALB2bodokGNZKMLWO7A/AefzwC51
EndfQ0F9FVkApMzCJ+fD6kzz57d0BrV6LSPFUY1NG79hSPIkVg/M6uE6zXChjvs=
=2mQN
-----END PGP SIGNATURE-----

--kEKuNRHxES2cs8UtNfhJ4PlkTqsJlxCpj--
