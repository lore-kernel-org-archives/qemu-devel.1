Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLyAR-0007O5-2Q
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 17:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLyAP-0002Ob-Ib
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 17:25:19 -0500
From: Max Reitz <mreitz@redhat.com>
Message-ID: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
Date: Sun, 11 Nov 2018 23:25:00 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dDF7fHuWxqxI2tph7q5NJ5jKQHuxa4eRp"
Subject: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dDF7fHuWxqxI2tph7q5NJ5jKQHuxa4eRp
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
Subject: KVM Forum block no[td]es
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is what I=E2=80=99ve taken from two or three BoF-like get-togethers =
on
blocky things.  Amendments are more than welcome, of course.



Permission system
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

GRAPH_MOD
---------

We need some way for the commit job to prevent graph changes on its
chain while it is running.  Our current blocker doesn=E2=80=99t do the jo=
b,
however.  What to do?

- We have no idea how to make a *permission* work.  Maybe the biggest
  problem is that it just doesn=E2=80=99t work as a permission, because t=
he
  commit job doesn=E2=80=99t own the BdrvChildren that would need to be
  blocked (namely the @backing BdrvChild).

- A property of BdrvChild that can be set by a non-parent seems more
  feasible, e.g. a counter where changing the child is possible only
  if the counter is 0.  This also actually makes sense in what it
  means.
  (We never quite knew what =E2=80=9Ctaking the GRAPH_PERMISSION=E2=80=9D=
 or
  =E2=80=9Cunsharing the GRPAH_MOD permission=E2=80=9D was supposed to me=
an.  Figuring
  that out always took like half an our in any face-to-face meeting,
  and then we decided it was pretty much useless for any case we had
  at hand.)


Reopen
------

How should permissions be handled while the reopen is under way?
Maybe we should take the union of @perm before and after, and the
intersection of @shared before and after?

- Taking permissions is a transaction that can fail.  Reopen, too, is
  a transaction, and we want to go from the intermediate to the final
  permissions in reopen=E2=80=99s commit part, so that transition is not
  allowed to fail.
  Since with the above model we would only relax things during that
  transition (relinquishing bits from @perm and adding bits to
  @shared), this transition should in theory be possible without any
  failure.  However, in practice things are different, as permission
  changes with file-posix nodes imply lock changes on the filesystem
  -- which may always fail.  Arguably failures from changing the
  file-posix locks can be ignored, because that just means that the
  file claims more permissions to be taken and less to be shared than
  is actually the case.  Which means you may not be able to open the
  file in some other application, while you should be, but that=E2=80=99s=
 the
  benign kind of error.  You won=E2=80=99t be able to access data in a wa=
y
  you shouldn=E2=80=99t be able to.
  - Note that we have this issue already, so in general dropping
    permissions sometimes aborts because code assumes that dropping
    permissions is always safe and can never result in an error.  It
    seems best to ignore such protocol layer errors in the generic
    block layer rather than handling this in every protocol driver
    itself.
    (The block layer should discard errors from dropping permissions
    on the protocol layer.)

- Is it possible that changing an option may require taking an
  intermediate permission that is required neither before nor after
  the reopen process?
  Changing a child link comes to mind (like changing a child from one
  BDS to another, where the visible data changes, which would mean we
  may want to e.g. unshare CONSISTENT_READ during the reopen).
  However:
  1. It is unfeasible to unshare that for all child changes.
     Effectively everything requires CONSISTENT_READ, and for good
     reason.
  2. Why would a user even change a BDS to something of a different
     content?
  3. Anything that currently allows you to change a child node assumes
     that the user always changes it to something of the same content
     (some take extra care to verify this, like mirror, which makes
     sure that @replaces and the target are connected, and there are
     only filter nodes in between).
  Always using the same enforcing model as mirror does (no. 3 above)
  does not really work, though, because one use case is to copy a
  backing file offline to some different storage and then replace the
  files via QMP.  To qemu, both files are completely unrelated.


Block jobs, including blockdev-copy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Example for use of the fleecing filter:
- The real target is on slow storage.  Put an overlay on fast storage
  on top of it.  Then use that overlay as the target of the fleecing
  filter (and commit the data later or on the side), so that the
  backup job does not slow down the guest.

For a unified copy job, having a backup/fleecing filter is not a
problem on the way.  One thing we definitely have to and can do is to
copy common functionality into a shared file so that the different
jobs can at least share that.

COR/Stream:
- There should be a way to discard ranges that have been copied into
  the overlay from the backing files to save space
- Also, the COR filter should integrated with the stream job (at some
  point, as always)

Hole punching with active commit:
- Putting data into the target and punching holes in the overlays to
  make it visible on the active disk may be reasonable for some, but
  not for others -- it should be an option.  You want this if saving
  space is important, but you may not want this if speed is more
  important (depends on your backing chain length and other factors
  then, but that=E2=80=99s your choice).

- Another thing: If we don=E2=80=99t need to punch any holes because the
  intermediate layers aren=E2=80=99t allocated anyway, we don=E2=80=99t n=
eed to write
  the data into the active disk either.  This can probably be done
  indiscriminately, because the check for this does not concern the
  protocol layer but only qemu-controlled metadata, so it should be
  deterministically fast (want_zero=3Dfalse).


qcow2
=3D=3D=3D=3D=3D

Recovering corrupt images:
- Salvaging qemu-img convert would help (one that doesn=E2=80=99t abort
  everything on encountering a single I/O error)
- We may want to add an in-sync L1 table copy to recover from the
  worst kinds of corruptions.  Checksumming would be a good idea
  (then), too.
  - Should we update the checksum every time?  If it=E2=80=99s just the s=
um of
    all L1 entry values, why not, doing the update is trivial then and
    does not involve looking at any but the entries modified.

Online check:
- This would need to be a block job
- The check function would probably need to be a proper coroutine
  (that does not just lock everything)
- Would be very complicated if you wanted it to work on R/W images.
  It=E2=80=99s probably the best to focus on making this work for read-on=
ly
  images, because you can always just put a temporary snapshot over
  the image for the time of the test and then commit it down after the
  check is done.


Bitmaps
=3D=3D=3D=3D=3D=3D=3D

(Got this section from sneaking into a BoF I wasn=E2=80=99t invited to.  =
Oh
well.  Won=E2=80=99t hurt to include them here.)

Currently, when dirty bitmaps are loaded, all IN_USE bitmaps are just
not loaded at all and completely ignored.  That isn=E2=80=99t correct, th=
ough,
they should either still be loaded (and automatically treated and
written back as fully dirty), or at least qemu-img check should
=E2=80=9Crepair=E2=80=9D them (i.e. fully dirtying them).

Sometimes qemu (running in a mode as bare as possible) is better than
using qemu-img convert, for instance.  It gives you more control
(through QMP; you get e.g. better progress reporting), you get all of
the mirror optimizations (we do have optimizations for convert, too,
but whether it=E2=80=99s any good to write the same (or different?)
optimizations twice is another question), and you get a common
interface for everything (online and offline).
Note that besides a bare qemu we=E2=80=99ve also always wanted to convert=
 as
many qemu-img operations into frontends for block jobs as possible.
We have only done this for commit, however, even though convert looked
like basically the ideal target.  It was just too hard with too little
apparent gain, like always (and convert supports additional features
like concatenation which we don=E2=80=99t have in the runtime block layer=

yet).

Someone (not that someone=E2=84=A2, but actually some specific someone) i=
s
about to make qemu-img info display the list of persistent bitmaps.
Potential reviewers should be aware of the fact that this should be
done bye adding that information to ImageInfoSpecificQCow2.

Transacitonable bitmap primitives (e.g. copying a bitmap) would be
nice so you can use them when creating a snapshot.  Then it=E2=80=99d be =
up to
the management layer to make use of them:
- Do you want to continue using the very same bitmap?  Copy it then
  (or move it, depending on what exactly you want to do and what
  primitives there are)
- Do you want to start with a new bitmap?  Then just create a new one
  along with the overlay.


Misc topics
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SEEK_HOLE/SEEK_DATA:
- According to Denis, the bugs left in SEEK_HOLE and fiemap are the
  same now, but the former is slow when you seek over large ranges
  (because we just want to know whether a certain portion is allocated
  or not, but SEEK_HOLE/DATA actively seeks until the next hole/data
  region and queries all metadata on that path, regardless whether we
  even care anymore)
  - Whether the bugs are the same depends on the version of Linux,
    however, and there is no clear way to determine for qemu whether
    fiemap is usable or not
  - Making it a configure option would leave it to the user or
    distribution, who should know for sure

Multiqueue with multiple iothreads:
- Kevin says Paolo says he=E2=80=99s working on it.  But there are some
  prerequisites left, the main one apparently being that there is one
  aio_poll() left that polls from the wrong context.  With that gone,
  we can also probably drop AIO context altogether.

Some things we want from a cache block driver:
- An optional maximum resident memory size; in this case, the driver
  needs to be backed by another node it uses for swapping
- Should support taking a bitmap from the cached node, from which it
  would then preload all dirty clusters


--dDF7fHuWxqxI2tph7q5NJ5jKQHuxa4eRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvorDwACgkQ9AfbAGHV
z0AIJQf/ZnMazJ8sgZ45KIMNdJ2uwPa7yVGeCh875qriTryI8jBFgGVLlNZdbEUb
XBTbItl+9sKdbWMrKn+bS5oCaBUsa/KK+qHC5m3EKnXPn1N1ftbCwnL+1atG+ynI
y23Wo1Fsc14XhloJYlfXwom/iN0vDkoD2M51djgMd83HIEWXXVkARKAhjKbh2yJO
hlT0j5iD7QMeEFhCr6PuKdYW1v5Qvpk1TKg22fXiUiHLMZHYQ8D4uwtB75chH2HJ
PnC9ftak/+MFF6yIoS8i7hjBr1NIEW0Ph+5wvrJQnQ8MbNkZ+xCmZHJZsiYkbpE4
9qaY0Ykio1WzlXYov6e9TEW8wFrmIg==
=dhby
-----END PGP SIGNATURE-----

--dDF7fHuWxqxI2tph7q5NJ5jKQHuxa4eRp--
