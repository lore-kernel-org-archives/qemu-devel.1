Received: from eggs.gnu.org ([209.51.188.92]:59121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw1LB-00026O-8j
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw1L7-000735-FX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:05:23 -0500
Date: Tue, 19 Feb 2019 10:04:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219090431.GD4727@localhost.localdomain>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-11-kwolf@redhat.com>
	<0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 10/11] qcow2: Store data file name in
 the image
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


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.02.2019 um 01:18 hat Max Reitz geschrieben:
> On 31.01.19 18:55, Kevin Wolf wrote:
> > Rather than requiring that the external data file node is passed
> > explicitly when creating the qcow2 node, store the filename in the
> > designated header extension during .bdrv_create and read it from there
> > as a default during .bdrv_open.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/qcow2.h              |  1 +
> >  block/qcow2.c              | 69 +++++++++++++++++++++++++++++++++++++-
> >  tests/qemu-iotests/082.out | 27 +++++++++++++++
> >  3 files changed, 96 insertions(+), 1 deletion(-)
>=20
> [...]
>=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 6cf862e8b9..4959bf16a4 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriverState =
*bs, uint64_t start_offset,
> >  #endif
> >              break;
> > =20
> > +        case QCOW2_EXT_MAGIC_DATA_FILE:
> > +        {
> > +            s->image_data_file =3D g_malloc0(ext.len + 1);
> > +            ret =3D bdrv_pread(bs->file, offset, s->image_data_file, e=
xt.len);
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret, "ERROR: Could not data fi=
le name");
>=20
> I think you accidentally a word.
>=20
> > +                return ret;
> > +            }
> > +#ifdef DEBUG_EXT
> > +            printf("Qcow2: Got external data file %s\n", s->image_data=
_file);
> > +#endif
> > +            break;
> > +        }
> > +
> >          default:
> >              /* unknown magic - save it in case we need to rewrite the =
header */
> >              /* If you add a new feature, make sure to also update the =
fast
> > @@ -1444,7 +1458,18 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
> >      /* Open external data file */
> >      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> >          s->data_file =3D bdrv_open_child(NULL, options, "data-file", b=
s,
> > -                                       &child_file, false, errp);
> > +                                       &child_file, false, &local_err);
> > +        if (!s->data_file) {
> > +            if (s->image_data_file) {
> > +                error_free(local_err);
> > +                local_err =3D NULL;
>=20
> This looked a bit weird to me at first because I was wondering why you
> wouldn't just pass allow_none=3Dtrue and then handle errors (by passing
> them on).  But right, we want to retry with a filename set, maybe that
> makes more sense of the options.

I think we want the normal error message for the !s->image_data_file
case. With allow_none=3Dtrue, we would have to come up with a new one here
(in the else branch below).

> Hm.  But then again, do we really?  It matches what we do with backing
> files, but that does give at least me headaches from time to time.  How
> bad would it be to allow either passing all valid options through
> @options (which would make qcow2 ignore the string in the header), or
> use the filename given in the header alone?

You mean offering only one of the two ways to configure the node?

The 'data-file' runtime option is a must so that libvirt can build the
graph node by node (and possibly use file descriptor passing one day).
But having to specify the option every time is very unfriendly for human
users, so I think allowing to store the file name in the header is a
must, too.

> > +                s->data_file =3D bdrv_open_child(s->image_data_file, o=
ptions,
> > +                                               "data-file", bs, &child=
_file,
> > +                                               false, errp);
> > +            } else {
> > +                error_propagate(errp, local_err);
> > +            }
> > +        }
> >          if (!s->data_file) {
> >              ret =3D -EINVAL;
> >              goto fail;
>=20
> [...]
>=20
> > @@ -3229,6 +3270,26 @@ static int coroutine_fn qcow2_co_create_opts(con=
st char *filename, QemuOpts *opt
> >          goto finish;
> >      }
> > =20
> > +    /* Create and open an external data file (protocol layer) */
> > +    val =3D qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
> > +    if (val) {
> > +        ret =3D bdrv_create_file(val, opts, errp);
>=20
> I suppose taking an existing file is saved for later?

I think it's saved for the day that 'qemu-img create' is extended (or
replaced with an alternative) to provide the same functionality as QMP
blockdev-create.

Kevin

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJca8afAAoJEH8JsnLIjy/WXikP/AmXmfCI1GpFLPN/71uCplnq
tLmHrBcyKD+bskKYwwVuaO9bQRJskYo+NBjSYM1KmjJeTP3gHxYbTDlYUrrTpmsN
AMcH4PNiZdqoPyLSX49VJskDRDQ06qfM1VTwBohIgpVfDmoYOgmxmXO/oDPKbLUI
9MbDXdX9jt/YNaR5n5LtUbQo2uE77C5I0srg9KJq+4jnV6iB0sfC9+ZCveh+WYYF
NBxK3WyNoMJH8GvmKucuWDk+I4IlqsS/zmqBiGRDj/xdEKr9xsv7yU/XC44t9Qtz
FmtcGGj61waSheSpQNzh69b/TSAwDfIORLKw6f1V2rI1dtvosGnZqZjMucnOYe7z
oBZz6rgz80FcaKIXyUefCnH8mZnMLpCbK0hoVc9L/2fKhIUKDf16cytsHVwpw7fj
ri5gdhBMgatGwO4NBJu8s4Db1LAapl4ffFQRUSHjOAjghjlnN3l5N1ZeAuIOVwjL
aH77quSlALPr9/P++5pPmf462RqhsM7zr17P/LQNCC1bKN1I179rxYgjVmizHe5D
VfYVJYrf9dJYqVRqO9zGdyF0Z+1rGmRbn3zJEBpsA6xGB/vKrMcCAhSwqakNupgo
IXAPooI3Oj/n+ojcZSqkeTpA0eZ24qt8OnfcOuErDGuHdz0A3mjziLC6Op2aW658
1XkllBDn3OVgxf0MEXB+
=dkxk
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
