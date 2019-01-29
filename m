Received: from eggs.gnu.org ([209.51.188.92]:33601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goVgO-00065v-KB
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goVdx-0005Xc-36
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:49:46 -0500
Date: Tue, 29 Jan 2019 16:49:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190129154937.GH4467@dhcp-200-176.str.redhat.com>
References: <1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190129095224.GA4467@dhcp-200-176.str.redhat.com>
	<9741099f-c0b2-5337-f313-255d8aa95ab6@virtuozzo.com>
	<20190129123851.GE4467@dhcp-200-176.str.redhat.com>
	<829cb522-05bf-57cc-b81e-4c028eea6821@virtuozzo.com>
	<20190129131740.GF4467@dhcp-200-176.str.redhat.com>
	<57eb5708-3e21-25b1-a559-d77fc3a11e2f@virtuozzo.com>
	<20190129142355.GG4467@dhcp-200-176.str.redhat.com>
	<b065edfa-f997-4e58-dc8d-12cda093fe8c@virtuozzo.com>
	<e90bc249-b7d3-baec-30ae-1b92503d6db1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e90bc249-b7d3-baec-30ae-1b92503d6db1@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 1/2] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

Am 29.01.2019 um 16:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 29.01.2019 17:35, Vladimir Sementsov-Ogievskiy wrote:
> > 29.01.2019 17:23, Kevin Wolf wrote:
> >> Am 29.01.2019 um 15:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>> 29.01.2019 16:17, Kevin Wolf wrote:
> >>>> Am 29.01.2019 um 13:50 hat Vladimir Sementsov-Ogievskiy geschriebe=
n:
> >>>>> 29.01.2019 15:38, Kevin Wolf wrote:
> >>>>>> Am 29.01.2019 um 13:04 hat Andrey Shinkevich geschrieben:
> >>>>>>>>>
> >>>>>>>>> diff --git a/block/qapi.c b/block/qapi.c
> >>>>>>>>> index c66f949..0fde98c 100644
> >>>>>>>>> --- a/block/qapi.c
> >>>>>>>>> +++ b/block/qapi.c
> >>>>>>>>> @@ -38,6 +38,7 @@
> >>>>>>>>> =A0=A0=A0=A0 #include "qapi/qmp/qstring.h"
> >>>>>>>>> =A0=A0=A0=A0 #include "sysemu/block-backend.h"
> >>>>>>>>> =A0=A0=A0=A0 #include "qemu/cutils.h"
> >>>>>>>>> +#include "qemu/error-report.h"
> >>>>>>>>> =A0=A0=A0=A0 BlockDeviceInfo *bdrv_block_device_info(BlockBac=
kend *blk,
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Blo=
ckDriverState *bs, Error **errp)
> >>>>>>>>> @@ -868,6 +869,11 @@ void bdrv_image_info_dump(fprintf_functi=
on func_fprintf, void *f,
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 if (info->has_format_specific) {
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 func_fprintf(f, "Format =
specific information:\n");
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (info->format_specific &&
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->format_specific->typ=
e =3D=3D IMAGE_INFO_SPECIFIC_KIND_QCOW2 &&
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->format_specific->u.q=
cow2.data->has_bitmaps =3D=3D false) {
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 warn_report("Failed to loa=
d bitmap list");
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 }
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bdrv_image_info_specific=
_dump(func_fprintf, f, info->format_specific);
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
> >>>>>>>>> =A0=A0=A0=A0 }
> >>>>>>>>
> >>>>>>>> Is it really necessary to introduce qcow2 specific knowledge i=
n
> >>>>>>>> block/qapi.c (where it definitely doesn't belong), just to emi=
t a
> >>>>>>>> warning?
> >>>>>>>>
> >>>>>>>> Why can't you print the warning in qcow2_get_specific_info()?
> >>>>>>>
> >>>>>>> Dear Kevin,
> >>>>>>> The reason behind the idea to move the warning to qapi is that =
we
> >>>>>>> wouldn't like to print that in case of JSON format.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
> >>>>>>>>> index 4897aba..07b99ee 100644
> >>>>>>>>> --- a/block/qcow2.c
> >>>>>>>>> +++ b/block/qcow2.c
> >>>>>>>>> @@ -4386,8 +4386,14 @@ static ImageInfoSpecific *qcow2_get_sp=
ecific_info(BlockDriverState *bs)
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *spec_info->u.qcow2.data=
 =3D (ImageInfoSpecificQCow2){
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compat=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D g_strdup("0.10"),
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_bi=
ts=A0=A0=A0=A0=A0 =3D s->refcount_bits,
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .has_bitmaps=A0=A0=A0=A0=A0=
=A0=A0 =3D true, /* To handle error check properly */
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bitmaps=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D NULL, /* Unsupported for version 2 */
> >>>>>>>>
> >>>>>>>> .has_bitmaps =3D false would be nicer if the format doesn't ev=
en support
> >>>>>>>> bitmaps. You only need this here because you put the warning i=
n the
> >>>>>>>> wrong place.
> >>>>>>>>
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 } else if (s->qcow_version =3D=3D 3)=
 {
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 Qcow2BitmapInfoList *bitmaps;
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 Error *local_err =3D NULL;
> >>>>>>>>> +
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 bitmaps =3D qcow2_get_bitmap_info_list=
(bs, &local_err);
> >>>>>>>>
> >>>>>>>> Here you even had a good error message to print...
> >>>>>>>>
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *spec_info->u.qcow2.data=
 =3D (ImageInfoSpecificQCow2){
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compat=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D g_strdup("1.1"),
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .lazy_refcou=
nts=A0=A0=A0=A0 =3D s->compatible_features &
> >>>>>>>>> @@ -4397,7 +4403,14 @@ static ImageInfoSpecific *qcow2_get_sp=
ecific_info(BlockDriverState *bs)
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 QCOW2_INCOMPAT_CORRUP=
T,
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .has_corrupt=
=A0=A0=A0=A0=A0=A0=A0 =3D true,
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_bi=
ts=A0=A0=A0=A0=A0 =3D s->refcount_bits,
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .has_bitmaps=A0=A0=A0=A0=A0=
=A0=A0 =3D !local_err,
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bitmaps=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D bitmaps,
> >>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 /*
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * If an error occurs in obtaining b=
itmaps, ignore
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * it to show other QCOW2 specific i=
nformation.
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
> >>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 error_free(local_err);
> >>>>>>>>
> >>>>>>>> ...but you decided to discard it.
> >>>>>>>>
> >>>>>>>> How about you do this here:
> >>>>>>>>
> >>>>>>>> =A0=A0=A0=A0=A0=A0=A0 warn_reportf_err(local_err, "Failed to l=
oad bitmap list: ");
> >>>>>>>
> >>>>>>> In case of JSON format, we can fail here.
> >>>>>>> It will happen in the current implementation of the new test #2=
39.
> >>>>>>
> >>>>>> Why do you want to silently leave out the bitmap list for JSON o=
utput?
> >>>>>>
> >>>>>> Essentially, this is the same question I asked here:
> >>>>>>
> >>>>>>>> And then get rid of the code in block/qapi.c and the version 2=
 path?
> >>>>>>>>
> >>>>>>>> Actually, should this really only be a warning, or in fact an =
error?
> >>>>>>>> What's the case where we expect that loading the bitmap list c=
an fail,
> >>>>>>>> but the management tool doesn't need to know that and we just =
want to
> >>>>>>>> log a message?
> >>>>>>
> >>>>>> I don't understand why it's okay not to print bitmaps without ma=
king it
> >>>>>> an error. Do you have a specific use case in mind for this behav=
iour?
> >>>>>>
> >>>>>
> >>>>>
> >>>>> We just can't print anything here, as this code is executed from =
qmp command.
> >>>>>
> >>>>> It was discussed, that we don't want to fail the whole query, if =
failed to
> >>>>> obtain bitmaps.
> >>>>
> >>>> It's obvious that you don't want to fail the query command, but I
> >>>> haven't found any explanation for _why_ you want this.
> >>>>
> >>>> The thing that is closest to an explanation is "it may be sad to f=
ail
> >>>> get any information because of repeating some disk/qcow2 error", w=
ritten
> >>>> by you in the v4 thread.
> >>>>
> >>>> I don't think "may be sad" is a good justification for non-standar=
d
> >>>> behaviour. If we can't load the bitmaps, the image is broken. And =
if the
> >>>> image is broken, the rest of the information may be invalid, too.
> >>>
> >>> So, you mean that we go wrong way. And it was my idea. That is sad =
too.
> >>>
> >>> Than, seems like we should add errp to the function and to the full=
 stack
> >>> down to qmp_query_block. And drop extra partial-success qapi logic.
> >>
> >> I'm not necessarily saying that it's the wrong way, though possibly =
it
> >> is wrong indeed.
> >>
> >> But ignoring some kind of failures is special, so what I was looking=
 for
> >> were comments or documentation to explain the reason behind it at le=
ast.
> >> Now from the replies I got so far it looks to me that possibly the
> >> reasons are not only undocumented, but we might actually not have an=
y.
> >>
> >>>>> So, to show, that there were error during bitmaps querying
> >>>>> we decided to use the following semantics:
> >>>>>
> >>>>> empty list (has_bitmaps=3Dtrue) means that there no bitmaps, and =
there were
> >>>>> no errors during bitmaps quering (if it was)
> >>>>>
> >>>>> absence of the field (has_bitmaps=3Dfalse) means that there _were=
_ errors during
> >>>>> bitmaps querying.
> >>>>
> >>>> ...or that you're running an old QEMU version. I'm not sure if mak=
ing
> >>>> old QEMU versions and image errors look the same is a good move.
> >>>
> >>> No, for old versions we return empty list, to show that there were =
no errors.
> >>
> >> You mean old image format versions?
> >=20
> > yes.
> >=20
> > I'm talking about old QEMU versions
> >> that don't even know the 'bitmaps' field.
> >=20
> > hmm. Yes, that's a problem, which we didn't considered.
> >=20
> >>
> >> A QMP client would have to parse the schema to understand whether a
> >> missing 'bitmaps' field means that it's talking to an old QEMU (then
> >> 'bitmaps' doesn't exist in the schema), or that an error happened (t=
hen
> >> the field does exist in the schema).
> >>
> >> Looking at the schema is not impossible, so if we require this for a
> >> good reason, it's okay. But it's not trivial either. If we really wa=
nt
> >> to go with this semantics, we should probably mention both the old a=
nd
> >> the new meaning in the QAPI documentation, with the recommendation t=
hat
> >> you parse the schema to determine the meaning of a missing 'bitmaps'
> >> field.
> >=20
> > Hm, now I think that if we really face the case when we need partial =
success
> > of info querying, it should be additional optional parameter which en=
ables it, like
> > skip-failed=3Dtrue (default false) or something, which is more clear =
than parsing the
> > schema. And, which we can add later if needed.
>=20
> Note also, that we already skip some errors, for example, block_crypto_=
get_specific_info_luks
> will return NULL on errors (unlike qcow2_get_specific_info, which abort=
s), and
> bdrv_query_image_info skip these errors, in same manner as for formats =
which don't support
> bdrv_get_specific_info.
>=20
> Looks like a good moment to fix this too, do you agree?

Yes, once we add an Error **errp to .bdrv_get_specific_info, returning
errors for failing qcrypto_block_get_info() calls as well (both in
crypto and qcow2) makes sense to me.

Or in fact, remove the errp parameter from qcrypto_block_get_info(). It
seems to never return errors.

Kevin
