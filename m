Received: from eggs.gnu.org ([2001:4830:134:3::10]:56312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj1OG-0002P0-Ka
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj1OF-0007fw-La
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:21:48 -0500
Date: Wed, 1 Mar 2017 10:21:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170301102129.GA29473@stefanha-x1.localdomain>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170227171052.GI10201@stefanha-x1.localdomain>
	<58B645AA.3030301@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <58B645AA.3030301@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 2/6] replication: add
 shared-disk and shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kwolf@redhat.com, xuquan8@huawei.com, xiecl.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>, zhangchen.fnst@cn.fujitsu.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 11:53:14AM +0800, Hailiang Zhang wrote:
> On 2017/2/28 1:10, Stefan Hajnoczi wrote:
> > On Fri, Jan 20, 2017 at 11:47:56AM +0800, zhanghailiang wrote:
> > > @@ -119,12 +136,31 @@ static int replication_open(BlockDriverState *b=
s, QDict *options,
> > >                      "The option mode's value should be primary or se=
condary");
> > >           goto fail;
> > >       }
> > > +    s->is_shared_disk =3D qemu_opt_get_bool(opts, REPLICATION_SHARED=
_DISK,
> > > +                                          false);
> > > +    if (s->is_shared_disk && (s->mode =3D=3D REPLICATION_MODE_PRIMAR=
Y)) {
> > > +        shared_disk_id =3D qemu_opt_get(opts, REPLICATION_SHARED_DIS=
K_ID);
> > > +        if (!shared_disk_id) {
> > > +            error_setg(&local_err, "Missing shared disk blk option");
> > > +            goto fail;
> > > +        }
> > > +        s->shared_disk_id =3D g_strdup(shared_disk_id);
> > > +        blk =3D blk_by_name(s->shared_disk_id);
> > > +        if (!blk) {
> > > +            error_setg(&local_err, "There is no %s block", s->shared=
_disk_id);
> > > +            goto fail;
> > > +        }
> > > +        /* We can't access root member of BlockBackend directly */
> > > +        tmp_bs =3D blk_bs(blk);
> > > +        s->primary_disk =3D QLIST_FIRST(&tmp_bs->parents);
> >=20
> > Why is this necessary?
> >=20
> > We already have the BlockBackend for the primary disk.  I'm not sure why
> > the BdrvChild is needed.
> >=20
>=20
> Er, the helper backup_job_create() needs the BlockDriverState for the pri=
mary disk,

You can get the BDS any time using blk_bs().

> besides, we want to make it same with 'secondary_disk' in struct BDRVRepl=
icationState.

Block drivers are allowed to access BDS->parents so it's not necessarily
a problem that the code does this.  But it's rare and usually means
there is a non-standard relationship between BDS nodes.

It wasn't obvious from the code why you are going through the trouble of
getting a BdrvChild instead of using the BlockBackend (the normal way of
accessing a drive).

Perhaps a comment would help:

/* We have a BlockBackend for the primary disk but use BdrvChild for
 * consistency - active_disk, secondary_disk, etc are also BdrvChild.
 */

Stefan

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtqCpAAoJEJykq7OBq3PIrq0H/0PN6ciZRIdoHqOlRcAgQ8Xr
km7X4W8KexcnFYx09KXffQsReOi0PciYq4WsQEvWz7ixcS6bsJCmWrwhlR6fccBS
O90z0jHELMdLnGu1x5YjF7yASLKFVqBpoA+zTGV8NOuiTo9/3CNB1jKOCNC+GODi
PnjUF4Vp4eFwZlI3aPOKGsUiIWgVljHDL9RrAy3rysa0IORH+95rznwXMudLbFCf
xHlGqCuv/r4sLrqYlUPvMVaGYS6/Sd3xr1m/oHT+0V+vcxRY0UYbiVEdIk9RAoJ8
mVOSlC1oBZNfXTpTnjLhNQ15XpSXWRNRbxSe3GqGoyaiBLD9JU9hCBwI1N/m9QM=
=hu4k
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
