Received: from eggs.gnu.org ([2001:4830:134:3::10]:55889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1vlP-0006RS-0k
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1vlO-0003K5-1l
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:44:07 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-2-eblake@redhat.com>
	<20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
Date: Tue, 10 Oct 2017 09:43:45 -0500
MIME-Version: 1.0
In-Reply-To: <20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Oi10ieKm9QnAnD4DOp5N0XtMKotl4x0Q"
Subject: Re: [Qemu-devel] [PATCH v5 01/23] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Oi10ieKm9QnAnD4DOp5N0XtMKotl4x0Q
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
Subject: Re: [PATCH v5 01/23] block: Allow NULL file for
 bdrv_get_block_status()
References: <20171004020048.26379-1-eblake@redhat.com>
 <20171004020048.26379-2-eblake@redhat.com>
 <20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 08:59 AM, Kevin Wolf wrote:
> Am 04.10.2017 um 04:00 hat Eric Blake geschrieben:
>> Not all callers care about which BDS owns the mapping for a given
>> range of the file.  This patch merely simplifies the callers by
>> consolidating the logic in the common call point, while guaranteeing
>> a non-NULL file to all the driver callbacks, for no semantic change.
>> The only caller that does not care about pnum is bdrv_is_allocated,
>> as invoked by vvfat; we can likewise add assertions that the rest
>> of the stack does not have to worry about a NULL pnum.
>>
>> Furthermore, this will also set the stage for a future cleanup: when
>> a caller does not care about which BDS owns an offset, it would be
>> nice to allow the driver to optimize things to not have to return
>> BDRV_BLOCK_OFFSET_VALID in the first place.  In the case of fragmented=

>> allocation (for example, it's fairly easy to create a qcow2 image
>> where consecutive guest addresses are not at consecutive host
>> addresses), the current contract requires bdrv_get_block_status()
>> to clamp *pnum to the limit where host addresses are no longer
>> consecutive, but allowing a NULL file means that *pnum could be
>> set to the full length of known-allocated data.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v5: use second label for cleaner exit logic [John], use local_pnum

>> @@ -1811,16 +1811,19 @@ static int64_t coroutine_fn bdrv_co_get_block_=
status(BlockDriverState *bs,
>>      int64_t total_sectors;
>>      int64_t n;
>>      int64_t ret, ret2;
>> +    BlockDriverState *local_file =3D NULL;
>> +    int local_pnum =3D 0;
>=20
> I don't quite see what the point of local_pnum is if we assert anyway
> that the real pnum is non-NULL.

I did it in parallel with fallout from John's review on v4:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06958.html

but since it wasn't specifically asked for, and is now getting
questions, I'm fine with not having it in v6.


>>
>> -out:
>> + out:
>=20
> git grep tells me that the old style (unindented label, as opposed to
> indented by a single space) is a lot more common both within the block
> layer and across qemu as a whole.

emacs likes to add the space (so that grepping for content in column 1
sees only function declarations, not mid-function labels - which in turn
makes 'diff -p' output nicer to read).  But I can override emacs'
insistence, and go with the label flush to the left.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3Oi10ieKm9QnAnD4DOp5N0XtMKotl4x0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc3KEACgkQp6FrSiUn
Q2rU+AgAgk6QTPllgZcCxpxwpzq7lz1Tp0VkPZTnniiagBgY7Sn9jXpCoS7Zbtbv
B5pz9LiOvO6fQUU1meB/8+CjHoC82zPF65xWFRmMGl5cVUsJuwx8oJid11A7tN7Q
C7UftwQR6etOYGQ/QG991ygAXamyiY+25bvDE7fuv8nrKK6VBeLNijfXdsa0BvUl
DBSF4jO6+ZL5zJB60Z8loyl67G/fW9YxCT965+IR9u5P86zZl+7UPsClq/aO56FR
0wFx6qr3SKy0l67Ba4LBkNRs4YGouZ+zUjJpGdCf8p4hnQi4gyISuL7FUaRoeLFn
71rZ8xYSYLMeqCfe0e9Ht3kP3AjsQQ==
=t1Y0
-----END PGP SIGNATURE-----

--3Oi10ieKm9QnAnD4DOp5N0XtMKotl4x0Q--
