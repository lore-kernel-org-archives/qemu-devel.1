Received: from eggs.gnu.org ([2001:4830:134:3::10]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT8Ba-0002Ya-5S
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT8BZ-00077e-5o
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:55:18 -0400
Date: Thu, 6 Jul 2017 16:55:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706145503.GL5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-13-eblake@redhat.com>
	<20170706133017.GE5975@noname.redhat.com>
	<8c855cfa-a26e-cbab-b2fd-626f3520be9f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <8c855cfa-a26e-cbab-b2fd-626f3520be9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/21] mirror: Switch mirror_do_read()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.07.2017 um 16:25 hat Eric Blake geschrieben:
> On 07/06/2017 08:30 AM, Kevin Wolf wrote:
> > Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> >> We are gradually converting to byte-based interfaces, as they are
> >> easier to reason about than sector-based.  Convert another internal
> >> function (no semantic change).
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> >> Reviewed-by: Jeff Cody <jcody@redhat.com>
> >=20
> >> -    /* The sector range must meet granularity because:
> >> +    assert(bytes <=3D s->buf_size);
> >> +    /* The range will be sector-aligned because:
> >>       * 1) Caller passes in aligned values;
> >> -     * 2) mirror_cow_align is used only when target cluster is larger=
=2E */
> >> -    assert(!(sector_num % sectors_per_chunk));
>=20
> So the strict translation would be assert(!(offset % s->granularity)),
> or rewritten to be assert(QEMU_IS_ALIGNED(offset, s->granularity)).

Right.

> >> -    nb_chunks =3D DIV_ROUND_UP(nb_sectors, sectors_per_chunk);
> >> +     * 2) mirror_cow_align is used only when target cluster is larger.
> >> +     * But it might not be cluster-aligned at end-of-file. */
> >> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>=20
> and you're right that this appears to be a new assertion.
>=20
> >> +    nb_chunks =3D DIV_ROUND_UP(bytes, s->granularity);
> >=20
> > The assertion in the old code was about sector_num (i.e.  that the start
> > of the range is cluster-aligned), not about nb_sectors, so while you add
> > a new assertion, it is asserting something different. This explains
> > why you had to switch to sector aligned even though the semantics
> > shouldn't be changed by this patch.
> >=20
> > Is this intentional or did you confuse sector_num and nb_sectors? I
> > think we can just have both assertions.
>=20
> At this point, I'm not sure if I confused things, or if I hit an actual
> iotest failure later in the series that I traced back to this point.

But if you did, wouldn't this indicate a real bug in the patch?

> If I have a reason to respin, I'll see if both assertions still hold
> (the rewritten alignment check on offset, and the new check on bytes
> being sector-aligned), through all the tests.

Actually, I think this one, while seemingly minor, is a reason to
respin. This kind of assertions is exactly for preventing bugs when
doing changes like this patch does, so removing the assertion in such a
patch looks really suspicious.

Also, with the new assertion, the comment doesn't really make that much
sense any more either.

> Also, while asserting that bytes is sector-aligned is good in the
> short term, it may be overkill by the time dirty-bitmap is changed to
> byte alignment (right now, bdrv_getlength() is always sector-aligned,
> because it rounds up; but if we ever make it byte-accurate, then the
> trailing cluster might not be a sector-aligned bytes length).

This is true, but I think for the time being the assertion is worth it.

Kevin

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZXk9HAAoJEH8JsnLIjy/WEVQP/0bwlYhIt+64/dwqsQ8OXmzh
7YF8hwbQHxchtXu8bgvrLub2YhSVMW4DtoMVfHy9gJnqnSI16vJhAhg4AW4dVEeU
hqIYb5o0VYFv4JH/Zf63jPWZwsOi2iJKRXMsM8B8+FkrRhtk7sL8HjNgcDwpeHqd
L6roc+WD2CG/QVkkJy4hDlXWb2kstHWWJnGa9CQeznSPqPnpxvlnbczuuoas6SAx
HoGWulc7TX4aLTHJll9jJB13E1JRvLfD3uDXKrIy0leNjAmTjJ8Qpmw35NhIRapd
2W0FynE6hMohtvccvfGjTnpOWaA5/v6W68tr/B5lc9zw6gb9lt2zZN2YZ4x9Ch+O
UTPcRi8DAsVIdYjK4ZKsiNil3VgdSSP+v0Xp+rHiCLrChjoonn9gl3P6MmwaHr6N
0ibG/9fzx6YIiS+YCznYiPG4dTj3cAE/QO2ACaBh4CuWfpdIe5uF7OtGaIAD9Eaf
IORYEvkiy5ugj0qf8Mp34RHvsxckuzYO2bcxm40kBmZZFMIbsxXEzD0F2s8GOPe+
AVNJSnTjGj7nMCEhHAEBxWH/4XdWQ4p0XUQXyuJ3josXDqNMvEETdoCmprgvD+e9
xf1IYoa0TfrgwI3BITY9aSdznyTYZJQhJ9rkoH/cRxwzW//Nl3CWW4W36qjVkRY8
XYhHWHUb9DdJ/wXxcLNo
=pAKN
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
