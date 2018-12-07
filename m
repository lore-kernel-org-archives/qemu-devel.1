Received: from eggs.gnu.org ([2001:4830:134:3::10]:43843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIri-0003Ii-AM
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIrh-0000hl-6K
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:20:34 -0500
References: <1544176849-899477-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c525644-cc38-9d0b-c591-6d75315e25cc@redhat.com>
Date: Fri, 7 Dec 2018 10:20:20 -0600
MIME-Version: 1.0
In-Reply-To: <1544176849-899477-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>

On 12/7/18 4:00 AM, Andrey Shinkevich wrote:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
> 
> image: /vz/vmprivate/VM1/harddisk.hdd
> file format: qcow2
> virtual size: 64G (68719476736 bytes)
> disk size: 3.0M
> cluster_size: 1048576
> Format specific information:
>      compat: 1.1
>      lazy refcounts: true
>      bitmaps:
>          [0]:
>              flags:
>                  [0]: in-use
>                  [1]: auto
>              name: back-up1
>              unknown flags: 4

I'm guessing you doctored an image in a hex-editor to get this 
particular output?

>              granularity: 65536
>          [1]:
>              flags:
>                  [0]: in-use
>                  [1]: auto
>              name: back-up2
>              unknown flags: 8
>              granularity: 65536
>      refcount bits: 16
>      corrupt: false
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> v4:
> Unknown flags are checked with the mask BME_RESERVED_FLAGS.
> The code minor refactoring was made.
> 

>   
> block/qcow2-bitmap.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c        |  8 ++++++++
>   block/qcow2.h        |  2 ++
>   qapi/block-core.json | 40 ++++++++++++++++++++++++++++++++++++-
>   4 files changed, 105 insertions(+), 1 deletion(-)

I'm assuming John will merge this as a bitmap-related patch; make sure 
he is in cc if you send a v5 (adding now).

> +++ b/block/qcow2.c
> @@ -4270,6 +4270,12 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>               .refcount_bits      = s->refcount_bits,
>           };
>       } else if (s->qcow_version == 3) {
> +        Qcow2BitmapInfoList *bitmaps;
> +        Error *local_err = NULL;
> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
> +        if (local_err != NULL) {
> +            error_report_err(local_err);
> +        }

Ouch. Calling error_report_err() doesn't always work in QMP context; 
better would be to plumb Error **errp back up to the caller, if getting 
this specific information can fail and we want the overall query-block 
to fail.  Or, we could decide that failure to get bitmap info is 
non-fatal, and that it was just a best-effort attempt to get more info, 
where we then ignore the failure, rather than trying to report it 
incorrectly.


> +++ b/qapi/block-core.json
> @@ -69,6 +69,8 @@
>   # @encrypt: details about encryption parameters; only set if image
>   #           is encrypted (since 2.10)
>   #
> +# @bitmaps: list of qcow2 bitmaps details (since 4.0)
> +#
>   # Since: 1.7
>   ##
>   { 'struct': 'ImageInfoSpecificQCow2',
> @@ -77,7 +79,8 @@
>         '*lazy-refcounts': 'bool',
>         '*corrupt': 'bool',
>         'refcount-bits': 'int',
> -      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
> +      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> +      '*bitmaps': ['Qcow2BitmapInfo']

Hmm. You're omitting this field both if there are 0 bitmaps, and when it 
was a version 2 image. Is it worth including this field as a 0-length 
array when there are no bitmaps but when the image format is new enough 
to support them, or are we happy with the idea of only including the 
field when it has at least one bitmap?  The difference is whether the 
calling app can explicitly learn that there are no bitmaps (0-length 
reply) vs. the ambiguity of omitting it from the reply (missing might 
mean no bitmaps, or an error in trying to report the bitmaps, or an 
older qemu that didn't know how to report bitmaps).


> +##
> +# @Qcow2BitmapInfo:
> +#
> +# Qcow2 bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# @flags: flags of the bitmap
> +#
> +# @unknown-flags: unspecified flags if detected
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'Qcow2BitmapInfo',
> +  'data': {'name': 'str', 'granularity': 'uint32',
> +           'flags': ['Qcow2BitmapInfoFlags'],
> +           '*unknown-flags': 'uint32' } }

Here, you said flags will always be present, even if it is a 0-length 
array. Did you test the case where an on-disk bitmap has neither 
'in-use' nor 'auto' set (where get_bitmap_info_flags() returns NULL) to 
ensure that it indeed results in a 0-length reply and not a crash?

Otherwise, it's looking fairly good.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
