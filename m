Received: from eggs.gnu.org ([2001:4830:134:3::10]:43386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctblM-0000zk-Tc
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctblL-0005Bd-VR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:24 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-8-git-send-email-armbru@redhat.com>
	<b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com>
	<87inmqzu1b.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0c2c6b6-5925-2a75-3ad7-2dd446ea04c6@redhat.com>
Date: Thu, 30 Mar 2017 10:13:11 -0500
MIME-Version: 1.0
In-Reply-To: <87inmqzu1b.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7TF3AKd5mbxvMApqDVLHr14vG2fGsXals"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7TF3AKd5mbxvMApqDVLHr14vG2fGsXals
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, namei.unix@gmail.com
Message-ID: <f0c2c6b6-5925-2a75-3ad7-2dd446ea04c6@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 07/10] sockets: New helper
 socket_address_crumple()
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-8-git-send-email-armbru@redhat.com>
 <b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com>
 <87inmqzu1b.fsf@dusky.pond.sub.org>
In-Reply-To: <87inmqzu1b.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 10:03 AM, Markus Armbruster wrote:

>>> +SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
>>> +{
>>> +    SocketAddress *addr =3D g_new(SocketAddress, 1);
>>> +
>>> +    addr->type =3D addr_flat->type;
>>
>> Works only because our enum is defined in the same order as the simple=

>> union's members.  A bit fragile, so maybe we want to comment in the
>> .json file that we can't reorder members of either the enum or the
>> simple union's 'data'?  Or it might even tickle a picky compiler to wa=
rn
>> about assignment between incompatible enum types.  Another option woul=
d
>> be making it robust by instead doing switch(addr_flat->type) and
>> assigning to addr->type in each branch of the switch.
>=20
> Sold.
>=20

> Now looks like this:
>=20
> SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
> {
>     SocketAddress *addr =3D g_new(SocketAddress, 1);
>=20
>     switch (addr_flat->type) {
>     case SOCKET_ADDRESS_FLAT_TYPE_INET:
>         addr->type =3D SOCKET_ADDRESS_KIND_INET;
>         addr->u.inet.data =3D QAPI_CLONE(InetSocketAddress,
>                                        &addr_flat->u.inet);
>         break;

Yes, that's better, and no tweaks to the .json file needed.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7TF3AKd5mbxvMApqDVLHr14vG2fGsXals
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3SCHAAoJEKeha0olJ0NqWRQH/1WDQF3mSBJGmX8/YXYsmQHn
SLWRs1Bkt+Ol9lGFwZrRp1zKOGnDd7+BzvQV+Ys640ucURnOZmXfg6627FwoBDPp
9Hh/THNfxLo0tsYSoMDz06Li7ntH2nOlwc88ySBlnLvpGTQdm0vxDqvFnOAjczWD
GkDhLFbX6Pma+iU4bBVuBE6YBd+9N6Munq2I3kMibOrpkqt80as9S/XNhDMQpmCV
4vzS1EBn6RFdfo/PLlLyZHUQb7dV6FyW90pT657p+65tZmplgD5cxr9yn1yVjcQJ
XfCJMDYglyMFbmZxdjpm6G7jxrhMjyko76uaO2R9dxUdup2EcodAd/u8tLQ33w8=
=btkn
-----END PGP SIGNATURE-----

--7TF3AKd5mbxvMApqDVLHr14vG2fGsXals--
