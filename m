Received: from eggs.gnu.org ([2001:4830:134:3::10]:58340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0HZY-00010W-6j
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0HZW-0000Xh-T2
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:04:48 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<a00efe8e-e10a-da03-c31b-d2817d562aea@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <56372609-18c6-cddc-aad3-28012c7abc1f@redhat.com>
Date: Mon, 17 Apr 2017 20:04:35 -0500
MIME-Version: 1.0
In-Reply-To: <a00efe8e-e10a-da03-c31b-d2817d562aea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lBkBsEQphTcNQIuxFP664OigK8AH4j76e"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/17] make
 bdrv_is_allocated[_above] byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lBkBsEQphTcNQIuxFP664OigK8AH4j76e
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <56372609-18c6-cddc-aad3-28012c7abc1f@redhat.com>
Subject: Re: [Qemu-block] [PATCH 00/17] make bdrv_is_allocated[_above]
 byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <a00efe8e-e10a-da03-c31b-d2817d562aea@redhat.com>
In-Reply-To: <a00efe8e-e10a-da03-c31b-d2817d562aea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 06:42 PM, John Snow wrote:
>=20
>=20
> On 04/11/2017 06:29 PM, Eric Blake wrote:
>> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
>> but NBD wants to report status on byte granularity (even if the
>> reporting will probably be naturally aligned to sectors or even
>> much higher levels).  I've therefore started the task of
>> converting our block status code to report at a byte granularity
>> rather than sectors.
>>
>> This is part one of that conversion: bdrv_is_allocated().
>> Other parts (still to be written) include tracking dirty bitmaps
>> by bytes (it's still one bit per granularity, but now we won't
>> be double-scaling from bytes to sectors to granularity),

That series is not only written, but reviewed now:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02163.html


>> then
>> replacing bdrv_get_block_status() with a byte based callback
>> in all the drivers.

Coming up soon.

>>
>> Available as a tag at:
>> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-allocated-v1
>>
>> It requires v9 or later of my prior work on blkdebug:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01723.html
>> which in turn requires Max's block-next tree:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01298.html
>>

>>  include/block/block.h        |   6 +-
>>  include/block/block_backup.h |  11 +-
>>  include/qemu/ratelimit.h     |   3 +-
>>  block/backup.c               | 126 ++++++++----------
>>  block/commit.c               |  54 ++++----
>>  block/io.c                   |  59 +++++----
>>  block/mirror.c               | 300 ++++++++++++++++++++++------------=
---------
>>  block/replication.c          |  29 +++--
>>  block/stream.c               |  35 +++--
>>  block/vvfat.c                |  34 +++--
>>  migration/block.c            |   9 +-
>>  qemu-img.c                   |  15 ++-
>>  qemu-io-cmds.c               |  57 ++++----
>>  block/trace-events           |  14 +-
>>  14 files changed, 381 insertions(+), 371 deletions(-)
>=20
> Shame, you added ten lines!

Yeah, some of that back-and-forth scaling is verbose and resulted in
line breaks that used to fit in one.  Of course, the second series
regained those ten lines and more, once I got to flatten some of the
interfaces away from repeated scaling:

$ git diff --stat nbd-byte-allocated-v1..nbd-byte-dirty-v1 | cat
 include/block/block_int.h    |  2 +-
 include/block/dirty-bitmap.h | 21 ++++-------
 block/backup.c               |  7 ++--
 block/dirty-bitmap.c         | 83
++++++++++++--------------------------------
 block/io.c                   |  6 ++--
 block/mirror.c               | 73 +++++++++++++++++---------------------=

 migration/block.c            | 14 ++++----
 7 files changed, 74 insertions(+), 132 deletions(-)

>=20
>>
>=20
> Patches 1-15:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> 9: Is there a good reason for a void fn() to return its argument via a
> passed parameter? I see you're matching the other interface, but that
> strikes me as wonky.

It bothered me a bit too; beyond the copy-and-paste factor, my
justification was that the parameter is both input and output, rather
than output-only. But I don't mind respinning to add a preliminary patch
that fixes mirror_clip_sectors() to return a value, then pattern
mirror_clip_bytes to do likewise.

>=20
> 11: Looks correct to me, but this one's a bit hairier than the rest. Ho=
w
> many times do we truly need to round, adjust, clip, round again, align,=

> clip, round, align, ...

I don't know that there are that many rounds of clipping going on, but
there is definitely a lot of scaling, and it gets better as later
patches make even more things be byte-based.

>=20
> I'll take a peek at the last two tomorrow.

Thanks for plodding through it so far. For supposedly being no semantic
change, it is still definitely a lot to think about.  But the end result
is more legible, in my opinion.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lBkBsEQphTcNQIuxFP664OigK8AH4j76e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9WYkAAoJEKeha0olJ0NqRhsH/igME5jfMwQdBRNYbvC1bYh2
kJSQGXgQk3eYCAMg0+DLmUNFqGRPH5s9OPtEuE5NLuUKrMXGkh16YBQ5vOrlOdqH
sPrWw+1peUEQCI7FIRjIVHDrnONh/ktFRM+3Xv62jksM53S1D1gtuQ8ZSaWkUO4t
r8ahluOF1HxeS2X2B0yJooudR4O8YaMpXtlIiu3wj0R8uyJfS7v4yMR+af0b+9gA
xNpuC2YPyTrjpOujJGqCOQBY0thgz3zyo3zQMkhmSemI+kwZCzDpuT/BpzxOb4Q0
Xgr8gH2lostuLkkBI1qMjv3wYx+LFAe511ITF7V8hLm1H3fKtozaov9D3maB7XU=
=xS3U
-----END PGP SIGNATURE-----

--lBkBsEQphTcNQIuxFP664OigK8AH4j76e--
