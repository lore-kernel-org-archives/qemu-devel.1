Received: from eggs.gnu.org ([2001:4830:134:3::10]:45518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTACF-0004hG-4P
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTACD-0000Y4-VI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:04:07 -0400
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-21-eblake@redhat.com>
	<20170706164820.GN5975@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3709c9e-8d99-b40e-a2a5-0299f151a40c@redhat.com>
Date: Thu, 6 Jul 2017 12:03:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170706164820.GN5975@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MOTN0TOwHEW8jLaJnJeqL7sp7sr7evonM"
Subject: Re: [Qemu-devel] [PATCH v4 20/21] block: Minimize raw use of
 bds->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MOTN0TOwHEW8jLaJnJeqL7sp7sr7evonM
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <f3709c9e-8d99-b40e-a2a5-0299f151a40c@redhat.com>
Subject: Re: [PATCH v4 20/21] block: Minimize raw use of bds->total_sectors
References: <20170705210842.960-1-eblake@redhat.com>
 <20170705210842.960-21-eblake@redhat.com>
 <20170706164820.GN5975@noname.redhat.com>
In-Reply-To: <20170706164820.GN5975@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2017 11:48 AM, Kevin Wolf wrote:
> Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
>> bdrv_is_allocated_above() was relying on intermediate->total_sectors,
>> which is a field that can have stale contents depending on the value
>> of intermediate->has_variable_length.  An audit shows that we are safe=

>> (we were first calling through bdrv_co_get_block_status() which in
>> turn calls bdrv_nb_sectors() and therefore just refreshed the current
>> length), but it's nicer to favor our accessor functions to avoid havin=
g
>> to repeat such an audit, even if it means refresh_total_sectors() is
>> called more frequently.
>>
>> @@ -1969,13 +1970,14 @@ int bdrv_is_allocated_above(BlockDriverState *=
top,
>>
>>          /*
>>           * [sector_num, nb_sectors] is unallocated on top but interme=
diate
>> -         * might have
>> -         *
>> -         * [sector_num+x, nr_sectors] allocated.
>> +         * might have [sector_num+x, nb_sectors-x] allocated.
>>           */
>=20
> I tried to figure out what this comment wants to tell us, and neither
> the original version nor your changed one seemed to make a lot of sense=

> to me.

The original one was definitely weird. I'm fine with bike-shedding on my
replacement (including deleting the comment altogether).

> The only case that I can see that actually needs the following
> block is a case like this:
>=20
>     (. =3D unallocated, # =3D allocated)
>=20
>     top             ....####
>     intermediate    ........
>=20
> Our initial request was for 8 sectors, but when going to the
> intermediate node, we need to reduce this to 4 sectors, otherwise we
> would return unallocated for sectors 5 to 8 even though they are
> allocated in top.
>=20
> That's kind of the opposite of what the comment says, though...

I think the comment was trying to worry about:

    top             ........
    intermediate    ....####

then our first query says we have 8 sectors unallocated, but we can't
return 8 unless we also check 8 sectors of the intermediate image
(because the intermediate image may have sectors 4-7 allocated).  So it
is explaining why the for loop is continuing down the backing chain.

If we ever get an answer of allocated, we can return immediately; we
only have to keep looking (on potentially smaller prefixes) as long as
we have an answer of unallocated and more backing chain to still check.

On the other hand, there's this situation:

top           ....####
intermediate  ####....

Right now (whether or not you apply my patch), the code only returns a
pnum of 4 sectors allocated (the first query on top sees 4 unallocated,
the second query on intermediate sees 4 allocated).  But in reality, we
COULD return a pnum of 8 (between the two images being queries, we can
account for an allocation of 8 sectors), although doing so requires
additional bookkeeping and calls into the drivers (get_status(top, 0, 8)
returns pnum of 4, get_status(intermediate, 0, 4) returns pnum of 4,
then get_status(top, 4, 4) returns pnum of 4, so that the overall
is_allocated(top, intermediate, 0, 8) sets pnum of 8).  Maybe it's worth
doing, but not in the same series that converts to byte-based.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MOTN0TOwHEW8jLaJnJeqL7sp7sr7evonM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXm1uAAoJEKeha0olJ0NqgRsH/3V2fayCQHwQ95mpmYmNQfi7
+YaOyq4vICY7Al+2LWZBwurjY2s4M4ptbtxNbJpQVCiCCchbXzMPXEon/geLDTRl
HgQwcBRmLQgV28a9wTEwNH39qjU40litYWgz/Ej1Hgf+k2yPd1klTqvawIgD6/tt
RqGvkJnRyaL+z2Qub+i5lCzHsc4CHXsB1Kpj2BYvq+nRtrkVS82AKSFbh2KBUzSX
Yp0sul7MsJPlDXmf5BjxBBneP0XfbDm5tjt01H+tZqYgdTdc/Y5rOsqhPtxH7nwX
vL2HqMqdkYyulQPli82SmbCWM/UF4ZvWKu0acc2fM8LpmrfCKS9BiFnsHqHRGn0=
=Qqw1
-----END PGP SIGNATURE-----

--MOTN0TOwHEW8jLaJnJeqL7sp7sr7evonM--
