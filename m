Received: from eggs.gnu.org ([209.51.188.92]:50617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goSfg-0000sj-Br
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goSfY-00032U-9v
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:39:14 -0500
Date: Tue, 29 Jan 2019 13:38:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190129123851.GE4467@dhcp-200-176.str.redhat.com>
References: <1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190129095224.GA4467@dhcp-200-176.str.redhat.com>
	<9741099f-c0b2-5337-f313-255d8aa95ab6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9741099f-c0b2-5337-f313-255d8aa95ab6@virtuozzo.com>
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
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Am 29.01.2019 um 13:04 hat Andrey Shinkevich geschrieben:
> >>
> >> diff --git a/block/qapi.c b/block/qapi.c
> >> index c66f949..0fde98c 100644
> >> --- a/block/qapi.c
> >> +++ b/block/qapi.c
> >> @@ -38,6 +38,7 @@
> >>   #include "qapi/qmp/qstring.h"
> >>   #include "sysemu/block-backend.h"
> >>   #include "qemu/cutils.h"
> >> +#include "qemu/error-report.h"
> >>   
> >>   BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
> >>                                           BlockDriverState *bs, Error **errp)
> >> @@ -868,6 +869,11 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
> >>   
> >>       if (info->has_format_specific) {
> >>           func_fprintf(f, "Format specific information:\n");
> >> +        if (info->format_specific &&
> >> +            info->format_specific->type == IMAGE_INFO_SPECIFIC_KIND_QCOW2 &&
> >> +            info->format_specific->u.qcow2.data->has_bitmaps == false) {
> >> +            warn_report("Failed to load bitmap list");
> >> +        }
> >>           bdrv_image_info_specific_dump(func_fprintf, f, info->format_specific);
> >>       }
> >>   }
> > 
> > Is it really necessary to introduce qcow2 specific knowledge in
> > block/qapi.c (where it definitely doesn't belong), just to emit a
> > warning?
> > 
> > Why can't you print the warning in qcow2_get_specific_info()?
> 
> Dear Kevin,
> The reason behind the idea to move the warning to qapi is that we 
> wouldn't like to print that in case of JSON format.
> 
> > 
> >> diff --git a/block/qcow2.c b/block/qcow2.c
> >> index 4897aba..07b99ee 100644
> >> --- a/block/qcow2.c
> >> +++ b/block/qcow2.c
> >> @@ -4386,8 +4386,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
> >>           *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
> >>               .compat             = g_strdup("0.10"),
> >>               .refcount_bits      = s->refcount_bits,
> >> +            .has_bitmaps        = true, /* To handle error check properly */
> >> +            .bitmaps            = NULL, /* Unsupported for version 2 */
> > 
> > .has_bitmaps = false would be nicer if the format doesn't even support
> > bitmaps. You only need this here because you put the warning in the
> > wrong place.
> > 
> >>           };
> >>       } else if (s->qcow_version == 3) {
> >> +        Qcow2BitmapInfoList *bitmaps;
> >> +        Error *local_err = NULL;
> >> +
> >> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
> > 
> > Here you even had a good error message to print...
> > 
> >>           *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
> >>               .compat             = g_strdup("1.1"),
> >>               .lazy_refcounts     = s->compatible_features &
> >> @@ -4397,7 +4403,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
> >>                                     QCOW2_INCOMPAT_CORRUPT,
> >>               .has_corrupt        = true,
> >>               .refcount_bits      = s->refcount_bits,
> >> +            .has_bitmaps        = !local_err,
> >> +            .bitmaps            = bitmaps,
> >>           };
> >> +        /*
> >> +         * If an error occurs in obtaining bitmaps, ignore
> >> +         * it to show other QCOW2 specific information.
> >> +         */
> >> +        error_free(local_err);
> > 
> > ...but you decided to discard it.
> > 
> > How about you do this here:
> > 
> >      warn_reportf_err(local_err, "Failed to load bitmap list: ");
> 
> In case of JSON format, we can fail here.
> It will happen in the current implementation of the new test #239.

Why do you want to silently leave out the bitmap list for JSON output?

Essentially, this is the same question I asked here:

> > And then get rid of the code in block/qapi.c and the version 2 path?
> > 
> > Actually, should this really only be a warning, or in fact an error?
> > What's the case where we expect that loading the bitmap list can fail,
> > but the management tool doesn't need to know that and we just want to
> > log a message?

I don't understand why it's okay not to print bitmaps without making it
an error. Do you have a specific use case in mind for this behaviour?

Kevin
