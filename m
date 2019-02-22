Received: from eggs.gnu.org ([209.51.188.92]:37188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxDCp-0002Df-SM
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxDCo-0004X3-N5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:57:43 -0500
Date: Fri, 22 Feb 2019 16:57:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190222155737.GD8035@dhcp-200-176.str.redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-12-kwolf@redhat.com>
	<d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
	<20190219091729.GE4727@localhost.localdomain>
	<ade91fc9-dab1-926b-dfba-d7347fcf62bc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <ade91fc9-dab1-926b-dfba-d7347fcf62bc@redhat.com>
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2019 um 14:51 hat Max Reitz geschrieben:
> On 19.02.19 10:17, Kevin Wolf wrote:
> > Am 19.02.2019 um 01:47 hat Max Reitz geschrieben:
> >> On 31.01.19 18:55, Kevin Wolf wrote:
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  qapi/block-core.json | 1 +
> >>>  block/qcow2.c        | 6 +++++-
> >>>  2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> [...]
> >>
> >>> diff --git a/block/qcow2.c b/block/qcow2.c
> >>> index 4959bf16a4..e3427f9fcd 100644
> >>> --- a/block/qcow2.c
> >>> +++ b/block/qcow2.c
> >>> @@ -1459,7 +1459,9 @@ static int coroutine_fn qcow2_do_open(BlockDriv=
erState *bs, QDict *options,
> >>>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> >>>          s->data_file =3D bdrv_open_child(NULL, options, "data-file",=
 bs,
> >>>                                         &child_file, false, &local_er=
r);
> >>> -        if (!s->data_file) {
> >>> +        if (s->data_file) {
> >>> +            s->image_data_file =3D g_strdup(s->data_file->bs->filena=
me);
> >>> +        } else {
> >>>              if (s->image_data_file) {
> >>>                  error_free(local_err);
> >>>                  local_err =3D NULL;
> >>
> >> Ah, this is what I looked for in the last patch. :-)
> >>
> >> (i.e. it should be in the last patch, not here)
> >=20
> > [RFC PATCH 11/11] qcow2: Add data file to ImageInfoSpecificQCow2
> >=20
> > This is the last patch. :-P
>=20
> Sorry, I meant the previous one.
>=20
> >> I think as it is it is just wrong, though.  If I pass enough options at
> >> runtime, this will overwrite the image header:
> >>
> >> $ ./qemu-img create -f qcow2 -o data_file=3Dfoo.raw foo.qcow2 64M
> >> $ ./qemu-img create -f raw bar.raw 64M
> >> $ ./qemu-img info foo.qcow2
> >> [...]
> >>     data file: foo.raw
> >> [...]
> >> $ ./qemu-io --image-opts \
> >>     file.filename=3Dfoo.qcow2,data-file.driver=3Dfile,\
> >> data-file.filename=3Dbar.raw,lazy-refcounts=3Don \
> >>     -c 'write 0 64k'
> >> # (The lazy-refcounts is so the image header is updated)
> >> $ ./qemu-img info foo.qcow2
> >> [...]
> >>     data file: bar.raw
> >> [...]
> >>
> >> The right thing would probably to check whether the header extension
> >> exists (i.e. if s->image_data_file is non-NULL) and if it does not (it
> >> is NULL), s->image_data_file gets set; because there are no valid imag=
es
> >> with the external data file flag set where there is no such header
> >> extension.  So we must be in the process of creating the image right n=
ow.
> >>
> >> But even then, I don't quite like setting it here and not creating the
> >> header extension as part of qcow2_co_create().  I can see why you've
> >> done it this way, but creating a "bad" image on purpose (one with the
> >> external data file bit set, but no such header extension present yet) =
in
> >> order to detect and rectify this case when it is first opened (and the
> >> opening code assuming that any such broken image must be one that is
> >> opened the first time) is a bit weird.
> >=20
> > It's not really a bad image, just one that's a bit cumbersome to use
> > because you need to specify the 'data-file' option manually.
>=20
> Of course it's bad because it doesn't adhere to the specification (which
> you could amend, of course, since you add it with this series).  The
> spec says "If this bit is set, an external data file name header
> extension must be present as well."  Which it isn't until the image is
> opened with the data-file option.

Hm, I wonder whether that's a good requirement to make or whether we
should indeed change the spec. It wouldn't be so bad to have images that
require the data-file runtime option.

I guess we could lift the restriction later if we want to make use of
it. But the QEMU code is already written in a way that this works, so
maybe just allow it.

> >> I suppose doing it right (if you agree with the paragraph before the
> >> last one) and adding a comment would make it less weird
> >> ("s->image_data_file must be non-NULL for any valid image, so this ima=
ge
> >> must be one we are creating right now" or something like that).
> >>
> >> But still, the issue you point out in your cover letter remains; which
> >> is that the node's filename and the filename given by the user may be
> >> two different things.
> >=20
> > I think what I was planning to do was leaving the path from the image
> > header in s->image_data_file even when a runtime option overrides it.
> > After all, ImageInfo is about the image, not about the runtime state.
>=20
> I'm not talking about ImageInfo here, though, I'm talking about the
> image creation process.  The hunk I've quoted should be in the previous
> patch, not in this one.
>=20
> Which doesn't make wrong what you're saying, though, the ImageInfo
> should print what's in the header.
>=20
> > Image creation would just manually set s->image_data_file before
> > updating the header.
>=20
> It should, but currently it does that rather indirectly (by setting the
> data-file option which then makes qcow2_do_open() copy it into
> s->image_data_file).

I'm not exactly sure what detail in the image creation process you are
talking about.

I confirmed that this way of getting the filename into the header is
broken, and it was a known problem when I sent the series, spelt out in
the cover letter and in fact fixed in my git branch by now.

Is there anything else about the image creation process that needs
fixing?

Kevin

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJccBvxAAoJEH8JsnLIjy/WCyUQAJfWh7Ly+vxm++F/dnxaYduS
jXk1HwLn/sdQucxjD6cWmS8EVxFXuiPdyYsPKH40VYktS6IixlNznPN5pawVxJmS
NBhnoNGylUSR+DcnbYy+01ymiDJjLZPBYW8T3ApVzn8Vq1HEsDMX6f+L/i8n8MhJ
Ib46IKvprf90BkkRS9EokgwjomBnfukg8bTeIG5xBNxCkgNDDh1uMs1Jss+ecEii
yqMQu7pyByL6DkFzYUgMsl79lTHcvEKCft14KhYePZUsRNw4qVMn7v+BhaJRelqI
Z3B5nxTmgW4lvTttYIJAcPS81d0pP68xGPARY2D2DWuMUi0IcSlCR27wnxJJ65kF
mFvd5YnxofxQnMMwdMqP3qYm9Zl38avM046CQ9OBLErMGALMSuiZuQs3ZSDrfanH
gmxIJyDFeNphpCP2/3hAp+Gs6CPvzVmqE9g8gn6yIYrTukmjCwZHPQksSTmt58hR
zFkg0z6/shs6XzgB6XoEEyYj/hNLbQNHahtaq9jruLcaxwKQMy66tpxc5F5eiLaB
n08ZW4EinUva6aGuYz4QprjpA0XqDfjOzL+kvIwKmQOzzW/LAkO2BQ7XGHvvwkHy
Kc0xLVDTmcw9BbnT6+n6Bj4fKEp21JvZFkuuChKwIug4YxQ2ZcEfC0b44JdM5RGH
EWzP1geI3FMF90ugHprS
=2UKd
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
