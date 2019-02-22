Received: from eggs.gnu.org ([209.51.188.92]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxDk8-0000cM-5x
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxDjv-0006Pd-KR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:31:59 -0500
Date: Fri, 22 Feb 2019 17:29:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190222162956.GF8035@dhcp-200-176.str.redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-12-kwolf@redhat.com>
	<d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
	<20190219091729.GE4727@localhost.localdomain>
	<ade91fc9-dab1-926b-dfba-d7347fcf62bc@redhat.com>
	<20190222155737.GD8035@dhcp-200-176.str.redhat.com>
	<a77df09e-681c-50bd-2e0f-ea0cabdd0510@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <a77df09e-681c-50bd-2e0f-ea0cabdd0510@redhat.com>
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


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2019 um 17:13 hat Max Reitz geschrieben:
> On 22.02.19 16:57, Kevin Wolf wrote:
> > Am 22.02.2019 um 14:51 hat Max Reitz geschrieben:
> >> On 19.02.19 10:17, Kevin Wolf wrote:
> >>> Am 19.02.2019 um 01:47 hat Max Reitz geschrieben:
> >>>> On 31.01.19 18:55, Kevin Wolf wrote:
> >>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>>>> ---
> >>>>>  qapi/block-core.json | 1 +
> >>>>>  block/qcow2.c        | 6 +++++-
> >>>>>  2 files changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>> [...]
> >>>>
> >>>>> diff --git a/block/qcow2.c b/block/qcow2.c
> >>>>> index 4959bf16a4..e3427f9fcd 100644
> >>>>> --- a/block/qcow2.c
> >>>>> +++ b/block/qcow2.c
> >>>>> @@ -1459,7 +1459,9 @@ static int coroutine_fn qcow2_do_open(BlockDr=
iverState *bs, QDict *options,
> >>>>>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> >>>>>          s->data_file =3D bdrv_open_child(NULL, options, "data-file=
", bs,
> >>>>>                                         &child_file, false, &local_=
err);
> >>>>> -        if (!s->data_file) {
> >>>>> +        if (s->data_file) {
> >>>>> +            s->image_data_file =3D g_strdup(s->data_file->bs->file=
name);
> >>>>> +        } else {
> >>>>>              if (s->image_data_file) {
> >>>>>                  error_free(local_err);
> >>>>>                  local_err =3D NULL;
> >>>>
> >>>> Ah, this is what I looked for in the last patch. :-)
> >>>>
> >>>> (i.e. it should be in the last patch, not here)
> >>>
> >>> [RFC PATCH 11/11] qcow2: Add data file to ImageInfoSpecificQCow2
> >>>
> >>> This is the last patch. :-P
> >>
> >> Sorry, I meant the previous one.
> >>
> >>>> I think as it is it is just wrong, though.  If I pass enough options=
 at
> >>>> runtime, this will overwrite the image header:
> >>>>
> >>>> $ ./qemu-img create -f qcow2 -o data_file=3Dfoo.raw foo.qcow2 64M
> >>>> $ ./qemu-img create -f raw bar.raw 64M
> >>>> $ ./qemu-img info foo.qcow2
> >>>> [...]
> >>>>     data file: foo.raw
> >>>> [...]
> >>>> $ ./qemu-io --image-opts \
> >>>>     file.filename=3Dfoo.qcow2,data-file.driver=3Dfile,\
> >>>> data-file.filename=3Dbar.raw,lazy-refcounts=3Don \
> >>>>     -c 'write 0 64k'
> >>>> # (The lazy-refcounts is so the image header is updated)
> >>>> $ ./qemu-img info foo.qcow2
> >>>> [...]
> >>>>     data file: bar.raw
> >>>> [...]
> >>>>
> >>>> The right thing would probably to check whether the header extension
> >>>> exists (i.e. if s->image_data_file is non-NULL) and if it does not (=
it
> >>>> is NULL), s->image_data_file gets set; because there are no valid im=
ages
> >>>> with the external data file flag set where there is no such header
> >>>> extension.  So we must be in the process of creating the image right=
 now.
> >>>>
> >>>> But even then, I don't quite like setting it here and not creating t=
he
> >>>> header extension as part of qcow2_co_create().  I can see why you've
> >>>> done it this way, but creating a "bad" image on purpose (one with the
> >>>> external data file bit set, but no such header extension present yet=
) in
> >>>> order to detect and rectify this case when it is first opened (and t=
he
> >>>> opening code assuming that any such broken image must be one that is
> >>>> opened the first time) is a bit weird.
> >>>
> >>> It's not really a bad image, just one that's a bit cumbersome to use
> >>> because you need to specify the 'data-file' option manually.
> >>
> >> Of course it's bad because it doesn't adhere to the specification (whi=
ch
> >> you could amend, of course, since you add it with this series).  The
> >> spec says "If this bit is set, an external data file name header
> >> extension must be present as well."  Which it isn't until the image is
> >> opened with the data-file option.
> >=20
> > Hm, I wonder whether that's a good requirement to make or whether we
> > should indeed change the spec. It wouldn't be so bad to have images that
> > require the data-file runtime option.
> >=20
> > I guess we could lift the restriction later if we want to make use of
> > it. But the QEMU code is already written in a way that this works, so
> > maybe just allow it.
>=20
> OK for me.
>=20
> >>>> I suppose doing it right (if you agree with the paragraph before the
> >>>> last one) and adding a comment would make it less weird
> >>>> ("s->image_data_file must be non-NULL for any valid image, so this i=
mage
> >>>> must be one we are creating right now" or something like that).
> >>>>
> >>>> But still, the issue you point out in your cover letter remains; whi=
ch
> >>>> is that the node's filename and the filename given by the user may be
> >>>> two different things.
> >>>
> >>> I think what I was planning to do was leaving the path from the image
> >>> header in s->image_data_file even when a runtime option overrides it.
> >>> After all, ImageInfo is about the image, not about the runtime state.
> >>
> >> I'm not talking about ImageInfo here, though, I'm talking about the
> >> image creation process.  The hunk I've quoted should be in the previous
> >> patch, not in this one.
> >>
> >> Which doesn't make wrong what you're saying, though, the ImageInfo
> >> should print what's in the header.
> >>
> >>> Image creation would just manually set s->image_data_file before
> >>> updating the header.
> >>
> >> It should, but currently it does that rather indirectly (by setting the
> >> data-file option which then makes qcow2_do_open() copy it into
> >> s->image_data_file).
> >=20
> > I'm not exactly sure what detail in the image creation process you are
> > talking about.
>=20
> Mostly the fact that when enough data-file options are provided, the
> header string is overwritten with the filename taken from the node
> that's been specified by those runtime options.
>=20
> (Which is what the creation process uses to get the filename into the
> header the first time.)

Okay. That's the obvious one that is fixed with the solution I said I
was planning to use (only storing the actual image header value in
s->image_data_file).

I guess we were just talking past each other then.

> > I confirmed that this way of getting the filename into the header is
> > broken, and it was a known problem when I sent the series, spelt out in
> > the cover letter and in fact fixed in my git branch by now.
>=20
> No need to be a bit upset.  As long as we agree, it's all good -- and as
> far as I remember I did acknowledge in my first response that you wrote
> something about this in your cover letter.
>=20
> I just wasn't sure what exactly you meant in the cover letter (to me it
> read more like the filename written the first time may be different from
> what the user has specified, thanks to the magic of
> bdrv_refresh_filename() and other things), and that you didn't say how
> you intended to fix it.  So I just wanted to discuss that.

I'm not really upset, I was just worried that you're insisting because
there's something else wrong and I'm just too dense to understand what
it is. Seems this is actually not the case, even better.

> > Is there anything else about the image creation process that needs
> > fixing?
>=20
> It was my impression that I went already into too much detail in my
> review of this series as an RFC. :-)

No, this is actually very helpful. After all, I want to do as few
iterations as possible.

> Also, I have to admit that I cannot guarantee a review in a fashion that
> once all my requested changes are incorporated, no further versions will
> be required.

That's probably unavoidable in any review.

Kevin

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJccCOEAAoJEH8JsnLIjy/Wf6cQAKro8qZgRLi05X3AkDGj+u2t
z6wwtbC8U1Sb4ieuKpeHtbnw1tzZIg7KXOKRyzISi/Za54238xKhPaw7mwivfn7g
fHym3rcH+5OyQGj7xSFqVjT1AYCVemOv3hgqsxQCAkY/NIQ2uewRr5PUOkKgHA2W
lUcygNWOsd0Cr2VAp1BUZT6wKiUB8ocNq5NW4w9ex35SoH9CRjlK5mfPFtpRZT2T
mtajMBEJA5v5SJzLz6aABx65D4tjzV/HphSqVrr0t838omksw+XgjWN6neLU2ngJ
b2jzgLMfYAiLy3Crzs8U2xTkSzmaXcQs25n3v4GMxD+XQw8ClqHkwdq5tYeUlFsZ
W5L1eNe7uSh7qNB4pq2S76dndMJC64wdD6Sis0o2MT3mkdgSeSoj0djV+D8j8BHf
Ync5yhzTGAiDqDdQqlT0vsWhLV7B9EiHhqniHLkALSmf7hGL7rUIeU4K9PwmS06Z
DI2G9p1v6Uk2Kc+u9zRfi8fkYZlW5hyUQe49Kg3sbD9OUJt4gBcTh50HyMxxXssY
Ri7t26q7yTiBrPyR3jmdCzkIah8Ll8y0cOFZSJ+IS1kb+mIB9kbPi7YHFuT8viuE
fmrQlu9kyfgN96gYbw6hrntNmrw0LmlDo8ujmA6uHiOlEQEljkUFmHQgAjUnTl6n
+OWi718csCudbnyERR6i
=v/zZ
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
