Received: from eggs.gnu.org ([2001:4830:134:3::10]:45698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw6tk-0000Ox-0a
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw6tj-0000jk-4c
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:52:24 -0400
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-11-eblake@redhat.com>
	<20170406090045.GC4341@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1313a278-947d-9b73-640f-3aa518019773@redhat.com>
Date: Thu, 6 Apr 2017 07:52:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170406090045.GC4341@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JVfPvemo5N4JQARebwtBcgOtLxENPn0Hp"
Subject: Re: [Qemu-devel] [PATCH v3 10/13] block: Simplify
 bdrv_append_temp_snapshot() logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JVfPvemo5N4JQARebwtBcgOtLxENPn0Hp
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <1313a278-947d-9b73-640f-3aa518019773@redhat.com>
Subject: Re: [PATCH v3 10/13] block: Simplify bdrv_append_temp_snapshot()
 logic
References: <20170405194741.18956-1-eblake@redhat.com>
 <20170405194741.18956-11-eblake@redhat.com>
 <20170406090045.GC4341@noname.redhat.com>
In-Reply-To: <20170406090045.GC4341@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 04:00 AM, Kevin Wolf wrote:
> Am 05.04.2017 um 21:47 hat Eric Blake geschrieben:
>> Noticed while checking Coccinelle results. Naming a label 'out:'
>> when it is only used on error paths is weird; meanwhile we know
>> that snapshot_options is NULL on success and that QDECREF(NULL)
>> is safe.  So merge the two exit paths into one.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 9b87bf6..a13625f 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2209,13 +2209,10 @@ static BlockDriverState *bdrv_append_temp_snap=
shot(BlockDriverState *bs,
>>          goto out;
>>      }
>>
>> +out:
>> +    QDECREF(snapshot_options);
>>      g_free(tmp_filename);
>>      return bs_snapshot;
>=20
> bs_snapshot is uninitialised or at least the wrong return value in erro=
r
> cases. (Hm... Shouldn't the compiler catch the uninitialised part?)

Odd, and I agree that I recall the compiler generally able to catch that
(maybe it's a matter of compiling with -g vs. -O2).  I'm surprised the
autobuilder didn't flag it.  (I think I missed it due to rebase churn on
my end).  The obvious fix is to:

-    BlockDriverState *bs_snapshot;
+    BlockDriverState *bs_snapshot =3D NULL;

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JVfPvemo5N4JQARebwtBcgOtLxENPn0Hp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5jn1AAoJEKeha0olJ0NqJK8IAJ5PJdHjudLH/dTW0j2XPf/T
t4Qp5UVK/1kMG+FGnqpintah2fyLdzOevRQUZXfuZZJMGyr7/ly6xioKMwg00S8w
S8RQ8B5vipwnECEmWGpbRj0QtfI82Nt3ZWb119x2bkdeOci8FZum4qLClOe9Cr3B
qg9UYIebCCnEzvAft5gL6U2O7H0gCV+E1NWIL8xFhGFICWB4aZh1DJa4mk+RpFqd
tL5aEJszhTBQY1dqcLF9TyX+kG55PmI+u8JNDC3xGIiQU3NKG7U+eit0SpzNtX0b
V25mzixRAYwY1KZr1qKVZh09ruvbvodsCMXG728/wlpw0/sCaWKZH/z2jFz2pDM=
=pv54
-----END PGP SIGNATURE-----

--JVfPvemo5N4JQARebwtBcgOtLxENPn0Hp--
