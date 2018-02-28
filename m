Received: from eggs.gnu.org ([2001:4830:134:3::10]:54909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2GE-00010Q-6q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2GD-0006qp-B4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:59:10 -0500
Date: Wed, 28 Feb 2018 13:58:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228135850.GN17774@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228131315.30194-1-mreitz@redhat.com>
	<20180228131315.30194-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228131315.30194-2-mreitz@redhat.com>
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org

On Wed, Feb 28, 2018 at 02:13:14PM +0100, Max Reitz wrote:
> Storing the lseek() result in an int results in it overflowing when the
> file is at least 2 GB big.  Then, we have a 50 % chance of the result
> being "negative" and thus thinking an error occurred when actually
> everything went just fine.
>=20
> So we should use the correct type for storing the result: off_t.
>=20
> Reported-by: Daniel P. Berrange <berrange@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1549231
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index f1591c3849..90c25864a0 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1697,6 +1697,7 @@ static int raw_regular_truncate(int fd, int64_t o=
ffset, PreallocMode prealloc,
>      case PREALLOC_MODE_FULL:
>      {
>          int64_t num =3D 0, left =3D offset - current_length;
> +        off_t seek_result;
> =20
>          /*
>           * Knowing the final size from the beginning could allow the f=
ile
> @@ -1711,8 +1712,8 @@ static int raw_regular_truncate(int fd, int64_t o=
ffset, PreallocMode prealloc,
> =20
>          buf =3D g_malloc0(65536);
> =20
> -        result =3D lseek(fd, current_length, SEEK_SET);
> -        if (result < 0) {
> +        seek_result =3D lseek(fd, current_length, SEEK_SET);
> +        if (seek_result < 0) {
>              result =3D -errno;
>              error_setg_errno(errp, -result,
>                               "Failed to seek to the old end of file");

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
