Received: from eggs.gnu.org ([2001:4830:134:3::10]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMbVi-0005we-FE
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMbVh-0005Ap-Br
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:21:22 -0500
References: <20171201014242.16877-1-eblake@redhat.com>
	<20171201014242.16877-2-eblake@redhat.com>
	<20171201144047.GE4147@localhost.localdomain>
	<c2bde291-63d7-d94c-aac7-d894fa2a5218@redhat.com>
	<20171201152443.GF4147@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a58f31d3-7252-e59b-8012-4a2a864275e0@redhat.com>
Date: Wed, 6 Dec 2017 09:20:57 -0600
MIME-Version: 1.0
In-Reply-To: <20171201152443.GF4147@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9HFJKjWaAQSFJTIHDPu3bKUVRWGd8wULr"
Subject: Re: [Qemu-devel] [PATCH v5 01/20] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9HFJKjWaAQSFJTIHDPu3bKUVRWGd8wULr
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <a58f31d3-7252-e59b-8012-4a2a864275e0@redhat.com>
Subject: Re: [PATCH v5 01/20] block: Add .bdrv_co_block_status() callback
References: <20171201014242.16877-1-eblake@redhat.com>
 <20171201014242.16877-2-eblake@redhat.com>
 <20171201144047.GE4147@localhost.localdomain>
 <c2bde291-63d7-d94c-aac7-d894fa2a5218@redhat.com>
 <20171201152443.GF4147@localhost.localdomain>
In-Reply-To: <20171201152443.GF4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/01/2017 09:24 AM, Kevin Wolf wrote:
> Am 01.12.2017 um 16:03 hat Eric Blake geschrieben:
>> On 12/01/2017 08:40 AM, Kevin Wolf wrote:
>>>> Note that most drivers give sector-aligned answers, except at
>>>> end-of-file, even when request_alignment is smaller than a sector.
>>>> However, bdrv_getlength() is sector-aligned (even though it gives a
>>>> byte answer), often by exceeding the actual file size.  If we were t=
o
>>>> give back strict results, at least file-posix.c would report a
>>>> transition from DATA to HOLE at the end of a file even in the middle=

>>>> of a sector, which can throw off callers; so we intentionally lie an=
d
>>>> state that any partial sector at the end of a file has the same
>>>> status for the entire sector.  Maybe at some future day we can
>>>> report actual file size instead of rounding up, but not for this
>>>> series.
>>>
>>> In what way does this throw off callers in practice?
>>
>> Several iotests failed if I didn't do that (it's been a few months, so=
 the
>> details are a bit fuzzy).  I think the biggest problem is that because=
 we
>> round the size up in bdrv_getlength(), but CANNOT access those rounded=

>> bytes, then reporting the status of those bytes as a hole (which is th=
e only
>> sane thing that file-posix can do) can cause grief when the rest of th=
e
>> sector (which we CAN access) is data.
>=20
> Does this indicate caller bugs? If they call byte-based
> bdrv_co_block_status(), they should surely be able to handle this
> situation in theory?

Hmm, the more I try to reproduce the failure, the more I'm coming to the
conclusion that I needed this back when we returned a rounded offset via
the return value (my tag nbd-byte-callback-v2), but now that we return
the actual offset rather than a rounded offset via a secondary parameter
(my tag nbd-byte-callback-v4), we don't need to compensate for
end-of-file at all!  That means even less code in my upcoming v5 submissi=
on.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9HFJKjWaAQSFJTIHDPu3bKUVRWGd8wULr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlooCtkACgkQp6FrSiUn
Q2rZsAgAreGOvprIKUYd9ae+BvnCSPcSFUiFwYzS1g8TkMeisetoMmgmxJYP+az/
8YryERQIsmCwID1r25R6SGxMGdhT1CQzxVlrokHyxkUKvKPwsqVg98us/IzQrA/i
JGDgNDpH40CmZcPNOq49ie2u9M2BBqw2lJWVUzDjoo2fQDtFmFaUFvHCduHUZb9f
XQyAnd9fnn6JlseN2SzanvmaWRb8rX5E40ryCuSZiHM7Ca+UInTfoFGEUAiJB7+b
dRt0+BHk8483T/98HiJZN91yriIlCI81yNk8x0OLVVGOJIJN2YwUAYA5X7cIbEID
ZK78bigb2Orl1rIawni4c3eDI9CSmA==
=fIlU
-----END PGP SIGNATURE-----

--9HFJKjWaAQSFJTIHDPu3bKUVRWGd8wULr--
