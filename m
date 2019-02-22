Received: from eggs.gnu.org ([209.51.188.92]:46329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxDbR-0006rC-6O
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxDbP-0006CL-Sb
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:23:09 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-11-kwolf@redhat.com>
	<0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
	<20190219090431.GD4727@localhost.localdomain>
	<ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
	<20190222153505.GB8035@dhcp-200-176.str.redhat.com>
	<487485f2-31c0-9200-b66d-e430047ad536@redhat.com>
	<20190222160613.GE8035@dhcp-200-176.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cf7daf3b-41e8-1098-f5de-e8feba204d2c@redhat.com>
Date: Fri, 22 Feb 2019 17:22:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190222160613.GE8035@dhcp-200-176.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lm5cpKkMhZWnGTWOP4TlrSDq9obmrBFB5"
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
--Lm5cpKkMhZWnGTWOP4TlrSDq9obmrBFB5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <cf7daf3b-41e8-1098-f5de-e8feba204d2c@redhat.com>
Subject: Re: [RFC PATCH 10/11] qcow2: Store data file name in the image
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-11-kwolf@redhat.com>
 <0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
 <20190219090431.GD4727@localhost.localdomain>
 <ba7c7518-8b44-c1d0-22c9-94f0bde58bdf@redhat.com>
 <20190222153505.GB8035@dhcp-200-176.str.redhat.com>
 <487485f2-31c0-9200-b66d-e430047ad536@redhat.com>
 <20190222160613.GE8035@dhcp-200-176.str.redhat.com>
In-Reply-To: <20190222160613.GE8035@dhcp-200-176.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22.02.19 17:06, Kevin Wolf wrote:
> Am 22.02.2019 um 16:43 hat Max Reitz geschrieben:
>> On 22.02.19 16:35, Kevin Wolf wrote:
>>> Am 22.02.2019 um 15:16 hat Max Reitz geschrieben:
>>>> On 19.02.19 10:04, Kevin Wolf wrote:
>>>>> Am 19.02.2019 um 01:18 hat Max Reitz geschrieben:
>>>>>> On 31.01.19 18:55, Kevin Wolf wrote:
>>>>>>> Rather than requiring that the external data file node is passed
>>>>>>> explicitly when creating the qcow2 node, store the filename in th=
e
>>>>>>> designated header extension during .bdrv_create and read it from =
there
>>>>>>> as a default during .bdrv_open.
>>>>>>>
>>>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>>>> ---
>>>>>>>  block/qcow2.h              |  1 +
>>>>>>>  block/qcow2.c              | 69 ++++++++++++++++++++++++++++++++=
+++++-
>>>>>>>  tests/qemu-iotests/082.out | 27 +++++++++++++++
>>>>>>>  3 files changed, 96 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>>>>> index 6cf862e8b9..4959bf16a4 100644
>>>>>>> --- a/block/qcow2.c
>>>>>>> +++ b/block/qcow2.c
>>>>>>> @@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriver=
State *bs, uint64_t start_offset,
>>>>>>>  #endif
>>>>>>>              break;
>>>>>>> =20
>>>>>>> +        case QCOW2_EXT_MAGIC_DATA_FILE:
>>>>>>> +        {
>>>>>>> +            s->image_data_file =3D g_malloc0(ext.len + 1);
>>>>>>> +            ret =3D bdrv_pread(bs->file, offset, s->image_data_f=
ile, ext.len);
>>>>>>> +            if (ret < 0) {
>>>>>>> +                error_setg_errno(errp, -ret, "ERROR: Could not d=
ata file name");
>>>>>>
>>>>>> I think you accidentally a word.
>>>>>>
>>>>>>> +                return ret;
>>>>>>> +            }
>>>>>>> +#ifdef DEBUG_EXT
>>>>>>> +            printf("Qcow2: Got external data file %s\n", s->imag=
e_data_file);
>>>>>>> +#endif
>>>>>>> +            break;
>>>>>>> +        }
>>>>>>> +
>>>>>>>          default:
>>>>>>>              /* unknown magic - save it in case we need to rewrit=
e the header */
>>>>>>>              /* If you add a new feature, make sure to also updat=
e the fast
>>>>>>> @@ -1444,7 +1458,18 @@ static int coroutine_fn qcow2_do_open(Bloc=
kDriverState *bs, QDict *options,
>>>>>>>      /* Open external data file */
>>>>>>>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>>>>>>>          s->data_file =3D bdrv_open_child(NULL, options, "data-fi=
le", bs,
>>>>>>> -                                       &child_file, false, errp)=
;
>>>>>>> +                                       &child_file, false, &loca=
l_err);
>>>>>>> +        if (!s->data_file) {
>>>>>>> +            if (s->image_data_file) {
>>>>>>> +                error_free(local_err);
>>>>>>> +                local_err =3D NULL;
>>>>>>
>>>>>> This looked a bit weird to me at first because I was wondering why=
 you
>>>>>> wouldn't just pass allow_none=3Dtrue and then handle errors (by pa=
ssing
>>>>>> them on).  But right, we want to retry with a filename set, maybe =
that
>>>>>> makes more sense of the options.
>>>>>
>>>>> I think we want the normal error message for the !s->image_data_fil=
e
>>>>> case. With allow_none=3Dtrue, we would have to come up with a new o=
ne here
>>>>> (in the else branch below).
>>>>>
>>>>>> Hm.  But then again, do we really?  It matches what we do with bac=
king
>>>>>> files, but that does give at least me headaches from time to time.=
  How
>>>>>> bad would it be to allow either passing all valid options through
>>>>>> @options (which would make qcow2 ignore the string in the header),=
 or
>>>>>> use the filename given in the header alone?
>>>>>
>>>>> You mean offering only one of the two ways to configure the node?
>>>>
>>>> Either just the filename from the image header, or ignore that and t=
ake
>>>> all options from the user (who'd have to give a syntactically comple=
te
>>>> QAPI BlockdevRef object).
>>>>
>>>>> The 'data-file' runtime option is a must so that libvirt can build =
the
>>>>> graph node by node (and possibly use file descriptor passing one da=
y).
>>>>> But having to specify the option every time is very unfriendly for =
human
>>>>> users, so I think allowing to store the file name in the header is =
a
>>>>> must, too.
>>>>
>>>> Sure.  But I don't know whether we have to support taking the filena=
me
>>>> from the image header, and the user overriding some of the node's
>>>> options (e.g. caching).
>>>
>>> So essentially this would mean passing NULL instead of options to
>>> bdrv_open_child() when we retry with the filename from the header.
>>>
>>> But it's inconsistent with all other places, which comes with two
>>
>> "all other places"?  Really it's just backing files, as everywhere els=
e
>> there is no filename that doesn't come from the command line.
>>
>> Yes, you can use -drive file=3Dfoo.qcow2,file.locking=3Doff, but I con=
sider
>> that case a bit different.  Although maybe it really isn't. *shrug*
>=20
> Why would it be different? At least as a user, I consider them the same=
=2E
> It's true that bs->file and bs->backing come with some additional magic=
,
> but I don't think it makes a difference for this aspect.
>=20
> I'll add the third example I can think of and I'm sure you'll love this=
:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 \
>   -drive file=3D/tmp/test.vmdk,extents.0.cache.no-flush=3Don
>=20
> So we have three examples that work this way. Can you think of any
> existing counterexample?

Define counterexample.  -drive has options for many things, so of course
I can underspecify everything.  file=3D is basically the same as
file.filename=3D, so I can give .file.filename=3D for any node (and some
additional options, but not all that would theoretically be necessary)
and -drive will do the rest.

It's just that that's -drive magic and not driver-level magic (which
this data-file handling is, by virtue of qcow2_do_open() trying to open
the child in two different ways consecutively).  Even for .backing and
the extents it's handled generically in the block layer, isn't it...?

But now I remember a real issue with .backing specifically:

$ ./qemu-img create -f qcow2 base.qcow2 64M
$ ./qemu-img create -f qcow2 -b base.qcow2 top.qcow2
$ x86_64-softmmu/qemu-system-x86_64 \
    -blockdev
node-name=3Dfoo,driver=3Dqcow2,file.driver=3Dfile,file.filename=3Dtop.qco=
w2,\
backing.driver=3Dnull-co
qemu-system-x86_64: -blockdev
node-name=3Dfoo,driver=3Dqcow2,file.driver=3Dfile,file.filename=3Dtop.qco=
w2,backing.driver=3Dnull-co:
Could not open backing file: The only allowed filename for this driver
is 'null-co://'

Because .backing is handled by the block driver just giving the filename
to the generic block layer, which then just puts it in
backing.file.filename.  It's actually pretty good that this will not
happen with your approach!  In fact, that prevents a major source of
headaches I really did have with .backing. :-)

>>> problems. It's confusing for users who are used to overriding just th=
at
>>> one option of a child. And do we actually spare you any headaches or =
do
>>> we create new ones because we have now two different behaviours of
>>> bdrv_open_child() callers that we must preserve in the future?
>>
>> It means I can act out on my pain by being angry on how .backing
>> behaves.  That's better for my health than having to keep it in becaus=
e
>> it's the same behavior everywhere and it's officially me who's in the =
wrong.
>=20
> You're officially wrong. ;-)

My poor liver.  I hope it can cope with all the Paracetamol it's going
to receive.

Max


--Lm5cpKkMhZWnGTWOP4TlrSDq9obmrBFB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwIcsACgkQ9AfbAGHV
z0BoPwf7BAkeRp6HjydwVFdUYEUiqEBBjmnj94AlouWKwOEdwp7uEgPJhwda8H0P
uAwerBrIilQi8TvQxlBdtVRxb14SDHdS2wYkX0FAEkCi4/i3SvyVPauOgYJxwTKO
qrvH6oA+MA8U4zqxrIqH8BZ/XF616LDWwAKQKWrjK8tUR9bFl7IyhKIr4MT9rXpO
+HX/3tGAkB+Qo48spXu0rlsFol+pqAY8ma2lJcjvxuzoKewFVbrbgzJkSHWs2gs+
uYW3mLpjeScjpM9g+OZ8ZJLFgfIg2G29QUit8GiZN4wAgqUwPnRkCZZfyhbZX2VE
HIjkgfHwq7jV9NuVwhMNwtbxYSLEYw==
=Z7vV
-----END PGP SIGNATURE-----

--Lm5cpKkMhZWnGTWOP4TlrSDq9obmrBFB5--
