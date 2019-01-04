Received: from eggsout.gnu.org ([209.51.188.92]:44423 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfZEc-0005AL-21
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfZEb-00071K-8f
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:50:38 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-8-eblake@redhat.com>
	<b91e2cff-2d5c-f5dd-e8cc-7a8944c93de4@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <048303ff-cdc2-d0b6-a990-1453df29626b@redhat.com>
Date: Fri, 4 Jan 2019 17:50:27 -0600
MIME-Version: 1.0
In-Reply-To: <b91e2cff-2d5c-f5dd-e8cc-7a8944c93de4@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qT5LB1aZst7GFKgAQv3S1xnDWQemmQPQS"
Subject: Re: [Qemu-devel] [PATCH v2 07/22] qemu-nbd: Avoid strtol open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qT5LB1aZst7GFKgAQv3S1xnDWQemmQPQS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com"
 <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <048303ff-cdc2-d0b6-a990-1453df29626b@redhat.com>
Subject: Re: [PATCH v2 07/22] qemu-nbd: Avoid strtol open-coding
References: <20181215135324.152629-1-eblake@redhat.com>
 <20181215135324.152629-8-eblake@redhat.com>
 <b91e2cff-2d5c-f5dd-e8cc-7a8944c93de4@virtuozzo.com>
In-Reply-To: <b91e2cff-2d5c-f5dd-e8cc-7a8944c93de4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/18/18 9:11 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.12.2018 16:53, Eric Blake wrote:
>> Our copy-and-pasted open-coding of strtol handling forgot to
>> handle overflow conditions.  Use qemu_strto*() instead.
>>
>> In the case of --partition, since we insist on a user-supplied
>> partition to be non-zero, we can use 0 rather than -1 for our
>> initial value to distinguish when a partition is not being
>> served, for slightly more optimal code.
>>
>> The error messages for out-of-bounds values are less specific,
>> but should not be a terrible loss in quality.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v2: Retitle, catch more uses of strtol
>> [Hmm - this depends on int64_t and off_t being compatible; if they
>> aren't that way on all platforms, I'll need a temporary variable]
>=20
> hmm, as I understand, even if this compatibility exists, it's not a par=
t
> of standard and nothing about off_t size in POSIX..

off_t allows you to run on older systems with 32-bit offsets and newer
systems with 64-bit offsets; but these days, even on 32-bit systems, we
compile qemu to always ask for 64-bit off_t.  Using off_t instead of
int64_t is probably a separate cleanup, but one that may be worth making
prior to this patch, so I'll defer this one to my v3.

>=20
> Moreover: what is the reason for using off_t in NBD code? We don't have=
 it
> in NBD protocol, we don't have it in generic block layer interface. Isn=
't it
> always casted to int64_t or like this?
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--qT5LB1aZst7GFKgAQv3S1xnDWQemmQPQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwv8UMACgkQ3g5py3or
ov0f0Qf+IlFcb3Vty3fmjYDvANVpx4XEdpedq6FKgV80ah0zCWc9tolqnJoMIADA
gBIJInsBNeLVNIMgqB9e2N59UTmi/zCih2ty4qUzKB01TREuXww2xsF4ZlIYjqsR
8cR5S1emNwFZPHVVn9MGpocNiQEhx/GU5poJap7b5dlAFVgH0FMLotAQwloRy4RE
zjGytqCB+RHigPT/KRxZb06euHc+GyM2/GqTZAqd8MgwHw3XT+KFNDDcbCyIP1Jz
Wt0t7pNk2elOnPRMWcHqpK2iPzUTaPmOb4Pin1zsicMWhLLYun69w/mWPxnc4egU
ZOComT9BadtHGbUI0TmovVR772PMLw==
=Rl8r
-----END PGP SIGNATURE-----

--qT5LB1aZst7GFKgAQv3S1xnDWQemmQPQS--
