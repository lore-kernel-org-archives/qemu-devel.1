Received: from eggs.gnu.org ([2001:4830:134:3::10]:43934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr4jU-0006QA-B2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr4jP-0003W4-Et
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:33:00 -0400
Date: Thu, 23 Mar 2017 15:32:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323153241.GG12560@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214001.26339-2-mreitz@redhat.com>
	<20170320101828.GC17887@stefanha-x1.localdomain>
	<56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
	<20170322162859.GC16717@stefanha-x1.localdomain>
	<52aecf7b-5cd7-44d0-94bf-bce90588da32@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <52aecf7b-5cd7-44d0-94bf-bce90588da32@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 01/16] block: Add
 PreallocMode to BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 05:50:59PM +0100, Max Reitz wrote:
> On 22.03.2017 17:28, Stefan Hajnoczi wrote:
> > On Mon, Mar 20, 2017 at 04:07:16PM +0100, Max Reitz wrote:
> >> On 20.03.2017 11:18, Stefan Hajnoczi wrote:
> >>> On Mon, Mar 13, 2017 at 10:39:46PM +0100, Max Reitz wrote:
> >>>> diff --git a/block/iscsi.c b/block/iscsi.c
> >>>> index ab559a6f71..5d6265c4a6 100644
> >>>> --- a/block/iscsi.c
> >>>> +++ b/block/iscsi.c
> >>>> @@ -2060,11 +2060,16 @@ static void iscsi_reopen_commit(BDRVReopenSt=
ate *reopen_state)
> >>>>      }
> >>>>  }
> >>>> =20
> >>>> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Err=
or **errp)
> >>>> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
> >>>> +                          PreallocMode prealloc, Error **errp)
> >>>>  {
> >>>>      IscsiLun *iscsilun =3D bs->opaque;
> >>>>      Error *local_err =3D NULL;
> >>>> =20
> >>>> +    if (prealloc !=3D PREALLOC_MODE_OFF) {
> >>>> +        return -ENOTSUP;
> >>>> +    }
> >>>> +
> >>>>      if (iscsilun->type !=3D TYPE_DISK) {
> >>>>          return -ENOTSUP;
> >>>>      }
> >>>
> >>> Nevermind what I said about adding a BiteSizedTasks entry:
> >>>
> >>> The missing errp usage is not in qemu.git/master yet.  Please fix up
> >>> your bdrv_truncate() errp patch to use errp in all cases, e.g.
> >>> error_setg("Unable to truncate non-disk LUN").
> >>
> >> The thing is that I wasn't comfortable doing that for all block driver=
s.
> >> I mean, I can take another look but I'd rather have vague error messag=
es
> >> ("truncation failed: #{strerror}") than outright wrong ones because I
> >> didn't know what error message to use.
> >>
> >> Of course you could argue that this may probably come out during review
> >> but that implies that every submaintainer for every block driver would
> >> actually come out for review...
> >=20
> > I'm worried about errp being set in only a subset of error cases.
> >=20
> > This is likely to cause bugs if callers use if (local_err).  Grepping
> > through the codebase I can see instances of:
>=20
> Yes, but the generic bdrv_truncate() will always set errp if the driver
> hasn't done so.

I prefer consistently setting errp to make patch review easy (no
checking all callers to see how they behave), making it safe to
copy-paste the code elsewhere, etc.

It's safer to be consistent, can produce more detailed error messages,
and the cost of writing error_setg() calls is low.  But it's a matter of
style, you've pointed out the code is technically correct right now.

Stefan

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0+qZAAoJEJykq7OBq3PIb/sIAMA6zPte7ItAQWDWrqQmiRu2
355upOZO9Kc7+1luIwaUSCFONsdSqdJFa1oZGQsspEu78Zgoy3+VfLDmNDEfpjN5
vR1uQlq9AqRWTXMrb4nl8LyNqOkTuaQukPV4864KD5hFyNKJsbnKLk+/Oid5xrVb
om4KSyWV0XUBcTR7C+/7RrrYAtFTutBkDB7GbMaMLvvDzutLIQxo6DLVOh0lgbyi
1uO9YkqRVw3lPVH9+BgD7Eex66gtf0mf/gOdT7l4e+HDkTG5tWcpqtsaze+UALTp
eE2JW0zgGrYHqR97fSC1RgX49fTgQyZoIu+ogJaw6eq46/HF61ygg/F8TCc5YXI=
=NHau
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
