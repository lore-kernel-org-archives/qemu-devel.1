Received: from eggs.gnu.org ([209.51.188.92]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw1X1-0006B5-MZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw1Wz-0002qO-QT
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:17:39 -0500
Date: Tue, 19 Feb 2019 10:17:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219091729.GE4727@localhost.localdomain>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-12-kwolf@redhat.com>
	<d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.02.2019 um 01:47 hat Max Reitz geschrieben:
> On 31.01.19 18:55, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json | 1 +
> >  block/qcow2.c        | 6 +++++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> [...]
>=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 4959bf16a4..e3427f9fcd 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -1459,7 +1459,9 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
> >      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> >          s->data_file =3D bdrv_open_child(NULL, options, "data-file", b=
s,
> >                                         &child_file, false, &local_err);
> > -        if (!s->data_file) {
> > +        if (s->data_file) {
> > +            s->image_data_file =3D g_strdup(s->data_file->bs->filename=
);
> > +        } else {
> >              if (s->image_data_file) {
> >                  error_free(local_err);
> >                  local_err =3D NULL;
>=20
> Ah, this is what I looked for in the last patch. :-)
>=20
> (i.e. it should be in the last patch, not here)

[RFC PATCH 11/11] qcow2: Add data file to ImageInfoSpecificQCow2

This is the last patch. :-P

> I think as it is it is just wrong, though.  If I pass enough options at
> runtime, this will overwrite the image header:
>=20
> $ ./qemu-img create -f qcow2 -o data_file=3Dfoo.raw foo.qcow2 64M
> $ ./qemu-img create -f raw bar.raw 64M
> $ ./qemu-img info foo.qcow2
> [...]
>     data file: foo.raw
> [...]
> $ ./qemu-io --image-opts \
>     file.filename=3Dfoo.qcow2,data-file.driver=3Dfile,\
> data-file.filename=3Dbar.raw,lazy-refcounts=3Don \
>     -c 'write 0 64k'
> # (The lazy-refcounts is so the image header is updated)
> $ ./qemu-img info foo.qcow2
> [...]
>     data file: bar.raw
> [...]
>=20
> The right thing would probably to check whether the header extension
> exists (i.e. if s->image_data_file is non-NULL) and if it does not (it
> is NULL), s->image_data_file gets set; because there are no valid images
> with the external data file flag set where there is no such header
> extension.  So we must be in the process of creating the image right now.
>=20
> But even then, I don't quite like setting it here and not creating the
> header extension as part of qcow2_co_create().  I can see why you've
> done it this way, but creating a "bad" image on purpose (one with the
> external data file bit set, but no such header extension present yet) in
> order to detect and rectify this case when it is first opened (and the
> opening code assuming that any such broken image must be one that is
> opened the first time) is a bit weird.

It's not really a bad image, just one that's a bit cumbersome to use
because you need to specify the 'data-file' option manually.

> I suppose doing it right (if you agree with the paragraph before the
> last one) and adding a comment would make it less weird
> ("s->image_data_file must be non-NULL for any valid image, so this image
> must be one we are creating right now" or something like that).
>=20
> But still, the issue you point out in your cover letter remains; which
> is that the node's filename and the filename given by the user may be
> two different things.

I think what I was planning to do was leaving the path from the image
header in s->image_data_file even when a runtime option overrides it.
After all, ImageInfo is about the image, not about the runtime state.

Image creation would just manually set s->image_data_file before
updating the header.

Kevin

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJca8mpAAoJEH8JsnLIjy/WBqwP/A0WHlAihWU2jSMdnAIWTeJk
iUTpBxrey6MUXZ/zW3MK6QZmoudgjnLARCcQg38dw6fQzanhm6ulsznZRMCYkVKY
5YzLn+cb6zSrA6taXbTq+y/Q9KZHBWAZ+rggLBLVgn467fkbN/7YLDWoQpf/fjO/
5mj8blpM6fV6gOik2y3ZqreC/mPXkpauTToWbmogsN+yjsznBXr4pEzcDO1/H8M8
rJ3eOVV1SFGLoOywm9KuSKRgdVALrQ5daAc3+49Jn31v7DRx4VPuno0en0+UaVvD
Czcd/tTS9xOH8dasWl72aZoyaCpO5/wFsDxsKdBFH+znsQqOsSzFNp7NI7Rewalv
tQVMOeR6lfIHJtALgScUTW96LmzT4NlXsFCOjTM8mNdHKar/HV8ymsY3IBqZ8AAD
Utjjh86bUUrtm0zIASWBbXLlPts1IHUBqdkrTHkZgQ/Y222bZStgcGGIlgS7iA6O
LnVcgwCZ8be6DI12vAHIhzByXiQh/CBWCYszJbm7xjONiQ0eRdRaNKR68hwtVFg1
tyjUTGRfLA6scfQWrVyvMqo9YEfPrrcW8rEnotZTmGgsqQXHOI1yDpvjiizTeU+h
udy5+UAV3AtALTDh/+OgxSxaRkWZVkYB/zo3pw04is91iQQCLQmW//VkDS9kCyJj
/DcPBVvb2H7IabddVIcQ
=0GxW
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
