Received: from eggs.gnu.org ([2001:4830:134:3::10]:53390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2Ae-0007Mj-C4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2Ad-0002ia-6p
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:53:24 -0500
Date: Wed, 28 Feb 2018 13:53:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228135305.GM17774@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228131315.30194-1-mreitz@redhat.com>
	<20180228131315.30194-2-mreitz@redhat.com>
	<20180228133434.GL17774@redhat.com>
	<1fc55643-7ca6-26a5-7e2e-7d6b09a43a13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fc55643-7ca6-26a5-7e2e-7d6b09a43a13@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] block/file-posix: Fix fully
 preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, "eblake@redhat.com Kevin Wolf" <kwolf@redhat.com>, qemu-stable@nongnu.org

On Wed, Feb 28, 2018 at 02:45:49PM +0100, Max Reitz wrote:
> On 2018-02-28 14:34, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Feb 28, 2018 at 02:13:14PM +0100, Max Reitz wrote:
> >> Storing the lseek() result in an int results in it overflowing when =
the
> >> file is at least 2 GB big.  Then, we have a 50 % chance of the resul=
t
> >> being "negative" and thus thinking an error occurred when actually
> >> everything went just fine.
> >>
> >> So we should use the correct type for storing the result: off_t.
> >>
> >> Reported-by: Daniel P. Berrange <berrange@redhat.com>
> >> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1549231
> >> Cc: qemu-stable@nongnu.org
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/file-posix.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/file-posix.c b/block/file-posix.c
> >> index f1591c3849..90c25864a0 100644
> >> --- a/block/file-posix.c
> >> +++ b/block/file-posix.c
> >> @@ -1697,6 +1697,7 @@ static int raw_regular_truncate(int fd, int64_=
t offset, PreallocMode prealloc,
> >>      case PREALLOC_MODE_FULL:
> >>      {
> >>          int64_t num =3D 0, left =3D offset - current_length;
> >> +        off_t seek_result;
> >> =20
> >>          /*
> >>           * Knowing the final size from the beginning could allow th=
e file
> >> @@ -1711,8 +1712,8 @@ static int raw_regular_truncate(int fd, int64_=
t offset, PreallocMode prealloc,
> >> =20
> >>          buf =3D g_malloc0(65536);
> >> =20
> >> -        result =3D lseek(fd, current_length, SEEK_SET);
> >> -        if (result < 0) {
> >> +        seek_result =3D lseek(fd, current_length, SEEK_SET);
> >> +        if (seek_result < 0) {
> >=20
> > off_t is an unsigned type, so this comparison to "< 0" is bogus - onl=
y the
> > exact value (off_t)-1 indicates an error. So this needs to be
> >=20
> >    if (seek_result =3D=3D (off_t)-1) {
> >       ...
> >    }
>=20
> Hmmm... On my system, it appears to be a long int[1].  And
> find_allocation() does an off_t < 0 comparison already.  And
> "man 0p sys_types.h" says "blkcnt_t and off_t shall be signed integer
> types."

Hmm, that's odd then - lseek man page explicitly said it must be cast,
which suggested to me it could be unsigned:

   RETURN VALUE
       Upon successful completion, lseek() returns the resulting offset  =
loca=E2=80=90
       tion  as  measured  in bytes from the beginning of the file.  On e=
rror,
       the value (off_t) -1 is returned and  errno  is  set  to  indicate=
  the
       error.

CC'ing Eric for the "official" POSIX answer....

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
