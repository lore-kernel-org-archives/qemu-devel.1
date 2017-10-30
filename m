Received: from eggs.gnu.org ([2001:4830:134:3::10]:46070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9GxG-00060u-HJ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9GxF-0001ig-Dn
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:46:42 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-7-eblake@redhat.com>
	<59449c29-0335-9eaf-47a6-edd6cc35bf73@virtuozzo.com>
	<5b8fbdd6-c3cd-aed8-f633-ad5f0d07507d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d682400-5be5-fce2-0742-d935c77889fa@redhat.com>
Date: Mon, 30 Oct 2017 21:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <5b8fbdd6-c3cd-aed8-f633-ad5f0d07507d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xnjD3rK9wcG2RsMDSWAVHSxVxRmJc3tUh"
Subject: Re: [Qemu-devel] [PATCH v6 06/12] nbd/server: Refactor zero-length
 option check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xnjD3rK9wcG2RsMDSWAVHSxVxRmJc3tUh
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <6d682400-5be5-fce2-0742-d935c77889fa@redhat.com>
Subject: Re: [PATCH v6 06/12] nbd/server: Refactor zero-length option check
References: <20171027104037.8319-1-eblake@redhat.com>
 <20171027104037.8319-7-eblake@redhat.com>
 <59449c29-0335-9eaf-47a6-edd6cc35bf73@virtuozzo.com>
 <5b8fbdd6-c3cd-aed8-f633-ad5f0d07507d@redhat.com>
In-Reply-To: <5b8fbdd6-c3cd-aed8-f633-ad5f0d07507d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 09:11 PM, Eric Blake wrote:
> On 10/30/2017 06:22 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 27.10.2017 13:40, Eric Blake wrote:
>>> Consolidate the response for a non-zero-length option payload
>>> into a new function, nbd_reject_length().=C2=A0 This check will
>>> also be used when introducing support for structured replies.
>>>

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (length) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Unconditionally drop the=
 connection if the client
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can't start a TLS n=
egotiation correctly */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_reject_length(client, l=
ength, option, true,
>>> errp);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>
>> why not to return nbd_reject_length's result? this EINVAL may not
>> correspond to errp (about EIO for example)..
>=20
> Somewhat true, if nbd_reject_length() fails. But nbd_reject_length() ma=
y
> also return 0 without setting errp, in which case, maybe this code
> should set errp rather than just blindly returning -EINVAL.
>=20
>>
>> with or without this fixed:
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>=20
> Okay, I'll squash this in, and include it in my pull request to be sent=

> shortly.

D'oh. Long week for me. The whole reason I added a 'bool fatal'
parameter was so that I don't have to worry about nbd_reject_length()
returning 0.  So it is instead better to just do:

> --- i/nbd/server.c
> +++ w/nbd/server.c
> @@ -684,8 +684,13 @@ static int nbd_negotiate_options(NBDClient *client=
,
> uint16_t myflags,
>                  if (length) {
>                      /* Unconditionally drop the connection if the clie=
nt
>                       * can't start a TLS negotiation correctly */
> -                    nbd_reject_length(client, length, option, true, er=
rp);
> -                    return -EINVAL;
> +                    return nbd_reject_length(client, length, option, t=
rue,
> +                                             errp);

rather than repeating an error message.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xnjD3rK9wcG2RsMDSWAVHSxVxRmJc3tUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln3j6cACgkQp6FrSiUn
Q2om/QgAlT8w6uOC3mkZo8JhcmYFYettk8v3lZNxP9LHm1bVSDB9xA5JPL2nOkZk
XD89yPi4oq8OcKzQCcvNmCUC0NSp42ymFwE9ElkPb0xis669HLn1tGsxdiCoPA9s
kOv5VCE7ZOyD0h7kdMJFhtmuGXvzKZ8arDdbXXQxGw9bv+0wkD3EbCmcjrXErCs2
zKnF7GkPiZgcWOtJ0F7nTjg0V+S0bHBKuf7DuNLt6WTo+3xDJ/bmNJlEQ0IQYF5v
d9ZXolnSlSnP6lbtP5zF2HAG3PQWGtLPo+Ukm1EyBvLesNHPBi17LIJctY0e/R/i
TNxfjRkwd+GIWfZNX7i2prmS1R9ibA==
=RBwq
-----END PGP SIGNATURE-----

--xnjD3rK9wcG2RsMDSWAVHSxVxRmJc3tUh--
