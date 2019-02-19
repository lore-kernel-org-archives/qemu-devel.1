Received: from eggs.gnu.org ([209.51.188.92]:57953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvtYz-00086E-AP
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvtYy-00035h-A6
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:47:09 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-12-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
Date: Tue, 19 Feb 2019 01:47:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-12-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DHg3VKAOWEWWHvVGkg68PpeLwhkIRqNhb"
Subject: Re: [Qemu-devel] [RFC PATCH 11/11] qcow2: Add data file to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DHg3VKAOWEWWHvVGkg68PpeLwhkIRqNhb
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
Subject: Re: [RFC PATCH 11/11] qcow2: Add data file to ImageInfoSpecificQCow2
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-12-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 18:55, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 1 +
>  block/qcow2.c        | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4959bf16a4..e3427f9fcd 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1459,7 +1459,9 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>          s->data_file =3D bdrv_open_child(NULL, options, "data-file", b=
s,
>                                         &child_file, false, &local_err)=
;
> -        if (!s->data_file) {
> +        if (s->data_file) {
> +            s->image_data_file =3D g_strdup(s->data_file->bs->filename=
);
> +        } else {
>              if (s->image_data_file) {
>                  error_free(local_err);
>                  local_err =3D NULL;

Ah, this is what I looked for in the last patch. :-)

(i.e. it should be in the last patch, not here)

I think as it is it is just wrong, though.  If I pass enough options at
runtime, this will overwrite the image header:

$ ./qemu-img create -f qcow2 -o data_file=3Dfoo.raw foo.qcow2 64M
$ ./qemu-img create -f raw bar.raw 64M
$ ./qemu-img info foo.qcow2
[...]
    data file: foo.raw
[...]
$ ./qemu-io --image-opts \
    file.filename=3Dfoo.qcow2,data-file.driver=3Dfile,\
data-file.filename=3Dbar.raw,lazy-refcounts=3Don \
    -c 'write 0 64k'
# (The lazy-refcounts is so the image header is updated)
$ ./qemu-img info foo.qcow2
[...]
    data file: bar.raw
[...]

The right thing would probably to check whether the header extension
exists (i.e. if s->image_data_file is non-NULL) and if it does not (it
is NULL), s->image_data_file gets set; because there are no valid images
with the external data file flag set where there is no such header
extension.  So we must be in the process of creating the image right now.=


But even then, I don't quite like setting it here and not creating the
header extension as part of qcow2_co_create().  I can see why you've
done it this way, but creating a "bad" image on purpose (one with the
external data file bit set, but no such header extension present yet) in
order to detect and rectify this case when it is first opened (and the
opening code assuming that any such broken image must be one that is
opened the first time) is a bit weird.

I suppose doing it right (if you agree with the paragraph before the
last one) and adding a comment would make it less weird
("s->image_data_file must be non-NULL for any valid image, so this image
must be one we are creating right now" or something like that).

But still, the issue you point out in your cover letter remains; which
is that the node's filename and the filename given by the user may be
two different things.

Max


--DHg3VKAOWEWWHvVGkg68PpeLwhkIRqNhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxrUgQACgkQ9AfbAGHV
z0DgqQgAoK78MLjOXMVlORZserxSFDx4hXGUqQRbOvwIDyTDgn3nTzL7PghGHgAJ
7H9z1iArykVCwWe87UIg0aZjA30hMxLD5tsTI1bvABbbM3+0lOaIpJE3s5foDyEn
GH4HL51jgzEY5akIMYxXKr4Fu2aBBLAAvTOvF2nbyUc7VhvdVHsYOva7QUi1YVE2
f/j3UiAlxRX8VO/1DOfXNyPqyb8r3hCnODAFv7MBm+/faXYDB77e8BTbnPf5vRbp
WE9GbXFlnUVn5oaB/V+/RLftGf8RvV5oisLABMNIo9mb/BSbd/ugl/Cf/ywiCYkG
w6WbFfKabG5LAjtzd9GW0gjqFwmkwQ==
=e9VJ
-----END PGP SIGNATURE-----

--DHg3VKAOWEWWHvVGkg68PpeLwhkIRqNhb--
