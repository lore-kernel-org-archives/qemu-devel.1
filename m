Received: from eggs.gnu.org ([2001:4830:134:3::10]:51052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Ckp-00051u-Lr
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Cko-0002eu-CQ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:56:07 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-3-eblake@redhat.com>
	<50d265a3-dec8-59f9-6840-c5720e406fa6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1412228f-01c5-da47-31db-4ed34c7dc055@redhat.com>
Date: Mon, 17 Apr 2017 14:55:53 -0500
MIME-Version: 1.0
In-Reply-To: <50d265a3-dec8-59f9-6840-c5720e406fa6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dT2A9X4PxkTFqOUsQ8UWkHI96V7TC1bJJ"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/17] trace: Show blockjob
 actions via bytes, not sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dT2A9X4PxkTFqOUsQ8UWkHI96V7TC1bJJ
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1412228f-01c5-da47-31db-4ed34c7dc055@redhat.com>
Subject: Re: [Qemu-block] [PATCH 02/17] trace: Show blockjob actions via
 bytes, not sectors
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-3-eblake@redhat.com>
 <50d265a3-dec8-59f9-6840-c5720e406fa6@redhat.com>
In-Reply-To: <50d265a3-dec8-59f9-6840-c5720e406fa6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 02:18 PM, John Snow wrote:

>> @@ -346,13 +349,15 @@ static uint64_t coroutine_fn mirror_iteration(Mi=
rrorBlockJob *s)
>>      if (sector_num < 0) {
>>          bdrv_set_dirty_iter(s->dbi, 0);
>>          sector_num =3D bdrv_dirty_iter_next(s->dbi);
>> -        trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bi=
tmap));
>> +        trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bi=
tmap) *
>> +                                  BDRV_SECTOR_SIZE);
>=20
> mirror_restart_iter(void *s, int64_t cnt) "s %p dirty count %"PRId64
>=20
> I guess the print doesn't really bother to say what the unit is, just a=

> "dirty count."
>=20
> Does this conflict with the bitmap series, though? (Won't need to scale=

> by BDRV_SECTOR_SIZE after that, I think.)
>=20

That series depends on this one going in first (as currently written),
and indeed, in that series, the code DOES simplify to drop the '*
BDRV_SECTOR_SIZE' in the patch that changes the return scale of
bdrv_get_dirty_count().


>>  backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
>>  backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId6=
4
>>  backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p st=
art %"PRId64" ret %d"
>=20
> I guess these three were "cluster" based, but you didn't need to change=

> anything to assert them as byte-based.
>=20
>>
>=20
> Under the assumption that it's okay to change tracing output without
> being able to differentiate between new and old output:

I'll leave that to Stefan's discretion as trace maintainer, but my
thoughts are that tracing is for debugging purposes, and as long as you
know what binary you are debugging, you can figure out what the trace
message meant by referring back to the source that generated that binary.=


>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dT2A9X4PxkTFqOUsQ8UWkHI96V7TC1bJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9R3JAAoJEKeha0olJ0NqMooH/j617O5NHM271KrC6AT8c/zJ
0+YPOlLFhTR2fZ9rxI/PHZnzStkhMbDrKyMua5k1yaAMXE8a2F5+8LzQuPJXJCO1
ivfEmvS5m7teQbRhFVxuXeS/TLqqhPRTah5st+AGTw3wLQM2qKcHC+SfiavTg0Jq
lNEZPvTvg8+xOo7+6XIw01NX/lQpKrrgyuTG1zfEZojYF0h9jOobEgVXLkHODS6N
qr4dAP+SC7CBHk9F+rfBdMTwkSnPnXjHAx2dH+QUxGJRvp+VarhAyV7mSLaOsXqo
NU+vJZK3WX7Laem9DSUlgXgT4RfO3QGq9yRaA/DYnW6ufDNmxEevDRHOg5HNooo=
=+RfV
-----END PGP SIGNATURE-----

--dT2A9X4PxkTFqOUsQ8UWkHI96V7TC1bJJ--
