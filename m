Received: from eggs.gnu.org ([209.51.188.92]:49725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goUq8-00061M-W1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goUZ8-0000DS-Vq
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:40:52 -0500
Date: Tue, 29 Jan 2019 15:23:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190129142355.GG4467@dhcp-200-176.str.redhat.com>
References: <1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190129095224.GA4467@dhcp-200-176.str.redhat.com>
	<9741099f-c0b2-5337-f313-255d8aa95ab6@virtuozzo.com>
	<20190129123851.GE4467@dhcp-200-176.str.redhat.com>
	<829cb522-05bf-57cc-b81e-4c028eea6821@virtuozzo.com>
	<20190129131740.GF4467@dhcp-200-176.str.redhat.com>
	<57eb5708-3e21-25b1-a559-d77fc3a11e2f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57eb5708-3e21-25b1-a559-d77fc3a11e2f@virtuozzo.com>
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

Am 29.01.2019 um 15:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 29.01.2019 16:17, Kevin Wolf wrote:
> > Am 29.01.2019 um 13:50 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 29.01.2019 15:38, Kevin Wolf wrote:
> >>> Am 29.01.2019 um 13:04 hat Andrey Shinkevich geschrieben:
> >>>>>>
> >>>>>> diff --git a/block/qapi.c b/block/qapi.c
> >>>>>> index c66f949..0fde98c 100644
> >>>>>> --- a/block/qapi.c
> >>>>>> +++ b/block/qapi.c
> >>>>>> @@ -38,6 +38,7 @@
> >>>>>>     #include "qapi/qmp/qstring.h"
> >>>>>>     #include "sysemu/block-backend.h"
> >>>>>>     #include "qemu/cutils.h"
> >>>>>> +#include "qemu/error-report.h"
> >>>>>>     
> >>>>>>     BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
> >>>>>>                                             BlockDriverState *bs, Error **errp)
> >>>>>> @@ -868,6 +869,11 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
> >>>>>>     
> >>>>>>         if (info->has_format_specific) {
> >>>>>>             func_fprintf(f, "Format specific information:\n");
> >>>>>> +        if (info->format_specific &&
> >>>>>> +            info->format_specific->type == IMAGE_INFO_SPECIFIC_KIND_QCOW2 &&
> >>>>>> +            info->format_specific->u.qcow2.data->has_bitmaps == false) {
> >>>>>> +            warn_report("Failed to load bitmap list");
> >>>>>> +        }
> >>>>>>             bdrv_image_info_specific_dump(func_fprintf, f, info->format_specific);
> >>>>>>         }
> >>>>>>     }
> >>>>>
> >>>>> Is it really necessary to introduce qcow2 specific knowledge in
> >>>>> block/qapi.c (where it definitely doesn't belong), just to emit a
> >>>>> warning?
> >>>>>
> >>>>> Why can't you print the warning in qcow2_get_specific_info()?
> >>>>
> >>>> Dear Kevin,
> >>>> The reason behind the idea to move the warning to qapi is that we
> >>>> wouldn't like to print that in case of JSON format.
> >>>>
> >>>>>
> >>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
> >>>>>> index 4897aba..07b99ee 100644
> >>>>>> --- a/block/qcow2.c
> >>>>>> +++ b/block/qcow2.c
> >>>>>> @@ -4386,8 +4386,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
> >>>>>>             *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
> >>>>>>                 .compat             = g_strdup("0.10"),
> >>>>>>                 .refcount_bits      = s->refcount_bits,
> >>>>>> +            .has_bitmaps        = true, /* To handle error check properly */
> >>>>>> +            .bitmaps            = NULL, /* Unsupported for version 2 */
> >>>>>
> >>>>> .has_bitmaps = false would be nicer if the format doesn't even support
> >>>>> bitmaps. You only need this here because you put the warning in the
> >>>>> wrong place.
> >>>>>
> >>>>>>             };
> >>>>>>         } else if (s->qcow_version == 3) {
> >>>>>> +        Qcow2BitmapInfoList *bitmaps;
> >>>>>> +        Error *local_err = NULL;
> >>>>>> +
> >>>>>> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
> >>>>>
> >>>>> Here you even had a good error message to print...
> >>>>>
> >>>>>>             *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
> >>>>>>                 .compat             = g_strdup("1.1"),
> >>>>>>                 .lazy_refcounts     = s->compatible_features &
> >>>>>> @@ -4397,7 +4403,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
> >>>>>>                                       QCOW2_INCOMPAT_CORRUPT,
> >>>>>>                 .has_corrupt        = true,
> >>>>>>                 .refcount_bits      = s->refcount_bits,
> >>>>>> +            .has_bitmaps        = !local_err,
> >>>>>> +            .bitmaps            = bitmaps,
> >>>>>>             };
> >>>>>> +        /*
> >>>>>> +         * If an error occurs in obtaining bitmaps, ignore
> >>>>>> +         * it to show other QCOW2 specific information.
> >>>>>> +         */
> >>>>>> +        error_free(local_err);
> >>>>>
> >>>>> ...but you decided to discard it.
> >>>>>
> >>>>> How about you do this here:
> >>>>>
> >>>>>        warn_reportf_err(local_err, "Failed to load bitmap list: ");
> >>>>
> >>>> In case of JSON format, we can fail here.
> >>>> It will happen in the current implementation of the new test #239.
> >>>
> >>> Why do you want to silently leave out the bitmap list for JSON output?
> >>>
> >>> Essentially, this is the same question I asked here:
> >>>
> >>>>> And then get rid of the code in block/qapi.c and the version 2 path?
> >>>>>
> >>>>> Actually, should this really only be a warning, or in fact an error?
> >>>>> What's the case where we expect that loading the bitmap list can fail,
> >>>>> but the management tool doesn't need to know that and we just want to
> >>>>> log a message?
> >>>
> >>> I don't understand why it's okay not to print bitmaps without making it
> >>> an error. Do you have a specific use case in mind for this behaviour?
> >>>
> >>
> >>
> >> We just can't print anything here, as this code is executed from qmp command.
> >>
> >> It was discussed, that we don't want to fail the whole query, if failed to
> >> obtain bitmaps.
> > 
> > It's obvious that you don't want to fail the query command, but I
> > haven't found any explanation for _why_ you want this.
> > 
> > The thing that is closest to an explanation is "it may be sad to fail
> > get any information because of repeating some disk/qcow2 error", written
> > by you in the v4 thread.
> > 
> > I don't think "may be sad" is a good justification for non-standard
> > behaviour. If we can't load the bitmaps, the image is broken. And if the
> > image is broken, the rest of the information may be invalid, too.
> 
> So, you mean that we go wrong way. And it was my idea. That is sad too.
> 
> Than, seems like we should add errp to the function and to the full stack
> down to qmp_query_block. And drop extra partial-success qapi logic.

I'm not necessarily saying that it's the wrong way, though possibly it
is wrong indeed.

But ignoring some kind of failures is special, so what I was looking for
were comments or documentation to explain the reason behind it at least.
Now from the replies I got so far it looks to me that possibly the
reasons are not only undocumented, but we might actually not have any.

> >> So, to show, that there were error during bitmaps querying
> >> we decided to use the following semantics:
> >>
> >> empty list (has_bitmaps=true) means that there no bitmaps, and there were
> >> no errors during bitmaps quering (if it was)
> >>
> >> absence of the field (has_bitmaps=false) means that there _were_ errors during
> >> bitmaps querying.
> > 
> > ...or that you're running an old QEMU version. I'm not sure if making
> > old QEMU versions and image errors look the same is a good move.
> 
> No, for old versions we return empty list, to show that there were no errors.

You mean old image format versions? I'm talking about old QEMU versions
that don't even know the 'bitmaps' field.

A QMP client would have to parse the schema to understand whether a
missing 'bitmaps' field means that it's talking to an old QEMU (then
'bitmaps' doesn't exist in the schema), or that an error happened (then
the field does exist in the schema).

Looking at the schema is not impossible, so if we require this for a
good reason, it's okay. But it's not trivial either. If we really want
to go with this semantics, we should probably mention both the old and
the new meaning in the QAPI documentation, with the recommendation that
you parse the schema to determine the meaning of a missing 'bitmaps'
field.

Kevin
