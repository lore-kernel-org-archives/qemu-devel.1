Received: from eggs.gnu.org ([2001:4830:134:3::10]:55708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1s1-0002gy-95
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1s0-0008H3-Et
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:47:05 -0400
Date: Fri, 14 Jul 2017 17:46:49 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170714144649.kh235ikxqp3j2x4r@postretch>
References: <20170714143548.32559-1-el13635@mail.ntua.gr>
	<20170714143548.32559-2-el13635@mail.ntua.gr>
	<886a2d3b-5ec0-9464-8b7c-1590fd69b9c1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5iygmp2ok6gyzdyk"
Content-Disposition: inline
In-Reply-To: <886a2d3b-5ec0-9464-8b7c-1590fd69b9c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] block: fix dangling
 bs->explicit_options in block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--5iygmp2ok6gyzdyk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 09:42:22AM -0500, Eric Blake wrote:
>On 07/14/2017 09:35 AM, Manos Pitsidianakis wrote:
>> In some error paths it is possible to QDECREF a freed dangling
>> explicit_options, resulting in a heap overflow crash.  For example
>> bdrv_open_inherit()'s fail unrefs it, then calls bdrv_unref which calls
>> bdrv_close which also unrefs it.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>
>Can you pinpoint which commit introduced the bug, in order to decide if
>this affects 2.9 and should therefore be cc'd to qemu-stable?

I think the particular error path was unreachable in every case since=20
bdrv_open_driver() erroneously sets bs->drv to NULL, so bdrv_close never=20
performs cleanups. I fix this in the next patch. I am not completely=20
sure if it's possible to trigger this otherwise.

--5iygmp2ok6gyzdyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllo2VkACgkQc2J8L2kN
9xBRSRAAhS/elPAGkZf1AjFJ6WJ5hWzSpsDdBSvWaSmf5lnl+kDKPc2+4+61HwJT
iMxtZ7vIHlLcvs8qqsHZX6MZ/M9LHbSjTbNBWZiyQzUR1yIiNpUO3BrIfObx+PTw
W4EDKeKKIIrFUwjKkK441KzcR9jgiUgBpM60yxm5jKyNrZm5HIH1CBXGWz5rLIj/
9y2jj8L1P0usk8oskUw/1T++VEiUgjFcDKj3vSHrrvcRKGWAIPu+hd6m73aHwlfD
FRxnK/pkaOBWyJ3tM7Gqzv3OAWtgoj15UrHAYWzFx/9rqRn0mYba8RlliISjHefi
flpSe9hy6Ko8o+AW91sXhjHoXDrB/PZhiNeWj/zIgw2W+qn0wCKierddznKb3as2
9111ow50+EomXq0uOK75a/N3l5gjPw5DmF0hbhboBrX1QoVzwukuyodmHSTdg8fL
i2TypzQgwCoIJbSA0flmcxxvFfumEfr9f0K9k2KGw1scnUg3TzlPy90F3Ynuu1fF
4SQ9QrGUMyyhgjuWhb0ROw1jczGxjGc/fMKmwqkD61/AB7Hqfb8CoZ5TPubfTIvq
10dsKlgsT8D/L1v7FaezGNjbqHN59AJounPO2E1M7Dkg5/xXJhWUPnG5dGo7aLUx
lpY1ZzZAvBEyEtWUxB16pphqqXyz9YAsRKf4lALLppTFkp6712E=
=PtWb
-----END PGP SIGNATURE-----

--5iygmp2ok6gyzdyk--
