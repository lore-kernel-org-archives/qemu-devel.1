Received: from eggs.gnu.org ([2001:4830:134:3::10]:59506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctbH9-0001qE-H3
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctbH8-0008VF-Ac
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:42:11 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com>
Date: Thu, 30 Mar 2017 09:42:00 -0500
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RLLQa5EwI8xs7bq2SJexLo7CiggslJ2ln"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 07/10] sockets: New helper
 socket_address_crumple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RLLQa5EwI8xs7bq2SJexLo7CiggslJ2ln
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com>
Subject: Re: [RFC v2 for-2.9 07/10] sockets: New helper
 socket_address_crumple()
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:15 AM, Markus Armbruster wrote:
> SocketAddress is a simple union, and simple unions are awkward: they
> have their variant members wrapped in a "data" object on the wire, and
> require additional indirections in C.  I intend to limit its use to
> existing external interfaces.  New ones should use SocketAddressFlat.
> I further intend to convert all internal interfaces to
> SocketAddressFlat.  This helper should go away then.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/sockets.h | 11 +++++++++++
>  util/qemu-sockets.c    | 29 +++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>=20
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 5f1bab9..cef05a5 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -119,4 +119,15 @@ SocketAddress *socket_remote_address(int fd, Error=
 **errp);
>   */
>  char *socket_address_to_string(struct SocketAddress *addr, Error **err=
p);
> =20
> +/**
> + * socket_address_crumple:
> + * @addr_flat: the socket addres to crumple

s/addres/address/

> +SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
> +{
> +    SocketAddress *addr =3D g_new(SocketAddress, 1);
> +
> +    addr->type =3D addr_flat->type;

Works only because our enum is defined in the same order as the simple
union's members.  A bit fragile, so maybe we want to comment in the
=2Ejson file that we can't reorder members of either the enum or the
simple union's 'data'?  Or it might even tickle a picky compiler to warn
about assignment between incompatible enum types.  Another option would
be making it robust by instead doing switch(addr_flat->type) and
assigning to addr->type in each branch of the switch.

> +    switch (addr->type) {
> +    case SOCKET_ADDRESS_FLAT_TYPE_INET:
> +        addr->u.inet.data =3D QAPI_CLONE(InetSocketAddress,
> +                                        &addr_flat->u.inet);

Indentation is off.

> +        break;
> +    case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
> +        addr->u.q_unix.data =3D QAPI_CLONE(UnixSocketAddress, &
> +                                          addr_flat->u.q_unix);

Why is the unary & split from its argument?

> +        break;
> +    case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
> +        addr->u.vsock.data =3D QAPI_CLONE(VsockSocketAddress,
> +                                         &addr_flat->u.vsock);

More indentation problems.

> +        break;
> +    case SOCKET_ADDRESS_FLAT_TYPE_FD:
> +        addr->u.fd.data =3D QAPI_CLONE(String, &addr_flat->u.fd);
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    return addr;
> +}
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--RLLQa5EwI8xs7bq2SJexLo7CiggslJ2ln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3Rk4AAoJEKeha0olJ0Nq55kH/2fjiyKszpwECHF5NVZpVsib
t1zawcP5QvfbInh5ygqj1iC+Zk8RH3HFLa8S2Eb62aubgOzUVNdH2X/UlrdnIqj1
QtAnZOCQN2RFlfoLERW70x3PlbbNVyZPOoJP0LYRY94rcQmpcYQkhk+dKfJuNVw2
mASIZyhNtJNaOBiue+bycfxC8OXki7Gs89gRpiC+kGMAdEV/uUbgQWv7c7AuI+x9
9C6DeJoPZEdEhaiD2DWV4iR1L8ISFNCXMpVOVraHIr34bqII6TitHeEf2CjuXvpV
oMJObxlSoxnPhOYDOvIIehBbwXp1BM5zyg0b4aormqFxtywygvPlXe2ws2dJRhI=
=t/cC
-----END PGP SIGNATURE-----

--RLLQa5EwI8xs7bq2SJexLo7CiggslJ2ln--
