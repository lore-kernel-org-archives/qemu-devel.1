Received: from eggs.gnu.org ([2001:4830:134:3::10]:48832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdJrL-00065H-4j
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdJrJ-0004AZ-T1
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:52:15 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-5-vsementsov@virtuozzo.com>
	<7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
	<829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
	<de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
	<e0ec9530-a87d-0f10-262d-4b2af4516eed@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14aa4b87-54d4-1faa-8453-5e5dea2e346a@redhat.com>
Date: Sat, 11 Feb 2017 13:30:22 -0600
MIME-Version: 1.0
In-Reply-To: <e0ec9530-a87d-0f10-262d-4b2af4516eed@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d98S1qPA9CkekA8G4TaSiuVrgRqkmIbvX"
Subject: Re: [Qemu-devel] [PATCH 04/18] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d98S1qPA9CkekA8G4TaSiuVrgRqkmIbvX
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <14aa4b87-54d4-1faa-8453-5e5dea2e346a@redhat.com>
Subject: Re: [PATCH 04/18] nbd/client: refactor nbd_receive_starttls
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-5-vsementsov@virtuozzo.com>
 <7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
 <829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
 <de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
 <e0ec9530-a87d-0f10-262d-4b2af4516eed@virtuozzo.com>
In-Reply-To: <e0ec9530-a87d-0f10-262d-4b2af4516eed@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/10/2017 05:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.02.2017 17:41, Eric Blake wrote:
>> On 02/09/2017 12:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 07.02.2017 19:32, Eric Blake wrote:
>>>> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Split out nbd_receive_simple_option to be reused for structured rep=
ly
>>>>> option.
>>>>> +    return "<unknown option>";
>>>> Can you please consider making this include the %d representation of=

>>>> the
>>>> unknown option; perhaps by snprintf'ing into static storage?  While =
it
>>> Hmm.. The caller should free it in this case.
>> Only if you print it into malloc'd space. I think that printing it int=
o
>> static storage may be sufficient (although then we have a race if more=

>> than one thread is trying to use that static storage at the same time =
-
>> but do we ever have more than one thread trying to handle an error at
>> the same time?).
>>
>=20
> This race would be if one thread decides to print two option names in
> one message. Or save one option in a var, then print other, then print =
var.

NBD_OPT_ are supposed to be handled sequentially. The NBD spec does NOT
allow for a single client to send a second NBD_OPT_ until after the
first one has received a final response.  So the only time we would have
two threads dealing with things in nbd/client.c during handshake is if
we have a single qemu process connecting as client to two different NBD
servers in parallel, where both servers issue an otherwise unknown opt
response at the same time, which I don't see as likely enough to be
worth avoiding static storage.

If you're still worried about the race (I'm not), to the point that you
don't want to use static storage just to avoid g_malloc(), then another
option is to make nbd_opt_name() take an input parameter for a buffer
and max size, and let the caller provide stack-based storage for
computing the resulting message (similar to how strerror_r does things).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--d98S1qPA9CkekA8G4TaSiuVrgRqkmIbvX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYn2ZOAAoJEKeha0olJ0NqJdMH/3nuJy8AOT5ZjViUgiDMTpr+
n1zNO8cqcA5Un2RBqjzj0G/f40dBxQAaX9XHoN0s7I+tmZaTCWtdACiFZ4eSsj7y
NEDcqr2MAMQ4M+yr2EOrqF/tR2R3+lTX9tw7Ce+xAaFD1CcrSxjXpYKnEnEobsKt
KlRZrG4agQ3H1KOlVNrfEuii3S/koGpZOQ2O1WzD9P4iz1rdxxgfCbFKuMypkYIX
Xu5eu9LHS04Efygf1lOzmWtT/2YOXWVX7TF0Pm3M1XGyQ4ci7SIvGvMM/byXGZSU
jyqQXAN6QFHELvZKfMYz9Q6ew4jXIHm15T3P9SkF0mqL+hlbrL2uJkM3sd7ksI4=
=90ih
-----END PGP SIGNATURE-----

--d98S1qPA9CkekA8G4TaSiuVrgRqkmIbvX--
