Received: from eggs.gnu.org ([2001:4830:134:3::10]:60139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEbfx-0003i4-VK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEbfw-0000QU-IQ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:27:09 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
	<CA+6E1=nHu1RgDD3OFthjj278RBRJAej4jWzr3TU8prWCt9czRQ@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <05b5f234-d3a1-7a74-1e72-6ae08ba3d33d@redhat.com>
Date: Fri, 4 May 2018 16:27:00 +0200
MIME-Version: 1.0
In-Reply-To: <CA+6E1=nHu1RgDD3OFthjj278RBRJAej4jWzr3TU8prWCt9czRQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WZ3WkZntsjPbeyajCrBIZPox3bSsDI9N4"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5Y+25q6L6aOO?= <renyime@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WZ3WkZntsjPbeyajCrBIZPox3bSsDI9N4
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?B?5Y+25q6L6aOO?= <renyime@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <05b5f234-d3a1-7a74-1e72-6ae08ba3d33d@redhat.com>
Subject: Re: [PATCH] qemu-img: return allocated size for block device with
 qcow2 format
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
 <44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
 <CA+6E1=nHu1RgDD3OFthjj278RBRJAej4jWzr3TU8prWCt9czRQ@mail.gmail.com>
In-Reply-To: <CA+6E1=nHu1RgDD3OFthjj278RBRJAej4jWzr3TU8prWCt9czRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-03 15:08, =E5=8F=B6=E6=AE=8B=E9=A3=8E wrote:
>> The whole implementation reminds me a lot of qcow2's check function,
>> which basically just recalculates the refcounts.=C2=A0 So I'm wonderin=
g
>> whether you could just count how many clusters with non-0 refcount the=
re
>> are and thus simplify the implementation dramatically.
>=20
> Thanks for your review, Max.
>=20
> Yes, just get the highest non-0 refcount cluster index can simply get t=
he
> end offset. But in some situations(such as some errors happen), a clust=
er
> is indexed in index table, but the refcount may be 0 error, just like t=
he
> qcow2 check inconsistency. So I traverse the whole index part, include =
L1,
> L2, snapshot and so on.

Yeah, well, then you use qemu-img check to repair it.  The refcount
structure is there to know which clusters are allocated, so we should
use it when we want to know that and not assume it's broken.  If the
user thinks it may be broken, they are free to run qemu-img check to chec=
k.

Note that qemu makes sure that no refcount ever is lower than it must
be.  Refcounts are always updated in an order such that if qemu crashes
during some operations the refcount is equal to or higher than what it
needs to be.  Anything else is a bug in qemu (or the result of
lazy-refcounts, but then the image is marked dirty and automatically
repaired when opened R/W the next time).

Max

> I try to reuse the qcow2 check code, but the check routine limit the
> avaliable
> end to SIZE_MAX which work well in file situation, however the block
> device has
> a fix end. And the check routine print a lot check info which I don't n=
eed.
>=20
>=20
>=20
>>> +static int64_t qcow2_get_allocated_file_size(BlockDriverState *bs)
>>> +{
>>> + =C2=A0 =C2=A0struct stat st;
>>> + =C2=A0 =C2=A0if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode=
)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto get_file_size;
>>> + =C2=A0 =C2=A0}
>>
>> This definitely doesn't work because nobody guarantees that bs->filena=
me
>> is something that stat() can work with.=C2=A0 I'm aware that you need =
to do
>> the S_ISBLK() check somewhere, but the qcow2 driver is not the right
> place.
>>
>> I don't really have a good way around this, though.=C2=A0 These things=
 come
>> to mind:
>> ...
>=20
> Yea, thank you for your suggestion. I think a hack to
> qcow2_get_allocated_file_size
> will work well.
>> (3) As a hack, qcow2_get_allocated_file_size() could first always call=

>> bdrv_get_allocated_file_size(bs->file->bs), and if that returns 0 (whi=
ch
>> is absolutely impossible for qcow2 files because they have an image
>> header that takes up some space), we fall back to
>> qcow2_get_block_allocated_size().=C2=A0 While I consider it a hack, I =
can't
>> come up with a scenario where it wouldn't work.
>=20
>=20
> Max Reitz <mreitz@redhat.com <mailto:mreitz@redhat.com>> =E4=BA=8E2018=E5=
=B9=B45=E6=9C=882=E6=97=A5
> =E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:37=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     Hi,
>=20
>     [replying to this version because the previous mail doesn't seem to=
 have
>     made it to the mailing lists for whatever reason]
>=20
>     On 2018-05-02 15:34, Ivan Ren wrote:
>     > qemu-img info with a block device which has a qcow2 format always=

>     > return 0 for disk size, and this can not reflect the qcow2 size
>     > and the used space of the block device. This patch return the
>     > allocated size of qcow2 as the disk size.
>=20
>     I'm not quite sure whether you really need this information for blo=
ck
>     devices (I tend to agree with Eric that wr_highest_cluster is the m=
ore
>     important information there), but I can imagine it just being nice
>     to have.
>=20
>     So the basic idea makes sense to me, but I think the implementation=
 can
>     be simplified and the reporting in qemu-img should be done differen=
tly.
>=20
>     >
>     > Signed-off-by: Ivan Ren <ivanren@tencent.com
>     <mailto:ivanren@tencent.com>>
>     > ---
>     >=C2=A0 block/qcow2-bitmap.c |=C2=A0 69 +++++++++++++++++
>     >=C2=A0 block/qcow2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 212
>     +++++++++++++++++++++++++++++++++++++++++++++++++++
>     >=C2=A0 block/qcow2.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 42 +++++++=
+++
>     >=C2=A0 3 files changed, 323 insertions(+)
>=20
>     The whole implementation reminds me a lot of qcow2's check function=
,
>     which basically just recalculates the refcounts.=C2=A0 So I'm wonde=
ring
>     whether you could just count how many clusters with non-0 refcount =
there
>     are and thus simplify the implementation dramatically.
>=20
>     [...]
>=20
>     > +static int64_t qcow2_get_allocated_file_size(BlockDriverState *b=
s)
>     > +{
>     > +=C2=A0 =C2=A0 struct stat st;
>     > +=C2=A0 =C2=A0 if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_=
mode)) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto get_file_size;
>     > +=C2=A0 =C2=A0 }
>=20
>     This definitely doesn't work because nobody guarantees that bs->fil=
ename
>     is something that stat() can work with.=C2=A0 I'm aware that you ne=
ed to do
>     the S_ISBLK() check somewhere, but the qcow2 driver is not the righ=
t
>     place.
>=20
>     I don't really have a good way around this, though.=C2=A0 These thi=
ngs come
>     to mind:
>=20
>     (1) We could let file-posix report an error for S_ISBLK because the=

>     information is known to be usually useless -- but I think that is n=
ot
>     quite the right thing to do because maybe some block devices do rep=
ort
>     useful information there, I don't know.
>=20
>     (2) Or we introduce a new field in qemu-img info (and thus in Image=
Info,
>     too, I suppose?).=C2=A0 qemu-img info (or rather bdrv_query_image_i=
nfo())
>     could detect whether the format layer supports
>     bdrv_get_allocated_file_size, and if so, it emits that information
>     separately from the allocated size of bs->file->bs.=C2=A0 But that =
would
>     break vmdk...
>=20
>     (3) As a hack, qcow2_get_allocated_file_size() could first always c=
all
>     bdrv_get_allocated_file_size(bs->file->bs), and if that returns 0 (=
which
>     is absolutely impossible for qcow2 files because they have an image=

>     header that takes up some space), we fall back to
>     qcow2_get_block_allocated_size().=C2=A0 While I consider it a hack,=
 I can't
>     come up with a scenario where it wouldn't work.
>=20
>     Max
>=20
>     > +
>     > +=C2=A0 =C2=A0 return qcow2_get_block_allocated_size(bs);
>     > +
>     > +get_file_size:
>     > +=C2=A0 =C2=A0 if (bs->file) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bdrv_get_allocated_file_size(=
bs->file->bs);
>     > +=C2=A0 =C2=A0 }
>     > +=C2=A0 =C2=A0 return -ENOTSUP;
>     > +}
>     > +
>=20



--WZ3WkZntsjPbeyajCrBIZPox3bSsDI9N4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrsbbQACgkQ9AfbAGHV
z0BvAAf/eXs88nYpRZxOhprEz6HFUgLDt+hul3AuELIxcACECfG8qu4r/zHezy9H
JCWpxMhSnCUhI+QWH0sptrroe7BAGAizHY/JEd9Jy1VLaz/TYx2UikadSLbpiJGx
72MHlN6hfx4CQegkEFnwigeOa3bkL81A2xi03mClV5z0Oi3+Itmtp6ngyxo7Hn7E
36J9kCwPBkdJhwFBChX0f/3IRWbDrDEjT3XR3MHC84GHEhQjR9h1NuH7u0l2tSGX
iiPvjyKzuxQNdHyzVnszMfKaJ9owOKj0XQa8bmmLpEKGAYYIK/ZnZBHwxKmdECiq
3qTdSM6WZW9GUw1TqBNxAk7AyUU3Vw==
=y05L
-----END PGP SIGNATURE-----

--WZ3WkZntsjPbeyajCrBIZPox3bSsDI9N4--
