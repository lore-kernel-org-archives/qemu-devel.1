Received: from eggs.gnu.org ([2001:4830:134:3::10]:37869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctcoN-0005UQ-0j
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctcoL-00058K-Vx
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:20:35 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-8-git-send-email-armbru@redhat.com>
	<b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com>
	<87inmqzu1b.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c97fe415-31a7-d9c0-a647-56c4e94eb376@redhat.com>
Date: Thu, 30 Mar 2017 18:20:11 +0200
MIME-Version: 1.0
In-Reply-To: <87inmqzu1b.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I9ep1JtCTJE6ggqWvi9PCgSntJ6qGTCT3"
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
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I9ep1JtCTJE6ggqWvi9PCgSntJ6qGTCT3
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com,
 namei.unix@gmail.com
Message-ID: <c97fe415-31a7-d9c0-a647-56c4e94eb376@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 07/10] sockets: New helper
 socket_address_crumple()
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-8-git-send-email-armbru@redhat.com>
 <b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com>
 <87inmqzu1b.fsf@dusky.pond.sub.org>
In-Reply-To: <87inmqzu1b.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 17:03, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/30/2017 08:15 AM, Markus Armbruster wrote:
>>> SocketAddress is a simple union, and simple unions are awkward: they
>>> have their variant members wrapped in a "data" object on the wire, an=
d
>>> require additional indirections in C.  I intend to limit its use to
>>> existing external interfaces.  New ones should use SocketAddressFlat.=

>>> I further intend to convert all internal interfaces to
>>> SocketAddressFlat.  This helper should go away then.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  include/qemu/sockets.h | 11 +++++++++++
>>>  util/qemu-sockets.c    | 29 +++++++++++++++++++++++++++++
>>>  2 files changed, 40 insertions(+)
>>>
>>> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>>> index 5f1bab9..cef05a5 100644
>>> --- a/include/qemu/sockets.h
>>> +++ b/include/qemu/sockets.h
>>> @@ -119,4 +119,15 @@ SocketAddress *socket_remote_address(int fd, Err=
or **errp);
>>>   */
>>>  char *socket_address_to_string(struct SocketAddress *addr, Error **e=
rrp);
>>> =20
>>> +/**
>>> + * socket_address_crumple:
>>> + * @addr_flat: the socket addres to crumple
>>
>> s/addres/address/
>=20
> Fixing...
>=20
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
>>> +    switch (addr->type) {
>>> +    case SOCKET_ADDRESS_FLAT_TYPE_INET:
>>> +        addr->u.inet.data =3D QAPI_CLONE(InetSocketAddress,
>>> +                                        &addr_flat->u.inet);
>>
>> Indentation is off.
>=20
>>> +        break;
>>> +    case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
>>> +        addr->u.q_unix.data =3D QAPI_CLONE(UnixSocketAddress, &
>>> +                                          addr_flat->u.q_unix);
>>
>> Why is the unary & split from its argument?
>=20
> Editing accident.
>=20
>>> +        break;
>>> +    case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
>>> +        addr->u.vsock.data =3D QAPI_CLONE(VsockSocketAddress,
>>> +                                         &addr_flat->u.vsock);
>>
>> More indentation problems.
>>
>>> +        break;
>>> +    case SOCKET_ADDRESS_FLAT_TYPE_FD:
>>> +        addr->u.fd.data =3D QAPI_CLONE(String, &addr_flat->u.fd);
>>> +        break;
>>> +    default:
>>> +        abort();
>>> +    }
>>> +
>>> +    return addr;
>>> +}
>>>
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
>     case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
>         addr->type =3D SOCKET_ADDRESS_KIND_UNIX;
>         addr->u.q_unix.data =3D QAPI_CLONE(UnixSocketAddress,
>                                          &addr_flat->u.q_unix);
>         break;
>     case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
>         addr->type =3D SOCKET_ADDRESS_KIND_VSOCK;
>         addr->u.vsock.data =3D QAPI_CLONE(VsockSocketAddress,
>                                         &addr_flat->u.vsock);
>         break;
>     case SOCKET_ADDRESS_FLAT_TYPE_FD:
>         addr->type =3D SOCKET_ADDRESS_KIND_FD;
>         addr->u.fd.data =3D QAPI_CLONE(String, &addr_flat->u.fd);
>         break;
>     default:
>         abort();
>     }
>=20
>     return addr;
> }

Looks good!

Max


--I9ep1JtCTJE6ggqWvi9PCgSntJ6qGTCT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdMDsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjhAIALiW+ZKtHZu0l68zgpxhOIwO7ReK4JO7
0qlJJyGosbj71Hf+R1QC1xj4KBc/Hmt/SPMFPerOvct0fHxGK3yn+ntcMEf2OqUz
FIm7ln7osWNPywcIgWu7h1WZNR4Hva9jJx2sVXxmNfeICtBkUCAeOOQtOzXllkPy
JTDrEOMLy9IFKAdc1lu8fdBoJFqF2GJFs1Oy/1wfpXNKuS/UypkTfBo9CzfxIZYD
IZ3Ru8kVgoz2vbBdj09Fg2gSbux7jMR8CJMgEdWGD5PEOAQcfIa9lHXbc5RxY94w
rrIRG4MuKoTtVPNWyJXe4yzsvX2tH6fa3mXNX/KVto3GidZVK27BgAM=
=mGLq
-----END PGP SIGNATURE-----

--I9ep1JtCTJE6ggqWvi9PCgSntJ6qGTCT3--
