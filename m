Received: from eggs.gnu.org ([2001:4830:134:3::10]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1fd1-00052b-4d
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1fd0-0003a7-27
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:30:23 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-10-eblake@redhat.com>
	<20171009200736.GA5170@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d9b40226-d9ea-c48a-3b00-82ed0ad2c874@redhat.com>
Date: Mon, 9 Oct 2017 16:30:05 -0500
MIME-Version: 1.0
In-Reply-To: <20171009200736.GA5170@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j5dgg7LHtDEHjdgjOmdJrll1hrcaS1AVN"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 09/23] block: Switch
 BdrvCoGetBlockStatusData to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5dgg7LHtDEHjdgjOmdJrll1hrcaS1AVN
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <d9b40226-d9ea-c48a-3b00-82ed0ad2c874@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 09/23] block: Switch
 BdrvCoGetBlockStatusData to byte-based
References: <20171004020048.26379-1-eblake@redhat.com>
 <20171004020048.26379-10-eblake@redhat.com>
 <20171009200736.GA5170@localhost.localdomain>
In-Reply-To: <20171009200736.GA5170@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 03:07 PM, Jeff Cody wrote:
> On Tue, Oct 03, 2017 at 09:00:34PM -0500, Eric Blake wrote:
>> We are gradually converting to byte-based interfaces, as they are
>> easier to reason about than sector-based.  Convert another internal
>> type (no semantic change), and rename it to match the corresponding
>> public function rename.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>> ---

>>  static void coroutine_fn bdrv_get_block_status_above_co_entry(void *o=
paque)
>>  {
>> -    BdrvCoGetBlockStatusData *data =3D opaque;
>> +    BdrvCoBlockStatusData *data =3D opaque;
>> +    int n;
>>
>>      data->ret =3D bdrv_co_get_block_status_above(data->bs, data->base=
,
>>                                                 data->mapping,
>> -                                               data->sector_num,
>> -                                               data->nb_sectors,
>> -                                               data->pnum,
>> +                                               data->offset >> BDRV_S=
ECTOR_BITS,
>> +                                               data->bytes >> BDRV_SE=
CTOR_BITS,
>> +                                               &n,
>>                                                 data->file);
>> +    *data->pnum =3D n * BDRV_SECTOR_SIZE;
>=20
> This throws a warning:
>=20
>  block/io.c: In function =E2=80=98bdrv_get_block_status_above_co_entry=E2=
=80=99:
>  block/io.c:1995:21: error: =E2=80=98n=E2=80=99 may be used uninitializ=
ed in this function=20
>        [-Werror=3Dmaybe-uninitialized] *data->pnum =3D n * BDRV_SECTOR_=
SIZE;
>=20

Ugh - my curse of compiling development builds with -g instead of -O2,
so I didn't see the warning.  Ideally, it would be nice if all the
various bdrv_*_block_status functions would set *pnum to a sane value on
all exit paths, including errors, but that is not the case in
bdrv_co_get_block_status_above().

>=20
> It is fixed a couple patches from now, but it will still break git-bise=
ct.

Indeed.  Will fix on respin, as I have to do a v6 anyways for some minor
rebasing conflict resolution.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--j5dgg7LHtDEHjdgjOmdJrll1hrcaS1AVN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnb6l4ACgkQp6FrSiUn
Q2polwf/RSaeXN0Kl13rXAOKK+q024ERyzTfnQ0Qyr40FMdHaWOObwTVFuYcEgIV
w3MBqgvPMoMG4UoUwxB6rjs1NW3ObBZ8ZpWDXz5AY8GbeQACc/CFATSiehJAJYnA
MgpKDR4Sq8eMLub/lztNCtpqnEpwLVEh7Uma9ehs5r2kmDydWDQzxtLcItfBzhVF
WbotCrqC3RVGPLAAk6qr8YauH9BqnZGLDNSVDY1jyhAPc5XRMXwXBSrK3rs24gsF
6NaBQDPDSW2oQjcpJItM/vpvTw7zcb8+AQxvbPe1jmHwhWsmgPKLw2dlVw+B6HKH
Rc15tYHrJi6ZUWkFgk3YsA070QIbWQ==
=JXFZ
-----END PGP SIGNATURE-----

--j5dgg7LHtDEHjdgjOmdJrll1hrcaS1AVN--
