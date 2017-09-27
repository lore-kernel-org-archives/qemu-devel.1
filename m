Received: from eggs.gnu.org ([2001:4830:134:3::10]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxHoW-0006I7-6d
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxHoU-0006WM-TK
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:16:08 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-14-eblake@redhat.com>
	<6cc0f8a8-6c3f-fd53-6167-82244b1633fa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <363ffebf-61a1-609b-a37f-76ba5c07513c@redhat.com>
Date: Wed, 27 Sep 2017 14:15:50 -0500
MIME-Version: 1.0
In-Reply-To: <6cc0f8a8-6c3f-fd53-6167-82244b1633fa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HtjuKaid71cuhs28lfdvlmCkK5gsK1tSP"
Subject: Re: [Qemu-devel] [PATCH v4 13/23] qemu-img: Simplify logic in
 img_compare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HtjuKaid71cuhs28lfdvlmCkK5gsK1tSP
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <363ffebf-61a1-609b-a37f-76ba5c07513c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 13/23] qemu-img: Simplify logic in
 img_compare()
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-14-eblake@redhat.com>
 <6cc0f8a8-6c3f-fd53-6167-82244b1633fa@redhat.com>
In-Reply-To: <6cc0f8a8-6c3f-fd53-6167-82244b1633fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 02:05 PM, John Snow wrote:
>=20
>=20
> On 09/13/2017 12:03 PM, Eric Blake wrote:
>> As long as we are querying the status for a chunk smaller than
>> the known image size, we are guaranteed that a successful return
>> will have set pnum to a non-zero size (pnum is zero only for
>> queries beyond the end of the file).  Use that to slightly
>> simplify the calculation of the current chunk size being compared.
>> Likewise, we don't have to shrink the amount of data operated on
>> until we know we have to read the file, and therefore have to fit
>> in the bounds of our buffer.  Also, note that 'total_sectors_over'
>> is equivalent to 'progress_base'.
>>
>> With these changes in place, sectors_to_process() is now dead code,
>> and can be removed.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> @@ -1402,14 +1393,9 @@ static int img_compare(int argc, char **argv)
>>              goto out;
>>          }
>>          allocated2 =3D status2 & BDRV_BLOCK_ALLOCATED;
>> -        if (pnum1) {
>> -            nb_sectors =3D MIN(nb_sectors,
>> -                             DIV_ROUND_UP(pnum1, BDRV_SECTOR_SIZE));
>> -        }
>> -        if (pnum2) {
>> -            nb_sectors =3D MIN(nb_sectors,
>> -                             DIV_ROUND_UP(pnum2, BDRV_SECTOR_SIZE));
>> -        }
>> +
>> +        assert(pnum1 && pnum2);
>> +        nb_sectors =3D DIV_ROUND_UP(MIN(pnum1, pnum2), BDRV_SECTOR_SI=
ZE);
>=20
> In the apocalyptic future where non-sector sized returns are possible,
> does this math make sense?
>=20
> e.g. say the return is zeroes, but it's not aligned anymore, so we
> assume we have an extra half a sector's worth of zeroes here.

Not introduced in this patch, but a good question for 12/23.  We want to
round up rather than down to ensure that we don't inf-loop on a partial
sector response; but at the same time, you're right that if we got a
report of a half-sector zero and we widen it, we can't guarantee that
the second half is zero.

On the bright side, this rounding goes away when later patches switch
img_compare to be byte-based, later in this series.  But you're right
that it is probably smarter to have 12/23 assert that things are already
aligned (and thus we don't need to round in the first place).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HtjuKaid71cuhs28lfdvlmCkK5gsK1tSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnL+OYACgkQp6FrSiUn
Q2p4Dgf/aSBraadS5h4k+nm5y94POR6dOQDrQlMp0VfHcU+rTE4o9TjofFBxw+s3
F7YyfSUwyc6/AvSxpyopLFOOBdn8ZvNtGeV7QghV58n2XjfgAXVD1crs0nXPmW5W
KHQrtR3dEQt3wACGD1Ji8hbt9Gfb2/W155wHXQxLRkqIRANQRUJer8KNAxC3CJky
KX8uecinNguJ+HMJas5XcDJWVg/BQAzl/7/0RTLDCFFq2PR6V+Gr6urIX/z/0TWo
M8hbJNWUCpd7BQ6jGYHxojAPEqrUso++x75eAu1dTQz6MCHHnE8Q8YUS0LmUhDP7
x7TuD/SddIqft2RbqneSQPdIrZzWtw==
=4iBi
-----END PGP SIGNATURE-----

--HtjuKaid71cuhs28lfdvlmCkK5gsK1tSP--
