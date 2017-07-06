Received: from eggs.gnu.org ([2001:4830:134:3::10]:42466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT7iq-0003tL-5Q
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT7io-0007oJ-Uq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:25:36 -0400
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-13-eblake@redhat.com>
	<20170706133017.GE5975@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c855cfa-a26e-cbab-b2fd-626f3520be9f@redhat.com>
Date: Thu, 6 Jul 2017 09:25:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170706133017.GE5975@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kMgKU8DqaLi2lQoqVuSS8CSKxr2bks3Dh"
Subject: Re: [Qemu-devel] [PATCH v4 12/21] mirror: Switch mirror_do_read()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kMgKU8DqaLi2lQoqVuSS8CSKxr2bks3Dh
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <8c855cfa-a26e-cbab-b2fd-626f3520be9f@redhat.com>
Subject: Re: [PATCH v4 12/21] mirror: Switch mirror_do_read() to byte-based
References: <20170705210842.960-1-eblake@redhat.com>
 <20170705210842.960-13-eblake@redhat.com>
 <20170706133017.GE5975@noname.redhat.com>
In-Reply-To: <20170706133017.GE5975@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2017 08:30 AM, Kevin Wolf wrote:
> Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
>> We are gradually converting to byte-based interfaces, as they are
>> easier to reason about than sector-based.  Convert another internal
>> function (no semantic change).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Jeff Cody <jcody@redhat.com>
>=20
>> -    /* The sector range must meet granularity because:
>> +    assert(bytes <=3D s->buf_size);
>> +    /* The range will be sector-aligned because:
>>       * 1) Caller passes in aligned values;
>> -     * 2) mirror_cow_align is used only when target cluster is larger=
=2E */
>> -    assert(!(sector_num % sectors_per_chunk));

So the strict translation would be assert(!(offset % s->granularity)),
or rewritten to be assert(QEMU_IS_ALIGNED(offset, s->granularity)).

>> -    nb_chunks =3D DIV_ROUND_UP(nb_sectors, sectors_per_chunk);
>> +     * 2) mirror_cow_align is used only when target cluster is larger=
=2E
>> +     * But it might not be cluster-aligned at end-of-file. */
>> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));

and you're right that this appears to be a new assertion.

>> +    nb_chunks =3D DIV_ROUND_UP(bytes, s->granularity);
>=20
> The assertion in the old code was about sector_num (i.e.  that the star=
t
> of the range is cluster-aligned), not about nb_sectors, so while you ad=
d
> a new assertion, it is asserting something different. This explains
> why you had to switch to sector aligned even though the semantics
> shouldn't be changed by this patch.
>=20
> Is this intentional or did you confuse sector_num and nb_sectors? I
> think we can just have both assertions.

At this point, I'm not sure if I confused things, or if I hit an actual
iotest failure later in the series that I traced back to this point.  If
I have a reason to respin, I'll see if both assertions still hold (the
rewritten alignment check on offset, and the new check on bytes being
sector-aligned), through all the tests.  Also, while asserting that
bytes is sector-aligned is good in the short term, it may be overkill by
the time dirty-bitmap is changed to byte alignment (right now,
bdrv_getlength() is always sector-aligned, because it rounds up; but if
we ever make it byte-accurate, then the trailing cluster might not be a
sector-aligned bytes length).

>=20
> The rest of the patch looks okay.
>=20
> Kevin
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kMgKU8DqaLi2lQoqVuSS8CSKxr2bks3Dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXkhKAAoJEKeha0olJ0Nq93QH/ivgrbDFaXXJE2iqII75/TcZ
iC0MletVQcMlcOhxyDw4RoFkDJUe0TIdr0Gq+Fl5sl0uBx8tYn+pMVeP6U8mhoq+
c+3loASsNcwZV1NqShkZyXlqRm+IBymLULs8JgP1yxieqGug5oAlzGo6j+r5ubz5
m8kJDCd2xmD9B0IWBKmoBtyRkm2ekjFBJ4AmA1SgK+PXbPKSW8swku0bMd0l0dpo
RK4qo3W46F9tVfU/fcX0cfA29eXRUXyzQ7a/dkX6PYIKDHjf/ORoa7EsdM6o7bhj
+RJ8L27VImL/dJatsUPE5xZJQr3n+gCBwSvzhYCM9UyVDuTAL6uBRXmxhqQZj7Y=
=dqxN
-----END PGP SIGNATURE-----

--kMgKU8DqaLi2lQoqVuSS8CSKxr2bks3Dh--
