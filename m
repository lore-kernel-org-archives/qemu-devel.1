Received: from eggs.gnu.org ([2001:4830:134:3::10]:56685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw7Rz-00052j-It
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw7Ry-0008Tk-Q3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:27:47 -0400
Date: Thu, 6 Apr 2017 15:27:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406132738.GG4341@noname.redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-11-eblake@redhat.com>
	<20170406090045.GC4341@noname.redhat.com>
	<1313a278-947d-9b73-640f-3aa518019773@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <1313a278-947d-9b73-640f-3aa518019773@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/13] block: Simplify
 bdrv_append_temp_snapshot() logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.04.2017 um 14:52 hat Eric Blake geschrieben:
> On 04/06/2017 04:00 AM, Kevin Wolf wrote:
> > Am 05.04.2017 um 21:47 hat Eric Blake geschrieben:
> >> Noticed while checking Coccinelle results. Naming a label 'out:'
> >> when it is only used on error paths is weird; meanwhile we know
> >> that snapshot_options is NULL on success and that QDECREF(NULL)
> >> is safe.  So merge the two exit paths into one.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> ---
> >>  block.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/block.c b/block.c
> >> index 9b87bf6..a13625f 100644
> >> --- a/block.c
> >> +++ b/block.c
> >> @@ -2209,13 +2209,10 @@ static BlockDriverState *bdrv_append_temp_snap=
shot(BlockDriverState *bs,
> >>          goto out;
> >>      }
> >>
> >> +out:
> >> +    QDECREF(snapshot_options);
> >>      g_free(tmp_filename);
> >>      return bs_snapshot;
> >=20
> > bs_snapshot is uninitialised or at least the wrong return value in error
> > cases. (Hm... Shouldn't the compiler catch the uninitialised part?)
>=20
> Odd, and I agree that I recall the compiler generally able to catch that
> (maybe it's a matter of compiling with -g vs. -O2).  I'm surprised the
> autobuilder didn't flag it.  (I think I missed it due to rebase churn on
> my end).  The obvious fix is to:
>=20
> -    BlockDriverState *bs_snapshot;
> +    BlockDriverState *bs_snapshot =3D NULL;

That's just half of the fix. It doesn't fix the cases where bs_snapshot
is already set. We still want to return NULL on errors there.

Kevin

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY5kJJAAoJEH8JsnLIjy/WIWAP/iTQGPsOaqy9Pl0A55tOY68M
MjhICjJMdyEqgzZBblwV9d98NAVVBglwHYA3yDdUkbbqfQh9iQZNUTW4CJDYpp1i
Z9gHjtnoH1Sh+jHu+W+ppczjV/R/ED45qCuOgYpiRjC5eWaR7hEfbpwLF8ZjW3+d
keK1JSkP3wYENMn0rVbSyQgzexUQdy6p6Cq6wBtIV2mDWr/5bkG2L06/KR4jYQYb
WKMwfvts/yzXS88F5hUDgjRg9couMAgk83LHKKTNjZP3M0e51UgWRqxc7Lg9rZYC
2GdA0iSVDRlA47SK2vLYgrM7zTZH0xm8CNNH4WyvKLPfBXR+BK+72TnIFqgWs0nr
gm/D4B6L1pP2oaAehhW6WYuSPdcdWxrBNdqnR9eZF2MEbLsQeCShgDrDGWccGuw3
YZ287n/34ouGhhwzgaJHMuv79X0DjTfrrtTI2ebXeBkITjPJVqHxx+XsbKyooClr
eXA1eLCe0YhaYuEEwEc0hpuFqBxUTM20jqTFtwFldEf6u67kEksCJtPa5J5fg2+r
i9WED9lnQ/d09BxCW3Wbnbk2dzKXVUmwhmiGpptUARYwMIR8OpkSUL6YDnYIRj4F
8Ob58+4gqgXXWOHgnexZ1R9Wujvvm29F7MHoT9cMTHtcgggFpX4MNu4YKO13+SFh
6sJti00s2TyVOGON3kKN
=fjnc
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
