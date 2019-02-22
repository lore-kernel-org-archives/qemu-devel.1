Received: from eggs.gnu.org ([209.51.188.92]:57121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBFL-000227-20
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBFJ-00079d-2K
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:52:10 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-12-kwolf@redhat.com>
	<d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
	<20190219091729.GE4727@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ade91fc9-dab1-926b-dfba-d7347fcf62bc@redhat.com>
Date: Fri, 22 Feb 2019 14:51:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190219091729.GE4727@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pAABsGAHXmnEUgFCpHmRGBlxUXYTaQqJB"
Subject: Re: [Qemu-devel] [RFC PATCH 11/11] qcow2: Add data file to
 ImageInfoSpecificQCow2
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
--pAABsGAHXmnEUgFCpHmRGBlxUXYTaQqJB
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <ade91fc9-dab1-926b-dfba-d7347fcf62bc@redhat.com>
Subject: Re: [RFC PATCH 11/11] qcow2: Add data file to ImageInfoSpecificQCow2
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-12-kwolf@redhat.com>
 <d38f5705-598a-38e6-d98e-e2241ba83056@redhat.com>
 <20190219091729.GE4727@localhost.localdomain>
In-Reply-To: <20190219091729.GE4727@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19.02.19 10:17, Kevin Wolf wrote:
> Am 19.02.2019 um 01:47 hat Max Reitz geschrieben:
>> On 31.01.19 18:55, Kevin Wolf wrote:
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  qapi/block-core.json | 1 +
>>>  block/qcow2.c        | 6 +++++-
>>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> [...]
>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 4959bf16a4..e3427f9fcd 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1459,7 +1459,9 @@ static int coroutine_fn qcow2_do_open(BlockDriv=
erState *bs, QDict *options,
>>>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>>>          s->data_file =3D bdrv_open_child(NULL, options, "data-file",=
 bs,
>>>                                         &child_file, false, &local_er=
r);
>>> -        if (!s->data_file) {
>>> +        if (s->data_file) {
>>> +            s->image_data_file =3D g_strdup(s->data_file->bs->filena=
me);
>>> +        } else {
>>>              if (s->image_data_file) {
>>>                  error_free(local_err);
>>>                  local_err =3D NULL;
>>
>> Ah, this is what I looked for in the last patch. :-)
>>
>> (i.e. it should be in the last patch, not here)
>=20
> [RFC PATCH 11/11] qcow2: Add data file to ImageInfoSpecificQCow2
>=20
> This is the last patch. :-P

Sorry, I meant the previous one.

>> I think as it is it is just wrong, though.  If I pass enough options a=
t
>> runtime, this will overwrite the image header:
>>
>> $ ./qemu-img create -f qcow2 -o data_file=3Dfoo.raw foo.qcow2 64M
>> $ ./qemu-img create -f raw bar.raw 64M
>> $ ./qemu-img info foo.qcow2
>> [...]
>>     data file: foo.raw
>> [...]
>> $ ./qemu-io --image-opts \
>>     file.filename=3Dfoo.qcow2,data-file.driver=3Dfile,\
>> data-file.filename=3Dbar.raw,lazy-refcounts=3Don \
>>     -c 'write 0 64k'
>> # (The lazy-refcounts is so the image header is updated)
>> $ ./qemu-img info foo.qcow2
>> [...]
>>     data file: bar.raw
>> [...]
>>
>> The right thing would probably to check whether the header extension
>> exists (i.e. if s->image_data_file is non-NULL) and if it does not (it=

>> is NULL), s->image_data_file gets set; because there are no valid imag=
es
>> with the external data file flag set where there is no such header
>> extension.  So we must be in the process of creating the image right n=
ow.
>>
>> But even then, I don't quite like setting it here and not creating the=

>> header extension as part of qcow2_co_create().  I can see why you've
>> done it this way, but creating a "bad" image on purpose (one with the
>> external data file bit set, but no such header extension present yet) =
in
>> order to detect and rectify this case when it is first opened (and the=

>> opening code assuming that any such broken image must be one that is
>> opened the first time) is a bit weird.
>=20
> It's not really a bad image, just one that's a bit cumbersome to use
> because you need to specify the 'data-file' option manually.

Of course it's bad because it doesn't adhere to the specification (which
you could amend, of course, since you add it with this series).  The
spec says "If this bit is set, an external data file name header
extension must be present as well."  Which it isn't until the image is
opened with the data-file option.

>> I suppose doing it right (if you agree with the paragraph before the
>> last one) and adding a comment would make it less weird
>> ("s->image_data_file must be non-NULL for any valid image, so this ima=
ge
>> must be one we are creating right now" or something like that).
>>
>> But still, the issue you point out in your cover letter remains; which=

>> is that the node's filename and the filename given by the user may be
>> two different things.
>=20
> I think what I was planning to do was leaving the path from the image
> header in s->image_data_file even when a runtime option overrides it.
> After all, ImageInfo is about the image, not about the runtime state.

I'm not talking about ImageInfo here, though, I'm talking about the
image creation process.  The hunk I've quoted should be in the previous
patch, not in this one.

Which doesn't make wrong what you're saying, though, the ImageInfo
should print what's in the header.

> Image creation would just manually set s->image_data_file before
> updating the header.

It should, but currently it does that rather indirectly (by setting the
data-file option which then makes qcow2_do_open() copy it into
s->image_data_file).

Max


--pAABsGAHXmnEUgFCpHmRGBlxUXYTaQqJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxv/mUACgkQ9AfbAGHV
z0CA8gf+ONvS3Qc/VkOshsq30ynuU5fbclO6XAcGPFJKoBEXB5C0AXnIGFFl2G7F
9aQjPis2ooUnSIrvxRpCSgKYchcsih5EAlA+xHdXpcGP2rUGG1+YeK0CFgQ626Hn
MVlRjVaHws+JkD3VkB1LHUy+194w5tA0rlETJcYRmMHzbGezVSWghXzGO/8X5Vwy
Pf0NTXVONbOzVl6yRIOIMt/FabCHBLUt0hqZUywmQwBqUZP/ypgDZsSt5fYpEFcC
lpz2a5QbKlvQar/4BDtVSlvPFPm7L2Bkx3DPXwdjUkcUFiIP4c2F9mEAD0qpBw+0
UAFSMJ32usiy29OhlMiRq1MHmdGU3w==
=oNX5
-----END PGP SIGNATURE-----

--pAABsGAHXmnEUgFCpHmRGBlxUXYTaQqJB--
