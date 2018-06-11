Received: from eggs.gnu.org ([2001:4830:134:3::10]:46850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNRA-0001kK-Ca
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNR4-0000ay-7B
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:04:48 -0400
References: <1528375581-29538-1-git-send-email-pl@kamp.de>
	<db7a78de-7962-63ee-e550-f954f12a3586@redhat.com>
	<6a1e0e02-0c43-7ca5-322a-565232802f75@kamp.de>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <87f37459-a276-035f-6ef3-5892061b689c@redhat.com>
Date: Mon, 11 Jun 2018 16:04:30 +0200
MIME-Version: 1.0
In-Reply-To: <6a1e0e02-0c43-7ca5-322a-565232802f75@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1cwAA0wZrAKrC1UJoYddSzcWnW9Qubhou"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: align is_allocated_sectors to 4k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1cwAA0wZrAKrC1UJoYddSzcWnW9Qubhou
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <87f37459-a276-035f-6ef3-5892061b689c@redhat.com>
Subject: Re: [PATCH] qemu-img: align is_allocated_sectors to 4k
References: <1528375581-29538-1-git-send-email-pl@kamp.de>
 <db7a78de-7962-63ee-e550-f954f12a3586@redhat.com>
 <6a1e0e02-0c43-7ca5-322a-565232802f75@kamp.de>
In-Reply-To: <6a1e0e02-0c43-7ca5-322a-565232802f75@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-11 15:59, Peter Lieven wrote:
> Am 11.06.2018 um 15:30 schrieb Max Reitz:
>> On 2018-06-07 14:46, Peter Lieven wrote:
>>> We currently don't enforce that the sparse segments we detect during
>>> convert are
>>> aligned. This leads to unnecessary and costly read-modify-write
>>> cycles either
>>> internally in Qemu or in the background on the storage device as
>>> nearly all
>>> modern filesystems or hardware has a 4k alignment internally.
>>>
>>> As we per default set the min_sparse size to 4k it makes perfectly
>>> sense to ensure
>>> that these sparse holes in the file are placed at 4k boundaries.
>>>
>>> The number of RMW cycles when converting an example image [1] to a
>>> raw device that
>>> has 4k sector size is about 4600 4k read requests to perform a total
>>> of about 15000
>>> write requests. With this path the 4600 additional read requests are
>>> eliminated.
>>>
>>> [1]
>>> https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-s=
erver-cloudimg-amd64-disk1.vmdk
>>>
>>>
>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>> ---
>>> =C2=A0 qemu-img.c | 21 +++++++++++++++------
>>> =C2=A0 1 file changed, 15 insertions(+), 6 deletions(-)
>> I like the idea, but it doesn't seem guaranteed that
>> is_allocated_sectors() is called on aligned offsets, so this alignment=

>> work may still leave things unaligned.
>=20
> I can't image why this should happen. As long as the alignment devides
> the buffer size we either
> write or skip aligned bytes. Maybe get_block_status returns an unaligne=
d
> number of sectors?

Yes, because the source medium does not need to be the same as the
destination (so the source may have e.g. 512-byte clusters).

>> Furthermore, we should probably not blindly assume 4k but instead use
>> some block limit of the target, like pwrite_zeroes_alignment, or
>> pdiscard_alignment, depending on the case.=C2=A0 (Or probably still
>> min_sparse, if that's less.)
>>
>> Since is_allocated_sectors_min() (the only caller of
>> is_allocated_sectors()) is called from just a single place, taking tho=
se
>> factors into account should be possible.
>=20
> I also thought of this, but for instance for raw-posix I always get a
> request_alignment of 1.

Yes, because request_alignment is a hard requirement.  With caching, you
can send requests with any alignment, so it's 1.

pwrite_zeroes_alignment and pdiscard_alignment are described as "Optimal
alignment", so those should contain the values we/you want.  If they are
0, then you should probably fall back to opt_transfer instead of
request_alignment.

Max

> But maybe the alignments you proposed produce a better result. I will
> check that.


--1cwAA0wZrAKrC1UJoYddSzcWnW9Qubhou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsegW4ACgkQ9AfbAGHV
z0A6igf/aO0HMUhZ5WQrT2KahZeCXX8p+kjJhFbz/LBs6++snyPbexL6oGnXOmOe
qFDRJh66DeGIlWyG7n423B/Y25tSYoQw77NMkETxJljYKGdnfEK3ZrPmzlesA6L1
aNpVW2dz0vh9Bnl5dkjgu9xdP0k7UrdOavwORO7XQ1h6ybNK6QI3lCrHuCkJElln
vT65CfPrFHCnpDJV7iYZr4AGENQc0WZltTmMZUdczR8E94YWYLtOlZVqVSuEJQdF
vxGquRm0S18+5kdae9yoN7dnxNbqHpKxFqUJDosa2Ct2fnYj8Pcr0VrMwi/gJ4+O
IB3yHKsN5r22Hd5/7y1m7u3TUMb/XQ==
=oQcE
-----END PGP SIGNATURE-----

--1cwAA0wZrAKrC1UJoYddSzcWnW9Qubhou--
