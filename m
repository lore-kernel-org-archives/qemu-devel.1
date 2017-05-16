Received: from eggs.gnu.org ([2001:4830:134:3::10]:55696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAXfQ-0004AJ-Rx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAXfP-00069N-Dh
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:17:16 -0400
Date: Tue, 16 May 2017 10:17:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170516081703.GB4438@noname.redhat.com>
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
	<6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
	<815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
	<de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
	<ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.05.2017 um 21:17 hat Max Reitz geschrieben:
> On 2017-05-15 20:41, Max Reitz wrote:
> > On 2017-05-12 21:47, John Snow wrote:
> >>
> >>
> >> On 05/12/2017 03:46 PM, Eric Blake wrote:
> >>> On 05/12/2017 01:07 PM, Max Reitz wrote:
> >>>> On 2017-05-11 20:27, John Snow wrote:
> >>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
> >>>>>
> >>>>> Or, rather, force the open of a backing image if one was specified
> >>>>> for creation. Using a similar -unsafe option as rebase, allow qemu-=
img
> >>>>> to ignore the backing file validation if possible.
> >>>>>
> >>>
> >>>>> +++ b/block.c
> >>>>> @@ -4275,37 +4275,37 @@ void bdrv_img_create(const char *filename, =
const char *fmt,
> >>>>>      // The size for the image must always be specified, with one e=
xception:
> >>>>>      // If we are using a backing file, we can obtain the size from=
 there
> >>>>>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
> >>>>> -    if (size =3D=3D -1) {
> >>>>
> >>>> "Hang on, why should this be -1 when the defval is 0? Where does the=
 -1
> >>>> come from?"
> >>>> "..."
> >>>> "Oh, the option exists and is set to -1? Why is that?"
> >>>> "..."
> >>>> "Oh, because this function always sets it itself, and because @img_s=
ize
> >>>> is set to (uint64_t)-1."
> >>>
> >>> I had pretty much the same conversation on my v1 review.
> >>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01097.html
> >>>
> >>>>
> >>>> First, I won't start with how signed integer overflow is
> >>>> implementation-defined in C because I hope you have thrashed that out
> >>>> with Eric (I hope that "to thrash out" is a good translation for
> >>>> "auskaspern" (lit. "to buffoon out").).
> >>>
> >>> Sounds like a reasonable choice of words, even if I don't speak the
> >>> counterpart language to validate your translation.
> >>>
> >>> (uint64_t)-1 is well-defined in C (so I think we're just fine here). =
But
> >>> (int64_t)UINT64_MAX is where signed integer overflow does indeed throw
> >>> wrinkles at you.
> >=20
> > We're not really fine because that conversion happens when the result of
> > qemu_opt_get_size() (a uint64_t) is stored in size (an int64_t).
> >=20
> >>> I seem to recall that qemu has chosen to use compiler flags and/or
> >>> assumptions that we are using 2s-complement arithmetic with sane
> >>> behavior (that is, tighter behavior than the bare minimum that C
> >>> requires), because it was easier than auditing our code for strict C
> >>> compliance on border cases of conversions from unsigned to signed that
> >>> trigger undefined behavior.  But again, I don't think it affects this
> >>> patch (where our conversion is only from signed to unsigned, and that=
 is
> >>> well-defined behavior).
> >=20
> > Right. Which is why I said I won't even start on it, but of course I
> > did. O:-)
> >=20
> >>>> Second, well, at least we should put -1 as the default value here, t=
hen.
> >>>
> >>> Indeed, now that two reviewers have tripped on it,
> >>> qemu_opt_get_size(,,-1) would be nicer.
> >>>
> >>>>
> >>>> Not strictly your fault or something that you need to fix, but it is
> >>>> just a single line in the vicinity...
> >>>>
> >>>> Let me know if you want to address this, for now I'll leave a
> >>>>
> >>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>>>
> >>>> here if you don't want to.
> >>>
> >>> I'm okay whether you want to squash that fix into this patch, or whet=
her
> >>> you do it as a separate followup patch.
> >>>
> >>
> >> I had considered the issue separate; but you're welcome to either write
> >> a patch or squish it into this one, I'm not going to be picky.
> >=20
> > Yep, it is a separate issue, just related. :-)
> >=20
> > But since you and Eric agree, I've squashed it in and thus I'm more than
> > glad to thank you very much and announce this patch as applied to my
> > block branch:
> >=20
> > https://github.com/XanClic/qemu/commits/block
>=20
> ...well, so much for that. I'll have to unstage it again because it
> breaks a bunch of iotests (41 85 96 118 139 141 144 155 156) due to
> failing to acquire image locks. :-/
>=20
> I suspect this is because the backing file is opened somewhere and
> trying to open it breaks now with the locking series applied.

I think we can legitimately set force-shared=3Don for opening the backing
file when testing whether the file exists.

Kevin

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZGrV/AAoJEH8JsnLIjy/WDZoP/2GgNemaG4sRu2O3WKLMHETy
7JmIQgArtwIH2wQHss6N8gHpCWD+VQMeleQK1q46kbAT29MFEkCBFrQ+S/bXNKLK
N2ezIqzIOc7VEMGRhebFMOXI5i7yT9o//ffdO9cp+7kxeRSOjKzluzFUILi+RFcy
inSchI8jXKwkgugkMZd4PRH7ErpbRWACGiu0jeD0tNV0WvSxurf0iW+2vmbuC3rJ
/qGToD3N5xMAfwuZRw0Rt1d5Lhpes9HwK71VJFYgfGSSAqQAb+HUxkMlIiyFvg+U
yeVGQqhqYTSSDM8CHiQH/4SBzDoeVT61o1/vMAwKSrq5i4UpiG4Nu5Ws69OSxSHr
u8SOSQ/asGB+P34ASKZjfw4QKqBbIADbHJwXvlbuwgy7EjPDNjtdzTMg+qkt2hUW
0wz711OOglcn7Rhj7dBVVyJzedBGicje+2xuxn6KqPM2xHuXiSobj2OVLOPJoAEB
rI1f1NUhZA3M1lkeMyadDdFRccdteBW2a0j73+4NUzHRvCqmODKWzMd+TvdHKKlb
19pncBXSEOwhRjFAP12N5t6L0wZssxXb7Yq5CPosF/C3xpSatDKOPfaozm6VC9XL
9BMl3LDs2eQy2ydLiClc+Q7H0vmGLRlZ6lULSVV2L5YUh+fgXUcJIcz2UoVDcnpI
oUcbsHmPA5HllYKEuLc6
=87Hy
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
