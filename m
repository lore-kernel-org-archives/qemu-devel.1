Received: from eggs.gnu.org ([2001:4830:134:3::10]:58245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctZu3-0001xt-9j
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctZu2-0001Su-4B
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:14:15 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-7-git-send-email-armbru@redhat.com>
	<7caffda9-7cbb-4044-7b6a-e398ffa125a6@redhat.com>
	<877f37fe44.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0f5ea3f-5f6e-cd73-6fe7-5269d2e0da5e@redhat.com>
Date: Thu, 30 Mar 2017 08:14:02 -0500
MIME-Version: 1.0
In-Reply-To: <877f37fe44.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d1nO36JOmJCHahXR6mwf6ub61A1S6g9Xa"
Subject: Re: [Qemu-devel] [for-2.9 6/8] qapi-schema: SocketAddressFlat
 variants 'vsock' and 'fd'
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
--d1nO36JOmJCHahXR6mwf6ub61A1S6g9Xa
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, namei.unix@gmail.com
Message-ID: <a0f5ea3f-5f6e-cd73-6fe7-5269d2e0da5e@redhat.com>
Subject: Re: [Qemu-devel] [for-2.9 6/8] qapi-schema: SocketAddressFlat
 variants 'vsock' and 'fd'
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-7-git-send-email-armbru@redhat.com>
 <7caffda9-7cbb-4044-7b6a-e398ffa125a6@redhat.com>
 <877f37fe44.fsf@dusky.pond.sub.org>
In-Reply-To: <877f37fe44.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 01:55 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/29/2017 11:45 AM, Markus Armbruster wrote:
>>> Note that the new variants are impossible in qemu_gluster_glfs_init()=
,
>>> because the gconf->server can only come from qemu_gluster_parse_uri()=

>>> or qemu_gluster_parse_json(), and neither can create anything but
>>> 'tcp' or 'unix'.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  block/gluster.c  |  2 ++
>>>  qapi-schema.json | 19 ++++++++-----------
>>>  2 files changed, 10 insertions(+), 11 deletions(-)
>>
>>> +# This is just like SocketAddress, except it's a flat union rather
>>> +# than a simple union.  Nicer because it avoids nesting (i.e. more {=
})
>>> +# on the wire.
>>>  #
>>>  # Since: 2.9
>>>  ##
>>>  { 'union': 'SocketAddressFlat',
>>>    'base': { 'type': 'SocketAddressFlatType' },
>>>    'discriminator': 'type',
>>> -  'data': { 'unix': 'UnixSocketAddress',
>>> -            'inet': 'InetSocketAddress' } }
>>> +  'data': { 'inet': 'InetSocketAddress',
>>> +            'unix': 'UnixSocketAddress',
>>> +            'vsock': 'VsockSocketAddress',
>>> +            'fd': 'String' } }
>>
>> Can we make 'fd':'str'?  That would be even less pointless nesting on
>> the wire.
>=20
> I guess it's wrapped in an object here to keep the door open for
> future extensions.  Perhaps also for symmetry.

And I just reminded myself of the restrictions on flat unions:

"A flat union definition avoids nesting on the wire, and specifies a
set of common members that occur in all variants of the union.  The
'base' key must specify either a type name (the type must be a
struct, not a union), or a dictionary representing an anonymous type.
All branches of the union must be complex types, "

So the end result is that as written, you pass "addr":{"type":"fd",
"str":"name_of_fd"}; and we can't use 'fd':'str' in the schema after all.=


With the fix that Max pointed out,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--d1nO36JOmJCHahXR6mwf6ub61A1S6g9Xa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3QSaAAoJEKeha0olJ0NqKXkH/RZ5NkzxW1q157bK7nRXdt1j
3C5F3tjMM45673uJcCmiiiQ+ZfGKmAyTL+TzO3aRwSOhmjJ41lFEhbx0IKdSr3e5
F88dhY9oeUKIX9or/Z7GZ8TMs6x3B6jBeoZXo6rvsY1AImbf3A+HS77D5g6c4BzT
rkOVP8+Jy8i28mKcWjTixYyyP7C3mHpwo8jIzWPX7EOKIQ+2O6hdiOwrC/HEMxrJ
NKsM0VktMe5JLhv3K039USVnyKanaxRtYKMATq123MDO6b1rHknb+jXftJ9M3/TZ
yK+hEmkS1jMLNCggRkf+yvgZeaXBwCknuqQHWTQXSXBkDDGr2uwLx5F+nQPEWUI=
=BixQ
-----END PGP SIGNATURE-----

--d1nO36JOmJCHahXR6mwf6ub61A1S6g9Xa--
