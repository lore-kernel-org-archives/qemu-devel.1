Received: from eggs.gnu.org ([209.51.188.92]:33909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKuIz-0008H1-LN
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKuIy-0005DT-7I
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:38:01 -0400
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
Date: Mon, 29 Apr 2019 02:37:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1EIwOoTLBUOpzjRdGND7sGLAJslZzwcb7"
Subject: Re: [Qemu-devel] [PATCH v5 00/10] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1EIwOoTLBUOpzjRdGND7sGLAJslZzwcb7
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
Subject: Re: [PATCH v5 00/10] qcow2: encryption threads
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
> v5: rebase on master, some conflicts resolved due to data-file feature
>=20
> 01: new patch, just move test from cover letter to a file. I really hop=
e that it
>     will not hang the whole series, so, if we don't want it as is or wi=
th really
>     tiny improvements, I'd prefer to skip it and queue 02-10 first.

Yup, noted.

> 09: "true" parameter added to moved qcow2_pre_write_overlap_check() cal=
l due to
>     rebase on master (both before and after patch). Seems OK, so keep A=
lberto's r-b.
>=20
> performance:
>=20
> after 01:
>  # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.=
enc.qcow2
> 14.18
>  # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.=
enc.qcow2 -W
> 13.77
>=20
> after 10:
>  # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.=
enc.qcow2
> 14.35
>  # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.=
enc.qcow2 -W
> 5.62

Hm, I see those results as well:

Before:
w/o -W: 7.15
w/  -W: 6.77

After:
w/o -W: 7.19
w/  -W: 3.65


But with -t none, this is what I get:

Before:
w/o -W: 15.98
w/  -W: 10.91

After:
w/o -W: 19.95
w/  -W: 11.77


For good measure, on tmpfs:

Before:
w/o -W: 6.98
w/  -W: 6.75

After:
w/o -W: 7.04
w/  -W: 3.63


So it looks like the results with cache enabled are really only in the
cache.  When it goes down to disk, this series seems to decrease
performance.

To confirm whether that=E2=80=99s actually the case, I took another machi=
ne with
an SSD where I have more empty space and increased the size to 8 GB (not
the $size, because qemu-io doesn't like that, but well, yeah), and then
ran it again without cache:

Before:
w/o -W: ~50 - ~60 (varies...)
w/  -W: ~50 - ~70

After:
w/o -W: ~60
w/  -W: ~55 - ~85


So it does seem slower, although the values vary so much that it=E2=80=99=
s
difficult to tell.

Hmm...  And on that machine, there is no difference between before and
after when using -t none.  So I suppose it also depends on the device?



OK, I tried using qemu-img bench.  After patching it to accept --object,
these are the results I got with -t none -w on a preallocated (full) 8
GB image:

Before:
HDD: 17.7 s, 17.8 s, 18.0 s
SSD 1: 12.9 s, 15.8 s, 15.1 s
SSD 2: 1.8 s, 1.7 s, 1.7 s

After:
HDD: 16.1 s, 15.8 s, 15.8 s
SSD 1: 16.3 s, 18.0 s, 17.9 s
SSD 2: 2.0 s, 1.5 s, 1.5 s

Result #1: My SSD 1 is trash.

Result #2: I need more requests for SSD 2 to get a useful results.
Let's try again with 2^20:
Before: 23.8, 23.5, 23.3
After:  21.0, 20.6, 20.5

OK, and I can clearly see that this series increases the CPU usage
(which is good).


So...  Hm.  I suppose I conclude that this series decreases performance
on trashy SSDs?  But it gets better on my HDD and on my good SSD, so...
 Good thing I tested it, or something.

The only really interesting thing that came out of this is that I didn't
see an improvement with qemu-img convert (only on tmpfs), but that I do
see it with qemu-img bench.  So I'm wondering why you aren't using
qemu-img bench in the test in your first patch...?

Max

> Vladimir Sementsov-Ogievskiy (10):
>   tests/perf: Test qemu-img convert from raw to encrypted qcow2
>   qcow2.h: add missing include
>   qcow2: add separate file for threaded data processing functions
>   qcow2-threads: use thread_pool_submit_co
>   qcow2-threads: qcow2_co_do_compress: protect queuing by mutex
>   qcow2-threads: split out generic path
>   qcow2: qcow2_co_preadv: improve locking
>   qcow2: qcow2_co_preadv: skip using hd_qiov when possible
>   qcow2: bdrv_co_pwritev: move encryption code out of the lock
>   qcow2: do encryption in threads
>=20
>  block/qcow2.h                               |  20 +-
>  block/qcow2-bitmap.c                        |   1 -
>  block/qcow2-cache.c                         |   1 -
>  block/qcow2-cluster.c                       |   8 +-
>  block/qcow2-refcount.c                      |   1 -
>  block/qcow2-snapshot.c                      |   1 -
>  block/qcow2-threads.c                       | 268 +++++++++++++++++++
>  block/qcow2.c                               | 275 ++++----------------=

>  block/Makefile.objs                         |   2 +-
>  tests/perf/block/qcow2/convert-to-encrypted |  48 ++++
>  10 files changed, 389 insertions(+), 236 deletions(-)
>  create mode 100644 block/qcow2-threads.c
>  create mode 100755 tests/perf/block/qcow2/convert-to-encrypted
>=20



--1EIwOoTLBUOpzjRdGND7sGLAJslZzwcb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzGR0QACgkQ9AfbAGHV
z0Brvgf+Nf7/PX7O9nnKTLzo7Vke+2wz55yLuFzvfrbaraPPj30eC/xqMSsPk3xU
GRD7hL/a3MzDuhovdglyQlCENa+UmXuyT2ihS18ZzdkNdNns+AdWrMb4pbk+mvm1
teqJe/uDphxR06DmhhCWJTLG+MUUJKvK4Ejs9DDNeXRn58vedWq50/SerXs5SjnN
p+oqK6VgShNWAqvmsM1qn+98MOLkibklee58QMQTuK7tVPNNl00I6CeZtasKGDfG
DJzwpZz2TimExhkyi1BBmCCeG6VAo/RJkOp+lmHw7YPxHzztH/2wGgns5RICjvS6
YVMqIu1k5ROCAzOaKBqWL54AOu3vCQ==
=gBjF
-----END PGP SIGNATURE-----

--1EIwOoTLBUOpzjRdGND7sGLAJslZzwcb7--
