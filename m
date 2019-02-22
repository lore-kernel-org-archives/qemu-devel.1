Received: from eggs.gnu.org ([209.51.188.92]:58853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxCzG-0006cU-84
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxCzF-0002bi-5w
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:43:42 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-11-kwolf@redhat.com>
	<0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
	<20190219090431.GD4727@localhost.localdomain>
	<ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
	<20190222153505.GB8035@dhcp-200-176.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <487485f2-31c0-9200-b66d-e430047ad536@redhat.com>
Date: Fri, 22 Feb 2019 16:43:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190222153505.GB8035@dhcp-200-176.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="09nYh3hNYYeBEyrS2ROn43PinDJmhp3ML"
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
--09nYh3hNYYeBEyrS2ROn43PinDJmhp3ML
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <487485f2-31c0-9200-b66d-e430047ad536@redhat.com>
Subject: Re: [RFC PATCH 10/11] qcow2: Store data file name in the image
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-11-kwolf@redhat.com>
 <0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
 <20190219090431.GD4727@localhost.localdomain>
 <ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
 <20190222153505.GB8035@dhcp-200-176.str.redhat.com>
In-Reply-To: <20190222153505.GB8035@dhcp-200-176.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22.02.19 16:35, Kevin Wolf wrote:
> Am 22.02.2019 um 15:16 hat Max Reitz geschrieben:
>> On 19.02.19 10:04, Kevin Wolf wrote:
>>> Am 19.02.2019 um 01:18 hat Max Reitz geschrieben:
>>>> On 31.01.19 18:55, Kevin Wolf wrote:
>>>>> Rather than requiring that the external data file node is passed
>>>>> explicitly when creating the qcow2 node, store the filename in the
>>>>> designated header extension during .bdrv_create and read it from th=
ere
>>>>> as a default during .bdrv_open.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>> ---
>>>>>  block/qcow2.h              |  1 +
>>>>>  block/qcow2.c              | 69 ++++++++++++++++++++++++++++++++++=
+++-
>>>>>  tests/qemu-iotests/082.out | 27 +++++++++++++++
>>>>>  3 files changed, 96 insertions(+), 1 deletion(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>>> index 6cf862e8b9..4959bf16a4 100644
>>>>> --- a/block/qcow2.c
>>>>> +++ b/block/qcow2.c
>>>>> @@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriverSt=
ate *bs, uint64_t start_offset,
>>>>>  #endif
>>>>>              break;
>>>>> =20
>>>>> +        case QCOW2_EXT_MAGIC_DATA_FILE:
>>>>> +        {
>>>>> +            s->image_data_file =3D g_malloc0(ext.len + 1);
>>>>> +            ret =3D bdrv_pread(bs->file, offset, s->image_data_fil=
e, ext.len);
>>>>> +            if (ret < 0) {
>>>>> +                error_setg_errno(errp, -ret, "ERROR: Could not dat=
a file name");
>>>>
>>>> I think you accidentally a word.
>>>>
>>>>> +                return ret;
>>>>> +            }
>>>>> +#ifdef DEBUG_EXT
>>>>> +            printf("Qcow2: Got external data file %s\n", s->image_=
data_file);
>>>>> +#endif
>>>>> +            break;
>>>>> +        }
>>>>> +
>>>>>          default:
>>>>>              /* unknown magic - save it in case we need to rewrite =
the header */
>>>>>              /* If you add a new feature, make sure to also update =
the fast
>>>>> @@ -1444,7 +1458,18 @@ static int coroutine_fn qcow2_do_open(BlockD=
riverState *bs, QDict *options,
>>>>>      /* Open external data file */
>>>>>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>>>>>          s->data_file =3D bdrv_open_child(NULL, options, "data-file=
", bs,
>>>>> -                                       &child_file, false, errp);
>>>>> +                                       &child_file, false, &local_=
err);
>>>>> +        if (!s->data_file) {
>>>>> +            if (s->image_data_file) {
>>>>> +                error_free(local_err);
>>>>> +                local_err =3D NULL;
>>>>
>>>> This looked a bit weird to me at first because I was wondering why y=
ou
>>>> wouldn't just pass allow_none=3Dtrue and then handle errors (by pass=
ing
>>>> them on).  But right, we want to retry with a filename set, maybe th=
at
>>>> makes more sense of the options.
>>>
>>> I think we want the normal error message for the !s->image_data_file
>>> case. With allow_none=3Dtrue, we would have to come up with a new one=
 here
>>> (in the else branch below).
>>>
>>>> Hm.  But then again, do we really?  It matches what we do with backi=
ng
>>>> files, but that does give at least me headaches from time to time.  =
How
>>>> bad would it be to allow either passing all valid options through
>>>> @options (which would make qcow2 ignore the string in the header), o=
r
>>>> use the filename given in the header alone?
>>>
>>> You mean offering only one of the two ways to configure the node?
>>
>> Either just the filename from the image header, or ignore that and tak=
e
>> all options from the user (who'd have to give a syntactically complete=

>> QAPI BlockdevRef object).
>>
>>> The 'data-file' runtime option is a must so that libvirt can build th=
e
>>> graph node by node (and possibly use file descriptor passing one day)=
=2E
>>> But having to specify the option every time is very unfriendly for hu=
man
>>> users, so I think allowing to store the file name in the header is a
>>> must, too.
>>
>> Sure.  But I don't know whether we have to support taking the filename=

>> from the image header, and the user overriding some of the node's
>> options (e.g. caching).
>=20
> So essentially this would mean passing NULL instead of options to
> bdrv_open_child() when we retry with the filename from the header.
>=20
> But it's inconsistent with all other places, which comes with two

"all other places"?  Really it's just backing files, as everywhere else
there is no filename that doesn't come from the command line.

Yes, you can use -drive file=3Dfoo.qcow2,file.locking=3Doff, but I consid=
er
that case a bit different.  Although maybe it really isn't. *shrug*

> problems. It's confusing for users who are used to overriding just that=

> one option of a child. And do we actually spare you any headaches or do=

> we create new ones because we have now two different behaviours of
> bdrv_open_child() callers that we must preserve in the future?

It means I can act out on my pain by being angry on how .backing
behaves.  That's better for my health than having to keep it in because
it's the same behavior everywhere and it's officially me who's in the wro=
ng.

More seriously, though, yeah, it was just a random idea.  It makes sense
to have the same behavior here as for .backing.

Max


--09nYh3hNYYeBEyrS2ROn43PinDJmhp3ML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwGJgACgkQ9AfbAGHV
z0A/qwf/eqf85CtCZkQp93t4xUk4A5+qHtb7GG7hkGTkptZk6YKHGLHISdT3+++V
NwopNxPFRU0xXCvafANZf/AkCwRu/lAXZOq0dAMwWTF2YnNBk/Pb0Dr/PM3m8Vxc
vEa/smheCeZIKMDjAXOBTZXaw6Q8RPOieSGFc3jPi1aKwR0sBXK/oXJ5fvf3bbbB
vJbbyBVJ2j+74Yi/vPQu9C2A/JvGHmVQEf4nlI5FP9FI/iBE8LP7SnWPJdwCOdhL
ufrjlhh8TgTFBDVFHSLVhm9CkYQuHIYmxdPQA8frWywk9JyXQ26TP6Nm1VijPxpS
ud+++K5HYZmX2lQmOfCgdQCnshaHFg==
=AAg0
-----END PGP SIGNATURE-----

--09nYh3hNYYeBEyrS2ROn43PinDJmhp3ML--
