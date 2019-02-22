Received: from eggs.gnu.org ([209.51.188.92]:43680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBdQ-0001MK-R2
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBdP-0000VO-6H
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:17:04 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-11-kwolf@redhat.com>
	<0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
	<20190219090431.GD4727@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
Date: Fri, 22 Feb 2019 15:16:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190219090431.GD4727@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5CsvVVxzWCn5uIrT8GZe7tAUTI0OTbTxn"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5CsvVVxzWCn5uIrT8GZe7tAUTI0OTbTxn
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
Subject: Re: [RFC PATCH 10/11] qcow2: Store data file name in the image
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-11-kwolf@redhat.com>
 <0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
 <20190219090431.GD4727@localhost.localdomain>
In-Reply-To: <20190219090431.GD4727@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19.02.19 10:04, Kevin Wolf wrote:
> Am 19.02.2019 um 01:18 hat Max Reitz geschrieben:
>> On 31.01.19 18:55, Kevin Wolf wrote:
>>> Rather than requiring that the external data file node is passed
>>> explicitly when creating the qcow2 node, store the filename in the
>>> designated header extension during .bdrv_create and read it from ther=
e
>>> as a default during .bdrv_open.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/qcow2.h              |  1 +
>>>  block/qcow2.c              | 69 ++++++++++++++++++++++++++++++++++++=
+-
>>>  tests/qemu-iotests/082.out | 27 +++++++++++++++
>>>  3 files changed, 96 insertions(+), 1 deletion(-)
>>
>> [...]
>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 6cf862e8b9..4959bf16a4 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriverStat=
e *bs, uint64_t start_offset,
>>>  #endif
>>>              break;
>>> =20
>>> +        case QCOW2_EXT_MAGIC_DATA_FILE:
>>> +        {
>>> +            s->image_data_file =3D g_malloc0(ext.len + 1);
>>> +            ret =3D bdrv_pread(bs->file, offset, s->image_data_file,=
 ext.len);
>>> +            if (ret < 0) {
>>> +                error_setg_errno(errp, -ret, "ERROR: Could not data =
file name");
>>
>> I think you accidentally a word.
>>
>>> +                return ret;
>>> +            }
>>> +#ifdef DEBUG_EXT
>>> +            printf("Qcow2: Got external data file %s\n", s->image_da=
ta_file);
>>> +#endif
>>> +            break;
>>> +        }
>>> +
>>>          default:
>>>              /* unknown magic - save it in case we need to rewrite th=
e header */
>>>              /* If you add a new feature, make sure to also update th=
e fast
>>> @@ -1444,7 +1458,18 @@ static int coroutine_fn qcow2_do_open(BlockDri=
verState *bs, QDict *options,
>>>      /* Open external data file */
>>>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>>>          s->data_file =3D bdrv_open_child(NULL, options, "data-file",=
 bs,
>>> -                                       &child_file, false, errp);
>>> +                                       &child_file, false, &local_er=
r);
>>> +        if (!s->data_file) {
>>> +            if (s->image_data_file) {
>>> +                error_free(local_err);
>>> +                local_err =3D NULL;
>>
>> This looked a bit weird to me at first because I was wondering why you=

>> wouldn't just pass allow_none=3Dtrue and then handle errors (by passin=
g
>> them on).  But right, we want to retry with a filename set, maybe that=

>> makes more sense of the options.
>=20
> I think we want the normal error message for the !s->image_data_file
> case. With allow_none=3Dtrue, we would have to come up with a new one h=
ere
> (in the else branch below).
>=20
>> Hm.  But then again, do we really?  It matches what we do with backing=

>> files, but that does give at least me headaches from time to time.  Ho=
w
>> bad would it be to allow either passing all valid options through
>> @options (which would make qcow2 ignore the string in the header), or
>> use the filename given in the header alone?
>=20
> You mean offering only one of the two ways to configure the node?

Either just the filename from the image header, or ignore that and take
all options from the user (who'd have to give a syntactically complete
QAPI BlockdevRef object).

> The 'data-file' runtime option is a must so that libvirt can build the
> graph node by node (and possibly use file descriptor passing one day).
> But having to specify the option every time is very unfriendly for huma=
n
> users, so I think allowing to store the file name in the header is a
> must, too.

Sure.  But I don't know whether we have to support taking the filename
from the image header, and the user overriding some of the node's
options (e.g. caching).

>>> +                s->data_file =3D bdrv_open_child(s->image_data_file,=
 options,
>>> +                                               "data-file", bs, &chi=
ld_file,
>>> +                                               false, errp);
>>> +            } else {
>>> +                error_propagate(errp, local_err);
>>> +            }
>>> +        }
>>>          if (!s->data_file) {
>>>              ret =3D -EINVAL;
>>>              goto fail;
>>
>> [...]
>>
>>> @@ -3229,6 +3270,26 @@ static int coroutine_fn qcow2_co_create_opts(c=
onst char *filename, QemuOpts *opt
>>>          goto finish;
>>>      }
>>> =20
>>> +    /* Create and open an external data file (protocol layer) */
>>> +    val =3D qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
>>> +    if (val) {
>>> +        ret =3D bdrv_create_file(val, opts, errp);
>>
>> I suppose taking an existing file is saved for later?
>=20
> I think it's saved for the day that 'qemu-img create' is extended (or
> replaced with an alternative) to provide the same functionality as QMP
> blockdev-create.

Ah, yes. :-)

Max


--5CsvVVxzWCn5uIrT8GZe7tAUTI0OTbTxn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwBEwACgkQ9AfbAGHV
z0BI8AgAphtFba0sLXbSDhut0m/OHyZi39EopLTq7IUUk+86vlctOgvVvUjTWTf0
LjcIdSh+jobxiEIl16Wg5G+bxBXaaPQo5uArT5I9MXHeMy2xbz6f7P5Gj1DP6NXR
0dZDkp4UIcGDMhtO8cYvyfNH5ehC87Ym9kBBKmZCj+P1zbdJgE/5C7iDbSn1VivS
7wH+W452TyOHuOPyO4VCchzNJtRpV+yWc+SxJBUwp2xHoMup2RxkA5qjXEwUxmMl
W86dPNFYxib7F61mYIq+hsGi7B0GNSGRSnFz34lVdGhGbRwJuPJ8cw5gl3E6bpMh
j4v80LxBYnAHUPUe31be805uPNSrZQ==
=D0Du
-----END PGP SIGNATURE-----

--5CsvVVxzWCn5uIrT8GZe7tAUTI0OTbTxn--
