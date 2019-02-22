Received: from eggs.gnu.org ([209.51.188.92]:54151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxCr3-00051F-Qa
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxCr2-0006ns-PF
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:35:13 -0500
Date: Fri, 22 Feb 2019 16:35:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190222153505.GB8035@dhcp-200-176.str.redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-11-kwolf@redhat.com>
	<0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
	<20190219090431.GD4727@localhost.localdomain>
	<ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
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


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2019 um 15:16 hat Max Reitz geschrieben:
> On 19.02.19 10:04, Kevin Wolf wrote:
> > Am 19.02.2019 um 01:18 hat Max Reitz geschrieben:
> >> On 31.01.19 18:55, Kevin Wolf wrote:
> >>> Rather than requiring that the external data file node is passed
> >>> explicitly when creating the qcow2 node, store the filename in the
> >>> designated header extension during .bdrv_create and read it from there
> >>> as a default during .bdrv_open.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  block/qcow2.h              |  1 +
> >>>  block/qcow2.c              | 69 ++++++++++++++++++++++++++++++++++++=
+-
> >>>  tests/qemu-iotests/082.out | 27 +++++++++++++++
> >>>  3 files changed, 96 insertions(+), 1 deletion(-)
> >>
> >> [...]
> >>
> >>> diff --git a/block/qcow2.c b/block/qcow2.c
> >>> index 6cf862e8b9..4959bf16a4 100644
> >>> --- a/block/qcow2.c
> >>> +++ b/block/qcow2.c
> >>> @@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriverStat=
e *bs, uint64_t start_offset,
> >>>  #endif
> >>>              break;
> >>> =20
> >>> +        case QCOW2_EXT_MAGIC_DATA_FILE:
> >>> +        {
> >>> +            s->image_data_file =3D g_malloc0(ext.len + 1);
> >>> +            ret =3D bdrv_pread(bs->file, offset, s->image_data_file,=
 ext.len);
> >>> +            if (ret < 0) {
> >>> +                error_setg_errno(errp, -ret, "ERROR: Could not data =
file name");
> >>
> >> I think you accidentally a word.
> >>
> >>> +                return ret;
> >>> +            }
> >>> +#ifdef DEBUG_EXT
> >>> +            printf("Qcow2: Got external data file %s\n", s->image_da=
ta_file);
> >>> +#endif
> >>> +            break;
> >>> +        }
> >>> +
> >>>          default:
> >>>              /* unknown magic - save it in case we need to rewrite th=
e header */
> >>>              /* If you add a new feature, make sure to also update th=
e fast
> >>> @@ -1444,7 +1458,18 @@ static int coroutine_fn qcow2_do_open(BlockDri=
verState *bs, QDict *options,
> >>>      /* Open external data file */
> >>>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> >>>          s->data_file =3D bdrv_open_child(NULL, options, "data-file",=
 bs,
> >>> -                                       &child_file, false, errp);
> >>> +                                       &child_file, false, &local_er=
r);
> >>> +        if (!s->data_file) {
> >>> +            if (s->image_data_file) {
> >>> +                error_free(local_err);
> >>> +                local_err =3D NULL;
> >>
> >> This looked a bit weird to me at first because I was wondering why you
> >> wouldn't just pass allow_none=3Dtrue and then handle errors (by passing
> >> them on).  But right, we want to retry with a filename set, maybe that
> >> makes more sense of the options.
> >=20
> > I think we want the normal error message for the !s->image_data_file
> > case. With allow_none=3Dtrue, we would have to come up with a new one h=
ere
> > (in the else branch below).
> >=20
> >> Hm.  But then again, do we really?  It matches what we do with backing
> >> files, but that does give at least me headaches from time to time.  How
> >> bad would it be to allow either passing all valid options through
> >> @options (which would make qcow2 ignore the string in the header), or
> >> use the filename given in the header alone?
> >=20
> > You mean offering only one of the two ways to configure the node?
>=20
> Either just the filename from the image header, or ignore that and take
> all options from the user (who'd have to give a syntactically complete
> QAPI BlockdevRef object).
>=20
> > The 'data-file' runtime option is a must so that libvirt can build the
> > graph node by node (and possibly use file descriptor passing one day).
> > But having to specify the option every time is very unfriendly for human
> > users, so I think allowing to store the file name in the header is a
> > must, too.
>=20
> Sure.  But I don't know whether we have to support taking the filename
> from the image header, and the user overriding some of the node's
> options (e.g. caching).

So essentially this would mean passing NULL instead of options to
bdrv_open_child() when we retry with the filename from the header.

But it's inconsistent with all other places, which comes with two
problems. It's confusing for users who are used to overriding just that
one option of a child. And do we actually spare you any headaches or do
we create new ones because we have now two different behaviours of
bdrv_open_child() callers that we must preserve in the future?

Kevin

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJccBapAAoJEH8JsnLIjy/WD58P/iQSDPV/5tvNwJbVYTwS7GkW
NXZu42Eqwe8dEQRo+F4VIR+g0jHe3kNOiMLae0GWFk432yGhAN0OuHAbRp5smit3
rcI7HRkwPiP3MUZapncZgBkXy58OWjfJnqWEehsTzhvipP8ObT9W0o+REJKCBPKe
V+DOrIshCBDENev4hwnTGLLKg+iBrhGzYY3+kwKRxsv5mGotpYkb3DoNrTrMaq5t
MDP5OKrnkEJ+ZbRBWGfEiJvZ5nPdfT7vEjoJUIFFt88Yn2xKi/fYUm/+uL/1sz/c
PKLDhJ03ubc2FX+1wKpJst+k9fZWQFQnPwAhz47uNk8+78ts1IvthD30GLYIsQ5W
KJ7aLCvqHE412WCs+MYQ9UdIZOsyA13XDojR4BQgLRCsLTZkvJrFyuRE7dxAUy95
b+1S1SSJzQwFVDepCZnRw3FfK/4P4WNXbJudmxwl6UGqg+COVpB05OQLBgC3GI1N
gwQRNy/wQmM/UPRVC/fRrTiH4OE8ozyextgKxKpvOGYnDgVQCjDykZlHhF3BtWGZ
6++f9wen7U9UijVmZ+g0AyQ8JJ0/FfeKKorzDkboNx020d2Kdl3WtF5DVpJrFAg6
7c/3N5dI60XXcUBIZoASLItVzIqhRpU0w4nnvE+hWeleQXZkPdtFC7A3foIYsmZs
Hk0+SQvGBSiwiY5i6/fv
=hv/g
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
