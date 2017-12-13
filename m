Received: from eggs.gnu.org ([2001:4830:134:3::10]:47775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP58j-0005Wk-Fy
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP58f-0000LX-DM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:23:53 -0500
Date: Wed, 13 Dec 2017 11:23:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213112345.GK16782@stefanha-x1.localdomain>
References: <VI1PR10MB0301515CFEEA940842FDF26FB7330@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171211115634.GI13593@stefanha-x1.localdomain>
	<VI1PR10MB030143CAC84D8E8AA783C0B0B7370@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <VI1PR10MB030143CAC84D8E8AA783C0B0B7370@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] qemu process crash: Assertion failed:
 QLIST_EMPTY(&bs->tracked_requests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Jeff Cody <jcody@redhat.com>


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 01:42:38PM +0000, Fernando Casas Sch=C3=B6ssow wrot=
e:
> Hello Stefan,
>=20
> Thanks for your reply.
> Fortunately I didn=E2=80=99t have the problem again and it=E2=80=99s not =
clear how it can be consistently reproduced. Daily backups are running as u=
sual at the moment.
>=20
> If there is anything I can do from my side or if you have any ideas to tr=
y to reproduce it let me know.

Okay, thanks.

In case it happens again, here is some information about the assertion
failure.  It will probably be necessary to use GDB to inspect the failed
process (core dump).  The starting point for debugging is mirror_run()
in block/mirror.c:

  if (cnt =3D=3D 0 && should_complete) {
      /* The dirty bitmap is not updated while operations are pending.
       * If we're about to exit, wait for pending operations before
       * calling bdrv_get_dirty_count(bs), or we may exit while the
       * source has dirty data to copy!
       *
       * Note that I/O can be submitted by the guest while
       * mirror_populate runs, so pause it now.  Before deciding
       * whether to switch to target check one last time if I/O has
       * come in the meanwhile, and if not flush the data to disk.
       */
      trace_mirror_before_drain(s, cnt);

      bdrv_drained_begin(bs);
      cnt =3D bdrv_get_dirty_count(s->dirty_bitmap);
      if (cnt > 0 || mirror_flush(s) < 0) {
          bdrv_drained_end(bs);
          continue;
      }

      /* The two disks are in sync.  Exit and report successful
       * completion.
       */
      assert(QLIST_EMPTY(&bs->tracked_requests));

The reason why this assertion makes sense is because
bdrv_drained_begin(bs) starts a region where I/O is quiesced (all
requests should have been completed).

Either there is a bug with blockjobs vs bdrv_drained_debug(), or maybe
mirror_flush() submitted new I/O requests.

It would be interesting to print the bs->tracked_requests linked list
in the GDB debugger.  Those requests might give a clue about the root
cause.

Stefan

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMQ3BAAoJEJykq7OBq3PIKtIH/jaVG0HeZ5GOg1f/M9cFIURe
MZlca/rt1TDJ2noNMHLEqAwUyoIVVSgIrqyg8TqanaqeGpGwhxnNkVQr7DIm97wl
4oMie7v6MWEnUe6kncCt2evruxbxsy7QAJWVL/GTgCNVTQiH9Ar3BkGC3hR9UFjU
+F97F097BCOWdt9/ajV6ZvBvnxvjpRSuG1QJJCnEMTx0Q3fGl4J0U3+LyfZwlNNC
2wQjQsQtToCwSdEhrBaEG26piWZxQzvRn2V/qSsueexuEyXsSQ1rNmJnYOdyAdv+
mTLLjerljMcSr+xkCmK+T5HN/IWy4OGMbgRnnz3yZBhXXHjbSIaHhgrnbye6IlY=
=VwdA
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
