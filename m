Received: from eggs.gnu.org ([2001:4830:134:3::10]:50246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIZYa-00042C-W7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIZYa-0005Hb-9x
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:59:57 -0400
Date: Tue, 15 May 2018 14:59:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180515125948.GD4442@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-33-kwolf@redhat.com>
	<43ee7ce4-a57f-0805-070e-e80eca6a8a36@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <43ee7ce4-a57f-0805-070e-e80eca6a8a36@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 32/42] job: Move completion and
 cancellation to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.05.2018 um 22:53 hat Max Reitz geschrieben:
> On 2018-05-09 18:26, Kevin Wolf wrote:
> > This moves the top-level job completion and cancellation functions from
> > BlockJob to Job.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > @@ -3362,7 +3362,7 @@ static void bdrv_close(BlockDriverState *bs)
> > =20
> >  void bdrv_close_all(void)
> >  {
> > -    block_job_cancel_sync_all();
> > +    job_cancel_sync_all();
>=20
> Do we really want to cancel jobs that might have nothing to do with the
> block layer?

Yes, though I admit it's a bit ugly to do it here. Alternatively, I
could assert here that no jobs are running and pull the
job_cancel_sync_all() into the callers. For vl.c, this is trivial.
qemu-nbd.c uses 'atexit(bdrv_close_all);', so I'd have to introduce a
wrapper function that calls both job_cancel_sync_all() and
bdrv_close_all().

Would you prefer that?

Kevin

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa+tnEAAoJEH8JsnLIjy/W+vMQAMBrwUExQHkZsqHOqEqqqN8m
zbgZzQ/v1ncCN6+5FBZBIu8db93gg/Lr3I1PkPIkLDwBzf+6xKeP+lBUjuW3ixfI
HfOTYmMbCkfgiRttuTxi8ERYqLnG+HWinACavL3XC8xp3S+bjWrTeirxxUmOwLve
SahQqae/jpy6eVBCRmJxpZKlMYmKlBUGI1y3WnrZn9ejyBI763sRXM2KS71uQbmI
pEQ4P8fq/Vn+h8TgHx+p7ALowzwsr0npS/SwMoNcL5lXZVqebUYKAkamXFwwqo6k
LTO93OHxRa9Knv+frTu5y/rhsRwWJze1NbnfE1yc14fzkZ+2Ls1ChU/cG4HD8gFC
XCKDHmmB0LXr7l58JVG3yNoQHRpjFbErzPZIl30Ap+oM/vxRtwPat2TcG+zppvCx
7iT5nVxP74QUqyOlPnzlR2m6YZtbrWf19yqYTd3MAT4YXTEM3Fny8VURASGhrpTz
UGWVsMUge3G5NpmX/hSk7E9fDdlx6DHNXxdXtiet+DSOrREft+eCa8N39BYqe2tU
T9cW42hVxpfW83ZTfsRC1vHPii/oak+FCc3C13TfR2pquNVEZCDpttPhIbEfJgTa
lB8ZGCb3Iot2PXxdHAeZlZFSBDfVEtKR+XLnuMNB+aInPYkxfpOl5Z4CnCglJSbL
ykvpDrVv70AxexvfDU5p
=gaNY
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
